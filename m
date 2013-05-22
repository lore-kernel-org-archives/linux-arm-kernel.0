From: w@1wt.eu (Willy Tarreau)
Date: Wed, 22 May 2013 18:35:57 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522180842.7edcc3ee@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
Message-ID: <20130522163557.GC27348@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wed, May 22, 2013 at 06:08:42PM +0200, Thomas Petazzoni wrote:
> And the new bootloaders that are remapping to 0xf1000000 on Armada
> 370/XP are already being shipped by Marvell, so it's not like we have
> much choice here.

Which also means we can't request to modify new boot loaders to pass
any specific information.

(...)
> And what happens when Globalscale (Mirabox manufacturer) or Plathome
> (manufacturer of OpenBlocks) release a new bootloader version, based on
> the new bootloader from Marvell, which remaps things at 0xf1000000 ? Or
> when those people boot from Barebox, which remaps at 0xf1000000 ?

We experienced a similar issue some time ago when something changed
in the boot loader spec. Kernels >= 3.2 would randomly hang at boot
when using old boot loaders, and many boot loaders had to be upgraded.
It was quite painful because there was no information reported with
this hang but I guess most people managed to upgrade the boot loaders.
I don't know for how long devices have been shipped with boot loaders
mapping at 0xd0, nor if all these platforms do have a new boot loader,
but maybe the same forced upgrade could be reasonable, I have no idea.
On the other hand, if we consider the forced upgrade as mostly acceptable,
then the CP15 trick already is an acceptable workaround in that it is
used as an indicator to detect the old boot loader. So even if for any
reason it fails on some users, they'll have to upgrade anyway.

> Conclusion: you can't classify on one side boards that are at 0xd0 and
> boards that are at 0xf1. It depends on *which* bootloader each
> particular instance of those boards will be using. Will it be a
> bootloader that complies with the "old" protocol (CP15 bit cleared and
> registers at 0xd0) or the "new" protocol (CP15 bit set and registers at
> 0xf1).

Just a point I'm thinking about, is it possible to detect the boot loader's
mode via ATAGs ? ATAGs are present very early as well (but maybe too late
already).

> So we can't encode into the boards Device Tree whether the registers
> are at 0xd0 or 0xf1, because it's not a board-related information, but
> a bootloader-related information.

I totally agree with you. The issue is only the boot loader.

Best regards,
Willy
