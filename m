From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 09 Sep 2012 01:16:54 +0000
Subject: [PATCH] ARM: add support for BCM2708/BCM2835 and Raspberry Pi
In-Reply-To: <20120908215609.GH13739@n2100.arm.linux.org.uk>
References: <1346908038-22421-1-git-send-email-swarren@wwwdotorg.org>
 <201209061546.45242.arnd@arndb.de>
 <20120908215609.GH13739@n2100.arm.linux.org.uk>
Message-ID: <1729018.3VWhxcipzn@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 08 September 2012 22:56:10 Russell King - ARM Linux wrote:
> On Thu, Sep 06, 2012 at 03:46:44PM +0000, Arnd Bergmann wrote:
> > We just had a discussion about
> > stale platforms at the ARM mini summit in San Diego. IMHO if a port
> > gets started and then nobody works on filling the gaps for two
> > years, we should remove it again. 
> 
> One of the issues there is that you don't know if the reason it's not
> receiving patches or comments is because it works and people are using
> it, and they don't have anything to report against it.
> 
> That's certainly true of a number of platforms we currently have.
> 
> And then there's the ones I run services on which I don't tend to reboot
> very often.  I'm currently looking at one which is coming up to 1000 days
> uptime which has had zero problems on a 2.6.32.8 kernel - in fact it's
> the one which provides www.arm.linux.org.uk and I'm typing this email
> message on...
> 
>  22:54:19 up 938 days,  9:27, 11 users,  load average: 0.21, 0.08, 0.01
> 
> so in that case I'm not going to know if anything is broken on an IOP32x
> kernel until that gets rebooted (which it will do soon because I want to
> change its disks - but hopefully not before 62 days time.)

I was specifically saying "a port gets started", not "a port is fully
working". The example I was thinking of is the mach-cns3xxx, which 
was introduced in a very minimal state about 2 years ago. The only
users I could find on the internet are on OpenWRT, which adds
support for an actual board file (upstream only has the evaluation
board) as well as SMP, clock, i2c, ethernet, gpio, and a bunch of
bug fixes[1]. I'd say we should either find someone who is willing to
submit the patches upstream and make sure they work with at least
one version, or we can remove what we have today because it's evidently
not used.

Of course, one of the main rules of Linux development is that we
don't break stuff, so whenever we remove something that looks like
it's not used and someone complains, we should revert the patch
to put the code back ASAP.

The platforms that we talked about removing during the ARM mini summit
are ks8695, h720x, l7200, netx, pnx4008, w90x900, ixp4xx and bcmring.
I've already heard back from people involved in almost all of those, with
pretty clear statements:

* ks8695 is in active use, but was missing a maintainer. Greg Ungerer
stepped up and already submitted new board files for hardware that he
is using.

* ixp4xx is (as expected) actively used, but a lot of patches are stuck
in openwrt[2] and not getting submitted.
Greg also submitted a regression fix, Ben Hutchins promised
another fix from Debian.

* h720x is pretty much dead, the original authors seem to not
be interested any more, we just need to decide how and when to
remove it.

* netx is used happily and just needs a contact address.

* pnx4008 is very dead and getting removed in 3.7.

* bcmring is getting orphaned and will likely get removed if nobody
steps up as a maintainer to clean it up.

* l7200 was already removed two years ago and a single file has crept back
in from a bad merge without anyone noticing.

* no news from w90x900, still need to contact the people who were last
working on them. May still be alive considering that we removed it's
nuc900 sibling and the maintainers were still active on it back then.
A quick online search shows that the chip is actively being marketed
and there is a BSP that adds a few device drivers (usbgadget, i2c, asoc,
[Cc'd Wan ZongShun, the maintainer, on this email]

	Arnd

[1] https://dev.openwrt.org/browser/trunk/target/linux/cns3xxx/patches-3.3
[2] https://dev.openwrt.org/browser/trunk/target/linux/ixp4xx/patches-3.3
