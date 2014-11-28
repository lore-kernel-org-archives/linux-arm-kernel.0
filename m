From: stefan@agner.ch (Stefan Agner)
Date: Sat, 29 Nov 2014 00:00:14 +0100
Subject: [PATCH 2/2] ARM: imx: src: support vf610 system reset controller
In-Reply-To: <18555848.LVhqYu0kXL@wuerfel>
References: <1417193015-6033-1-git-send-email-stefan@agner.ch>
 <2716009.DOfHfaSPkY@wuerfel> <6341b31998ff843d236bc2a3e34537b0@agner.ch>
 <18555848.LVhqYu0kXL@wuerfel>
Message-ID: <d3026e3c95825c31a80cf32b3600ad42@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-11-28 23:22, Arnd Bergmann wrote:
> On Friday 28 November 2014 23:09:09 Stefan Agner wrote:
>> On 2014-11-28 22:24, Arnd Bergmann wrote:
>> > On Friday 28 November 2014 22:02:01 Stefan Agner wrote:
>> >
>> >> > If the SRC is also capable of resetting individual blocks instead of just
>> >> > the entire machine, it would be a reset driver in drivers/reset instead.
>> >>
>> >> Beside the system reset, there is only a mask functionality for the
>> >> watchdogs (there are two watchdogs, one for Cortex-A5 and one for the
>> >> M4). This makes the SRC module in the Vybrid a bit different then what
>> >> is available on other i.MX SoC's...
>> >
>> > If you already have the watchdog registers in there and want to have
>> > a watchdog driver too, the easiest way would be to register the reboot
>> > handler from the watchdog driver.
>>
>> Hm, not sure we speak about the same here. The SRC module has two
>> (multi-)bit fields to mask the watchdog reset event for each watchdog.
>> Beside that, there are two full watchdog register maps, which are in
>> different areas. There is already a driver for this watchdogs. I'm not
>> sure what the idea behind this is exactly, I guess it would easily allow
>> to (temporary) mask the other CPU's watchdog. However, I don't think we
>> need that functionality, so I don't care about that right now.
> 
> Ok, I see, thanks for the clarification!
> 
>> There is also a restart handler in the watchdog driver, but I prefer to
>> use the reset capabilities of the SRC since it has immediate effect.
>>
>> Lets get to the big picture again: I could register the whole SRC
>> register map as a syscon device and then access the registers from my
>> suspend/resume implementation later on. And similar in the restart
>> driver, I would use syscon_regmap_lookup_by_compatible to check if it
>> contains the vf610-src compatible string and register the restart
>> driver/handler if available.
> 
> Correct, and also in the watchdog driver, I guess.
> 
> Instead of syscon_regmap_lookup_by_compatible, please use
> syscon_regmap_lookup_by_phandle and put the link to the syscon
> device into the device accessing it.
> 
> Also, see if you can use or extend drivers/power/reset/syscon-reboot.c
> for your use case.

Nice, this allows to do the reset with almost no code. The only thing
which might be a problem is the priority: I used 192 since 128 is
already used by the watchdog driver. Maybe we can change that
syscon-reboot is a bit above watchdogs by default, or maybe even a dt
property? I will try to use that driver for v2. Thx! 

--
Stefan
