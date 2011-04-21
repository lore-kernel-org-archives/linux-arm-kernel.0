From: bn@niasdigital.com (Ben Nizette)
Date: Thu, 21 Apr 2011 10:29:11 +1000
Subject: [PATCH 1/2] gpio: add pin biasing and drive mode to gpiolib
In-Reply-To: <BANLkTi=W7jaVtW1FThvG_ca57q+yDz1kzQ@mail.gmail.com>
References: <1303076273-8093-1-git-send-email-linus.walleij@stericsson.com>
	<3F5641E3-C443-4541-9FDA-24D215597C1F@niasdigital.com>
	<20110418091902.13345132@lxorguk.ukuu.org.uk>
	<92FFDB9F-37F1-4618-A53D-FEF4151A4953@niasdigital.com>
	<20110418132629.12d9a106@lxorguk.ukuu.org.uk>
	<6C3F739A-A157-4796-9572-C6B0FAC2565E@niasdigital.com>
	<BANLkTi=W7jaVtW1FThvG_ca57q+yDz1kzQ@mail.gmail.com>
Message-ID: <62B5223C-AFC9-4DF6-B0BD-2678E082047D@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


RESEND, sorry if you get this twice.  Crappy MUA..

On 20/04/2011, at 10:21 PM, Linus Walleij wrote:

> 2011/4/19 Ben Nizette <bn@niasdigital.com>:
>> On 18/04/2011, at 10:26 PM, Alan Cox wrote:
>> 
>>> The logical extension to that is to delete the gpio layer because the
>>> board code can do it ?
>> 
>> Well anything that is done once at startup, yes,
> 
> This patch is about biasing and drive modes. We need to alter
> these at runtime (from board code, indeed) due to the fact that
> when you go to sleep e.g. floating a pin yeilds better power
> characteristics.

This is actually an interesting case because floating pins yeild
/worse/ power characteristics (each transistor of the push-pull
is on a little bit and you get a path straight through) [1].  To
get good power performance you want to pull an input pin high or
low but which of those two directions depends on external
constraints, i.e. the board.  This is a case where the driver
should /not/ go playing with things it can't fully understand.

Perhaps one of the properties that a board can set in a gpio chip
driver is the suspend state and have suspend/resume hooks in the
gpio chip take care of setting things up on each side.

	--Ben.

[1] http://processors.wiki.ti.com/index.php/Optimizing_IO_Power_Consumption

> 
> Linus Walleij
