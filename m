From: tony@atomide.com (Tony Lindgren)
Date: Thu, 17 Oct 2013 16:34:59 -0700
Subject: getting rid of subsys_initcall usage? (was: Re: [PATCH RESEND]
 i2c: designware: use module_platform_driver)
In-Reply-To: <20131008221056.GW8313@atomide.com>
References: <1376987548-12366-1-git-send-email-zhangfei.gao@linaro.org>
 <20130828095706.GH4086@katana>
 <CACRpkdb1p1=3a0PM+r2ZrMN+ECv5BAZFdv2omDK5npaer4ddcw@mail.gmail.com>
 <CAMj5BkhQkwb+T9VepN7UrWNRSgtv=Dw-Sa-gv0orOANo55iqNw@mail.gmail.com>
 <20130830054858.GR7656@atomide.com>
 <CAMj5BkiDExikXi3JcVhO7RN8_82eGYhq3i6oPf5Wbipy=N+iHQ@mail.gmail.com>
 <20130830082712.GT7656@atomide.com> <20131008205304.GA29121@katana>
 <20131008221056.GW8313@atomide.com>
Message-ID: <20131017233459.GH15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [131008 15:19]:
> * Wolfram Sang <wsa@the-dreams.de> [131008 14:01]:
> > On Fri, Aug 30, 2013 at 01:27:13AM -0700, Tony Lindgren wrote:
> > > * zhangfei gao <zhangfei.gao@gmail.com> [130829 23:36]:
> > > > What about concerns from Wolfram:
> > > > " Other people might be
> > > > depending on subsys_initcall to get I2C active before they want to
> > > > activate, say, PMICs. So, I fear regressions, since deferred probing
> > > > might not be available in the needed places to avoid these regressions."
> > > 
> > > There should not be any reason to get a PMIC activated
> > > early on. The system should be booting already at that point,
> > > and the PMIC related init can be done later on.
> > 
> > Okay, here is a more concrete example:
> > 
> > Consider the amplifier driver 'sound/soc/codecs/max9768.c'. Back then, unaware
> > of deferred probing, I wrote the following code to get the GPIOs (which are
> > optional):
> > 
> > 	err = gpio_request_one(pdata->mute_gpio, GPIOF_INIT_HIGH, "MAX9768 Mute");
> > 	max9768->mute_gpio = err ?: pdata->mute_gpio;
> > 
> > And later in the process:
> > 
> >         if (gpio_is_valid(max9768->mute_gpio)) {
> >                 ret = snd_soc_add_codec_controls(codec, max9768_mute,
> >                                 ARRAY_SIZE(max9768_mute));
> >                 if (ret)
> >                         return ret;
> >         }
> > 
> > So, the mute control will only be added if the gpio_request succeeded. On that
> > particular board, the mute GPIO was wired to an I2C GPIO controller. If I now
> > change the I2C (or GPIO) driver from subsys_initcall to module_init, then the
> > gpio_request in the amplifier driver could hit -EPROBE_DEFER and the mute
> > control will then disappear. Yes, the driver can be fixed easily, yet I fear a
> > number of regressions like this. Instead of people digging into why things
> > disappear after a kernel update, I wonder if there is a way to guide users if
> > this happens. I didn't have time for that, though, sadly. Still, it makes me
> > wonder how easily we could shift from subsys_initcall to module_init, although
> > I'd really love to get away from subsys_initcall in device drivers.
> 
> Well it should be pretty trivial to update drivers to use deferred
> probing. Maybe some spatch to check for that in driver probes would
> help getting an idea how many might be affected?
> 
> Anyways, it should be fixed as otherwise we'll just dig ourselves
> deeper into the mess of things not working as loadable modules.

BTW, another place where things can go wrong is if there's an irqchip
driver that is being set up at module_init time. If an interrupt client
driver does irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0), the
resources may not have been initialize for the DT case as those are
populated triggered by of_platform_populate().

The fix there is to use irq = irq_of_parse_and_map(pdev->dev.of_node, 0)
instead. Or somehow make of_platform_populate() support -EPROBE_DEFER.

Just FYI,

Tony

Tony
