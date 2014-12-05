From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 05 Dec 2014 14:59:52 +0000
Subject: [PATCH v12 7/7] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <1417774227.2232.1.camel@linaro.org>
References: <1417671172-52915-1-git-send-email-wangnan0@huawei.com>
 <1417671360-53399-1-git-send-email-wangnan0@huawei.com>
 <1417710073.2239.10.camel@linaro.org> <5481289E.4060504@huawei.com>
 <1417774227.2232.1.camel@linaro.org>
Message-ID: <1417791592.2232.5.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2014-12-05 at 10:10 +0000, Jon Medhurst (Tixy) wrote:
[...]
> I'm worried because this whole optimised kprobes has some rather
> complicated interactions, e.g. can the background thread that changes
> breakpoints to jumps (or back again?) could occur at the same time
> another CPU is processing a kprobe that's been hit, or is in the process
> of removing a probe.

I think that is a plausible theory. We can have this situation...

1. CPU A executes a probe's 'breakpoint' instruction and the undefined
instruction exception handler is triggered.

2. CPU B is executing the kprobes optimisation thread and replaces the
'breakpoint' with a branch instruction.

3. CPU A reads the invalid instruction from memory and because this is
now the branch instruction it doesn't match
KPROBE_ARM_BREAKPOINT_INSTRUCTION which kprobes registered to handle.
This means the undefined instruction exception is treated as just that,
execution of an undefined instruction.

The above scenario is the exact reason why arch_disarm_kprobe is
implemented to always use stop_machine to modify the code and we need to
ensure the same happens with arch_optimize_kprobes.

-- 
Tixy
