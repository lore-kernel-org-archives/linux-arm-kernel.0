From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 18 Nov 2014 13:28:15 +0000
Subject: [PATCH v3 1/5] arm64: Kprobes with single stepping support
In-Reply-To: <1416292375-29560-2-git-send-email-dave.long@linaro.org>
References: <1416292375-29560-1-git-send-email-dave.long@linaro.org>
 <1416292375-29560-2-git-send-email-dave.long@linaro.org>
Message-ID: <1416317295.1735.9.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-11-18 at 01:32 -0500, David Long wrote:
> From: Sandeepa Prabhu <sandeepa.prabhu@linaro.org>
> 
> Add support for basic kernel probes(kprobes) and jump probes
> (jprobes) for ARM64.
> 
> Kprobes will utilize software breakpoint and single step debug
> exceptions supported on ARM v8.
> 
> software breakpoint is placed at the probe address to trap the
> kernel execution into kprobe handler.
> 
> ARM v8 support single stepping to be enabled while exception return
> (ERET) with next PC in exception return address (ELR_EL1).
> kprobe handler prepares a executable memory slot for out-of-line
> execution with the copy of the original instruction under probe, and
> enable single stepping from the instruction slot. With this scheme,
> the instruction is executed with the exact same register context
> 'except PC' that points to instruction slot.
> 
> Debug mask(PSTATE.D) is enabled only when single stepping a recursive
> kprobes i.e. during kprobes reenter so that probes instruction can be
> single stepped within the kprobe handler -exception- context.

Does this mean that at the point the probed instruction is
single-stepped there is nothing extra that has been pushed on on the
kernel stack by any kprobes handling code? I just want to check that you
aren't going to hit the problems that the 32-bit kprobes code is
currently being fixed for [1]. 

The simulated instructions in patch 2 don't access the stack, so they
are safe from the problem.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/303525.html

-- 
Tixy
