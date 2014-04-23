From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 23 Apr 2014 17:04:46 +0200
Subject: [PATCH RFC 3/3] drm/exynos: use pending_components for	components
 tracking
In-Reply-To: <20140422115145.GU24070@n2100.arm.linux.org.uk>
References: <1397734130-21019-1-git-send-email-a.hajda@samsung.com>
 <1397734130-21019-4-git-send-email-a.hajda@samsung.com>
 <20140417220412.GZ24070@n2100.arm.linux.org.uk> <5351145D.8070207@samsung.com>
 <20140418124652.GE24070@n2100.arm.linux.org.uk> <535652B2.7000607@samsung.com>
 <20140422115145.GU24070@n2100.arm.linux.org.uk>
Message-ID: <5357D68E.8060605@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/22/2014 01:51 PM, Russell King - ARM Linux wrote:
> On Tue, Apr 22, 2014 at 01:29:54PM +0200, Andrzej Hajda wrote:
>> On 04/18/2014 02:46 PM, Russell King - ARM Linux wrote:
>>> On Fri, Apr 18, 2014 at 02:02:37PM +0200, Andrzej Hajda wrote:
>>>> Separation of the interfaces exposed by the device from the device itself
>>>> seems to me a good thing. I would even consider it as a biggest
>>>> advantage of this solution :)
>>>>
>>>> The problem of re-initialization does not seems to be relevant here, it
>>>> is classic
>>>> problem of coding correctness nothing more, it can appear here and in
>>>> many different
>>>> places.
>>> It may be a problem of coding correctless, but it's also a maintainability
>>> problem too - it makes it _much_ more difficult to ensure that everything
>>> is correct.
>> But forcibly re-initializing all component devices instead of fixing bugs
>> in specific drivers seems to be 'absolutely absurd' as classic says.
> They're *unnecessary* bugs that wouldn't even exist if it weren't for
> the forced-splitup of the initialisation into two separate parts that
> your approach mandates.
>
> Yes, I know that you're desperate to play that down, but you can't get

Not true. I only try to find the best solution and the approach with
multiple re-probing just to avoid potential bugs in drivers does not
look to me correct.

> away from this fact: your approach _forces_ a split up of the
> initialisation into dependent two stages and that fact _alone_ adds
> additional complexity, and along with that additional complexity comes
> more opportunity for bugs. 

This sound so funny, just look at componentize patches - every patch
adds two stage initialization for every component and the master,
with forced unwinding and two levels of devres management.

'My approach' adds only one call to probe and one call to remove of
components,
and very simple and straightforward interface to the master.

'My approach' is very standard - during probe driver probes hardware,
and registers interfaces which can be used by other drivers, for example
by drm master. The only addition is reporting its readiness. Comparing to
'your approach' it is bloody simple.


>  Also with that additional complexity comes
> the need to perform more tests to find those bugs, and given that most
> people just say "okay, it boots and seems to work, that's good enough
> for me" there is a high possibility that these kinds of bugs will take
> a long time to find.

Volume of changes for each component and drm device management
dispersed on all components makes your argument very valid for
component subsystem.

Btw have you observed component framework when one of the components
during bind returns -EPROBE_DEFER ? In my tests it resulted in
deferred probing of master and unbind/bind of other components.
So lets say you have N components and the last component will be deferred
K times, it results in:
- K times deferring of the last component and the master,
- (N - 1) * K - unbinds and binds of other components.


>
>> As I wrote already, this framework was proposed for drivers which
>> are tied together anyway, and this is case of many drivers, not
>> only exynos.
> Please name them.
>
>> Standalone drivers were not at my sight but I have also described in
>> other mail how the framework can be 'improved' to support standalone
>> drivers also.
> At the moment, I don't see a justification for your "simplified"
> and restrictive solution, which if used will lock drivers into that
> simplisitic method, and which can't ever be extended without lots of
> ifdeffery to having other components (such as TDA998x) attached.
>
> My objections are entirely based on where imx-drm and armada DRM are
> going, neither of which could ever use your implementation.
>
> Before you say that it isn't meant to deal with stuff like the TDA998x,
> take a moment to think about this - the Dove video subsystem was
> designed to support OLPC.  It was primerly designed to drive a LCD
> screen plus an on-board VGA DAC.  Everything for that is on-SoC.  With
> that, the hardware is well known, and your solution could be used.
>
> However, then SolidRun came along and dropped a TDA998x on the LCD output
> pins.  Suddenly, things aren't that simple, and your solution falls
> apart, because it can't cope with a generic component that has no knowledge
> of the rest of its "master".
>
> This kind of scenario can happen /any/ time, and any time it does happen,
> your simple solution falls apart.

I think I have answered you two or three times that it is not a problem
to remove
'glued drivers' restriction. I desperately try to avoid accusing you for
'desperately
playing down' on this subject, so I will not comment this anymore.

On the other hand you have not answered quite important question - how
do you plan to componentize drivers shared by different drms when
one of drms is not componentized???


Regards
Andrzej
