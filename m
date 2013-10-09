From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 9 Oct 2013 15:35:48 +0100
Subject: [PATCH 22/23] ARM: cci: driver need big endian fixes in asm code
In-Reply-To: <1381271679-27804-23-git-send-email-ben.dooks@codethink.co.uk>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
 <1381271679-27804-23-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20131009143543.GA2306@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 09, 2013 at 12:34:38AM +0200, Ben Dooks wrote:
> From: Victor Kamensky <victor.kamensky@linaro.org>
> 
> cci_enable_port_for_self written in asm and it works with h/w
> registers that are in little endian format. When run in big
> endian mode it needs byte swap before/after it writes/reads
> to/from such registers

I had a play with an alternate way of doing this that may be a bit
cleaner, posted as a separate mini-series.  See:

ARM: Unify const-swabbing and conditional asm
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-October/203479.html

Cheers
---Dave

> 
> CC: Lorenzon Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/bus/arm-cci.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bus/arm-cci.c b/drivers/bus/arm-cci.c
> index 2009266..6db173e 100644
> --- a/drivers/bus/arm-cci.c
> +++ b/drivers/bus/arm-cci.c
> @@ -281,6 +281,9 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>  	/* Enable the CCI port */
>  "	ldr	r0, [r0, %[offsetof_port_phys]] \n"
>  "	mov	r3, #"__stringify(CCI_ENABLE_REQ)" \n"
> +#ifdef __ARMEB__
> +"	rev	r3, r3 \n"
> +#endif /* __ARMEB__ */
>  "	str	r3, [r0, #"__stringify(CCI_PORT_CTRL)"] \n"
>  
>  	/* poll the status reg for completion */
> @@ -288,6 +291,9 @@ asmlinkage void __naked cci_enable_port_for_self(void)
>  "	ldr	r0, [r1] \n"
>  "	ldr	r0, [r0, r1]		@ cci_ctrl_base \n"
>  "4:	ldr	r1, [r0, #"__stringify(CCI_CTRL_STATUS)"] \n"
> +#ifdef __ARMEB__
> +"	rev	r1, r1 \n"
> +#endif /* __ARMEB__ */
>  "	tst	r1, #1 \n"
>  "	bne	4b \n"
>  
> -- 
> 1.8.4.rc3
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
