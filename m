From: rostedt@goodmis.org (Steven Rostedt)
Date: Thu, 06 Dec 2012 14:19:41 -0500
Subject: [PATCH] ARM: ftrace: Ensure code modifications are synchronised
 across all cpus
In-Reply-To: <1354817466.30905.13.camel@linaro1.home>
References: <1354817466.30905.13.camel@linaro1.home>
Message-ID: <1354821581.17101.17.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-12-06 at 18:11 +0000, Jon Medhurst (Tixy) wrote:
> When the generic ftrace implementation modifies code for trace-points it
> uses stop_machine() to call ftrace_modify_all_code() on one CPU. This
> ultimately calls the ARM specific function ftrace_modify_code() which
> updates the instruction and then does flush_icache_range(). As this
> cache flushing only operates on the local CPU then other cores may end
> up executing the old instruction if it's still in their icaches.
> 
> This may or may not cause problems for the use of ftrace on kernels
> compiled for ARM instructions. However, Thumb2 instructions can straddle
> two cache lines so its possible for half the old instruction to be in
> the cache and half the new one, leading to the CPU executing garbage.

Hmm, your use of "may or may not" seems as you may not know this answer.
I wonder if you can use the break point method as x86 does now, and
remove the stop machine completely. Basically this is how it works:

add sw breakpoints to all locations to modify (the bp handler just does
a nop over the instruction).

send an IPI to all CPUs to flush their icache.

Modify the non breakpoint part of the instruction with the new
instruction.

send an IPI to all CPUs to flush their icache

Replace the breakpoint with the finished instruction.

Then you don't suffer the stomp_machine() latency hit. The system will
slow a bit due to the breakpoints but there wont be a huge "halt" in the
middle of processing.

-- Steve

> 
> This patch fixes this situation by providing an arch-specific
> implementation of arch_ftrace_update_code() which ensures that after one
> core has modified all the code, the other cores invalidate their icaches
> before continuing.
> 
> Signed-off-by: Jon Medhurst <tixy@linaro.org>
> ---
