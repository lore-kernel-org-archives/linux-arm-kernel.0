From: kurt.van.dijck@eia.be (Kurt Van Dijck)
Date: Mon, 25 Apr 2011 07:25:12 +0200
Subject: [RFC] What is the preferred way to share ADC unit between
	hwmon and input(ts) drivers?
In-Reply-To: <4DB4C252.30005@emcraft.com>
References: <4DB4C252.30005@emcraft.com>
Message-ID: <20110425052512.GB484@kurt.e-circ.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 25, 2011 at 04:37:38AM +0400, Ilya Yanok wrote:
> Hello,
> 
> we are working with Freescale i.MX25 SoC which has the same register
> space for ADC and touch-screen controller (AFAIK, that's pretty common
> situation).
> So, to add both input and hwmon drivers we need to serialize the
> register accesses.

1 physical device may contain several 'class_device's, even if they're of
different types.  So in a single platform_device probe function, you can do
both 'input_register_device' and 'hwmon_register_device'.
This way of working actually puts 2 drivers in 1 file, and let those
share 1 lock (mutex or so). A peripheral with 2 functions mixed together
should IMHO be addressed this way. Your driver is the coupling
between hardware (mixed functions) and Linux device model (clean seperation).

> I was thinking about adding some middle-layer to
> perform the actual conversion. The question is what is the preferred way
> to add such a middle layer?

IMHO a middle layer for this type of problem is a bit overkill.

> Should we use a multi-function device driver
> for this or just some platform-specific code (as S3C does)? Or maybe
> there is another way?

AFAIK MFD is a solution when multiple devices have sequential register maps.
MFD does no locking.

Just my ideas...
Maybe I don't understand your problem exactly...

Kurt
