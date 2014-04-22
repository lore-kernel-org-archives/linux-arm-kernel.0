From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Apr 2014 12:51:45 +0100
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for
 components tracking
In-Reply-To: <535652B2.7000607@samsung.com>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
 <20140417220412.GZ24070@n2100.arm.linux.org.uk>
 <5351145D.8070207@samsung.com>
 <20140418124652.GE24070@n2100.arm.linux.org.uk>
 <535652B2.7000607@samsung.com>
Message-ID: <20140422115145.GU24070@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 22, 2014 at 01:29:54PM +0200, Andrzej Hajda wrote:
> On 04/18/2014 02:46 PM, Russell King - ARM Linux wrote:
> > On Fri, Apr 18, 2014 at 02:02:37PM +0200, Andrzej Hajda wrote:
> >> Separation of the interfaces exposed by the device from the device itself
> >> seems to me a good thing. I would even consider it as a biggest
> >> advantage of this solution :)
> >>
> >> The problem of re-initialization does not seems to be relevant here, it
> >> is classic
> >> problem of coding correctness nothing more, it can appear here and in
> >> many different
> >> places.
> > It may be a problem of coding correctless, but it's also a maintainability
> > problem too - it makes it _much_ more difficult to ensure that everything
> > is correct.
> 
> But forcibly re-initializing all component devices instead of fixing bugs
> in specific drivers seems to be 'absolutely absurd' as classic says.

They're *unnecessary* bugs that wouldn't even exist if it weren't for
the forced-splitup of the initialisation into two separate parts that
your approach mandates.

Yes, I know that you're desperate to play that down, but you can't get
away from this fact: your approach _forces_ a split up of the
initialisation into dependent two stages and that fact _alone_ adds
additional complexity, and along with that additional complexity comes
more opportunity for bugs.  Also with that additional complexity comes
the need to perform more tests to find those bugs, and given that most
people just say "okay, it boots and seems to work, that's good enough
for me" there is a high possibility that these kinds of bugs will take
a long time to find.

> As I wrote already, this framework was proposed for drivers which
> are tied together anyway, and this is case of many drivers, not
> only exynos.

Please name them.

> Standalone drivers were not at my sight but I have also described in
> other mail how the framework can be 'improved' to support standalone
> drivers also.

At the moment, I don't see a justification for your "simplified"
and restrictive solution, which if used will lock drivers into that
simplisitic method, and which can't ever be extended without lots of
ifdeffery to having other components (such as TDA998x) attached.

My objections are entirely based on where imx-drm and armada DRM are
going, neither of which could ever use your implementation.

Before you say that it isn't meant to deal with stuff like the TDA998x,
take a moment to think about this - the Dove video subsystem was
designed to support OLPC.  It was primerly designed to drive a LCD
screen plus an on-board VGA DAC.  Everything for that is on-SoC.  With
that, the hardware is well known, and your solution could be used.

However, then SolidRun came along and dropped a TDA998x on the LCD output
pins.  Suddenly, things aren't that simple, and your solution falls
apart, because it can't cope with a generic component that has no knowledge
of the rest of its "master".

This kind of scenario can happen /any/ time, and any time it does happen,
your simple solution falls apart.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
