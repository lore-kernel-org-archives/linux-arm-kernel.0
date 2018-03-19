From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 19 Mar 2018 14:41:48 +0100
Subject: [PATCH v2 8/8] mmc: sunxi: Add runtime_pm support
In-Reply-To: <CAPDyKFoc0gK3GSdCeswkx13_cEbhMprM3DrJJni99a-Mew5H7A@mail.gmail.com>
References: <cover.e1acb3dc84e043c8342166e7fb45f79be36ab154.1520520655.git-series.maxime.ripard@bootlin.com>
 <052c21c000f64c28fd6b64c4db11e4b706bebf79.1520520655.git-series.maxime.ripard@bootlin.com>
 <CAPDyKFoJ0KftG1VxzdM97ubFJ25M+X0EjgOPc6HxewgyZMPipg@mail.gmail.com>
 <20180315100411.iqcnwqws623ws6yn@flea>
 <CAPDyKFpzi2fbSHPUaJRnBmb7YLCzwD0fTFStXgY1eB136m2gEw@mail.gmail.com>
 <20180315120413.yafkee4wgf4pyulq@flea>
 <CAPDyKFoc0gK3GSdCeswkx13_cEbhMprM3DrJJni99a-Mew5H7A@mail.gmail.com>
Message-ID: <20180319134148.rjbukgfdjqglucp5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

On Thu, Mar 15, 2018 at 01:40:41PM +0100, Ulf Hansson wrote:
> On 15 March 2018 at 13:04, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > Hi,
> >
> > On Thu, Mar 15, 2018 at 11:24:36AM +0100, Ulf Hansson wrote:
> >> >> > +static int sunxi_mmc_runtime_resume(struct device *dev)
> >> >> > +{
> >> >> > +       struct mmc_host *mmc = dev_get_drvdata(dev);
> >> >> > +       struct sunxi_mmc_host *host = mmc_priv(mmc);
> >> >> > +       int ret;
> >> >> > +
> >> >> > +       ret = sunxi_mmc_enable(host);
> >> >> > +       if (ret)
> >> >> > +               return ret;
> >> >> > +
> >> >> > +       sunxi_mmc_power_up(mmc, &mmc->ios);
> >> >>
> >> >> Instead of doing power up, you may need restore some ios settings,
> >> >> such as the clock rate for example.
> >> >>
> >> >> You may also need to restore some registers in sunxi device, in case
> >> >> it's possible that the controller loses context at runtime suspend.
> >> >
> >> > The thing I was precisely trying to avoid was this :)
> >> >
> >> > I could save and restore registers when the MMC controller is put into
> >> > suspend, but that's pretty much exactly the same sequence than what is
> >> > done in the MMC_POWER_UP sequence in .set_ios.
> >>
> >> Well, there may be some overlap.
> >>
> >> >
> >> > So it just felt cleaner to just do the power_up sequence at resume
> >> > time. It avoids having to maintain the list of registers to save and
> >> > restore, and it involves less code overall.
> >>
> >> I understand.
> >>
> >> >
> >> > It suprised me a bit that the core will not call .set_ios with
> >> > MMC_POWER_UP at resume by itself, but I guess there's a good reason
> >> > for that :)
> >>
> >> It does that when it runtime PM manages the mmc/sd/sdio card, don't
> >> confuse that with the mmc host. That's because it needs to follow the
> >> (e)MMC/SD/SDIO spec, which don't allows you to just cut the power to
> >> card without first informing (sending commands) the card about it.
> >
> > Ok. So this might sound a bit trivial, but I'm confused now about what
> > set_ios is supposed to be doing.
> >
> > I thought this was about the MMC controller itself, but from what
> > you're saying, it seems that it is used for both the MMC controller
> > and the MMC card itself, with the powermode being about the MMC card,
> > and the rest about the MMC controller.
> 
> Correct.
> 
> The ->set_ios() ops, is an interface called by the core at points when
> it wants to change some settings for the card. Those settings may or
> may not involve changes to internal controller registers, depending on
> the controller/SoC.
> 
> For example, some mmc controllers have build in support for changing
> (dividing) the clock rate. While others may rely solely on other
> separate clock providers.
> 
> Same goes for powering the mmc card, while I would say it more common
> to use external regulators controlled by the regulator APIs, some
> actually have internal registers needed be change to provide power to
> the card.
> 
> You may have a look at mmci.c, it has these kind of things.

So I guess if I split out the MMC controller initialization into
separate functions, called in both the set_ios callback and the
runtime_resume path, that would be ok for you?

> >
> > I guess we're mixing the two then, especially the power off part that
> > will also reset the controller, or the controller that is initialised
> 
> If you need to reset the controller at runtime resume of the
> controller device, that's controller and SoC specific.

I was talking about:
https://elixir.bootlin.com/linux/v4.16-rc6/source/drivers/mmc/host/sunxi-mmc.c#L899

Ie. in set_ios, with MMC_POWER_DOWN, not during runtime_resume. I
guess from what you were telling me that it's not really advisable?

> > only at power on. Other MMC controller drivers I could find were doing
> > the MMC controller setup unconditionally, so I guess we have room for
> > improvements here.
> 
> Yeah, perhaps they are better safe than sorry. But again, it's device
> and SoC specific.

Ok.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
