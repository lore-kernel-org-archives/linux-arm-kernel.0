From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 24 Mar 2010 12:02:30 +0100
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <20100324102144.GA21935@rakim.wolfsonmicro.main>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
	<20100324102144.GA21935@rakim.wolfsonmicro.main>
Message-ID: <005401cacb41$821d46f0$8657d4d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, March 24, 2010 11:22 AM Mark Brown wrote:

> On Wed, Mar 24, 2010 at 08:10:38AM +0100, Marek Szyprowski wrote:
> 
> > I've encountered a problem with regulator framework and the device
> > probe order. In my system there is a pmic chip connected thought i2c bus
> > and a platform device (let's call it A) that depends on the regulator
> > device (for proper probing pmic chip must enable voltage to the device
> > A). In the current configuration the i2c driver is also a platform
> > device. However during the system initialization the device A is probed
> > before the i2c driver would register pmic chip and its regulators.
> 
> This is (if I'm parsing what you say above correctly) a very common case
> - if you look at most of the existing PMIC core and regulator drivers
> you'll see that their initcalls are subsys_initcall(), and similarly for
> the I2C controller drivers they use.  This means that at boot the PMICs
> come up before pretty much any other device.

Ok, I get this idea, but this requires to move the i2c bus initialization
also to subsys_initcall. We use generic i2c-gpio driver. I suspect there
might be some unpredicted consequences on some other systems if we push
the patch that changes it init to subsys_initcall. I have no idea if the
gpiolib calls are available on all systems during the subsys_initcall.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
