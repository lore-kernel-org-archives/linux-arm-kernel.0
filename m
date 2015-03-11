From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 11 Mar 2015 12:17:01 +0100
Subject: [PATCH v2 5/6] watchdog: at91sam9: request the irq with
 IRQF_NO_SUSPEND
In-Reply-To: <20150311093848.2b23a027@bbrezillon>
References: <1425287898-15093-1-git-send-email-boris.brezillon@free-electrons.com>	<20150307103939.GA17964@amd>	<20150307110645.GW3989@piout.net>	<2616799.fRG1k0Q6sR@vostro.rjw.lan>
 <20150311093848.2b23a027@bbrezillon>
Message-ID: <5500242D.3080605@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/03/2015 09:38, Boris Brezillon a ?crit :
> On Sun, 08 Mar 2015 02:11:45 +0100
> "Rafael J. Wysocki" <rjw@rjwysocki.net> wrote:
> 
>> On Saturday, March 07, 2015 12:06:45 PM Alexandre Belloni wrote:
>>> On 07/03/2015 at 11:39:39 +0100, Pavel Machek wrote :
>>>>> The Atmel watchdog can't be stopped once it's started. This is actually 
>>>>> very useful so we can reset if suspend or resume failed, the only 
>>>>> drawback is that you have to wake up from time to time (e.g. by using 
>>>>> the RTC/RTT) to clear the watchdog and then go back to sleep ASAP.
>>>>
>>>> Yeah. So you do "echo mem > /sys/power/state", and few seconds/minutes
>>>> after watchdog kills the system. But you did not ask for dead system,
>>>> you asked for suspend.
>>>>
>>>> And while that behaviour is useful for you, I don't think it is
>>>> exactly useful behaviour, nor it is the behaviour user would expect.
>>>>
>>>
>>> I think you misunderstood, that is exactly the expected behaviour. This
>>> is hardware defined. Once the watchdog is started, nobody can stop it.
>>> Trying to change the mode register will result in a reset of the SoC.
>>>
>>> It is documented in the datasheet and any user wanting another behaviour
>>> is out of luck.
>>>
>>> So basically, when using a watchdog, you have to wake up every 15-16s to
>>> restart it.
>>
>> So question is if we need a separate interrupt handler for that, expecially
>> since it is shared with the PIT timer anyway.
>>
>> Seems to me that the simplest way out of this conundrum would be to simply
>> make the timer's interrupt handler kick the watchdog every once a while and
>> get rid of the separate watchdog interrupt handler entirely.
> 
> The watchdog interrupt handler is not here to ping the watchdog, it's
> here to reset the platform if the watchdog hasn't been refreshed
> appropriately.
> 
> IOW, it's a software watchdog using at91 WDT capabilities to determine
> when it should reboot the system.
> IIRC, we need this on some at91 platforms to fix a HW bug (maybe
> Nicolas can confirm this).

Yes, the HW bug that we address in these functions:
at91sam9260_restart() and at91sam9g45_restart().

We have this issue because of NAND flash lines shared with DDR that are
driven during product reboot on old products (Cf. these functions
comments). This bug would kick-in when doing "software reset"/"watchdog
reset"/"push button reset". Only the "software reset" is handled by the
functions above.

So, yes, this "software watchdog" is there for this purpose IIRC.

Bye,
-- 
Nicolas Ferre
