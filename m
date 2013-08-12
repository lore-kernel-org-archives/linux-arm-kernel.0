From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Mon, 12 Aug 2013 14:09:01 -0300
Subject: [PATCH 1/3] ARM: Introduce atomic MMIO clear/set
In-Reply-To: <520910DA.4000203@gmail.com>
References: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130810140237.GB3080@localhost> <20130810140927.GC3080@localhost>
 <1376149388.716003514@f150.i.mail.ru>
 <20130810155552.GB17936@localhost>
 <20130812154646.GA5460@localhost> <520910DA.4000203@gmail.com>
Message-ID: <20130812170900.GA7198@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Mon, Aug 12, 2013 at 06:44:10PM +0200, Sebastian Hesselbarth wrote:
> On 08/12/13 17:46, Ezequiel Garcia wrote:
> >> Indeed, syscon looks like a nice match for this use case.
> >> (although it still looks like an overkill to me).
> >>
> >> I've been trying to implement a working solution based in syscon but I'm
> >> unable to overcome an issue.
> >>
> >> The problem is that we need the register/regmap to initialize the clocksource
> >> driver for this machine (aka the timer). Of course, this happens at a
> >> *very* early point, way before the syscon driver is available... :-(
> >>
> >> Maybe someone has an idea?
> >
> > Sebastian, Russell: I can't find the previous mail where you proposed
> > this solution to address the shared register issue between Kirkwood's
> > watchdog and clocksource.
> 
> Russell first mentioned an atomic modify function here:
> http://archive.arm.linux.org.uk/lurker/message/20130618.113606.d7d4fe4b.en.html
> 

Thanks a lot for finding this thread. I see we all just went through the
same line of reasoning.

> 
> The pro of a generic atomic clear/set is that we can use it
> very early, on all platforms, and from totally unrelated
> drivers. As you already mentioned, using syscon from timers will
> get us into into trouble, because it has not been registered.
> 

Yes, indeed.

> > Do you think trying to use a regmap could be better (given we can
> > sort out the problem explained above)?
> 
> Given the small number of registers we need to protect and especially
> for using it in timers, I'd prefer your proposal. Otherwise, I guess,
> we would have to mimic mfd/syscon for time-orion and time-armada-370-xp
> and make wdt-orion depend on it. I doubt we can make any use of
> mfd/syscon for the timer use case.
> 

Then I think we all agree here. Just to confirm:

  * The proposed API is almost exactly the one proposed by Russell
    in the mail you just mentioned:
    http://archive.arm.linux.org.uk/lurker/message/20130618.113606.d7d4fe4b.en.html

  * Linus Walleij suggested mfd/syscon, but Russell, Mark and Linus
    itself seem to agree it's more heavy-weight than necessary.
    http://archive.arm.linux.org.uk/lurker/message/20130618.151116.712407e0.en.html
    http://archive.arm.linux.org.uk/lurker/message/20130618.183359.a6184b7f.en.html
    http://archive.arm.linux.org.uk/lurker/message/20130618.152300.bffa038f.en.html

The only open question is: given there's nothing arch-dependent in this
mechanism, should we keep this in arch/arm/kernel? And if not, where
should we move this?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
