From: gadiyar@ti.com (Gadiyar, Anand)
Date: Mon, 14 Dec 2009 17:58:36 +0530
Subject: [PATCH] ARMv7: fix Oprofile events count
In-Reply-To: <1260790811.8106.2.camel@def-laptop>
References: <1260790811.8106.2.camel@def-laptop>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB030ADD4F9E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet wrote:
> 
> Hi,
> 
> Here is a patch that fixes the oprofile events count.
> If it is OK I will submit it to the patch system.
> 
> Any thought?
> 
> Regards,
> Jean
> 
> ---
> ARMv7: fix Oprofile events count
>     
>     On Oprofile ARMv7 the PMNC_D bit was set to lower the PMU IRQs
>     and so to decrease the risk of errata #628216 from appearing.
>     The effect of setting the PMNC_D bit is that the CCNT counter
>     is divided by 64, making the program counter events count
>     inaccurate.
>     The new OMAP3 r4 cores should have that errata fixed.
>     
>     The PMNC_D bit should not be set, this patch fixes it.


Not an expert, so this is just a general comment.

Many OMAP3's don't have this newer core, right?
Does it make sense to clear this bit for all ARMv7s?

- Anand

>     
>     Signed-off-by: Jean Pihet <jpihet@mvista.com>
> 
> diff --git a/arch/arm/oprofile/op_model_v7.c
> b/arch/arm/oprofile/op_model_v7.c
> index f20295f..2088a6c 100644
> --- a/arch/arm/oprofile/op_model_v7.c
> +++ b/arch/arm/oprofile/op_model_v7.c
> @@ -191,12 +191,8 @@ int armv7_setup_pmnc(void)
>                 return -EBUSY;
>         }
>  
> -       /*
> -        * Initialize & Reset PMNC: C bit, D bit and P bit.
> -        *  Note: Using a slower count for CCNT (D bit: divide by 64) results
> -        *   in a more stable system
> -        */
> -       armv7_pmnc_write(PMNC_P | PMNC_C | PMNC_D);
> +       /* Initialize & Reset PMNC: C bit and P bit */
> +       armv7_pmnc_write(PMNC_P | PMNC_C);
>  
>  
>         for (cnt = CCNT; cnt < CNTMAX; cnt++) {
> 
> 
> 
> 
