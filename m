From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Sep 2011 17:56:07 +0200
Subject: [PATCH 5/5] mach-ux500: add a SoC ID (serial) callback for the
	u8500
In-Reply-To: <4E60F333.1010902@linaro.org>
References: <1314880043-22517-1-git-send-email-lee.jones@linaro.org>
	<201109021622.50591.arnd@arndb.de> <4E60F333.1010902@linaro.org>
Message-ID: <201109021756.07976.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 September 2011, Lee Jones wrote:
> > static void __devinit db8500_read_soc_id(struct db8500_dev *dev)
> > {
> >       u32 __iomem *uid = dev->base + U8500_BB_UID_OFFSET;
> >       snprintf(dev->soc_id, sizeof (dev->soc_id), "%08x%08x%08x%08x%08x",
> >               readl(uid[0]), readl(uid[1]), readl(uid[2]), readl(uid[3]), readl(uid[4]));
> > }
> 
> No problem.
> 
> Where did you get dev->base from though?

In this example, db8500_dev would be derived from soc_device. and
get initialized at the time you register it to the soc subsystem.
You clearly have to pass in the base address at some point, so if
there is no device tree, that init function should statically set it,
but you would still avoid spreading the use of these constants all
over the code.

> > The style you use here is preexisting in the db8500 code, but you should
> > not keep adding more of that crap. 
> 
> Not meaning to pass the buck at all, but this isn't my code.
> 
> It's remnant from when I took this over (starting to wish I hadn't ;))

I feel your pain. Sorry that you got dragged in this so deeply when
you only wanted a place to add a tiny bit of information.

> > All the code like 
> > #define db8500_add_i2c0(pdata) \
> >         dbx500_add_i2c(0, U8500_I2C0_BASE, IRQ_DB8500_I2C0, pdata)
> > #define db8500_add_i2c1(pdata) \
> >         dbx500_add_i2c(1, U8500_I2C1_BASE, IRQ_DB8500_I2C1, pdata)
> > 
> > should never really have been there. What you want to do for this is
> > to call this from the code that initializes the db8500 controller, and
> > pass the board specific pdata into the db8500 init function, along
> > with the i2c client data.
> 
> Not my domain. Speak to Linus W. :)

Yes, I understand. I was mostly using this as explanation about where
the problem lies. I'm not expecting you to fix all of the problems
of the platform, but in order to add new code the right way, we have
to agree on how it should have been there to start with.

	Arnd
