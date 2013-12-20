From: arno@natisbad.org (Arnaud Ebalard)
Date: Fri, 20 Dec 2013 21:23:46 +0100
Subject: [rtc-linux] Re: Can someone Ack and queue a patch for RTC
 subsytem?
In-Reply-To: <20131220183050.GB31886@sirena.org.uk> (Mark Brown's message of
 "Fri, 20 Dec 2013 18:30:50 +0000")
References: <87siton6ke.fsf@natisbad.org>
 <20131219164624.GV2609@titan.lakedaemon.net>
 <20131219175738.1dad3ade@linux.lan.towertech.it>
 <8761qk32pj.fsf@natisbad.org> <20131220183050.GB31886@sirena.org.uk>
Message-ID: <8738lnl19p.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Mark Brown <broonie@kernel.org> writes:

> On Thu, Dec 19, 2013 at 11:17:44PM +0100, Arnaud Ebalard wrote:
>
>> All NETGEAR ReadyNAS 102, 104 and 2120 have an ISL 12057 RTC chip which
>> is used as main RTC clock but can also provide alarm. But the alarm
>> interrupt line of the chip is *not* connected to the SoC. It is
>> connected to some power component and can be used to wake up the NAS
>> when it is completely off and the alarm rings.
>
> Can the PMIC or whatever function as an interrupt controller and report
> the interrupt on to the SoC?

I do not even know to which specific component the irq line of the chip
is connected. You can take a look at [1] to see what's on the PCB; if
you have an idea about which one could be a good candidate (TPS65251?),
I can try and check with an ohmmeter which pin is connected to confirm
your guess. Then, I could look at the datasheet (if any) to see if it
can relay the interrupt to the SoC (if the component is supported by
Linux kernel).

But, except if we can do what you propose, there are two problems at
hand:

 1) I cannot currently test the IRQ handler my changes would bring
 because it is not connected to the SoC on my platforms

 2) even if I find a solution for 1), noone ever provided any directions
 on what should be required to make some program like rtc-test.c happy on
 my platforms (alarm support but no interrupt from the RTC). e.g. some 
 refinements like the one introduced by c9f5c7e7a84f1b7 (rtc: rtc-spear:
 Provide flag for no support of UIE mode). I guess it should be fairly
 simple for someone w/ good knowledge of the RTC subsystem to tell what
 is needed. I do not have that knowledge and the documentation does not
 help.

Regarding 1), I am starting to wonder if the best way out would not be
for me to connect the interrupt line of the ISL12057 to one of the GPIO
line currently connected to the LCD on my RN104 (after having
disconnected the LCD) and change the function of the associated MPP on
the SoC to make it an interrupt line. Could that work w/o additional
hardware modification? What are my chances of killing the board?

But this is pointless if I do not get any clear directions about 2).

Cheers,

a+

[1]: http://natisbad.org/NAS2/index.html#hw
