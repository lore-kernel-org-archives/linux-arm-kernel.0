From: wangnan0@huawei.com (Wang Nan)
Date: Mon, 8 Dec 2014 14:34:39 +0800
Subject: [PATCH v12 7/7] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <1417791592.2232.5.camel@linaro.org>
References: <1417671172-52915-1-git-send-email-wangnan0@huawei.com>	
 <1417671360-53399-1-git-send-email-wangnan0@huawei.com>	
 <1417710073.2239.10.camel@linaro.org> <5481289E.4060504@huawei.com>	
 <1417774227.2232.1.camel@linaro.org> <1417791592.2232.5.camel@linaro.org>
Message-ID: <5485467F.6060005@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014/12/5 22:59, Jon Medhurst (Tixy) wrote:
> On Fri, 2014-12-05 at 10:10 +0000, Jon Medhurst (Tixy) wrote:
> [...]
>> I'm worried because this whole optimised kprobes has some rather
>> complicated interactions, e.g. can the background thread that changes
>> breakpoints to jumps (or back again?) could occur at the same time
>> another CPU is processing a kprobe that's been hit, or is in the process
>> of removing a probe.
> 
> I think that is a plausible theory. We can have this situation...
> 
> 1. CPU A executes a probe's 'breakpoint' instruction and the undefined
> instruction exception handler is triggered.
> 
> 2. CPU B is executing the kprobes optimisation thread and replaces the
> 'breakpoint' with a branch instruction.
> 
> 3. CPU A reads the invalid instruction from memory and because this is
> now the branch instruction it doesn't match
> KPROBE_ARM_BREAKPOINT_INSTRUCTION which kprobes registered to handle.
> This means the undefined instruction exception is treated as just that,
> execution of an undefined instruction.
> 

I confirmed your theory by printing the buggy instruction:

...
[  474.824206] subls	r9,  r9, r14, lsr r7	@ 9049973e
[  476.954206] subge	r10, r11, r14, asr r7	@ a04ba75e
[  479.014206] sublt	r11, r11, r14, asr r7	@ b04bb75e
[  479.194212] undefined instruction: pc=bf001bbc, instruction=ea01187f
[  479.290190] Internal error: Oops - undefined instruction: 0 [#1] SMP ARM
[  479.370533] Modules linked in: test_kprobes(+)
[  479.423990] CPU: 10 PID: 1410 Comm: insmod Not tainted 3.10.53-HULK2+ #31
[  479.505377] task: c42b72c0 ti: ed4f8000 task.ti: ed4f8000
[  479.570189] PC is at kprobe_arm_test_cases+0x122c/0xfeed [test_kprobes]
...

ea01187f is a branch instruction.

Please help me to review my v14 patch series:

http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/309236.html

In which I fix it by wrapping __arch_optimize_kprobes() using stop_machine().


> The above scenario is the exact reason why arch_disarm_kprobe is
> implemented to always use stop_machine to modify the code and we need to
> ensure the same happens with arch_optimize_kprobes.
> 
