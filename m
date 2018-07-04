From: pbrobinson@gmail.com (Peter Robinson)
Date: Wed, 4 Jul 2018 08:33:20 +0100
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <fe05405a-c06d-d8fe-07fa-5840e498bb13@iogearbox.net>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
 <CALeDE9MykqKyk5hJKn2OxZx2USW76ySm8Wxsw3eVgxa2g7PKXg@mail.gmail.com>
 <fe05405a-c06d-d8fe-07fa-5840e498bb13@iogearbox.net>
Message-ID: <CALeDE9OJomWstG+AcftR543WBi5Bo8ANQj3T-pOW3BfBNzB=uw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 26, 2018 at 1:52 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 06/26/2018 02:23 PM, Peter Robinson wrote:
>>>>> On 06/24/2018 11:24 AM, Peter Robinson wrote:
>>>>>>>> I'm seeing this netlink/sk_filter_trim_cap crash on ARMv7 across quite
>>>>>>>> a few ARMv7 platforms on Fedora with 4.18rc1. I've tested RPi2/RPi3
>>>>>>>> (doesn't happen on aarch64), AllWinner H3, BeagleBone and a few
>>>>>>>> others, both LPAE/normal kernels.
>>>>>
>>>>> So this is arm32 right?
>>>>
>>>> Correct.
>>>>
>>>>>>>> I'm a bit out of my depth in this part of the kernel but I'm wondering
>>>>>>>> if it's known, I couldn't find anything that looked obvious on a few
>>>>>>>> mailing lists.
>>>>>>>>
>>>>>>>> Peter
>>>>>>>
>>>>>>> Hi Peter
>>>>>>>
>>>>>>> Could you provide symbolic information ?
>>>>>>
>>>>>> I passed in through scripts/decode_stacktrace.sh is that what you were after:
>>>>>>
>>>>>> [    8.673880] Internal error: Oops: a06 [#10] SMP ARM
>>>>>> [    8.673949] ---[ end trace 049df4786ea3140a ]---
>>>>>> [    8.678754] Modules linked in:
>>>>>> [    8.678766] CPU: 1 PID: 206 Comm: systemd-udevd Tainted: G      D
>>>>>>         4.18.0-0.rc1.git0.1.fc29.armv7hl+lpae #1
>>>>>> [    8.678769] Hardware name: Allwinner sun8i Family
>>>>>> [    8.678781] PC is at sk_filter_trim_cap ()
>>>>>> [    8.678790] LR is at   (null)
>>>>>> [    8.709463] pc : lr : psr: 60000013 ()
>>>>>> [    8.715722] sp : c996bd60  ip : 00000000  fp : 00000000
>>>>>> [    8.720939] r10: ee79dc00  r9 : c12c9f80  r8 : 00000000
>>>>>> [    8.726157] r7 : 00000000  r6 : 00000001  r5 : f1648000  r4 : 00000000
>>>>>> [    8.732674] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 00000000
>>>>>> [    8.739193] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>>>>> [    8.746318] Control: 30c5387d  Table: 6e7bc880  DAC: ffe75ece
>>>>>> [    8.752055] Process systemd-udevd (pid: 206, stack limit = 0x(ptrval))
>>>>>> [    8.758574] Stack: (0xc996bd60 to 0xc996c000)
>>>>>
>>>>> Do you have BPF JIT enabled or disabled? Does it happen with disabled?
>>>>
>>>> Enabled, I can test with it disabled, BPF configs bits are:
>>>> CONFIG_BPF_EVENTS=y
>>>> # CONFIG_BPFILTER is not set
>>>> CONFIG_BPF_JIT_ALWAYS_ON=y
>>>> CONFIG_BPF_JIT=y
>>>> CONFIG_BPF_STREAM_PARSER=y
>>>> CONFIG_BPF_SYSCALL=y
>>>> CONFIG_BPF=y
>>>> CONFIG_CGROUP_BPF=y
>>>> CONFIG_HAVE_EBPF_JIT=y
>>>> CONFIG_IPV6_SEG6_BPF=y
>>>> CONFIG_LWTUNNEL_BPF=y
>>>> # CONFIG_NBPFAXI_DMA is not set
>>>> CONFIG_NET_ACT_BPF=m
>>>> CONFIG_NET_CLS_BPF=m
>>>> CONFIG_NETFILTER_XT_MATCH_BPF=m
>>>> # CONFIG_TEST_BPF is not set
>>>>
>>>>> I can see one bug, but your stack trace seems unrelated.
>>>>>
>>>>> Anyway, could you try with this?
>>>>
>>>> Build in process.
>>>>
>>>>> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
>>>>> index 6e8b716..f6a62ae 100644
>>>>> --- a/arch/arm/net/bpf_jit_32.c
>>>>> +++ b/arch/arm/net/bpf_jit_32.c
>>>>> @@ -1844,7 +1844,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>>>                 /* there are 2 passes here */
>>>>>                 bpf_jit_dump(prog->len, image_size, 2, ctx.target);
>>>>>
>>>>> -       set_memory_ro((unsigned long)header, header->pages);
>>>>> +       bpf_jit_binary_lock_ro(header);
>>>>>         prog->bpf_func = (void *)ctx.target;
>>>>>         prog->jited = 1;
>>>>>         prog->jited_len = image_size;
>>>
>>> So with that and the other fix there was no improvement, with those
>>> and the BPF JIT disabled it works, I'm not sure if the two patches
>>> have any effect with the JIT disabled though.
>>>
>>> Will look at the other patches shortly, there's been some other issue
>>> introduced between rc1 and rc2 which I have to work out before I can
>>> test those though.
>>
>> Quick update, with linus's head as of yesterday, basically rc2 plus
>> davem's network fixes it works if the JIT is disabled IE:
>> # CONFIG_BPF_JIT_ALWAYS_ON is not set
>> # CONFIG_BPF_JIT is not set
>>
>> If I enable it the boot breaks even worse than the errors above in
>> that I get no console output at all, even with earlycon, so we've gone
>> backwards since rc1 somehow.
>>
>> I'll try the above two reverted unless you have any other suggestions.
>
> Ok, thanks, lets do that!
>
> I'm still working on fixes meanwhile, should have something by end of day.

Sorry for the delay on this from my end. I noticed there was some bpf
bits land in the last net fixes pull request landed Monday so I built
a kernel with the JIT reenabled. It seems it's improved in that the
completely dead no output boot has gone but the original problem that
arrived in the merge window still persists:

[   17.564142] note: systemd-udevd[194] exited with preempt_count 1
[   17.592739] Unable to handle kernel NULL pointer dereference at
virtual address 0000000c
[   17.601002] pgd = (ptrval)
[   17.603819] [0000000c] *pgd=00000000
[   17.607487] Internal error: Oops: 805 [#10] SMP ARM
[   17.612396] Modules linked in:
[   17.615484] CPU: 0 PID: 195 Comm: systemd-udevd Tainted: G      D
        4.18.0-0.rc3.git1.1.bpf1.fc29.armv7hl #1
[   17.626056] Hardware name: Generic AM33XX (Flattened Device Tree)
[   17.632198] PC is at sk_filter_trim_cap+0x218/0x2fc
[   17.637102] LR is at   (null)
[   17.640086] pc : [<c0ab03b4>]    lr : [<00000000>]    psr: 60000013
[   17.646384] sp : cfe1dd48  ip : 00000000  fp : 00000000
[   17.651635] r10: d837e000  r9 : d833be00  r8 : 00000000
[   17.656887] r7 : 00000001  r6 : e003d000  r5 : 00000000  r4 : 00000000
[   17.663447] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 00000000
[   17.670009] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[   17.677180] Control: 10c5387d  Table: 8fe20019  DAC: 00000051
[   17.682956] Process systemd-udevd (pid: 195, stack limit = 0x(ptrval))
[   17.689518] Stack: (0xcfe1dd48 to 0xcfe1e000)
[   17.693901] dd40:                   00000000 00000000 c0ab0234
c1308f38 da610180 da610180
[   17.702123] dd60: 006000c0 00000000 00000000 c0a74524 da610600
da610600 da610180 00000000
[   17.710345] dd80: 00000000 00000000 c1424000 c0addd48 cfc72400
00000001 cfc72400 00000000
[   17.718567] dda0: 00000002 00000000 00000001 d837e064 cfe1de78
00000002 da610180 00000000
[   17.726790] ddc0: cfe1df68 00000085 cfc72400 00000008 00000000
c0adde48 006000c0 00000000
[   17.735012] dde0: 00000000 00000002 00000002 c0ae0c5c 006000c0
00000000 cfd5b580 00000000
[   17.743234] de00: 000000c3 00000000 00000000 00000000 c1379d6c
cfe1df68 cf979900 cfe1de50
[   17.751456] de20: 00000040 00000000 cf979900 00000000 00000000
c0a6ac80 cfe1df68 00000000
[   17.759678] de40: cfe1de50 c0a6b4c4 00000003 00000000 d83f2940
7fff0000 cfe1de88 cfe1dee4
[   17.767899] de60: ffff0000 000000a0 00000000 c044b6c0 beec47e4
00000028 012c6750 0000005d
[   17.776121] de80: 00000000 012d71c8 00000128 40000028 b6c35548
00000000 0000000d 00000000
[   17.784343] dea0: beec47b8 00000000 00000000 00000000 00000010
00000000 00000002 00000002
[   17.792565] dec0: 60000093 c13085ec 00000000 c03bf5f4 00000001
00000080 00000000 c0438d18
[   17.800787] dee0: 00000000 00000000 c1bcd804 00000001 c1bcd7c0
c1bcd804 cfe1df40 c0438d18
[   17.809009] df00: 00000000 60000013 00000001 c03f6064 00000001
00000000 c0438d18 00000000
[   17.817231] df20: cfc73800 cfe1df40 00000001 00000000 beec47b8
cf979900 beec47b8 00000000
[   17.825453] df40: 00000128 c03011c4 cfe1c000 00000128 00000000
c0a6c314 00000000 00000000
[   17.833674] df60: 00000000 fffffff7 cfe1deb0 0000000c 00000001
00000000 00000000 cfe1de80
[   17.841894] df80: 00000000 00000128 00000000 00000000 00000040
00000000 00000000 012d71c8
[   17.850117] dfa0: beec47b8 c03011a0 00000000 012d71c8 0000000d
beec47b8 00000000 00000000
[   17.858339] dfc0: 00000000 012d71c8 beec47b8 00000128 0000005d
012bb998 012d78e8 00000000
[   17.866561] dfe0: b6efbad4 beec4780 b6d40780 b6c35548 60000010
0000000d 00000000 00000000
[   17.874805] [<c0ab03b4>] (sk_filter_trim_cap) from [<c0addd48>]
(netlink_broadcast_filtered+0x2e0/0x3bc)
[   17.884341] [<c0addd48>] (netlink_broadcast_filtered) from
[<c0adde48>] (netlink_broadcast+0x24/0x2c)
[   17.893615] [<c0adde48>] (netlink_broadcast) from [<c0ae0c5c>]
(netlink_sendmsg+0x338/0x370)
[   17.902107] [<c0ae0c5c>] (netlink_sendmsg) from [<c0a6ac80>]
(sock_sendmsg+0x3c/0x4c)
[   17.909986] [<c0a6ac80>] (sock_sendmsg) from [<c0a6b4c4>]
(___sys_sendmsg+0x1e4/0x228)
[   17.917949] [<c0a6b4c4>] (___sys_sendmsg) from [<c0a6c314>]
(__sys_sendmsg+0x48/0x6c)
[   17.925828] [<c0a6c314>] (__sys_sendmsg) from [<c03011a0>]
(__sys_trace_return+0x0/0x10)
[   17.933957] Exception stack(0xcfe1dfa8 to 0xcfe1dff0)
[   17.939037] dfa0:                   00000000 012d71c8 0000000d
beec47b8 00000000 00000000
[   17.947259] dfc0: 00000000 012d71c8 beec47b8 00000128 0000005d
012bb998 012d78e8 00000000
[   17.955478] dfe0: b6efbad4 beec4780 b6d40780 b6c35548
[   17.960563] Code: 1afffff7 e59c0000 e5830000 e3520000 (e584800c)
[   17.966827] ---[ end trace 27a2820a2162a4fd ]---
