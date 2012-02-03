From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 3 Feb 2012 09:50:40 -0800
Subject: [PATCH V2 1/4] pinctrl: add a driver for NVIDIA Tegra
In-Reply-To: <CACRpkdbMPrvN80cLyVLUNvTjx4ZV4iLeHcJaJyM_qvTHHAfWww@mail.gmail.com>
References: <1328130290-17607-1-git-send-email-swarren@nvidia.com>
 <CACRpkda+KCutSFgPwH2Xvd14h0OCrArFGXAidp3n_ZgG28KB5g@mail.gmail.com>
 <201202021533.14650.arnd@arndb.de>
 <CACRpkdbMPrvN80cLyVLUNvTjx4ZV4iLeHcJaJyM_qvTHHAfWww@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF178E124DB9@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Friday, February 03, 2012 7:57 AM:
> On Thu, Feb 2, 2012 at 4:33 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > [Me]
> >> Olof, Arnd: please verify that this is a direction you accept for the Tegra.
> >> (Olof has already ACK:ed it, mainly thinking about Arnd.)
> >
> > I would have liked to see a smaller pinctrl driver and one with fewer macros,
> > but I'm not going to complain about it -- drivers/pinctrl is definitely your
> > turf not mine and I assume that Olof's Ack was meant in his position as Tegra
> > maintainer instead of his position as arm-soc maintainer.
> 
> Which means I have no ACK from any of the ARM SoC maintainers
> on this which is touching the ARM tree substantially and affecting
> more or less all recent ARM SoCs,
> 
> Which is actually bad enough for me to have second thoughts on
> this.
> 
> So I'm taking this branch off from -next until we resolve this.

Seriously? That's lame.

To be completely honest, I'm losing interest in spending time on pinctrl.
Perhaps the solution here is to require bootloaders to set up the complete
initial pinmux state, and only use pinctrl for dynamic pinmux. Then, most
people can simply ignore pinctrl.

> The big issue here is whether SoC hardware block
> properties (such as the pins and their names, and their
> groups) should be:
> 
> (A) open-coded in the driver or
> (B) provided as data in the device tree

There's really no need for everyone to do the same thing here; it's an
issue that's completely isolated within the individual drivers, and has
no effect outside of them, other than kernel size in a multi-SoC kernel.

The main issue with (B) is that it slows down boot time measurably by
requiring a ton of data to be parsed from it, which entails a bunch of
string handling. And then, you end up with exactly the same data as if
you'd just bundled it into the kernel in the first place.

> nVidia Tegra have opted for the former, Texas OMAP for the latter.
> The in-kernel drivers also do like Tegra. However they
> are smaller due to less combinatorics.

Well, I think not so much because the SoCs don't have the same number of
combinations, but that the drivers don't support all the HW's options.

> > One thing that worries me a bit is the object size of the tegra
> > pinctrl driver: There are now about 70kb pinmux driver binary in
> > each kernel that wants to run on tegra (about the same as the
> > remaining tegra platform code), which can become a bottleneck
> > in future multi-platform kernels that also want to run on a lot of
> > other things.
> 
> This sounds like a correct observation and I think I have said
> the same previously.
> 
> > Will it be possible to eventually put the pinmux driver into a loadable
> > module?
> 
> Tony had made it possible to have pinctrl drivers as modules,
> but some systems may need their pin control up before
> they even bring up the filesystem :-(
> 
> Booting from initramfs and switchroot can solve the above
> but will slow down boot I believe, and ARM systems
> usually don't like that.

I guess we could load modules from an initrd OK, but that does indeed
add some complexity.

Rather, it might be interesting to pursue building the pinctrl drivers
as modules, but somehow binding them into the kernel image itself, and
allowing them to be unloaded (like __init functions and __initdata) once
we know they aren't used. That's somewhat similar to an initramfs, but
avoids the need to package everything into a filesystem and explicitly
load it before it can be used.

-- 
nvpublic
