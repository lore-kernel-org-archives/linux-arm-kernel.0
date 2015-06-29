From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 29 Jun 2015 11:23:54 +0200
Subject: [PATCH v3 3/6] rtc: mxc: use a second rtc clock
In-Reply-To: <1434820360-21935-4-git-send-email-tremyfr@gmail.com>
References: <1434820360-21935-1-git-send-email-tremyfr@gmail.com>
 <1434820360-21935-4-git-send-email-tremyfr@gmail.com>
Message-ID: <20150629092354.GW485@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/06/2015 at 19:12:37 +0200, Philippe Reynes wrote :
> -	rate = clk_get_rate(pdata->clk);
> +	pdata->clk_rtc = devm_clk_get(&pdev->dev, "rtc");
> +	if (IS_ERR(pdata->clk_rtc)) {
> +		dev_err(&pdev->dev, "unable to get rtc clock!\n");
> +		ret = PTR_ERR(pdata->clk_rtc);
> +		goto exit_put_clk;
> +	}
> +
> +	rate = clk_get_rate(pdata->clk_rtc);
>  

You have to prepare_enable() before using get_rate(). Else, it is not
guaranteed to work:
"clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
                This is only valid once the clock source has been enabled."
http://lxr.free-electrons.com/source/include/linux/clk.h#L269

It may work right now because the clock is enabled elsewhere. But that
may change at some point in time (we had the issue on at91).


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
