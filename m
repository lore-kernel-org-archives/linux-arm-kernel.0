From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 4 Aug 2011 18:07:15 -0500
Subject: [PATCH 1/2] arm/mx5: parse iomuxc pad configuratoin from device
	tree
In-Reply-To: <20110725204630.GD26735@ponder.secretlab.ca>
References: <1311606467-28985-1-git-send-email-shawn.guo@linaro.org>
	<1311606467-28985-2-git-send-email-shawn.guo@linaro.org>
	<20110725204630.GD26735@ponder.secretlab.ca>
Message-ID: <CAKGA1bmbWUeyhUtDwHZjB8V4e2wJ0NHX2qWhqaqx6HoBm7uMnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant, Shawn,



On Mon, Jul 25, 2011 at 3:46 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> This could get really verbose in a really big hurry. ?Fortunately the
> dtb format is sophisticated enough to only store each unique property
> name once, so the data shouldn't be huge, but it is still going to
> make for huge source files. ?Can you think of a more concise
> representation?

Yes: no representation at all. The correct place for IOMUX setup being
done is *inside the boot firmware as soon as physically possible* and
not seconds into boot after U-Boot has made a console, done a boot
timeout, loaded scripts, kernels and ramdisks from media and then
uncompressed and entered a Linux kernel.

The only beneficial place for setting up IOMUX inside Linux is when
you really need to modify the behavior of an SoC unit that is acting
weird, the only real example I can think of being the situation with
eCSPI errata on the MX51 (ENGcm09397 whereby slave select stays
asserted at  the end of a transfer when SSB_POL = 1). That in itself
was only needed for Freescale's solution (which was kind of funky and
hoped the chip would do the right thing at the start and give control
back at the end). The current mainline solution is to handle slave
select as GPIO and twiddle it as needed for correct operation. I can't
think of - or find - a single example after that where IOMUX settings
are configured at runtime, and the method currently used in
Freescale's BSP and in mainline is just fundamentally wrong.

If you think the solution is not so great due to the complexity of
describing the IOMUX settings, including the pad definitions as binary
blobs or so such that Linux can read them out, please feel free to
take the hint and go nag the U-Boot developers at Linaro to go put
this in the right place - in U-Boot. The device tree is absolutely not
the place to define pin multiplexing settings for later parsing and
configuration by the Kernel. They should have been set up correctly
already, and they should not be being *changed* based on an arbitrary
configuration file. Consider that the i2c pin definitions you used in
your example *absolutely will not change* for the lifetime of the
board, and in most cases, will have been set up by U-Boot anyway.
There is no point telling Linux to copy in identical settings again.
What's missing from U-Boot and set up by Linux, should be moved out of
Linux back into U-Boot.

That said, as a reference to be able to view the settings of the IOMUX
pads, it is useful. In theory, once you set up your controller in
U-Boot, you may want to use sysfs or so to read out the configuration
of that pin in userspace to confirm the board settings, or other debug
processes. By naming it and providing the offsets and mode definitions
somewhere other than a reference manual you are enabling this to get
done.. but please, please, please don't make the mistake of
considering that just because every board right now does this at Linux
init, that it therefore it must be the correct solution and maintained
:(

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
