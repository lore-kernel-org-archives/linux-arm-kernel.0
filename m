From: hzpeterchen@gmail.com (Peter Chen)
Date: Mon, 1 Aug 2016 09:58:57 +0800
Subject: [v3,2/6] power: add power sequence library
In-Reply-To: <c2e3679b-4522-d403-0a98-eb09c5a2c02d@chromium.org>
References: <1469007629-31757-3-git-send-email-peter.chen@nxp.com>
 <c2e3679b-4522-d403-0a98-eb09c5a2c02d@chromium.org>
Message-ID: <20160801015857.GA15388@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 29, 2016 at 01:06:48PM -0700, Matthias Kaehlcke wrote:
> Hi Peter,
> 
> Thanks for your work on this, a few comments inline
> 
> 
> On 07/20/2016 02:40 AM, Peter Chen wrote:
> 
> >...
> >
> >+static int pwrseq_generic_on(struct device_node *np, struct pwrseq *pwrseq)
> >+{
> >
> >...
> >
> >+	if (gpiod_reset) {
> >+		u32 duration_us = 50;
> >+
> >+		of_property_read_u32(np, "reset-duration-us",
> >+				&duration_us);
> >+		usleep_range(duration_us, duration_us + 10);
> The end of the range could allow for more margin. Also consider busy
> looping for very short delays as in
> http://lxr.free-electrons.com/source/drivers/regulator/core.c#L2062

Thanks, I will change it.

> >...
> >
> >+static int pwrseq_generic_get(struct device_node *np, struct pwrseq *pwrseq)
> >+{
> >+	struct pwrseq_generic *pwrseq_gen = to_generic_pwrseq(pwrseq);
> >+	enum of_gpio_flags flags;
> >+	int reset_gpio, ret = 0;
> >+
> >+	pwrseq_gen->clk = of_clk_get_by_name(np, NULL);
> This only gets the first of potentially multiple clocks, is that intended?

Since it is ran before the driver's probe, we thought one clock for
power sequence is enough. If your case really needs several clocks
to be enabled before your device can be found by bus, let me know.
I will add support for it. But what are the name for clocks, since
it is generic library? "gen1, gen2 and gen3"?

-- 

Best Regards,
Peter Chento 
