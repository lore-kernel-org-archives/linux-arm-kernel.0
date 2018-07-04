From: daniel@iogearbox.net (Daniel Borkmann)
Date: Thu, 5 Jul 2018 01:10:20 +0200
Subject: [offlist] Re: Crash in netlink/sk_filter_trim_cap on ARMv7 on
 4.18rc1
In-Reply-To: <CALeDE9OJomWstG+AcftR543WBi5Bo8ANQj3T-pOW3BfBNzB=uw@mail.gmail.com>
References: <CALeDE9PP__kPHX_aW24kwzGf9BgA0gQOQJSY+Qw0yFMOLn4Pcw@mail.gmail.com>
 <7ff516fd-1d01-4d7a-1d5d-b58932c0c69d@gmail.com>
 <CALeDE9Nkz+cbueruiez_43ZS1ebAiQHDaVZRARE8raypYz323A@mail.gmail.com>
 <ad98d60c-bd60-b495-c4bd-507fc29c8bcd@iogearbox.net>
 <CALeDE9PBZWJBp8KB0mB4zoNXqscmzxWzz+LnuqRA-z4t1e9T8g@mail.gmail.com>
 <CALeDE9OOrZUnaNpzkYPU30iN=4HFQaqEomjf14EO5EtcnHu8OQ@mail.gmail.com>
 <CALeDE9MykqKyk5hJKn2OxZx2USW76ySm8Wxsw3eVgxa2g7PKXg@mail.gmail.com>
 <fe05405a-c06d-d8fe-07fa-5840e498bb13@iogearbox.net>
 <CALeDE9OJomWstG+AcftR543WBi5Bo8ANQj3T-pOW3BfBNzB=uw@mail.gmail.com>
Message-ID: <fc5ab18a-922c-ea53-f9f3-fd5073c43248@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/2018 09:33 AM, Peter Robinson wrote:
> On Tue, Jun 26, 2018 at 1:52 PM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 06/26/2018 02:23 PM, Peter Robinson wrote:
>>>>>> On 06/24/2018 11:24 AM, Peter Robinson wrote:
>>>>>>>>> I'm seeing this netlink/sk_filter_trim_cap crash on ARMv7 across quite
>>>>>>>>> a few ARMv7 platforms on Fedora with 4.18rc1. I've tested RPi2/RPi3
>>>>>>>>> (doesn't happen on aarch64), AllWinner H3, BeagleBone and a few
>>>>>>>>> others, both LPAE/normal kernels.
>>>>>>
>>>>>> So this is arm32 right?
>>>>>
>>>>> Correct.
>>>>>
>>>>>>>>> I'm a bit out of my depth in this part of the kernel but I'm wondering
>>>>>>>>> if it's known, I couldn't find anything that looked obvious on a few
>>>>>>>>> mailing lists.
>>>>>>>>>
>>>>>>>>> Peter
>>>>>>>>
>>>>>>>> Hi Peter
>>>>>>>>
>>>>>>>> Could you provide symbolic information ?
>>>>>>>
>>>>>>> I passed in through scripts/decode_stacktrace.sh is that what you were after:
>>>>>>>
>>>>>>> [    8.673880] Internal error: Oops: a06 [#10] SMP ARM
>>>>>>> [    8.673949] ---[ end trace 049df4786ea3140a ]---
>>>>>>> [    8.678754] Modules linked in:
>>>>>>> [    8.678766] CPU: 1 PID: 206 Comm: systemd-udevd Tainted: G      D
>>>>>>>         4.18.0-0.rc1.git0.1.fc29.armv7hl+lpae #1
>>>>>>> [    8.678769] Hardware name: Allwinner sun8i Family
>>>>>>> [    8.678781] PC is at sk_filter_trim_cap ()
>>>>>>> [    8.678790] LR is at   (null)
>>>>>>> [    8.709463] pc : lr : psr: 60000013 ()
>>>>>>> [    8.715722] sp : c996bd60  ip : 00000000  fp : 00000000
>>>>>>> [    8.720939] r10: ee79dc00  r9 : c12c9f80  r8 : 00000000
>>>>>>> [    8.726157] r7 : 00000000  r6 : 00000001  r5 : f1648000  r4 : 00000000
>>>>>>> [    8.732674] r3 : 00000007  r2 : 00000000  r1 : 00000000  r0 : 00000000
>>>>>>> [    8.739193] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>>>>>>> [    8.746318] Control: 30c5387d  Table: 6e7bc880  DAC: ffe75ece
>>>>>>> [    8.752055] Process systemd-udevd (pid: 206, stack limit = 0x(ptrval))
>>>>>>> [    8.758574] Stack: (0xc996bd60 to 0xc996c000)
>>>>>>
>>>>>> Do you have BPF JIT enabled or disabled? Does it happen with disabled?
>>>>>
>>>>> Enabled, I can test with it disabled, BPF configs bits are:
>>>>> CONFIG_BPF_EVENTS=y
>>>>> # CONFIG_BPFILTER is not set
>>>>> CONFIG_BPF_JIT_ALWAYS_ON=y
>>>>> CONFIG_BPF_JIT=y
>>>>> CONFIG_BPF_STREAM_PARSER=y
>>>>> CONFIG_BPF_SYSCALL=y
>>>>> CONFIG_BPF=y
>>>>> CONFIG_CGROUP_BPF=y
>>>>> CONFIG_HAVE_EBPF_JIT=y
>>>>> CONFIG_IPV6_SEG6_BPF=y
>>>>> CONFIG_LWTUNNEL_BPF=y
>>>>> # CONFIG_NBPFAXI_DMA is not set
>>>>> CONFIG_NET_ACT_BPF=m
>>>>> CONFIG_NET_CLS_BPF=m
>>>>> CONFIG_NETFILTER_XT_MATCH_BPF=m
>>>>> # CONFIG_TEST_BPF is not set
>>>>>
>>>>>> I can see one bug, but your stack trace seems unrelated.
>>>>>>
>>>>>> Anyway, could you try with this?
>>>>>
>>>>> Build in process.
>>>>>
>>>>>> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
>>>>>> index 6e8b716..f6a62ae 100644
>>>>>> --- a/arch/arm/net/bpf_jit_32.c
>>>>>> +++ b/arch/arm/net/bpf_jit_32.c
>>>>>> @@ -1844,7 +1844,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>>>>>>                 /* there are 2 passes here */
>>>>>>                 bpf_jit_dump(prog->len, image_size, 2, ctx.target);
>>>>>>
>>>>>> -       set_memory_ro((unsigned long)header, header->pages);
>>>>>> +       bpf_jit_binary_lock_ro(header);
>>>>>>         prog->bpf_func = (void *)ctx.target;
>>>>>>         prog->jited = 1;
>>>>>>         prog->jited_len = image_size;
>>>>
>>>> So with that and the other fix there was no improvement, with those
>>>> and the BPF JIT disabled it works, I'm not sure if the two patches
>>>> have any effect with the JIT disabled though.
>>>>
>>>> Will look at the other patches shortly, there's been some other issue
>>>> introduced between rc1 and rc2 which I have to work out before I can
>>>> test those though.
>>>
>>> Quick update, with linus's head as of yesterday, basically rc2 plus
>>> davem's network fixes it works if the JIT is disabled IE:
>>> # CONFIG_BPF_JIT_ALWAYS_ON is not set
>>> # CONFIG_BPF_JIT is not set
>>>
>>> If I enable it the boot breaks even worse than the errors above in
>>> that I get no console output at all, even with earlycon, so we've gone
>>> backwards since rc1 somehow.
>>>
>>> I'll try the above two reverted unless you have any other suggestions.
>>
>> Ok, thanks, lets do that!
>>
>> I'm still working on fixes meanwhile, should have something by end of day.
> 
> Sorry for the delay on this from my end. I noticed there was some bpf
> bits land in the last net fixes pull request landed Monday so I built
> a kernel with the JIT reenabled. It seems it's improved in that the
> completely dead no output boot has gone but the original problem that
> arrived in the merge window still persists:

Okay, thanks a lot! And on top of that tree could you try with the below
applied to check whether it fixes the issue?

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index f6a62ae..45e6b49 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -234,11 +234,11 @@ static void jit_fill_hole(void *area, unsigned int size)
 #define SCRATCH_SIZE 80

 /* total stack size used in JITed code */
-#define _STACK_SIZE	(ctx->prog->aux->stack_depth + SCRATCH_SIZE)
+#define _STACK_SIZE	(ctx->prog->aux->stack_depth + SCRATCH_SIZE + 4)
 #define STACK_SIZE	ALIGN(_STACK_SIZE, STACK_ALIGNMENT)

 /* Get the offset of eBPF REGISTERs stored on scratch space. */
-#define STACK_VAR(off) (STACK_SIZE - off)
+#define STACK_VAR(off) (STACK_SIZE - 4 - off)

 #if __LINUX_ARM_ARCH__ < 7
