From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 22 May 2013 19:14:20 +0200
Subject: [PATCH 0/9] Switch internal registers address to 0xF1 on Armada
 370/XP
In-Reply-To: <20130522170807.GE27348@1wt.eu>
References: <1369132414-18959-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201305221633.46705.arnd@arndb.de> <20130522170643.54a2b9d2@skate>
 <201305221735.11815.arnd@arndb.de> <20130522180842.7edcc3ee@skate>
 <20130522163557.GC27348@1wt.eu> <20130522184250.1d5f2f10@skate>
 <20130522164928.GD27348@1wt.eu> <20130522190004.67880320@skate>
 <20130522170807.GE27348@1wt.eu>
Message-ID: <20130522191420.1ef08f8d@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Willy Tarreau,

On Wed, 22 May 2013 19:08:07 +0200, Willy Tarreau wrote:
> On Wed, May 22, 2013 at 07:00:04PM +0200, Thomas Petazzoni wrote:
> > Yes, they could upgrade. But as of today, such upgrades do not even
> > exist for the Mirabox and OpenBlocks AX3 boards. So what do we tell to
> > those users?
> 
> I was assuming these boot loaders do already exist if they're shipping
> on some devices, but maybe not all yet.

The new bootloaders have started being offered by Marvell to
board/system manufacturers since only a few weeks or so, so besides
evaluation boards, there are not yet public products that use the new
bootloaders. But the vast majority of Armada 370 and Armada XP
platforms are still to be coming, and this vast majority will be using
the new bootloader.

> > Of course, one option is simply to have a kconfig option "I am booting
> > from an old bootloader", but with the CP15 trick, we've tried to make
> > this automatic so that users don't have to understand the kind of gory
> > details we are discussing right now.
> 
> Same as for ATAGS right now which are not necessarily the most obvious
> setting for end users. Better keep the trick on by default if it's safe
> enough. In fact I'm mostly concerned about the risk that it later breaks
> for even newer boot loaders. But then we'll have more feedback to decide.

As I suggested earlier, we can print a warning when people boot from an
old bootloader, and then down the road get rid of the trick. Or move it
under a conditional compilation so that the minority of remaining users
will have to enable this particular option. This will anyway be needed
if we want to go multiplatform with Dove, for example.

> OK, that was what I was wondering about. Sorry for having bothere you with
> my questions but at least not it's much clearer that CP15 probably is the
> only viable solution.

We've also gone through a lot of thinking about this problem, and we've
considered various options, and we came down to the following two
options:

 * Assume we're booted with a bootloader that has done the remapping at
   0xf1. Works for all new platforms, breaks all the older platforms,
   unless people upgrade their bootloaders.

 * Have a nicer way to handle the transition, and in this case, when
   you take into account all the complexities, the CP15 turned out to
   be the only really viable solution.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
