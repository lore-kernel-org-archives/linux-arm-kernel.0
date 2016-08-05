From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 5 Aug 2016 16:40:19 +0200
Subject: [PATCH] Added perf functionality to mmdc driver
In-Reply-To: <20160805143525.28765-1-zhengyu.shen@nxp.com>
References: <20160805143525.28765-1-zhengyu.shen@nxp.com>
Message-ID: <20160805144019.GU6879@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 05, 2016 at 09:35:25AM -0500, Zhengyu Shen wrote:
> $ perf stat -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
> Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':
> 
>          898021787      mmdc/busy-cycles/
>           14819600      mmdc/read-accesses/
>             471.30 MB   mmdc/read-bytes/
>         2815419216      mmdc/total-cycles/
>           13367354      mmdc/write-accesses/
>             427.76 MB   mmdc/write-bytes/
> 
>        5.334757334 seconds time elapsed

This Changelog fails to explain why. Or even wth mmdc is.

> @@ -61,7 +249,22 @@ static int imx_mmdc_probe(struct platform_device *pdev)
>  			__func__);
>  		return -EBUSY;
>  	}
> +	pmu_mmdc = kzalloc(sizeof(struct mmdc_pmu), GFP_KERNEL);
> +	if (!pmu_mmdc) {
> +		pr_err("failed to allocate PMU device!\n");
> +		return -ENOMEM;
> +    }

whitespace fail

> +	mmdc_pmu_init(pmu_mmdc, mmdc_base);
> +	platform_set_drvdata(pdev, pmu_mmdc);
> +	perf_pmu_register(&(pmu_mmdc->pmu), "mmdc", -1);

This seems to suggest there can be multiple mmdc thingies, should the
name reflect this?

> +	return 0;
> +}
