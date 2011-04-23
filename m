From: bn@niasdigital.com (Ben Nizette)
Date: Sat, 23 Apr 2011 18:25:27 +1000
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTin_e1Kkn=KGvnqCHvnJVZczRwdnVA@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<BANLkTi=W7jaVtW1FThvG_ca57q+yDz1kzQ@mail.gmail.com>
	<E0A55C1E-9DA0-4FFE-90EE-575BB1E649CB@niasdigital.com>
	<BANLkTin_e1Kkn=KGvnqCHvnJVZczRwdnVA@mail.gmail.com>
Message-ID: <699D6248-729F-4E9B-A9D3-713B653E818F@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 21/04/2011, at 4:48 PM, Linus Walleij wrote:

> 2011/4/21 Ben Nizette <bn@niasdigital.com>:
> 
>>> This patch is about biasing and drive modes. We need to alter
>>> these at runtime (from board code, indeed) due to the fact that
>>> when you go to sleep e.g. floating a pin yeilds better power
>>> characteristics.
>> 
>> This is actually an interesting case because floating pins yeild
>> /worse/ power characteristics (each transistor of the push-pull
>> is on a little bit and you get a path straight through) [1].  To
>> get good power performance you want to pull an input pin high or
>> low but which of those two directions depends on external
>> constraints, i.e. the board.
> 
> Yeah, mea culpa, I twisted it around in my head. I mean the
> reverse. So this is why there are GPIO_CONFIG_BIAS_HIGH
> and GPIO_CONFIG_BIAS_GROUND in the predefined pin
> bias states.
> 
> (I do get it, don't worry, I was in electroscience before I
> turned computer science actually...)

np, did a bit of a double-take myself :)

> 
>>  This is a case where the driver
>> should /not/ go playing with things it can't fully understand.
>> 
>> Perhaps one of the properties that a board can set in a gpio chip
>> driver is the suspend state and have suspend/resume hooks in the
>> gpio chip take care of setting things up on each side.
> 
> Yes, the API is not only for drivers, it's for boards alright.
> 
> Pushing it to drivers/gpio give us two advantages:
> 
> 1. Depopulate the overpopulated arch/arm/* etc trees
> 2. Give an overview so the GPIO maintainer and others can
>  think about consolidations
> 3. Clear cut drivers that can have runtime PM hooks etc...
> 

Yep I think I like this now, looking forward to seeing a few driver
implementations and seeing what kind of cool custom features i/o IP
blocks have that can now be easily and usefully exposed.

Thanks!
	--Ben.

> Linus Walleij
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
