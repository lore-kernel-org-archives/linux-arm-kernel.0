From: John.Linn@xilinx.com (John Linn)
Date: Sun, 6 Nov 2011 19:11:24 -0700
Subject: [PATCH] ARM: Allow kernel unaligned accesses on ARMv6+ processors
In-Reply-To: <1320489687-9642-1-git-send-email-catalin.marinas@arm.com>
References: <1320489687-9642-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <8e74d1d8-0772-4770-8ce6-5d362cb58009@VA3EHSMHS018.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at gmail.com] On Behalf Of
> Catalin Marinas
> Sent: Saturday, November 05, 2011 3:41 AM
> To: linux-arm-kernel at lists.infradead.org
> Cc: John Linn
> Subject: [PATCH] ARM: Allow kernel unaligned accesses on ARMv6+
> processors
> 
> Recent gcc versions generate unaligned accesses by default on ARMv6
and
> later processors. This patch ensures that the SCTLR.A bit is always
> cleared on such processors to avoid kernel traping before
> alignment_init() is called.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Cc: John Linn <John.Linn@xilinx.com>

It worked great, thanks Catalin. I'd love to see a solution merged in
the mainline and this seems reasonable.
I'm being pushed to newer tools which require a solution.

Tested-by: John Linn <john.linn@xilinx.com>

> ---
>  arch/arm/kernel/head.S |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
> index a400a4d..1768db2 100644
> --- a/arch/arm/kernel/head.S
> +++ b/arch/arm/kernel/head.S
> @@ -394,7 +394,7 @@ __secondary_data:
>   *  r13 = *virtual* address to jump to upon completion
>   */
>  __enable_mmu:
> -#ifdef CONFIG_ALIGNMENT_TRAP
> +#if defined(CONFIG_ALIGNMENT_TRAP) && __LINUX_ARM_ARCH__ < 6
>  	orr	r0, r0, #CR_A
>  #else
>  	bic	r0, r0, #CR_A

**** Please ignore the following footer which I'm still working on
getting removed, this IS open source information ***

This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
