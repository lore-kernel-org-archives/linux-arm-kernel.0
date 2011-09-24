From: mika.westerberg@iki.fi (Mika Westerberg)
Date: Sat, 24 Sep 2011 11:13:42 +0300
Subject: [PATCH] arm: proc-v7: pc phy addresses before disable MMU
In-Reply-To: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
References: <1316851370-7284-1-git-send-email-per.forlin@stericsson.com>
Message-ID: <20110924081342.GA2639@mwesterb-mobl.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 24, 2011 at 10:02:50AM +0200, Per Forlin wrote:
> PC runs virtual addresses when calling cpu_v7_reset(). The MMU
> is switched off and "mov pc, r0" sets pc back to
> virtual addresses even though the MMU is switched off.
> This will result in a crash if the pipeline delay after
> MMU disable is one instruction. To prevent this set PC
> to physical addresses before disabling the MMU.
> 
> Signed-off-by: Per Fransson <per.xx.fransson@stericsson.com>
> Signed-off-by: Per Forlin <per.forlin@stericsson.com>
> ---
>  arch/arm/mm/proc-v7.S |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index 9049c07..f26e831 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -64,6 +64,7 @@ ENDPROC(cpu_v7_proc_fin)
>   */
>  	.align	5
>  ENTRY(cpu_v7_reset)
> +	sub	pc, pc, #PAGE_OFFSET+4		@ go to physical addresses

This only works on machines where PHYS_OFFSET is zero.

IIRC, there is a P<->V offset calculated at boot time. Maybe you could use
that instead here?

>  	mrc	p15, 0, r1, c1, c0, 0		@ ctrl register
>  	bic	r1, r1, #0x1			@ ...............m
>   THUMB(	bic	r1, r1, #1 << 30 )		@ SCTLR.TE (Thumb exceptions)
> -- 
> 1.6.3.3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
