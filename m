From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 3 May 2017 14:13:01 +0100
Subject: [PATCH 1/2] kvm: Fix mmu_notifier release race
In-Reply-To: <611d0ad2-f907-d41c-cdc1-5977c247b104@arm.com>
References: <1493028624-29837-1-git-send-email-suzuki.poulose@arm.com>
 <1493028624-29837-2-git-send-email-suzuki.poulose@arm.com>
 <20170425184904.GI5713@potion> <c1232b1d-ad82-794b-1b86-4d0cc0d4cd7f@arm.com>
 <611d0ad2-f907-d41c-cdc1-5977c247b104@arm.com>
Message-ID: <f732440f-bfad-f2f8-2524-037f03f31c10@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/17 18:20, Suzuki K Poulose wrote:
> On 26/04/17 17:03, Suzuki K Poulose wrote:
>> On 25/04/17 19:49, Radim Kr?m?? wrote:
>>> 2017-04-24 11:10+0100, Suzuki K Poulose:
>>>> The KVM uses mmu_notifier (wherever available) to keep track
>>>> of the changes to the mm of the guest. The guest shadow page
>>>> tables are released when the VM exits via mmu_notifier->ops.release().
>>>> There is a rare chance that the mmu_notifier->release could be
>>>> called more than once via two different paths, which could end
>>>> up in use-after-free of kvm instance (such as [0]).
>>>>
>>>> e.g:
>>>>
>>>> thread A                                        thread B
>>>> -------                                         --------------
>>>>
>>>>  get_signal->                                   kvm_destroy_vm()->
>>>>  do_exit->                                        mmu_notifier_unregister->
>>>>  exit_mm->                                        kvm_arch_flush_shadow_all()->
>>>>  exit_mmap->                                      spin_lock(&kvm->mmu_lock)
>>>>  mmu_notifier_release->                           ....
>>>>   kvm_arch_flush_shadow_all()->                   .....
>>>>   ... spin_lock(&kvm->mmu_lock)                   .....
>>>>                                                   spin_unlock(&kvm->mmu_lock)
>>>>                                                 kvm_arch_free_kvm()
>>>>    *** use after free of kvm ***
>>>
>>> I don't understand this race ...
>>> a piece of code in mmu_notifier_unregister() says:
>>>
>>>       /*
>>>        * Wait for any running method to finish, of course including
>>>        * ->release if it was run by mmu_notifier_release instead of us.
>>>        */
>>>       synchronize_srcu(&srcu);
>>>
>>> and code before that removes the notifier from the list, so it cannot be
>>> called after we pass this point.  mmu_notifier_release() does roughly
>>> the same and explains it as:
>>>
>>>       /*
>>>        * synchronize_srcu here prevents mmu_notifier_release from returning to
>>>        * exit_mmap (which would proceed with freeing all pages in the mm)
>>>        * until the ->release method returns, if it was invoked by
>>>        * mmu_notifier_unregister.
>>>        *
>>>        * The mmu_notifier_mm can't go away from under us because one mm_count
>>>        * is held by exit_mmap.
>>>        */
>>>       synchronize_srcu(&srcu);
>>>
>>> The call of mmu_notifier->release is protected by srcu in both cases and
>>> while it seems possible that mmu_notifier->release would be called
>>> twice, I don't see a combination that could result in use-after-free
>>> from mmu_notifier_release after mmu_notifier_unregister() has returned.
>>
>> Thanks for bringing it up. Even I am wondering why this is triggered ! (But it
>> does get triggered for sure !!)
>>
>> The only difference I can spot with _unregister & _release paths are the way
>> we use src_read_lock across the deletion of the entry from the list.
>>
>> In mmu_notifier_unregister() we do :
>>
>>                 id = srcu_read_lock(&srcu);
>>                 /*
>>                  * exit_mmap will block in mmu_notifier_release to guarantee
>>                  * that ->release is called before freeing the pages.
>>                  */
>>                 if (mn->ops->release)
>>                         mn->ops->release(mn, mm);
>>                 srcu_read_unlock(&srcu, id);
>>
>> ## Releases the srcu lock here and then goes on to grab the spin_lock.
>>
>>                 spin_lock(&mm->mmu_notifier_mm->lock);
>>                 /*
>>                  * Can not use list_del_rcu() since __mmu_notifier_release
>>                  * can delete it before we hold the lock.
>>                  */
>>                 hlist_del_init_rcu(&mn->hlist);
>>                 spin_unlock(&mm->mmu_notifier_mm->lock);
>>
>> While in mmu_notifier_release() we hold it until the node(s) are deleted from the
>> list :
>>         /*
>>          * SRCU here will block mmu_notifier_unregister until
>>          * ->release returns.
>>          */
>>         id = srcu_read_lock(&srcu);
>>         hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list, hlist)
>>                 /*
>>                  * If ->release runs before mmu_notifier_unregister it must be
>>                  * handled, as it's the only way for the driver to flush all
>>                  * existing sptes and stop the driver from establishing any more
>>                  * sptes before all the pages in the mm are freed.
>>                  */
>>                 if (mn->ops->release)
>>                         mn->ops->release(mn, mm);
>>
>>         spin_lock(&mm->mmu_notifier_mm->lock);
>>         while (unlikely(!hlist_empty(&mm->mmu_notifier_mm->list))) {
>>                 mn = hlist_entry(mm->mmu_notifier_mm->list.first,
>>                                  struct mmu_notifier,
>>                                  hlist);
>>                 /*
>>                  * We arrived before mmu_notifier_unregister so
>>                  * mmu_notifier_unregister will do nothing other than to wait
>>                  * for ->release to finish and for mmu_notifier_unregister to
>>                  * return.
>>                  */
>>                 hlist_del_init_rcu(&mn->hlist);
>>         }
>>         spin_unlock(&mm->mmu_notifier_mm->lock);
>>         srcu_read_unlock(&srcu, id);
>>
>> ## The lock is release only after the deletion of the node.
>>
>> Both are followed by a synchronize_srcu(). Now, I am wondering if the unregister path
>> could potentially miss SRCU read lock held in _release() path and go onto finish the
>> synchronize_srcu before the item is deleted ? May be we should do the read_unlock
>> after the deletion of the node in _unregister (like we do in the _release()) ?
>
> I haven't been able to reproduce the mmu_notifier race condition, which leads to KVM
> free, reported at [1]. I will leave it running (with tracepoints/ftrace) over the
> weekend.
>

I couldn't reproduce the proposed "mmu_notifier race" reported in [0].
However I found some other use-after-free cases in the unmap_stage2_range()
code due to the introduction of cond_resched_lock(). It may be just that the
IP reported in [0] was for wrong line of code ? i.e, arch_spin_is_locked instead
of unmap_stage2_range ?
Anyways, I will send a new version of the patches in a separate series.

[0] https://marc.info/?l=linux-kernel&m=149201399018791&w=2

Suzuki
