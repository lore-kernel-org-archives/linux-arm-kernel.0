From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 24 Mar 2010 10:21:44 +0000
Subject: Device probe order (i2c regulator vs. platform device)
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
References: <E4D3F24EA6C9E54F817833EAE0D912AC09C80E05C7@bssrvexch01.BS.local>
Message-ID: <20100324102144.GA21935@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 24, 2010 at 08:10:38AM +0100, Marek Szyprowski wrote:

[Reflowed into 80 columns - please fix your mail client to wrap text, it
makes it very much easier to read your messages.]

> I've encountered a problem with regulator framework and the device
> probe order. In my system there is a pmic chip connected thought i2c bus
> and a platform device (let's call it A) that depends on the regulator
> device (for proper probing pmic chip must enable voltage to the device
> A). In the current configuration the i2c driver is also a platform
> device. However during the system initialization the device A is probed
> before the i2c driver would register pmic chip and its regulators.

This is (if I'm parsing what you say above correctly) a very common case
- if you look at most of the existing PMIC core and regulator drivers
you'll see that their initcalls are subsys_initcall(), and similarly for
the I2C controller drivers they use.  This means that at boot the PMICs
come up before pretty much any other device.

> How I can delay probing the device A to the moment when the regulator
> device will be available in the system? Is there any generic was of
> changing the device probe order?

The solution above is the other way around - it ensures that the
regulators come up first - but achieves the same effect.  Unfortunately
it's not as generic as would be best but it resolves the issues.
