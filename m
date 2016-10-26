From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 26 Oct 2016 14:56:31 +0100
Subject: [PATCH 7/7] mfd: tps65217: Fix mismatched interrupt number
In-Reply-To: <20161021140106.21531-8-woogyom.kim@gmail.com>
References: <20161021140106.21531-1-woogyom.kim@gmail.com>
 <20161021140106.21531-8-woogyom.kim@gmail.com>
Message-ID: <20161026135631.GC13127@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 21 Oct 2016, Milo Kim wrote:

> Enum value of 'tps65217_irq_type' is not matched with DT parsed hwirq
> number[*].
> 
> The MFD driver gets the IRQ data by referencing hwirq, but the value is
> different. So, irq_to_tps65217_irq() returns mismatched IRQ data.
> Eventually, the power button driver enables not PB but USB interrupt
> when it is probed.
> 
> According to the TPS65217 register map[**], USB interrupt is the LSB.
> This patch synchronizes TPS65217 IRQ index.
> 
> [*]  include/dt-bindings/mfd/tps65217.h
> [**] http://www.ti.com/lit/ds/symlink/tps65217.pdf
> 
> Signed-off-by: Milo Kim <woogyom.kim@gmail.com>
> ---
>  include/linux/mfd/tps65217.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mfd/tps65217.h b/include/linux/mfd/tps65217.h
> index 4ccda89..75a3a5f 100644
> --- a/include/linux/mfd/tps65217.h
> +++ b/include/linux/mfd/tps65217.h
> @@ -235,9 +235,9 @@ struct tps65217_bl_pdata {
>  };
>  
>  enum tps65217_irq_type {
> -	TPS65217_IRQ_PB,
> -	TPS65217_IRQ_AC,
>  	TPS65217_IRQ_USB,
> +	TPS65217_IRQ_AC,
> +	TPS65217_IRQ_PB,
>  	TPS65217_NUM_IRQ
>  };

This is why using enum for these types of assignments is sometimes
dangerous.  It's probably best to be explicit.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
