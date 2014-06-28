From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 28 Jun 2014 17:34:13 +0100
Subject: [PATCH RFCv2 1/5] ARM: use write allocate by default on ARMv6+
In-Reply-To: <20140628173955.7d105d3a@free-electrons.com>
References: <20140528112450.GH3693@n2100.arm.linux.org.uk>
 <20140530100819.1208149f@free-electrons.com>
 <20140530092044.GO3693@n2100.arm.linux.org.uk>
 <20140613121121.7e7dc8e6@free-electrons.com>
 <20140613102019.GQ23430@n2100.arm.linux.org.uk>
 <20140613133437.1a85f287@free-electrons.com>
 <20140613155139.05e2393c@free-electrons.com>
 <20140617104854.7393c14c@free-electrons.com>
 <20140617112624.GI23430@n2100.arm.linux.org.uk>
 <20140628173955.7d105d3a@free-electrons.com>
Message-ID: <20140628163413.GI32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 28, 2014 at 05:39:55PM +0200, Thomas Petazzoni wrote:
> Hello Russell,
> 
> On Tue, 17 Jun 2014 12:26:24 +0100, Russell King - ARM Linux wrote:
> > On Tue, Jun 17, 2014 at 10:48:54AM +0200, Thomas Petazzoni wrote:
> > > Russell,
> > > 
> > > Do you have some input/feedback about the below proposals/questions?
> > 
> > Not at the moment, I'm busy sorting through the 150-odd months-old
> > patches which remain in my tree post-merge window, working through
> > regressions, and trying to sort them out so I can (re-)post them and
> > hopefully get rid of them.
> > 
> > Of course, if it didn't take many months to get patches into mainline,
> > then I wouldn't be doing this right now, and I could spend more time
> > thinking more about these sorts of issues, rather than (eg) thinking
> > about how to generate DT binding documentation for drivers which have
> > been merged without that required documentation, which I then need to
> > modify, and then promptly get asked to write that required documentation
> > for.
> 
> I surely understand that it sometimes takes a lot of time to get some
> feedback from maintainers, I also had similar troubles with the
> maintainers of certain subsystems.

Yes, it takes /months/.  The typical way things work is you send a
patch set of any size.  You get a number of minor comments on it.  You
address those comments.  You get another set of minor comments on a
different selection of patches.  You address those.  So the loop
continues, wasting lots of time updating the patches and re-posting
them.

That means that the maintainers who are trying to push those patches
are consumed with this process trying to deal with these other people
rather than working on the area that they're supposed to be maintaining.

It's a vicious circle where eventually no one is doing any useful work -
one which I see kernel development heading headlong towards.

I still have a significant quantity of patches (slightly more than
when I sent my reply on the 17th of June) with only a relatively small
amount of movement towards getting some of them accepted by maintainers.

I'm not talking about patches which I've only just created - I'm talking
about patches which are more than /six/ months old.

The more time this takes, the less time I have to look at core ARM stuff.

Then you have problems like the fscked regulator code, which seems to be
the only code in the kernel which doesn't allow GPIO number 0 to be
specified, not even via DT.  It just ignores it.  It seems that I'm
having to work to fix that code, rather than being able to report it
as a bug and have the bug fixed.

There is very little to no sharing of these issues, so consequently I'm
the one who ends up with _loads_ of crap on my plate to try and solve.

> However, I'd really like to see the hardware I/O coherency issue make
> some progress: it's currently completely broken on Armada 370, causing
> random corruptions, and the only solution is to be able to properly
> enable write-allocate. Your patch series makes that partially possible,
> but there are some remaining problems, which I summarized at
> http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/263524.html.

Yes, I'm aware that there are still some remaining problems, but I don't
have a solution for it yet.

What we really need for your case is someway to detect your SoCs in the
early assembly code - and right now I don't have any idea how to do that.
The reason we need to do that is because we must have the write-allocate
cache mode and the shared bits set appropriately from the initial page
table setup in the early assembly code, because we can't just overwrite
the existing page tables with differing cache attributes without polluting
the TLB with those differing cache attributes (which can lead to
unpredictable behaviour.)

The Armada 37x/38x problem is a very difficult one to solve... really
I wish that those spins of the SoC had been chucked in the trash, because
working around this properly is going to take a lot of time and effort.
That would've been /far/ better for us.

I'll also note that it would've been a _lot_ easier to work around had
we not had this DT stuff, and kept the machine IDs being passed to the
kernel.  Such is life though, while DT makes some stuff easier, it
makes other stuff absolute hell.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
