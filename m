From: pbrobinson@gmail.com (Peter Robinson)
Date: Tue, 26 Jun 2018 13:23:04 +0100
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
Message-ID: <CALeDE9MykqKyk5hJKn2OxZx2USW76ySm8Wxsw3eVgxa2g7PKXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

>>> On 06/24/2018 11:24 AM, Peter Robinson wrote:
>>>>>> I'm seeing this netlink/sk_filter_trim_cap crash on ARMv7 across quite
>>>>>> a few ARMv7 platforms on Fedora with 4.18rc1. I've tested RPi2/RPi3
>>>>>> (doesn't happen on aarch64), AllWinner H3, BeagleBone and a few
>>>>>> others, both LPAE/normal kernels.
>>>
>>> So this is arm32 right?
>>
>> Correct.
>>
>>>>>> I'm a bit out of my depth in this part of the kernel but I'm wondering
>>>>>> if it's known, I couldn't find anything that looked obvious on a few
>>>>>> mailing lists.
>>>>>>
>>>>>> Peter
>>>>>
>>>>> Hi Peter
>>>>>
>>>>> Could you provide symbolic information ?
>>>>
>>>> I passed in through scripts/decode_stacktrace.sh is that what you were after:
>>>>
>>>> [    8.673880] Internal error: Oops: a06 [#10] SMP ARM
>>>> [    8.673949] ---[ end trace 049df4786ea3140a ]---
>>>> [    8.678754] Modules linked in:
>>>> [    8.678766] CPU: 1 PID: 206 Comm: systemd-udevd Tainted: G      D
>>>>         4.18.0-0.rc1.git0.1.fc29.armv7hl+lpae #1
>>>> [    8.678769] Hardware name: Allwinner sun8i Family
>>>> [    8.678781] PC is at sk_filter_trim_cap ()
>>>> [    8.678790] LR is at   (null)
>>>> [    8.709463] pc : lr : psr: 60000013 ()
>>>> [    8.715722] sp : c996bd60  ip : 00000000  fp : 00000000
>>>> [    8.720939] r10: ee79dc00  r9 : c12c9f80  r8 : 00000000
>>>> [    8.726157] r7 : 00000000  r6 : 00000001  r5 : f1648000  r4 : 00000000
>>>> [    8.732674] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 00000000
>>>> [    8.739193] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>>> [    8.746318] Control: 30c5387d  Table: 6e7bc880  DAC: ffe75ece
>>>> [    8.752055] Process systemd-udevd (pid: 206, stack limit = 0x(ptrval))
>>>> [    8.758574] Stack: (0xc996bd60 to 0xc996c000)
>>>
>>> Do you have BPF JIT enabled or disabled? Does it happen with disabled?
>>
>> Enabled, I can test with it disabled, BPF configs bits are:
>> CONFIG_BPF_EVENTS=y
>> # CONFIG_BPFILTER is not set
>> CONFIG_BPF_JIT_ALWAYS_ON=y
>> CONFIG_BPF_JIT=y
>> CONFIG_BPF_STREAM_PARSER=y
>> CONFIG_BPF_SYSCALL=y
>> CONFIG_BPF=y
>> CONFIG_CGROUP_BPF=y
>> CONFIG_HAVE_EBPF_JIT=y
>> CONFIG_IPV6_SEG6_BPF=y
>> CONFIG_LWTUNNEL_BPF=y
>> # CONFIG_NBPFAXI_DMA is not set
>> CONFIG_NET_ACT_BPF=m
>> CONFIG_NET_CLS_BPF=m
>> CONFIG_NETFILTER_XT_MATCH_BPF=m
>> # CONFIG_TEST_BPF is not set
>>
>>> I can see one bug, but your stack trace seems unrelated.
>>>
>>> Anyway, could you try with this?
>>
>> Build in process.
>>
>>> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
>>> index 6e8b716..f6a62ae 100644
>>> --- a/arch/arm/net/bpf_jit_32.c
>>> +++ b/arch/arm/net/bpf_jit_32.c
>>> @@ -1844,7 +1844,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>                 /* there are 2 passes here */
>>>                 bpf_jit_dump(prog->len, image_size, 2, ctx.target);
>>>
>>> -       set_memory_ro((unsigned long)header, header->pages);
>>> +       bpf_jit_binary_lock_ro(header);
>>>         prog->bpf_func = (void *)ctx.target;
>>>         prog->jited = 1;
>>>         prog->jited_len = image_size;
>
> So with that and the other fix there was no improvement, with those
> and the BPF JIT disabled it works, I'm not sure if the two patches
> have any effect with the JIT disabled though.
>
> Will look at the other patches shortly, there's been some other issue
> introduced between rc1 and rc2 which I have to work out before I can
> test those though.

Quick update, with linus's head as of yesterday, basically rc2 plus
davem's network fixes it works if the JIT is disabled IE:
# CONFIG_BPF_JIT_ALWAYS_ON is not set
# CONFIG_BPF_JIT is not set

If I enable it the boot breaks even worse than the errors above in
that I get no console output at all, even with earlycon, so we've gone
backwards since rc1 somehow.

I'll try the above two reverted unless you have any other suggestions.

Peter
