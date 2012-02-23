From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Feb 2012 10:00:19 +0000
Subject: [PATCH 0/7] share sa1100 rtc driver to arch-mmp
In-Reply-To: <CAN1soZxbDKHjMxjNjDOXk8Ko9AyJEDGFV1XpqpiJCaL9ikNEdg@mail.gmail.com>
References: <1329815096-6200-1-git-send-email-haojian.zhuang@marvell.com>
 <201202221239.54321.arnd@arndb.de>
 <CAN1soZwgtxR7pNGBQuMHZS0URXM7U6ZABD4disNmvRarZnjwxA@mail.gmail.com>
 <201202221350.00100.arnd@arndb.de>
 <CAN1soZxTutYQ=uU0y_AvBTn37es+8tBU=1L6eKtJDUNONgwHFw@mail.gmail.com>
 <87r4xmygb7.fsf@free.fr>
 <CAN1soZx84dmAVz-Kyv18+fjOJyzvun7fpbXA+rYb6xeEhQbXtQ@mail.gmail.com>
 <87booqx771.fsf@free.fr>
 <CAN1soZxbDKHjMxjNjDOXk8Ko9AyJEDGFV1XpqpiJCaL9ikNEdg@mail.gmail.com>
Message-ID: <20120223100019.GK22562@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 05:45:20PM +0800, Haojian Zhuang wrote:
> On Thu, Feb 23, 2012 at 4:52 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> > The behaviour should be as before, the config should be able to choose between
> > rtc-pxa and rtc-sa1100 for a pxa27x based board. For sharpsl_pm, I suppose the
> > rtc-sa1100 will be chosen in the .config, and for mioa701, it will be
> > rtc-pxa.
> >
> > Just to clear, I'm against removing "resources, clock" from pxa27x platform code
> > which would break rtc-pxa driver on pxa27x. Now I don't care if you're talking
> > about changing some "defconfigs".
> >
> 
> How about to move the rtc-sa1100 or rtc-pxa device register from
> pxa27x.c to board file? Then we'll be both happy.

How about stopping thinking about "one or other" and start thinking "both" ?
The RTC library can and does cope with more than one RTC, and each RTC is
exposed uniquely to userspace.  So there shouldn't be any problem in keeping
both around, or even registering both together.

You just have to make sure you don't use both of them together as their
open functions will want to claim the same IRQ.  That's not really a
problem because that should provide exclusivity between the two.
