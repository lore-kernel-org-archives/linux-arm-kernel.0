From: bn@niasdigital.com (Ben Nizette)
Date: Tue, 19 Apr 2011 14:50:52 +1000
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <20110418223108.GA5935@sirena.org.uk>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418115903.GB9462@sirena.org.uk>
	<34EB51B7-AF3B-4DCE-A402-953B2DBC0474@niasdigital.com>
	<20110418223108.GA5935@sirena.org.uk>
Message-ID: <528C1A42-AFCB-4EE1-A881-3D6BD4C1F539@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 19/04/2011, at 8:31 AM, Mark Brown wrote:

> On Tue, Apr 19, 2011 at 08:16:12AM +1000, Ben Nizette wrote:
>> On 18/04/2011, at 9:59 PM, Mark Brown wrote:
> 
>>> Even if it ends up being the board code using these APIs it seems
>>> sensible to have a standard API that GPIO drivers can use to expose the
>>> functionality.  This will help with getting control into code Linux owns
>>> (since people don't have to implement custom APIs) and will mean we can
>>> do things like add control of this for device tree based boards.
> 
>> Oh I'm all for platform-specific libraries abstracting this away from the
>> board code if that helps, that's certainly the way that, eg, AVR32 does it.
>> It just doesn't make sense to me to bounce from the board code in to
>> 'generic' gpio code then back to platform-specific implementations when
>> you could cut out the middle man.
> 
> We have cross platform abstractions for lots of things - device tree,
> which I mentioned, is the obvious example - and many of the GPIO
> controllers are themselves cross platform as they're for off-SoC chips.

OK let's take a step back here:  My qualms simply expressed are that the
board code knows how the pin needs to be set up and the gpio provider knows
how the pin can be set up; I don't like the idea of trying to teach gpiolib
and any driver that uses it about those parameters.  I don't see it as necessary
or, for that matter, a war we can without exploding enums.

How about we provide a conduit in gpiolib through which the board code can
express its wishes directly to the gpio provider without trying to interpret
it first?  The gpio provider can supply the mode enumerations in a header
file (much like they do already with, eg, platform data structures), the
board support writer can make a judgement about which settings are required
and gpiolib just worries about passing essentially an opaque cookie of setup
data through as soon as the latter side is ready to accept it?

Or does the gpio-consuming driver genuinely need to know about these concepts?

	--Ben.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
