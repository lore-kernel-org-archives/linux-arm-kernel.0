From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 3 Nov 2018 20:17:04 +0100
Subject: [PATCH 4/4] ARM: mmp/mmp2: dt: enable the clock
In-Reply-To: <20180918205455.25464-5-lkundrak@v3.sk>
References: <20180918205455.25464-1-lkundrak@v3.sk>
 <20180918205455.25464-5-lkundrak@v3.sk>
Message-ID: <20181103191703.GJ31179@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2018-09-18 22:54:55, Lubomir Rintel wrote:
> The device-tree booted MMP2 needs to enable the timer clock, otherwise
> the it would stop ticking when the boot finishes.

"the it" -> "it"

> It can also use the clock rate from the clk, the non-DT boards need to
> keep using the hardcoded rates.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> +	clk = of_clk_get(np, 0);
> +	if (!IS_ERR(clk)) {
> +		ret = clk_prepare_enable(clk);
> +		if (ret)
> +			goto out;
> +		rate = clk_get_rate(clk) / 2;
> +	} else if (cpu_is_pj4 ()) {

extra space.

> +		rate = 6500000;
> +	} else {
> +		rate = 3250000;
> +	}
> +
>  	irq = irq_of_parse_and_map(np, 0);
>  	if (!irq) {
>  		ret = -EINVAL;
> @@ -231,7 +239,7 @@ void __init mmp_dt_init_timer(void)
>  		ret = -ENOMEM;
>  		goto out;
>  	}
> -	timer_init(irq);
> +	timer_init(irq, rate);
>  	return;
>  out:
>  	pr_err("Failed to get timer from device tree with error:%d\n", ret);

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181103/a5f27dd5/attachment.sig>
