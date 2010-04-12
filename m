From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Apr 2010 20:39:43 +0100
Subject: [PATCH] mach-pxa/viper: Fix timeout usage for I2C
In-Reply-To: <20100412213235.1688dda8@hyperion.delvare>
References: <1270390118-1802-1-git-send-email-w.sang@pengutronix.de>
	<m2rf17812d71004121057n5131d025pb4965f45b61271f@mail.gmail.com>
	<20100412211319.5a43c65b@hyperion.delvare>
	<20100412192010.GM3048@n2100.arm.linux.org.uk>
	<20100412213235.1688dda8@hyperion.delvare>
Message-ID: <20100412193943.GP3048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 12, 2010 at 09:32:35PM +0200, Jean Delvare wrote:
> On Mon, 12 Apr 2010 20:20:10 +0100, Russell King - ARM Linux wrote:
> > On Mon, Apr 12, 2010 at 09:13:19PM +0200, Jean Delvare wrote:
> > > On Tue, 13 Apr 2010 01:57:51 +0800, Eric Miao wrote:
> > > > One other better and cleaner approach to such inconsistency issue is
> > > > to have a timeout_ms field, and having i2c-gpio.c driver to convert this
> > > > to jiffies using msec_to_jiffies() at run-time.
> > > 
> > > With what benefit? Expressing time values in units of HZ is very
> > > frequent in the kernel code and shouldn't actually surprise anyone.
> > 
> > Actually, this patch shows there is confusion.
> > 
> > "Assume '100' means 100ms here and adapt accordingly."
> > 
> > Since this patch is for ARM, where HZ=100, the above patch is not a
> > simple "convert how we derive this constant" patch - it's a functional
> > change, reducing the timeouts by a factor of 10.
> > 
> > Could that be because the patch author misinterpreted the HZ-based
> > values?
> 
> I admit I would have assumed 100 -> HZ, as hard-coded HZ-dependent
> value typically assume HZ=100.
> 
> > I suspect I'm not the only one who thinks that the latter of "HZ / 10"
> > "100ms" is easier to read and comprehend without mistake.
> 
> OTOH, converting from ms to jiffies each time you need the value has a
> cost.

True; what I did for MMC stuff is converted it from ms to jiffies at
initialization time when copying it in from platform data in the
driver's probe function.

I'm not saying that I care either way, I'm merely showing that dealing
with HZ-based values can be (maybe unexpectedly) more error prone.
