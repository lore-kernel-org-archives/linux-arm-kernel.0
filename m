From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 May 2011 16:21:03 +0200
Subject: [PATCH 2/2] drivers/amba: probe via device tree
In-Reply-To: <4DD66B8A.5040404@gmail.com>
References: <1305829704-11774-1-git-send-email-robherring2@gmail.com>
	<20110519233958.GB18181@ponder.secretlab.ca>
	<4DD66B8A.5040404@gmail.com>
Message-ID: <201105201621.03801.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 May 2011 15:24:26 Rob Herring wrote:
> Maybe we are looking this in the wrong way.
> 
> AMBA is not really the bus, but certain types of devices on the bus. 
> Granted, it may actually be an AMBA bus vs. vendor bus (i.MX AIPS), but 
> that is really transparent to s/w. Separating AMBA devices in the 
> devicetree is really Linux requirements defining the devicetree 
> structure. It is certainly conceivable that an OS could make no 
> distinction. In my case, there is a mixture of regular platform devices 
> and AMBA(Primecell really) devices all interleaved on the same bus.

I don't see how that would work. If the bus is AMBA, it should
only have AMBA devices on it, otherwise how would they be connected?

Whether software is supposed to know care about this is a different
question. The device tree should generally reflect the block
diagram of the hardware, and I would expect the AMBA devices be
on a different level from the rest there.

> Based on this, I think of_platform_populate should always just match 
> against "simple-bus" and make the matches parameter define the device 
> creation hook rather than the bus type. Or you could have both 
> bus_matches and dev_matches parameters.

I think it would be much better to only look at the parent bus for
device to add, never at the device itself. 

If the bus is AMBA, add all devices as amba_device, if it's simple-bus,
add all devices as platform_device.

	Arnd
