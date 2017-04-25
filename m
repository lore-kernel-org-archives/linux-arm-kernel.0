From: rkrcmar@redhat.com (Radim =?utf-8?B?S3LEjW3DocWZ?=)
Date: Tue, 25 Apr 2017 20:49:05 +0200
Subject: [PATCH 1/2] kvm: Fix mmu_notifier release race
In-Reply-To: <1493028624-29837-2-git-send-email-suzuki.poulose@arm.com>
References: <1493028624-29837-1-git-send-email-suzuki.poulose@arm.com>
 <1493028624-29837-2-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170425184904.GI5713@potion>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-04-24 11:10+0100, Suzuki K Poulose:
> The KVM uses mmu_notifier (wherever available) to keep track
> of the changes to the mm of the guest. The guest shadow page
> tables are released when the VM exits via mmu_notifier->ops.release().
> There is a rare chance that the mmu_notifier->release could be
> called more than once via two different paths, which could end
> up in use-after-free of kvm instance (such as [0]).
> 
> e.g:
> 
> thread A                                        thread B
> -------                                         --------------
> 
>  get_signal->                                   kvm_destroy_vm()->
>  do_exit->                                        mmu_notifier_unregister->
>  exit_mm->                                        kvm_arch_flush_shadow_all()->
>  exit_mmap->                                      spin_lock(&kvm->mmu_lock)
>  mmu_notifier_release->                           ....
>   kvm_arch_flush_shadow_all()->                   .....
>   ... spin_lock(&kvm->mmu_lock)                   .....
>                                                   spin_unlock(&kvm->mmu_lock)
>                                                 kvm_arch_free_kvm()
>    *** use after free of kvm ***

I don't understand this race ...
a piece of code in mmu_notifier_unregister() says:

  	/*
  	 * Wait for any running method to finish, of course including
  	 * ->release if it was run by mmu_notifier_release instead of us.
  	 */
  	synchronize_srcu(&srcu);

and code before that removes the notifier from the list, so it cannot be
called after we pass this point.  mmu_notifier_release() does roughly
the same and explains it as:

  	/*
  	 * synchronize_srcu here prevents mmu_notifier_release from returning to
  	 * exit_mmap (which would proceed with freeing all pages in the mm)
  	 * until the ->release method returns, if it was invoked by
  	 * mmu_notifier_unregister.
  	 *
  	 * The mmu_notifier_mm can't go away from under us because one mm_count
  	 * is held by exit_mmap.
  	 */
  	synchronize_srcu(&srcu);

The call of mmu_notifier->release is protected by srcu in both cases and
while it seems possible that mmu_notifier->release would be called
twice, I don't see a combination that could result in use-after-free
from mmu_notifier_release after mmu_notifier_unregister() has returned.

Doesn't [2/2] solve the exact same issue (that the release method cannot
be called twice in parallel)?

Thanks.
