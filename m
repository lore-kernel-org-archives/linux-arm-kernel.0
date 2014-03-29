From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Mar 2014 22:03:19 -0400 (EDT)
Subject: [PATCH RFC 0/3] arm64: NEON crypto under CONFIG_PREEMPT
In-Reply-To: <1396004735-15475-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1396004735-15475-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <alpine.LFD.2.11.1403282155290.1571@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Mar 2014, Ard Biesheuvel wrote:

> This series is an attempt to reduce latency under CONFIG_PREEMPT while
> maintaining optimal throughput otherwise, i.e., under !CONFIG_PREEMPT or
> while running outside of process context.
> 
> In the in_interrupt() case, the calls to kernel_neon_begin and kernel_neon_end
> incur a fixed penalty (i.e., each call needs to stack/unstack a fixed number of
> registers), and preemption is not possible anyway, so the call into the crypto
> algorithm should just complete as fast as possible, ideally by processing all
> of the input in the core loop without having to spill state to memory or reload
> round keys (e.g., SHA-256 uses 64 32-bit round keys to process each input block
> of 64 bytes)
> 
> In contrast, when running in process context, we should avoid hogging the CPU by
> spending unreasonable amounts of time inside a kernel_neon_begin/kernel_neon_end
> section. However, reloading those 64 32-byte round keys to process each 64-byte
> block one by one is far from optimal.
> 
> The solution proposed here is to allow the inner loops of the crypto algorithms
> to test the TIF_NEED_RESCHED flag, and terminate early if it is set. This is
> essentially CONFIG_PREEMPT_VOLUNTARY, even under CONFIG_PREEMPT, but it is the
> best we can do when running with preemption disabled.
> 
> Patch #1 introduces the shared asm macro, patches #2 and #3 are the SHA-1 and
> SHA-224/SHA-256 implementations I posted earlier, but reworked to utilize
> voluntary preemption.

How extensive is the required rework?  If reasonably small, I think this 
would be better to have #2 and #3 as patches to be applied on top of 
your initial implementations instead.  It helps with patch review, and 
it makes it easier in the occurrence of a problem to tell users to just 
revert commit xyz in order to get the SHA code without voluntary 
preemption for testing.


Nicolas
