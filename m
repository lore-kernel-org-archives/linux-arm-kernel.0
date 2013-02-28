From: marvin24@gmx.de (Marc Dietrich)
Date: Thu, 28 Feb 2013 14:58:05 +0100
Subject: Multi-platform, and secure-only ARM errata workarounds
In-Reply-To: <512E4583.4080609@wwwdotorg.org>
References: <512BF81A.3080700@wwwdotorg.org>
 <22709540.96uJddbx1U@fb07-iapwap2.physik.uni-giessen.de>
 <512E4583.4080609@wwwdotorg.org>
Message-ID: <33225818.Ckiz9JWK6f@fb07-iapwap2.physik.uni-giessen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 27. Februar 2013, 10:42:27 schrieb Stephen Warren:
> On 02/27/2013 02:03 AM, Marc Dietrich wrote:
> > Am Dienstag, 26. Februar 2013, 09:39:15 schrieb Stephen Warren:
> >> On 02/26/2013 02:36 AM, Marc Dietrich wrote:
> >>> Am Montag, 25. Februar 2013, 16:47:38 schrieb Stephen Warren:
> >>>> ...
> >>>> Now, I can easily add those 3 errata workarounds to U-Boot, but that
> >>>> will require people to reflash their bootloader. This is probably
> >>>> acceptable for development/reference boards (although I'm sure people
> >>>> will find it annoying) but for re-purposed production boards (such as
> >>>> the Toshiba AC100 or various tablets) it will be impossible to update
> >>>> the factory bootloader. Switching to upstream U-Boot would currently
> >>>> lose some functionality, and significantly affect people's boot flow,
> >>>> so
> >>>> is likely unacceptable.
> >>> 
> >>> personally, I have no problem to require a certain u-boot version for a
> >>> given kernel. From a distro point of view, you will likely update the
> >>> bootloader/kernel on a distro update anyway.
> >> 
> >> So a distro will certainly update the kernel.
> >> 
> >> But updating a bootloader would be very unusual, I believe.
> > 
> > mmh? Every time I update to a new distro release, the bootloader gets also
> > updated - even on arm, e.g.
> > ftp://ports.ubuntu.com/ubuntu-ports/pool/main/u/u-boot-linaro lists four
> > version of uboot - one for each supported distro release. I know for
> > closed embedded device this is different, but that's not our target.
> 
> I have no idea why that package exists or what it is. It clearly doesn't
> install U-Boot on the device when the package is installed, or anyone
> using an AC100 would already be running U-Boot not our binary
> bootloader, right?

yes, you are right - it's left to user to break its board. I somehow missed 
this.
 
> >> Also, I hope that upstream U-Boot is never going to support the bizarre
> >> "Tegra partition table" cruft that our "fastboot" bootloader supports,
> >> so you'll end up completely re-programming the flash (BCT, bootloader,
> >> partition table, all filesystems) if you want to switch to U-Boot. That
> >> seems like a fair chunk for the installer to own, but I guess if you're
> >> comfortable with doing that, I won't complain.
> > 
> > Yes, that a huge pile of work and people are working on this already. One
> > the other hand, why (if not for upgrade use) do we have u-boot support
> > for all these legacy boards?
> 
> Mainly because I didn't want to use our binary bootloader when
> developing or testing kernel support for the AC100, I think:-)
> 
> But yes, I would support all AC100 general Linux usage switching to U-Boot.
> 
> I think what I'll do when Tegra is converted to multi-platform is:
> 
> a) The WARs will be disabled in the kernel; no choice there really.
> 
> b) I've already submitted patches to U-Boot to implement the WARs there.
> 
> c) Everyone will need to update to the latest U-Boot:-(
> 
> d) For people wanting to continue running our binary bootloader (which
> only implements 1 of the 3 WARs in question in the latest code, and I
> have no idea if it even did that when the AC100 bootloader binary was
> compiled), they'll need to create a small stub binary that implements
> the WARs and prepend this to the zImage. I can help create this if
> people need. Or, you can chain-load U-Boot. I've filed bugs against our
> binary bootloader, so hopefully within a few years or something, new
> products won't need this stub!

I don't want to drive this thread further off topic. I just like to add that 
the AC100 support is purly community driven. It is planed that we can use both 
bootloaders (fastboot and u-boot) with a 3.1 kernel (downstream nvidia based). 
In this situation, the user can upgrade his bootloader to u-boot and later 
install a 3.8 kernel based on mainline. At 3.10 kernel version times, all 
users are expected to have u-boot installed, whatever u-boot version is 
required then.

Marc
