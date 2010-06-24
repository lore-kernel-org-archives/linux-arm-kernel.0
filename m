From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Thu, 24 Jun 2010 05:33:56 +0100
Subject: [RFC PATCH] Rework gpio cansleep (was Re: gpiolib and
	sleepinggpios)
In-Reply-To: <20100624000403.GH7058@shareable.org>
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE08E0855B96@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Lokier wrote:
> Ryan Mallon wrote:
>> On 06/24/2010 10:53 AM, Jamie Lokier wrote:

>>> It has an I2C driven GPIO expander, with a watchdog reset chip
>>> hanging off the expander.
>>>
>>> The watchdog is kept alive off the back end of a timer BH, which
>>> means the I2C GPIO routines are written to be safe in BH context
>>> (which
>>> isn't sleepable), but they can't be used in IRQ context because the
>>> necessary spin_lock_irqsave() would turn off interrupts for too long
>>> for other subsystems to function properly.
>>
>> Do the implementations of the get/set calls for the io expander gpios
>> sleep at all?
>
> No, because sleeping isn't allowed in BH context.  (Note that this is
> 2.4.26 code - things have changed a bit for 2.6, but the hardware is
> the same, and still needs the I2C watchdog to be driven from a BH-like
> context).

Could you use a workqueue instead to prod the watchdog?
Then the GPIOs could sleep, you could rewrite them as such, and other things could use them safely.

Disabling IRQs while you talk to an I2C peripheral sounds like a hack that will impact performance.

Although, if it does that then I think your GPIOs qualify as non-sleeping.. so "safe" to use from a can't-sleep context but probably unacceptably slow as you say.

--
Jon Povey
jon.povey at racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
