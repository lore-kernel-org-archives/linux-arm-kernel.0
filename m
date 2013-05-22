From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 18:42:50 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522163557.GC27348@1wt.eu>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu>
Message-ID: <20130522184250.1d5f2f10@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Wed, 22 May 2013 18:35:57 +0200, Willy Tarreau wrote:

> On Wed, May 22, 2013 at 06:08:42PM +0200, Thomas Petazzoni wrote:
> > And the new bootloaders that are remapping to 0xf1000000 on Armada
> > 370/XP are already being shipped by Marvell, so it's not like we have
> > much choice here.
> 
> Which also means we can't request to modify new boot loaders to pass
> any specific information.

Correct.

> > And what happens when Globalscale (Mirabox manufacturer) or Plathome
> > (manufacturer of OpenBlocks) release a new bootloader version, based on
> > the new bootloader from Marvell, which remaps things at 0xf1000000 ? Or
> > when those people boot from Barebox, which remaps at 0xf1000000 ?
> 
> We experienced a similar issue some time ago when something changed
> in the boot loader spec. Kernels >= 3.2 would randomly hang at boot
> when using old boot loaders, and many boot loaders had to be upgraded.
> It was quite painful because there was no information reported with
> this hang but I guess most people managed to upgrade the boot loaders.

Agreed. I already receive quite a number of e-mails from users trying
to do this or that with the Mirabox, and I'm not sure I would receive
many more e-mails if the kernel would not "just" work without having to
do some bizarre configuration. Especially if the kernel just hangs with
no useful information.

> I don't know for how long devices have been shipped with boot loaders
> mapping at 0xd0, nor if all these platforms do have a new boot loader,
> but maybe the same forced upgrade could be reasonable, I have no idea.

I guess the Mirabox and OpenBlocks have been shipping for about 9-10
months now. Judging by the amount of e-mails are received about Mirabox
kernel (asking when PCIe support will be available, when NAND will be
available), there is definitely a certain number of people who have
those platforms in their hands.

> On the other hand, if we consider the forced upgrade as mostly acceptable,
> then the CP15 trick already is an acceptable workaround in that it is
> used as an indicator to detect the old boot loader. So even if for any
> reason it fails on some users, they'll have to upgrade anyway.

My plan would be to have this CP15 trick for now. In two release
cycles, show a big fat warning to users that are booting with old
bootloaders, which would encourage them to update their bootloader. By
this time, hopefully, the manufacturers of OpenBlocks and Mirabox will
have released updated bootloader versions, and we can tell users to
upgrade. The upgrade process is easy and safe, because it takes place
through the UART, as you know.

Then, another two release cycles later, we could remove the CP15 trick
entirely.

So it's just a matter of living with this for about 4 release cycles,
approximately a year.

> > Conclusion: you can't classify on one side boards that are at 0xd0 and
> > boards that are at 0xf1. It depends on *which* bootloader each
> > particular instance of those boards will be using. Will it be a
> > bootloader that complies with the "old" protocol (CP15 bit cleared and
> > registers at 0xd0) or the "new" protocol (CP15 bit set and registers at
> > 0xf1).
> 
> Just a point I'm thinking about, is it possible to detect the boot loader's
> mode via ATAGs ? ATAGs are present very early as well (but maybe too late
> already).

As far as I know, a DT-capable bootloader doesn't pass any ATAG. The
ARM register that was used to pass the pointer to the ATAGS is now used
to pass the pointer to the DTB in memory.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
