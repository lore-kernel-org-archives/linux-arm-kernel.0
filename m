From: khilman@linaro.org (Kevin Hilman)
Date: Thu, 29 Aug 2013 10:20:25 -0700
Subject: [PATCH v2 3/3] ARM: OMAP4+: Remove static iotable mappings for
 SRAM
In-Reply-To: <1377775391-13103-4-git-send-email-rnayak@ti.com> (Rajendra
 Nayak's message of "Thu, 29 Aug 2013 16:53:11 +0530")
References: <1377775391-13103-1-git-send-email-rnayak@ti.com>
 <1377775391-13103-4-git-send-email-rnayak@ti.com>
Message-ID: <871u5c2z3a.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rajendra Nayak <rnayak@ti.com> writes:

> In order to handle errata I688, a page of sram was reserved by doing a
> static iotable map. Now that we use gen_pool to manage sram, we can
> completely remove all of these static mappings and use gen_pool_alloc()
> to get the one page of sram space needed to implement errata I688.
>
> Suggested-by: Sekhar Nori <nsekhar@ti.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

[...]

> @@ -71,6 +72,21 @@ void omap_bus_sync(void)
>  }
>  EXPORT_SYMBOL(omap_bus_sync);
>  
> +static int __init omap4_sram_init(void)
> +{
> +	struct device_node *np;
> +	struct gen_pool *sram_pool;
> +
> +	np = of_find_compatible_node(NULL, NULL, "ti,omap4-mpu");
> +	if (!np)
> +		pr_warn("%s:Unable to allocate sram needed to handle errata I688\n",
> +			 __func__);
> +	sram_pool = of_get_named_gen_pool(np, "sram", 0);

I haven't actually tested this, but if there is no 'sram' property defined...
  
> +	sram_sync = (void *)gen_pool_alloc(sram_pool, PAGE_SIZE);

... does this still behave properly?

> +	return 0;
> +}

Kevin
