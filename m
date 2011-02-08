From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 8 Feb 2011 22:06:20 +0530
Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
In-Reply-To: <20110117192050.GE23331@n2100.arm.linux.org.uk>
References: <20110117192050.GE23331@n2100.arm.linux.org.uk>
Message-ID: <0557426516de482c1769a50fa0b5f17a@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Tuesday, January 18, 2011 12:51 AM
> To: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org
> Subject: [PATCH 00/14] Fix issues with ARMv6+v6k+v7 kernels
>
> This patch series reworks the ARMv6/ARMv6K support options, code
> selection, and bit operations such that it's possible to safely
> build a kernel which supports ARMv6, ARMv6K, ARMv7 and ARMv7 SMP
> in one image.
>
> Currently, we use CPU_V6 for both ARMv6 and ARMv6K, setting
> CPU_32v6K
> if we have the K extensions.  CPU_32v6K directly controlled whether
> we should include the ARMv6K instructions (clrex, load/store
> exclusive
> byte, half-word, double).  As the bitops code uses the load/store
> exclusive byte operations, unsetting CPU_32v6K results in these
> falling back to their non-SMP local-irq-disabling variants.  These
> are only safe in uniprocessor environments.
>
> So, the first two patches convert the bitops to use the ARMv6
> load/store
> exclusive word operations - and ensuring correctness by ensuring
> that
> the pointer passed in is word-aligned.
>
> We then introduce a new CPU_V6K which indicates that we're including
> an ARMv6K CPU in the build, which frees up CPU_V6 to mean that we're
> including an ARMv6 non-K CPU.
>
> We can then use CPU_V6 to ensure that the non-v6K code paths which
> are
> still SMP safe are selected.
>
> Without this patch set, such a kernel will be unsafe when run on
> SMP platforms as it omits necessary SMP code to ensure that bit
> operations are safe.
> --

Have tested this series on OMAP4430 and OMAP3430.
Don't know if it helps to push some of these patches to be part
of rc cycles. At least the SMP specific fixes should get merged
otherwise, builds like omap2plus_defconfig won't be running
right configuration on SMP machine.

Regards,
Santosh
