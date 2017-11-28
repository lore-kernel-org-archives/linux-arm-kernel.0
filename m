From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Nov 2017 10:20:25 +0000
Subject: [PATCH] rtc: Allow rtc drivers to specify the tv_nsec value for
 ntp
In-Reply-To: <20171127193135.GA21126@piout.net>
References: <20171013175433.GA22062@obsidianresearch.com>
 <20171123095456.lkc4nkuzsd2q26mm@piout.net>
 <CALAqxLUBWd-mv_3iiFrXLf0ka685t0an89jjduHpT-2jjv5O2Q@mail.gmail.com>
 <20171127175254.GL31757@n2100.armlinux.org.uk>
 <20171127184411.GA19577@piout.net>
 <20171127185352.GN31757@n2100.armlinux.org.uk>
 <20171127193135.GA21126@piout.net>
Message-ID: <20171128102025.GT31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 27, 2017 at 08:31:35PM +0100, Alexandre Belloni wrote:
> On 27/11/2017 at 18:53:52 +0000, Russell King - ARM Linux wrote:
> > You are, yet again, wrong.
> > 
> > I am in a position to make the comment because it was me who identified
> > the problem, put in the hours to work on, develop and extensively test
> > Jason's patch.  So, it's partly my time that you seem to be wasting,
> > and that gives me every right to complain at this point.
> > 
> > You, on the other hand, were copied with every single email, and did
> > nothing to discuss the issue except for the "easy" bits when I posted
> > a relatively smaller patch - but you ignored the bigger issue.
> 
> And this is exactly what you do with other people patches/time when you
> don't like their changes.
> You simply ignore the patch series until they go away.

That is not intentional.

> I would really expect people merging code in any subsystem to wait for
> the ack of the maintainer of that subsystem.
> 
> I didn't complain about any missing email addresses, I said the RTC ML
> was not copied but that is didn't matter.

A mailing list is an email address.

> You're not even happy about the patch that was merged because it was the
> wrong one!

That's not what I said.  I was concerned that an _old_ patch had been
merged, but as it turns out, it was not an old patch, but a newer
patch that I'd missed.

> > And now that someone dare criticise your abilities, you decide to revert
> > the change and restore Linux back to a crippled state.
> > 
> > Honestly, I don't _care_ if you revert it and if you want to cripple
> > the kernel as a result in regards to this issue, I can carry the patch
> > ad infinitum, no skin off my back.  You're only going to be hurting
> > yourself and other people through your spite by doing that revert.
> > 
> > I suggest you take a good long hard look at what you're about to do and
> > ask whether you are being reasonable, given that it's taken you over
> > two months whole months to raise any _technical_ issues with the approach
> > that Jason and myself came up with.
> > 
> 
> What I don't get is that it has been broken for almost 5 years and now
> you seem to think it has to be fixed urgently.

Now you're making crap up.  I've not made any comment about this being
something that needs fixing urgently.  In fact, as I've said several
times already, I really don't care what you do with the mainline kernel,
because I have a fix here locally that I intend to use and maintain
into the future.  For me, the issue is fixed and resolved, and I intend
to spend no further time developing any fixes for it.

My comments are about the _two months_ its taken to get to the stage of
finding out that you don't like the approach.

The result of this is, most likely, one of:
1. you'll revert the patch (which, incidentally, has no real effect until
   my other patches get merged) and everyone will either be stuck with a
   kernel that sets their RTC time wrong when they have NTP installed

2. you'll remove the systohc code, people won't realise that their kernel
   no longer sync's the RTC time, and systems that are on the Internet
   (eg, providing stratum 1 NTP servers) will be unreliable if they are
   rebooted even more so than they are today.

> On my side, I want to take the opportunity to think about systohc before
> adding an ABI that we will maybe regret later.

Fine, but bear in mind that I don't care anymore, because I have
perfectly good fixes locally, and I'm not wasting any further time
in this issue.

While you think about it, I would encourage anyone who wishing to run
or running a public NTP server using rtclib to ditch Linux and use
FreeBSD instead to avoid their NTP server supplying false time, even
when synchronised to a reference clock.  A reboot of such a server
will supply false time for a period of a few hours depending on how
far the time is out (which can be up to a couple of seconds) after
such an event.  In such a scenario, NTP will not step-correct the
time but will gradually slew it instead.

This goes for systems that some ISPs deploy as stratum 1 NTP servers,
which today tend to be Raspberry Pis.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
