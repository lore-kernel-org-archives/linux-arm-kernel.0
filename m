From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 31 Jul 2010 12:34:50 +0200
Subject: [PATCH] PXA: Colibri320: Add M41T00 RTC support
In-Reply-To: <20100731090554.GX17833@buzzloop.caiaq.de>
References: <1280543453-28237-1-git-send-email-marek.vasut@gmail.com>
	<201007310933.05611.marek.vasut@gmail.com>
	<20100731090554.GX17833@buzzloop.caiaq.de>
Message-ID: <201007311234.50775.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 31. ?ervence 2010 11:05:54 Daniel Mack napsal(a):
> On Sat, Jul 31, 2010 at 09:33:05AM +0200, Marek Vasut wrote:
> > Dne So 31. ?ervence 2010 09:26:03 pieterg napsal(a):
> > > On Saturday 31 July 2010 04:30:53 Marek Vasut wrote:
> > > > +#if defined(CONFIG_RTC_DRV_DS1307) ||
> > > > defined(CONFIG_RTC_DRV_DS1307_MODULE)
> > > > +static mfp_cfg_t colibri_pxa320_i2c_pin_config[] __initdata = {
> > > > +	GPIO32_I2C_SCL,
> > > > +	GPIO33_I2C_SDA,
> > > > +};
> > > 
> > > Should the i2c pins really depend on the DS1307 config?
> > > On my board, I use a different rtc. So I do need the I2C pins to be
> > > configured, but I don't need the DS1307.
> 
> Yes, I think you're right. The I2C pins should only be set up if I2C
> support for PXA is in fact enabled. If someone manages to build a kernel
> which has support for this driver (which should depend on the I2C core
> as its transport layer) but not for PXA I2C, that's an unfortunate
> exception.
> 
> You could think about something like
> 
>   select I2C_PXA if RTC_DRV_DS1307
> 
> in the Colibri block of mach-pxa/Kconfig, but that's somewhat overdone
> maybe.

You're right, probably. I'll see what I can do about it (maybe I'll just queue 
this patch after the rework).

> 
> > Well I'd like to rework the colibri pxa3xx stuff later, but I'll have to
> > discuss it with Dan. I believe reworking it the same way as pxa270
> > colibri would be nice (and it'd solve your problem too as you use custom
> > board I think?).
> 
> Yes, that'd be nice.

It's a mess, true indeed. But now I need to get some sleep :-)
> 
> > Actually, there is one thing that puzzles me. Eric/Dan, shall I stick all
> > the MFP configs into one (or two, one for board and once for cpu card)
> > array or keep it split in multiple smaller arrays for each device? I
> > think putting it all in one place would be more readable.
> 
> Hmm, GPIOs for peripherals that are assembled on the module itself can
> safely be configured unconditionally as it is impossible to use them for
> anything else. For GPIOs that are allocted by a specific base board,
> things are different though, especially for the the Colibri eval board
> with it hundreds of jumpers on it. It's a convenience feature to have
> them free for general purpose use just by disabling a certain config
> directive.

Ok, I'd agree on this ;-)
> 
> Daniel
