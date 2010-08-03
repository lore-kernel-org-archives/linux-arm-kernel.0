From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 3 Aug 2010 02:40:39 +0200
Subject: [PATCH v4] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100730070943.GA29746@n2100.arm.linux.org.uk>
References: <20100710071913.GM22845@n2100.arm.linux.org.uk>
	<AANLkTimskXW4Nnxhc5bxwKiNrfJkMb-9NeWKhVOGaA1k@mail.gmail.com>
	<20100713074449.GA20118@n2100.arm.linux.org.uk>
	<AANLkTilZJTHh_iFS37UL7XoUs_DhAB50A3tHfcfEr5JM@mail.gmail.com>
	<20100713182644.GC30142@n2100.arm.linux.org.uk>
	<4C3EA46B.1000709@st.com>
	<20100715083032.GA26212@n2100.arm.linux.org.uk>
	<4C3ED678.7010308@st.com>
	<20100715095637.GF26212@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F80AC392ACFC@eu1rdcrdc1wx030.exi.nxp.com>
	<20100730070943.GA29746@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F80AC39A091A@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Cc: Viresh KUMAR; rabin at rab.in; Linus Walleij; baruch at tkos.co.il;
> linux-arm-kernel at lists.infradead.org
> Subject: Re: [PATCH v4] GPIO PL061: Adding Clk framework support
> 
> On Fri, Jul 30, 2010 at 01:22:58AM +0200, Kevin Wells wrote:
> > >  /*
> > >   * These are the device model conversion veneers; they convert the
> > >   * device model structures to our more specific structures.
> > > @@ -130,17 +155,33 @@ static int amba_probe(struct device *dev)
> > >  {
> > >  	struct amba_device *pcdev = to_amba_device(dev);
> > >  	struct amba_driver *pcdrv = to_amba_driver(dev->driver);
> > > -	struct amba_id *id;
> > > +	struct amba_id *id = amba_lookup(pcdrv->id_table, pcdev);
> > > +	int ret;
> > >
> > > -	id = amba_lookup(pcdrv->id_table, pcdev);
> > > +	do {
> > > +		ret = amba_get_enable_pclk(pcdev);
> > > +		if (ret)
> > > +			break;
> > > +
> > > +		ret = pcdrv->probe(pcdev, id);
> > > +		if (ret == 0)
> > > +			break;
> > >
> > > -	return pcdrv->probe(pcdev, id);
> > > +		amba_put_disable_pclk(pcdev);
> >
> > Should the AMBA clock be disabled if the probe() fails?
> 
> This is exactly what happens here.

I think I got my logic reversed..

One more item I noted. These changes want to keep the clock enabled
after the probe - only disabling the clock on amba_remove. Both the
AMBA peripheral driver (ie, the LCD or MMCI driver) and the amba_remove
function now disable the clocks.

Wouldn't drivers that use clk_disable in their xxx_suspend functions
have some problems with this as multiple clk_enables have been called?

ie,
AMBA enables clock in amba_probe() <<< clock use count = 1
pl022 driver enables clock in mmci_probe <<< clock use count = 2
...SPI stuff happens...
...Linux enters suspend mode...
pl022 driver enters suspend mode, disables clock <<< clock use count = 1

Because the AMBA driver enabled the clock, the clock driver would still
see a use count > 1 on suspend and keep the clock enabled. Should the
suspend and resume functions in bus.c also disable/enable clocks? Or
maybe the peripheral drivers should just handle clocking and the clock
enable in amba_probe should be removed?
