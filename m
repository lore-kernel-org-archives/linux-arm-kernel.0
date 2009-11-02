From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Nov 2009 16:37:01 +0000
Subject: Using statically allocated memory for platform_data.
In-Reply-To: <20091102162839.GD20341@fluff.org.uk>
References: <20091102112316.16163f6a.ospite@studenti.unina.it>
	<20091102150011.GB20341@fluff.org.uk>
	<20091102150525.GB5785@n2100.arm.linux.org.uk>
	<20091102152500.GD23772@trinity.fluff.org>
	<20091102155231.GC20341@fluff.org.uk>
	<20091102155625.GC5785@n2100.arm.linux.org.uk>
	<20091102162839.GD20341@fluff.org.uk>
Message-ID: <20091102163701.GD5785@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 02, 2009 at 04:28:39PM +0000, Ben Dooks wrote:
> On Mon, Nov 02, 2009 at 03:56:25PM +0000, Russell King - ARM Linux wrote:
> > The reason we have platform_device_add_data() is that people think that
> > the device data needs to persist for the lifetime of the device.  I
> > personally disagree with that - once you unregister the device, it's
> > guaranteed that device drivers will have been unregistered, so who's
> > going to use the platform data?
> 
> That doesn't make any sense, in the current case of using the
> platform_device_alloc() and those calls the data is only living
> for the lifetime of the device, as the release call is tidying up
> the result.

What I'm saying is that the lifetime of the data finishes once
the _unregister() call has returned.  So:

	data = pdev->dev.platform_data;
	platform_device_unregister(pdev);
	kfree(data);

is an entirely valid way of handling the "I allocated my platform
data" problem - it doesn't need to exist to the point where the
device itself is freed.

> There are a number of places where this data isn't __initdata, and
> still needs to be copied, and then freed once the device has been
> removed.

What I'm saying is that the point where the platform data can be
freed is the point where the device is unregistered.  It is not the
point where the device is actually freed.

Whenever you have the pointer for the platform device to be unregistered,
you also have the pointer for its data available.

If we accept that the lifetime for the platform data is from the point
the device is registered to the point immediately following when the
device is unregistered, then the above solution is acceptable and
we don't need to play games with release pointers.
