From: contact@paulk.fr (Paul Kocialkowski)
Date: Tue, 29 Dec 2015 12:13:33 +0100
Subject: [PATCH 4/6] regulator: lp872x: Add enable GPIO pin support
In-Reply-To: <5681D7A8.2030101@ti.com>
References: <1450868319-20513-1-git-send-email-contact@paulk.fr>
 <1450868319-20513-5-git-send-email-contact@paulk.fr>
 <20151223115632.GS16023@sirena.org.uk> <568088B4.6090207@ti.com>
 <1451342963.14631.13.camel@collins> <5681D7A8.2030101@ti.com>
Message-ID: <1451387613.18148.9.camel@collins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Milo,

Le mardi 29 d?cembre 2015 ? 09:45 +0900, Milo Kim a ?crit :
> Hi Paul,
> 
> On 29/12/15 07:49, Paul Kocialkowski wrote:
> > Hi Milo, thanks for the review,
> >
> > Le lundi 28 d?cembre 2015 ? 09:56 +0900, Milo Kim a ?crit :
> >> Hi Paul,
> >>
> >> On 23/12/15 20:56, Mark Brown wrote:
> >>> On Wed, Dec 23, 2015 at 11:58:37AM +0100, Paul Kocialkowski wrote:
> >>>
> >>>> +	gpio = lp->pdata->enable_gpio;
> >>>> +	if (!gpio_is_valid(gpio))
> >>>> +		return 0;
> >>>> +
> >>>> +	/* Always set enable GPIO high. */
> >>>> +	ret = devm_gpio_request_one(lp->dev, gpio, GPIOF_OUT_INIT_HIGH, "LP872X EN");
> >>>> +	if (ret) {
> >>>> +		dev_err(lp->dev, "gpio request err: %d\n", ret);
> >>>> +		return ret;
> >>>> +	}
> >>>
> >>> This isn't really adding support for the enable GPIO as the changelog
> >>> suggests, it's requesting but not managing the GPIO.  Since there is
> >>> core support for manging enable GPIOs this seems especially silly,
> >>> please tell the core about the GPIO and then it will work at runtime
> >>> too.
> >>>
> >>
> >> With reference to my previous mail, external GPIOs for LDO3 and BUCK2 in
> >> LP8725 can be specified through regulator_config.ena_gpio. BUCK2 only
> >> can be controlled by external pin when CONFIG pin is grounded.
> >>
> >> Please see the description at page 5 of the datasheet.
> >>
> >> 	http://www.ti.com/lit/ds/symlink/lp8725.pdf
> >
> > After reading the datasheets thoroughly, it seems to me that for the
> > lp8720, the EN pin is used to enable the regulators output, which is a
> > good fit for the core regulator GPIO framework, as there is no reason to
> > keep it on when no regulator is in use. The serial interface is already
> > available when EN=0 and regulators can be configured in that state. The
> > lp8725 seems seems to behave the same when CONFIG=0 (the datasheet
> > clearly states: "CONFIG=0: EN=1 turns on outputs or standby mode if
> > EN=0"). On the other hand, it is indeed used as a power-on pin when
> > CONFIG=1.
> 
> I think it's different use case. LP8720/5 are designed for system PMU, 
> so some regulators are enabled by default after the device is on. EN pin 
> is used for turning on/off the chip. This pin does not control regulator 
> outputs directly. It's separate functional block in the silicon.

Well, I really don't understand why the EN pin would turn on/off the
chip. All it does it enable the regulators outputs (by entering IDLE
mode), the serial block is already available in STANDBY state.

If we want some regulators enabled at boot, the best thing to do seems
to be to request the GPIO with the GPIOF_INIT_HIGH flag, as done in e.g.
the max8952 regulator driver:

	if (pdata->reg_data->constraints.boot_on)
		config.ena_gpio_flags |= GPIOF_OUT_INIT_HIGH;

> On the other hand, 'ena_gpio' is used for each regulator control itself.
> For example, WM8994 has two LDOs which are controlled by external pins. 
> LDOs are enabled/disabled through LDO1ENA and LDO2ENA pins. In this 
> case, 'ena_gpio' is used.

Of course, but the ena_gpio feature is also a good fit for a global
enable pin, as the GPIO can be shared by multiple regulators of the same
chip, which is what we have here.

In my opinion, using the ena_gpio feature is a good fit, as we don't
need to keep the EN pin high when no regulator is used.

> 	http://www.cirrus.com/en/pubs/proDatasheet/WM8994_v4.4.pdf
> 	(please refer to page 224 and 225)

Cheers,

-- 
Paul Kocialkowski, Replicant developer

Replicant is a fully free Android distribution running on several
devices, a free software mobile operating system putting the emphasis on
freedom and privacy/security.

Website: https://www.replicant.us/
Blog: https://blog.replicant.us/
Wiki/tracker/forums: https://redmine.replicant.us/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151229/9aca2394/attachment.sig>
