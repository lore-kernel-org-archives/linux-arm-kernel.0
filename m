From: jon.nettleton@gmail.com (Jon Nettleton)
Date: Wed, 25 Nov 2015 15:06:04 +0100
Subject: [PATCH] ARM: avoid SMP DT initialisation on UP-only capable
 systems
In-Reply-To: <20151125125634.GK8644@n2100.arm.linux.org.uk>
References: <E1a1XXS-00060O-GS@rmk-PC.arm.linux.org.uk>
 <20151125113538.GB12434@leverpostej>
 <20151125114908.GI8644@n2100.arm.linux.org.uk>
 <1448455831.3689.55.camel@pengutronix.de>
 <20151125125634.GK8644@n2100.arm.linux.org.uk>
Message-ID: <CALHpu34Big-4CKbLvS4pyf8=t_Gkw7=_p83FU24s2AJyJMAiug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 1:56 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Nov 25, 2015 at 01:50:31PM +0100, Lucas Stach wrote:
>> What we do in barebox is to look into the SCU to find out how many CPU
>> cores are actually present and fix up the DT passed to the kernel
>> accordingly by deleting any superfluous CPU nodes. This satisfies both
>> the need to keep the required DT source files to a minimum, while also
>> providing correct information to the kernel.
>
> ... which is a function of the boot loader, but not all boot loaders
> do this.  So, if we're using u-boot, what option do we have?
>
> I've never been able to successfully build and boot uboot myself (it
> always fails one way or another with my toolchains - if I get it to
> link, it silently fails on the hardware, but if someone else builds
> it for me from exactly the same source, it works fine) so count me
> out of fixing uboot in this regard.
>
> Note that it's not that the kernel doesn't work, it's just that people
> are complaining that they see warnings from the kernel during their
> boot.  So, unless we're going to start providing iMX6S and iMX6D
> specific DT blobs (which will double the number of .dtb files we end
> up with on iMX6), I think we're stuck with users complaining about
> this.

I have been looking into doing some of this cleanup in u-boot
recently.  More and more this seems like a hack because the
device-tree descriptions belong to the kernel.  If the bootloader
isn't generating them it seems counter intuitive that it should be
responsible for altering them so the kernel doesn't complain about
incorrect hardware configuration.  It seems as though device-tree
could benefit from some logic definitions that could load device-tree
snippets or overlays depending on the hardware that is probed.

Or in the case of SR hardware we just generate 24 device tree files
and push this probing back into each bootloader  implementation to
detect and load accordingly.

-Jon
