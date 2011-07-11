From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Tue, 12 Jul 2011 04:59:10 +0530
Subject: [PATCH v14 04/12] OMAP2+: dmtimer: convert to platform devices
In-Reply-To: <20110711231935.GB8312@google.com>
References: <1310383759-19059-1-git-send-email-tarun.kanti@ti.com>
	<1310383759-19059-5-git-send-email-tarun.kanti@ti.com>
	<20110711231935.GB8312@google.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB037BE78070@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Todd Poynor [mailto:toddpoynor at google.com]
> Sent: Tuesday, July 12, 2011 4:50 AM
> To: DebBarma, Tarun Kanti
> Cc: linux-omap at vger.kernel.org; Hilman, Kevin; Shilimkar, Santosh;
> tony at atomide.com; linux-arm-kernel at lists.infradead.org; Gopinath, Thara
> Subject: Re: [PATCH v14 04/12] OMAP2+: dmtimer: convert to platform
> devices
> 
> On Mon, Jul 11, 2011 at 04:59:11PM +0530, Tarun Kanti DebBarma wrote:
> > Add routines to converts dmtimers to platform devices. The device data
> > is obtained from hwmod database of respective platform and is registered
> > to device model after successful binding to driver.
> > In addition, capability attribute of each of the timers is added in
> > hwmod database.
> >
> ...
> > +static int omap2_dm_timer_set_src(struct platform_device *pdev, int
> source)
> > +{
> > +	int ret;
> > +	struct dmtimer_platform_data *pdata = pdev->dev.platform_data;
> > +	struct clk *fclk, *parent;
> > +	char *parent_name = NULL;
> > +
> > +	fclk = clk_get(&pdev->dev, "fck");
> > +	if (IS_ERR_OR_NULL(fclk)) {
> > +		dev_err(&pdev->dev, "%s: %d: clk_get() FAILED\n",
> > +				__func__, __LINE__);
> > +		return -EINVAL;
> > +	}
> > +
> > +	switch (source) {
> > +	case OMAP_TIMER_SRC_SYS_CLK:
> > +		parent_name = "sys_ck";
> > +		break;
> > +
> > +	case OMAP_TIMER_SRC_32_KHZ:
> > +		parent_name = "32k_ck";
> > +		break;
> > +
> > +	case OMAP_TIMER_SRC_EXT_CLK:
> > +		if (pdata->timer_ip_type == OMAP_TIMER_IP_VERSION_1) {
> > +			parent_name = "alt_ck";
> > +			break;
> > +		}
> > +		dev_err(&pdev->dev, "%s: %d: invalid clk src.\n",
> > +			__func__, __LINE__);
> > +		return -EINVAL;
> 
> Should clk_put(fclk);
Ok.

> 
> ...
> > +	pdata = kzalloc(sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata) {
> > +		pr_err("%s: No memory for [%s]\n", __func__, oh->name);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	/*
> > +	 * Extract the IDs from name field in hwmod database
> > +	 * and use the same for constructing ids' for the
> > +	 * timer devices. In a way, we are avoiding usage of
> > +	 * static variable witin the function to do the same.
> > +	 * CAUTION: We have to be careful and make sure the
> > +	 * name in hwmod database does not change in which case
> > +	 * we might either make corresponding change here or
> > +	 * switch back static variable mechanism.
> > +	 */
> > +	sscanf(oh->name, "timer%2d", &id);
> > +
> > +	pdata->set_timer_src = omap2_dm_timer_set_src;
> > +	pdata->timer_ip_type = oh->class->rev;
> > +	pdata->needs_manual_reset = 0;
> 
> Can omit init to zero of kzalloc'ed mem.
Sure. Thanks.
--
Tarun
> 
> 
> Todd
