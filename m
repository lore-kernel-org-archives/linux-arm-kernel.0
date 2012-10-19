From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 Oct 2012 10:40:27 +0100
Subject: Do we need to fix below dump during cpu hot plug operation?
In-Reply-To: <CACRpkdaS3bJwnJMJHRSEukiD4r+62h-0HzL7bKF_Ppa4TFy-xw@mail.gmail.com>
References: <20121019015621.GA17360@nchen-desktop>
 <20121019045802.GA21078@S2101-09.ap.freescale.net>
 <CACRpkdaS3bJwnJMJHRSEukiD4r+62h-0HzL7bKF_Ppa4TFy-xw@mail.gmail.com>
Message-ID: <20121019094027.GF21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 19, 2012 at 11:37:48AM +0200, Linus Walleij wrote:
> @@ -93,6 +94,8 @@ static void twd_timer_stop(struct clock_event_device *clk)
>  {
>  	twd_set_mode(CLOCK_EVT_MODE_UNUSED, clk);
>  	disable_percpu_irq(clk->irq);
> +	if (twd_clk)
> +		clk_disable(twd_clk);

While we're here, can we please ensure that the CLK API is properly
respected, and use IS_ERR(twd_clk) to determine of the clock is valid
or not (and not use IS_ERR_OR_NULL()).
