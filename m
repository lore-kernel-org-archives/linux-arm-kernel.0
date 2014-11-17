From: mturquette@linaro.org (Mike Turquette)
Date: Mon, 17 Nov 2014 11:25:55 -0800
Subject: [PATCH v1 1/5] clk: pxa: fix pxa27x CCCR bit usage
In-Reply-To: <1412636881-6211-2-git-send-email-robert.jarzmik@free.fr>
References: <1412636881-6211-1-git-send-email-robert.jarzmik@free.fr>
 <1412636881-6211-2-git-send-email-robert.jarzmik@free.fr>
Message-ID: <20141117192555.25314.18664@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Robert Jarzmik (2014-10-06 16:07:57)
> Trivial fix to check the A bit of CCCR for memory frequency
> calculations, where the shift of the bit index was missing, triggering a
> wrong calculation of memory frequency.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>

Applied to clk-fixes towards -rc6.

Regards,
Mike

> ---
>  drivers/clk/pxa/clk-pxa27x.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/clk/pxa/clk-pxa27x.c b/drivers/clk/pxa/clk-pxa27x.c
> index b345cc7..88b9fe1 100644
> --- a/drivers/clk/pxa/clk-pxa27x.c
> +++ b/drivers/clk/pxa/clk-pxa27x.c
> @@ -322,7 +322,7 @@ static unsigned long clk_pxa27x_memory_get_rate(struct clk_hw *hw,
>         unsigned long ccsr = CCSR;
>  
>         osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
> -       a = cccr & CCCR_A_BIT;
> +       a = cccr & (1 << CCCR_A_BIT);
>         l  = ccsr & CCSR_L_MASK;
>  
>         if (osc_forced || a)
> @@ -341,7 +341,7 @@ static u8 clk_pxa27x_memory_get_parent(struct clk_hw *hw)
>         unsigned long ccsr = CCSR;
>  
>         osc_forced = ccsr & (1 << CCCR_CPDIS_BIT);
> -       a = cccr & CCCR_A_BIT;
> +       a = cccr & (1 << CCCR_A_BIT);
>         if (osc_forced)
>                 return PXA_MEM_13Mhz;
>         if (a)
> -- 
> 2.1.0
> 
