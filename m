From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Wed, 11 Jul 2018 14:14:25 +0530
Subject: [PATCH v5 06/10] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180710152527.GA3616@redhat.com>
References: <20180628052209.13056-1-ravi.bangoria@linux.ibm.com>
 <20180628052209.13056-7-ravi.bangoria@linux.ibm.com>
 <20180701210935.GA14404@redhat.com>
 <0c543791-f3b7-5a4b-f002-e1c76bb430c0@linux.ibm.com>
 <20180702180156.GA31400@redhat.com>
 <f19e3801-d56a-4e34-0acc-1040a071cf91@linux.ibm.com>
 <20180703163645.GA23144@redhat.com> <20180703172543.GC23144@redhat.com>
 <f5a39a88-c21e-4606-a04d-11b5f32016b8@linux.ibm.com>
 <20180710152527.GA3616@redhat.com>
Message-ID: <6e3ff60b-267a-d49d-4ebb-c4264f9c034b@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 07/10/2018 08:55 PM, Oleg Nesterov wrote:
> Hi Ravi,
> 
> On 07/04, Ravi Bangoria wrote:
>>
>>> Now I understand what did you mean by "for each consumer". So if we move this logic
>>> into install/remove_breakpoint as I tried to suggest, we will also need another error
>>> code for the case when verify_opcode() returns false.
>>
>> Ok so if we can use verify_opcode() inside install_breakpoint(), we can probably
>> move implementation logic in install/remove_breakpoint(). Let me explore that more.
> 
> No, sorry for confusion, I meant another thing... But please forget. If we rely on
> verify_opcode() I no longer think it would be more clean to move this logic into
> install/remove_breakpoint.
> 
> However, I still think it would be better to avoid uprobe exporting and modifying
> set_swbp/set_orig_insn. May be we can simply kill both set_swbp() and set_orig_insn(),
> I'll re-check...

Good that you bring this up. Actually, we can implement same logic
without exporting uprobe. We can do "uprobe = container_of(arch_uprobe)"
in uprobe_write_opcode(). No need to export struct uprobe outside,
no need to change set_swbp() / set_orig_insn() syntax. Just that we
need to pass arch_uprobe object to uprobe_write_opcode().


But, I wanted to discuss about making ref_ctr_offset a uprobe property
or a consumer property, before posting v6:

If we make it a consumer property, the design becomes flexible for
user. User will have an option to either depend on kernel to handle
reference counter or he can create normal uprobe and manipulate
reference counter on his own. This will not require any changes to
existing tools. With this approach we need to increment / decrement
reference counter for each consumer. But, because of the fact that our
install_breakpoint() / remove_breakpoint() are not balanced, we have
to keep track of which reference counter have been updated in which
mm, for which uprobe and for which consumer. I.e. Maintain a list of
{uprobe, consumer, mm}. This will make kernel implementation quite
complex because there are chances of races. What we gain in return
is flexibility for users. Please let me know if there are any other
advantages of this approach.

By making it a uprobe property, we are forcing user to use
uprobe_register_refctr() for uprobes having reference counter. Because
we don't allow same uprobe with multiple reference counter and thus
user can't use both uprobe_register_refctr() and uprobe_register() in
parallel for same uprobe. Which means user does not have a flexibility
to create normal uprobe with uprobe_register() and maintain reference
counter on his own. But kernel implementation becomes simple with this
approach. Though, this will require changes in tools which already
supports SDT events, systemtap and bcc I'm aware of. But AFAICS, the
change should not be major. In fact, the change should make tool code
simpler because they don't have to worry about maintaining reference
counter.

Third options: How about allowing 0 as a special value for reference
counter? I mean allow uprobe_register() and uprobe_register_refctr()
in parallel but do not allow two uprobe_register_refctr() with two
different reference counter. If we can do this, the issue of forcing
legacy user to use uprobe_register_refctr() will be solved. I.e. no
change needed on tools side and still kernel implementation will
remain simple. I'll explore this option.

Let me know your thoughts.

Thanks,
Ravi

PS: We can't abuse MSB with first approach because any userspace tool
can also abuse MSB in parallel. Probably, we can abuse MSB in second
and third approach, though, there is no need to.
