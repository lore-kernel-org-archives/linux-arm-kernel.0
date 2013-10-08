From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 8 Oct 2013 18:51:42 +0100
Subject: [PATCH 2/2] ARM: cci: driver need big endian fixes in asm code
In-Reply-To: <1381207040-1623-3-git-send-email-victor.kamensky@linaro.org>
References: <1381207040-1623-1-git-send-email-victor.kamensky@linaro.org>
 <1381207040-1623-3-git-send-email-victor.kamensky@linaro.org>
Message-ID: <20131008175136.GA3866@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 07, 2013 at 09:37:20PM -0700, Victor Kamensky wrote:
> cci_enable_port_for_self written in asm and it works with h/w
> registers that are in little endian format. When run in big
> endian mode it needs byte swap before/after it writes/reads
> to/from such registers

Lorenzo should comment on this if he's not already seen it.

> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>
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

Hmmm, this is a bit ugly, but we can't easily use ARM_BE8() here.

That would be more easily solved if this was a separate .S file...

Maybe it's not worth it.

Cheers
---Dave

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
> 1.8.1.4
> 
> 
> _______________________________________________
> linaro-kernel mailing list
> linaro-kernel at lists.linaro.org
> http://lists.linaro.org/mailman/listinfo/linaro-kernel
