From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Nov 2015 22:47:21 +0000
Subject: [PATCH 0/5] ARM: orion5x/dove/mv78xx0 multiplatform
In-Reply-To: <2762753.604XuTRa75@wuerfel>
References: <1448466557-435335-1-git-send-email-arnd@arndb.de>
 <20151125160937.GJ14338@lunn.ch>
 <20151125183728.GO8644@n2100.arm.linux.org.uk>
 <2762753.604XuTRa75@wuerfel>
Message-ID: <20151125224721.GR8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 09:05:02PM +0100, Arnd Bergmann wrote:
> On Wednesday 25 November 2015 18:37:28 Russell King - ARM Linux wrote:
> > On Wed, Nov 25, 2015 at 05:09:37PM +0100, Andrew Lunn wrote:
> > > Russell, you are the last known user of mach-dove. What are your
> > > plans? You keep saying you have given up trying to mainline your Cubox
> > > patches. Have you really given up? Can we remove mach-dove?
> > 
> > Right now, I'm developing etnaviv in spare time on the Cubox[*], which
> > is still primarily running a non-DT kernel.
> > 
> > It's actually a kernel that I've hacked which is capable of booting
> > both DT and non-DT, but even when booted in DT mode, I still require
> > much of the arch/arm/mach-dove infrastructure to get things like
> > armada-drm, etnaviv and other drivers running.  Especially because
> > we're missing things like the high-speed clocks (the stuff above the
> > tclk domain.)  I've not even started to work out how to get that
> > into mainline, or how to integrate that with CCF.  Quite what can be
> > done with the audio patches, I've no idea, that remains a bone of
> > contention and stalemate, and currently isn't DT-able.  See the list
> > of patches at the end of this message...
> 
> I think it's ok to keep mach-dove around for a longer time to keep the
> board file, I'm way more interested in completing the multiplatform
> work at last.
> 
> If I understand you right, being able to build mach-dove and mach-mvebu
> together will actually help you remove one or more of your patches,
> but of course will require a small bit of rebasing.

This is something I already do, and it's trivial to make it work.
You're doing it by moving some includes around, I've found that it's
not necessary to move any includes around what so ever.

The problem I have right now is that people are expecting me to do
everything at once: people want me to write documentation for the
component helper.  People want me to merge more Dove patches.  People
want me to merge the Armada 38x work I have queued.  People are wanting
to get the etnaviv kernel driver out for merging this week, now that
I've solved the final part of the etnaviv puzzle - but yesterday I've
uncovered another user API issue that needs to be discussed and
resolved.

You know, there aren't enough me's to do everything - people just have
to get used to the idea that if they're not willing to put the work in
(iow, I have to put the work in) then things are going to be slow for
anything that isn't funded work, because I have a lot on my plate.

In the case of Dove, I only ever look at the current state of things
once every kernel cycle, as I only ever update the tree to a final
kernel release.  That means it takes about five months between
submission and seeing the result of those patches merged, so I can
then sort through what other stuff needs to be sent.  Why six months?
Get it queued for the next merge window (which can be up to six to
eight weeks away).  Then wait a full kernel cycle (eight to ten weeks)
for it to appear in a final kernel.  That's 14 to 18 weeks.

The last stuff which was merged was the PMU driver, merged in August.
It's taken until 4.3 for this to become "visible" in my Dove tree.
I should, at some point during this cycle - depending on my available
time - start looking at what other pieces I can send, but what I'm
saying is that this is the _earliest_ opportunity I have to start
looking again at this.

Meanwhile, during this last merge window, more Armada DRM patches have
gone in, along with some TDA998x patches - both of which I term Dove
patches because that's their applicable kernel tree that they get
tested with.

Meanwhile, Etnaviv is progressing, which again, is a Dove thing,
because the Dove has a Vivante GC600 GPU, which etnaviv drives.

Meanwhile, Andrew's complaining that he's not seen anything from me
for a long time.  What Andrew can't see is that the work is going on
at the peripheral driver level, not at the core level, /because/ it's
the peripheral drivers which are blocking me dropping the non-DT
support.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
