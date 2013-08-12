From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Mon, 12 Aug 2013 18:44:10 +0200
Subject: [PATCH 1/3] ARM: Introduce atomic MMIO clear/set
In-Reply-To: <20130812154646.GA5460@localhost>
References: <1376138582-7550-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130810140237.GB3080@localhost> <20130810140927.GC3080@localhost>
 <1376149388.716003514@f150.i.mail.ru> <20130810155552.GB17936@localhost>
 <20130812154646.GA5460@localhost>
Message-ID: <520910DA.4000203@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/13 17:46, Ezequiel Garcia wrote:
>> Indeed, syscon looks like a nice match for this use case.
>> (although it still looks like an overkill to me).
>>
>> I've been trying to implement a working solution based in syscon but I'm
>> unable to overcome an issue.
>>
>> The problem is that we need the register/regmap to initialize the clocksource
>> driver for this machine (aka the timer). Of course, this happens at a
>> *very* early point, way before the syscon driver is available... :-(
>>
>> Maybe someone has an idea?
>
> Sebastian, Russell: I can't find the previous mail where you proposed
> this solution to address the shared register issue between Kirkwood's
> watchdog and clocksource.

Russell first mentioned an atomic modify function here:
http://archive.arm.linux.org.uk/lurker/message/20130618.113606.d7d4fe4b.en.html

Linus Walleij already suggested mfd/syscon as a container
for protected register accesses later.

> Is this what you had in mind?

The pro of a generic atomic clear/set is that we can use it
very early, on all platforms, and from totally unrelated
drivers. As you already mentioned, using syscon from timers will
get us into into trouble, because it has not been registered.

> Do you think trying to use a regmap could be better (given we can
> sort out the problem explained above)?

Given the small number of registers we need to protect and especially
for using it in timers, I'd prefer your proposal. Otherwise, I guess,
we would have to mimic mfd/syscon for time-orion and time-armada-370-xp
and make wdt-orion depend on it. I doubt we can make any use of
mfd/syscon for the timer use case.

Sebastian
