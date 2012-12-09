From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 9 Dec 2012 14:40:14 +0000
Subject: Question2: Determine subarch type
In-Reply-To: <20121209142405.4e199831b4f455daf1818459@mail.ru>
References: <20121209105117.1f96e5c80560a8431a9eecee@mail.ru>
 <20121209101358.GG14363@n2100.arm.linux.org.uk>
 <20121209142405.4e199831b4f455daf1818459@mail.ru>
Message-ID: <201212091440.14857.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 09 December 2012, Alexander Shiyan wrote:
> 
> On Sun, 9 Dec 2012 10:13:59 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > > > > How can we determine the sub-architecture type from the driver code?
> > > > > For example, we are building a multi-platform kernel for subarch A and B.
> > > > > One of the drivers should be used for subarch A only, and can not be used for
> > > > > subarch B. So, we need to avoid load this driver for other sub-architectures.
> > > > > Of course, we can check all machines in the subarch with machine_is_xx() macro,
> > > > > but I think that this is not the best way to do it.
> > > > > Do we have another way to do this?
> > > > 
> > > > You control this by only registering the appropriate struct devices rather
> > > > than controlling this in the driver.
> > > 
> > > Yes, but if driver is compiled as module?
> > 
> > Makes no difference.
> 
> Do you mean that all the drivers for multi-platform targets should be
> converted to platform_drivers?

Right, if you have drivers that just use hardware directly rather than
registering a 'struct device_driver' of some sort, they should be 
converted. We did most of those conversions during linux-2.5 over
ten years ago, but a few may have slipped through into 2.6 and 3.x.

> OK, and what about (arch/fs/core/postcore)_initcall-s? Current multiplatform
> targets use these calls.

These all need to be audited and get extra checks to make sure they
only execute on hardware they are written for. Shawn Guo did a lot
of work in that area recently.

	Arnd
