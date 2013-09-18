From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 18 Sep 2013 09:39:59 -0300
Subject: mvebu: Armada XP doesn't boot in v3.12-rc1
In-Reply-To: <20130917180957.GI19937@titan.lakedaemon.net>
References: <20130917173502.GA4231@localhost>
 <20130917180957.GI19937@titan.lakedaemon.net>
Message-ID: <20130918123958.GB2563@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

On Tue, Sep 17, 2013 at 02:09:57PM -0400, Jason Cooper wrote:
> On Tue, Sep 17, 2013 at 02:35:03PM -0300, Ezequiel Garcia wrote:
> > Armada XP boards are not booting in v3.12-rc1.
> > 
> > These two patches, which are already in linux-mvebu/mvebu/dt,
> > are needed to fix the problem:
> > 
> > commit 585b136b73696ac37c9614b4b3d8fa0407adcdf1
> > Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > Date:   Tue Aug 20 12:45:51 2013 -0300
> > 
> >     ARM: mvebu: Add clock properties to Armada XP timer node
> > 
> > commit d36fd447d5e2d0993a8ec34afc26fc449ac1e2f3
> > Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > Date:   Tue Aug 20 12:45:50 2013 -0300
> > 
> >     ARM: mvebu: Add the reference 25 MHz fixed-clock to Armada XP
> 
> Yes, I saw that tglx sent a late pull for corresponding driver changes.
> I'll move these two over to mvebu/fixes shortly.
> 
> > FWIW, CONFIG_HAVE_ARM_ARCH_TIMER=y is also needed or the board freezes,
> > but that's another problem which I'm currently investigating.
> 
> Sounds like we just need a select, is there something more to it?
> 
> Please send a patch as soon as you have it nailed down.  I'd like the
> two changes above and this patch to spend a few days in -next before I
> send the pull.
> 

We've nailed it down (Jean Pihet did, actually). The problem was
introduced by the patch adding clocksource_of_init() to initialize
the timer, but missing a CONFIG_CLKSRC_OF option selection.

The offending commit is:

commit 573145f08c2b92c45498468afbbba909f6ce6135
Author: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date:   Tue Aug 13 11:43:12 2013 -0300

    clocksource: armada-370-xp: Use CLOCKSOURCE_OF_DECLARE

Jean already has a patch and will send it later today.

Regards,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
