From: Rongjun.Ying@csr.com (Rongjun Ying)
Date: Tue, 7 Jan 2014 09:02:19 +0000
Subject: [PATCH v3] extcon: gpio: Add power resume support
In-Reply-To: <52CB9A16.9010305@samsung.com>
References: <1389070590-3139-1-git-send-email-rongjun.ying@csr.com>
 <52CB9A16.9010305@samsung.com>
Message-ID: <86130EF012BDF348AA0D464A4F449478012AC858E6@SHAASIEXM01.ASIA.ROOT.PRI>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Chanwoo Choi [mailto:cw00.choi at samsung.com]
> Sent: Tuesday, January 07, 2014 2:09 PM
> To: RongJun Ying
> Cc: MyungJoo Ham; Barry Song; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; DL-SHA-WorkGroupLinux; Rongjun Ying
> Subject: Re: [PATCH v3] extcon: gpio: Add power resume support
> 
> Hi RongJun,
> 
> On 01/07/2014 01:56 PM, RongJun Ying wrote:
> > From: Rongjun Ying <rongjun.ying@csr.com>
> >
> > When system on the suspend state, Some SoC can't get gpio interrupt.
> > After system resume, need send extcon uevent to userspace.
> >
> > Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
> > Reviewed-by: Barry Song <Baohua.Song@csr.com>
> > ---
> >  -v3:
> >  'check_on_resume' instead of 'load_sleep_irq' as Chanwoo Choi's
> proposal.
> >
> >  drivers/extcon/extcon-gpio.c       |   20 ++++++++++++++++++++
> >  include/linux/extcon/extcon-gpio.h |    1 +
> >  2 files changed, 21 insertions(+), 0 deletions(-)
> >
> > diff --git a/drivers/extcon/extcon-gpio.c
> > b/drivers/extcon/extcon-gpio.c index 7e0dff5..fde52c1 100644
> > --- a/drivers/extcon/extcon-gpio.c
> > +++ b/drivers/extcon/extcon-gpio.c
> > @@ -40,6 +40,7 @@ struct gpio_extcon_data {
> >  	int irq;
> >  	struct delayed_work work;
> >  	unsigned long debounce_jiffies;
> > +	bool check_on_resume;
> >  };
> >
> >  static void gpio_extcon_work(struct work_struct *work) @@ -103,6
> > +104,7 @@ static int gpio_extcon_probe(struct platform_device *pdev)
> >  	extcon_data->gpio_active_low = pdata->gpio_active_low;
> >  	extcon_data->state_on = pdata->state_on;
> >  	extcon_data->state_off = pdata->state_off;
> > +	extcon_data->check_on_resume = pdata->check_on_resume;
> >  	if (pdata->state_on && pdata->state_off)
> >  		extcon_data->edev.print_state = extcon_gpio_print_state;
> >  	if (pdata->debounce) {
> > @@ -159,12 +161,30 @@ static int gpio_extcon_remove(struct
> platform_device *pdev)
> >  	return 0;
> >  }
> >
> > +#ifdef CONFIG_PM_SLEEP
> > +static int gpio_extcon_resume(struct device *dev) {
> > +	struct gpio_extcon_data *extcon_data;
> > +
> > +	extcon_data = dev_get_drvdata(dev);
> > +	if (extcon_data->check_on_resume)
> > +		queue_delayed_work(system_power_efficient_wq,
> > +			&extcon_data->work, extcon_data->debounce_jiffies);
> > +	return 0;
> > +}
> > +#endif
> > +
> > +static const struct dev_pm_ops gpio_extcon_pm_ops = {
> > +	SET_SYSTEM_SLEEP_PM_OPS(NULL, gpio_extcon_resume)
> 
> If CONFIG_PM_SLEEP is undefined, gpio_extcon_pm_ops cannot find
> gpio_extcon_resume function.
> You should define dummy function for gpio_extcon_resume function.
> 
> 
In the include/Linux/pm.h
If CONFIG_PM_SLEEP is undefined, the SET_SYSTEM_SLEEP_PM_OPS macro is bypassed.

#ifdef CONFIG_PM_SLEEP
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
        .suspend = suspend_fn, \
        .resume = resume_fn, \
        .freeze = suspend_fn, \
        .thaw = resume_fn, \
        .poweroff = suspend_fn, \
        .restore = resume_fn,
#else
#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
#endif
> 
> 
>  To report this email as spam click
> https://www.mailcontrol.com/sr/MZbqvYs5QwJvpeaetUwhCQ==
> UfkIuR0P8QH1DW7C+lVo3569nqreWejYcysfmF8UmgH1OQ== .


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
