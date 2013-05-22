From: w@1wt.eu (Willy Tarreau)
Date: Wed, 22 May 2013 18:49:28 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522184250.1d5f2f10@skate>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
Message-ID: <20130522164928.GD27348@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 06:42:50PM +0200, Thomas Petazzoni wrote:
> > I don't know for how long devices have been shipped with boot loaders
> > mapping at 0xd0, nor if all these platforms do have a new boot loader,
> > but maybe the same forced upgrade could be reasonable, I have no idea.
> 
> I guess the Mirabox and OpenBlocks have been shipping for about 9-10
> months now. Judging by the amount of e-mails are received about Mirabox
> kernel (asking when PCIe support will be available, when NAND will be
> available), there is definitely a certain number of people who have
> those platforms in their hands.

Indeed, but either these people are running stock kernel on them and don't
care, or they're ready to hack their box and should not be much frightened
by a boot loader upgrade (especially since it's safe from the UART as we
have found).

> > On the other hand, if we consider the forced upgrade as mostly acceptable,
> > then the CP15 trick already is an acceptable workaround in that it is
> > used as an indicator to detect the old boot loader. So even if for any
> > reason it fails on some users, they'll have to upgrade anyway.
> 
> My plan would be to have this CP15 trick for now. In two release
> cycles, show a big fat warning to users that are booting with old
> bootloaders, which would encourage them to update their bootloader. By
> this time, hopefully, the manufacturers of OpenBlocks and Mirabox will
> have released updated bootloader versions, and we can tell users to
> upgrade. The upgrade process is easy and safe, because it takes place
> through the UART, as you know.
> 
> Then, another two release cycles later, we could remove the CP15 trick
> entirely.
> 
> So it's just a matter of living with this for about 4 release cycles,
> approximately a year.

This seems reasonable to me indeed!

> > > Conclusion: you can't classify on one side boards that are at 0xd0 and
> > > boards that are at 0xf1. It depends on *which* bootloader each
> > > particular instance of those boards will be using. Will it be a
> > > bootloader that complies with the "old" protocol (CP15 bit cleared and
> > > registers at 0xd0) or the "new" protocol (CP15 bit set and registers at
> > > 0xf1).
> > 
> > Just a point I'm thinking about, is it possible to detect the boot loader's
> > mode via ATAGs ? ATAGs are present very early as well (but maybe too late
> > already).
> 
> As far as I know, a DT-capable bootloader doesn't pass any ATAG. The
> ARM register that was used to pass the pointer to the ATAGS is now used
> to pass the pointer to the DTB in memory.

OK so one possibility could be to rely on this as well if we're certain there
is a 1:1 relation between DT support and new mapping. But at least you have
working code now with CP15, so let's not complexify the situation !

Best regards,
Willy
