From: liu.song.a23@gmail.com (Song Liu)
Date: Thu, 12 Jul 2018 12:53:11 -0700
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180712145849.GB15265@redhat.com>
References: <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
 <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
 <20180712145849.GB15265@redhat.com>
Message-ID: <CAPhsuW6kCtn-tWSj5eKf+kGt8ZEjVwJKLxj9C6zdaqMZByRytg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I guess I got to the party late. I found this thread after I started developing
the same feature...

On Thu, Jul 12, 2018 at 7:58 AM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 07/11, Ravi Bangoria wrote:
>>
>> > However, I still think it would be better to avoid uprobe exporting and modifying
>> > set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
>> > I'll re-check...
>>
>> Good that you bring this up. Actually, we can implement same logic
>> without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
>> in uprobe_write_opcode(). No need to export struct uprobe outside,
>> no need to change set_swbp() / set_orig_insn() syntax. Just that we
>> need to pass arch_uprobe object to uprobe_write_opcode().
>
> Yes, but you still need to modify set_swbp/set_orig_insn to pass the new
> arg to uprobe_write_opcode(). OK, this is fine.
>
>
>> But, I wanted to discuss about making ref_ctr_offset a uprobe property
>> or a consumer property, before posting v6:
>>
>> If we make it a consumer property, the design becomes flexible for
>> user. User will have an option to either depend on kernel to handle
>> reference counter or he can create normal uprobe and manipulate
>> reference counter on his own. This will not require any changes to
>> existing tools. With this approach we need to increment / decrement
>> reference counter for each consumer. But, because of the fact that our
>> install_breakpoint() / remove_breakpoint() are not balanced, we have
>> to keep track of which reference counter have been updated in which
>> mm, for which uprobe and for which consumer. I.e. Maintain a list of
>> {uprobe, consumer, mm}.

Is it possible to maintain balanced refcount by modifying callers of
install_breakpoint() and remove_breakpoint()? I am actually working
toward this direction. And I found some imbalance between
     register_for_each_vma(uprobe, uc)
and
     register_for_each_vma(uprobe, NULL)

>From reading the thread, I think there are other sources of imbalance.
But I think it is still possible to fix it? Please let me know if this is not
realistic...


About race conditions, I think both install_breakpoint() and remove_breakpoint()
are called with

   down_write(&mm->mmap_sem);


As long as we do the same when modifying the reference counter,
it should be fine, right?

Wait... sometimes we only down_read(). Is this by design?

Thanks,
Song
