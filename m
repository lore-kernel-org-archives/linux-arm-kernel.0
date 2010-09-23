From: jacmet@sunsite.dk (Peter Korsgaard)
Date: Thu, 23 Sep 2010 12:54:30 +0200
Subject: [PATCH] at91sam9g45: fix i2c bus speed
In-Reply-To: <20100923103645.GA23295@n2100.arm.linux.org.uk> (Russell King's
	message of "Thu, 23 Sep 2010 11:36:45 +0100")
References: <1285147886-17100-1-git-send-email-jacmet@sunsite.dk>
	<4C9B0D4D.4050102@atmel.com> <87k4mcak6b.fsf@macbook.be.48ers.dk>
	<20100923093104.GA22397@n2100.arm.linux.org.uk>
	<87fwx0ahgl.fsf@macbook.be.48ers.dk>
	<20100923103645.GA23295@n2100.arm.linux.org.uk>
Message-ID: <877hicafx5.fsf@macbook.be.48ers.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>>>> "Russell" == Russell King <- ARM Linux <linux@arm.linux.org.uk>> writes:

Hi,

 Russell> Jean is right - if you want to care this much about getting the I2C
 Russell> transfer rate as close to 100kHz or 400kHz (without exceeding it),
 Russell> you need to pass the required speed and run some sort of calibration
 Russell> in the driver to calculate the correct delay.

I don't care about all those things. I just want to fix the obvious bug
that happened while copying this code from the older (slower) SoCs
without taking into consideration the faster gpio handling - E.G.

-       .udelay                 = 2,            /* ~100 kHz */
+       .udelay                 = 5,            /* ~100 kHz */

So the comment matches and devices that don't handle >100KHz works on
the new SoCs as well.

And yes, if you run the SoC at nonstandard (slower) speed this might be
slower than 100Khz, but that's still safe, so not a big deal.

And then if Jean wants to extend the interface to make the speed
configurable from the board code, he can do so independently of this
patch.

-- 
Bye, Peter Korsgaard
