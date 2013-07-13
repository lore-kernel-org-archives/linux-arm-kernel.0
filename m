From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 13 Jul 2013 19:44:58 +0200
Subject: DT binding review for Armada display subsystem
In-Reply-To: <20130713111239.GM24642@n2100.arm.linux.org.uk>
References: <20130712164428.AC3D2FAAE9@dev.laptop.org>
 <20130712203952.6b7aa927@armhf>
 <CAMLZHHT1oAvOLe3JgQqMqLNXEr0NGrdtgELtF_djbqLFceHtiQ@mail.gmail.com>
 <20130713103516.38a55b0b@armhf> <51E13272.5040903@gmail.com>
 <20130713111239.GM24642@n2100.arm.linux.org.uk>
Message-ID: <51E1921A.3070207@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/13/2013 01:12 PM, Russell King - ARM Linux wrote:
> On Sat, Jul 13, 2013 at 12:56:50PM +0200, Sylwester Nawrocki wrote:
>> On 07/13/2013 10:35 AM, Jean-Francois Moine wrote:
>>> On Fri, 12 Jul 2013 13:00:23 -0600 Daniel Drake<dsd@laptop.org>  wrote:
>>>> On Fri, Jul 12, 2013 at 12:39 PM, Jean-Francois Moine<moinejf@free.fr>  wrote:
>>
>>>>> - the phandles to the clocks does not tell how the clock may be set by
>>>>>     the driver (it is an array index in the 510).
>>>>
>>>> In the other threads on clock selection, we decided that that exact
>>>> information on how to select a clock (i.e. register bits/values) must
>>>> be in the driver, not in the DT. What was suggested there is a
>>>> well-documented scheme for clock naming, so the driver knows which
>>>> clock is which. That is defined in the proposed DT binding though the
>>>> "valid clock names" part. For an example driver implementation of this
>>>> you can see my patch "armada_drm clock selection - try 2".
>>>
>>> OK.
>>>
>>> Sorry to go back to this thread.
>>>
>>> I use my Cubox for daily jobs as a desktop computer. My kernel is a DT
>>> driven 3.10.0. The dove-drm, tda998x and si5351 (clock) are kernel
>>> modules. I set 3 clocks in the DT for the LCD0: lcdclk, axi and extclk0
>>
>> Hmm, a bit off topic question, does it work when the si5351 module gets
>> removed ? I can't see anything preventing clock provider module from being
>> removed why any of its clocks is used and clk_unregister() function is
>> currently unimplemented.
>
> When I designed the clk API, I arranged for things like clk_get() to
> take a reference on the module if the clock was supplied by a module.
> You'll see some evidence of that by looking back in the git history
> for arch/arm/mach-integrator/include/mach/clkdev.h.

Last time I checked, clkdev API neither implements referencing nor
unregister. This is on Mike's list and IIRC there already has been
a proposal for unregister. Si5351 was the first clkdev driver ever
that could possibly be unloaded, so there may be still some features
missing.

> If the common clk API has been designed without any thought to clocks
> supplied by modules and making sure that in-use clocks don't go away,
> then it's going to be a real pain to sort that out.  I don't think
> refcounting clocks makes sense (what do you do with an enabled clock
> that you then remove the module for but it's still being used?  Do you
> just shut it down anyway?  Do you leave it running?  What about
> subsequent calls?).

Good point, first I thought always disable on last user dropping it but
that may most likely break some platforms. Second thought, get back to
the state when the driver was loaded.

> I think this is one case where taking a reference on the module supplying
> it makes total sense.
>
>>> (si5351). Normally, the external clock is used, but, sometimes, the
>>> si5351 module is not yet initialized when the drm driver starts. So,
>>> for 1920x1080p, it uses the lcdclk which sets the LCD clock to 133333
>>> (400000/3) instead of 148500. As a result, display and sound still work
>>> correctly on my TV set thru HDMI.
>>>
>>> So, it would be nice to have 2 usable clocks per LCD, until we find a
>>> good way to initialize the modules in the right order at startup time.
>>
>> Doesn't deferred probing help here ?
>
> Indeed it does.  Just because one TV works with such a wrong clock does not
> mean that all TVs and HDMI compatible monitors will do.  It's 11% out.
>
> The reason that audio works is because of the way the HDMI transmitter works
> - it can calculate the CTS value to send (by measuring it) and it sends that
> value over the link so the TV can regenerate the correct audio clock from
> the HDMI clock.

True, wrong clock will most likely not work on all monitors or TV. My
impression for TVs is that the the "cheaper" the brand is, the more
likely they accept any mode/clock combination ;)

> Whether that's going to be universally true, I don't know - it depends on
> how much audio data gets sent via each frame.  As the HDMI clock is slower,
> there would need to be more audio data sent.

Also: audio/video clock relation is sent in AVI packets over HDMI.
Picking a clock with 11% off may not even allow you to send (valid) CTS
information.

>>> 	lcd0: lcd-controller at 820000 {
>>> 		compatible = "marvell,dove-lcd0";
>> [...]
>>> 	};
>>>
>>> 	lcd1: lcd-controller at 810000 {
>>> 		compatible = "marvell,dove-lcd1";
>> [...]
>>> 	};
>>
>> Using different compatible strings to indicate multiple instances of same
>> hardware doesn't seem right. Unless LCD0, LCD1 are really different pieces
>
> They aren't.  They're 100% identical in the Armada 510.
>
>> of hardware incompatible with each other I think it would be more correct
>> to use same compatible property and DT node aliases, similarly as is now
>> done with e.g. I2C busses:
>>
>> 	aliases {
>> 		lcd0 = &lcd_0;	
>> 		lcd1 = &lcd_1;	
>> 	};
>>
>>   	lcd_0: lcd-controller at 820000 {
>>   		compatible = "marvell,dove-lcd";
>
> I'd much prefer marvell,armada-510-lcd rather than using the codenames for
> the devices.  Otherwise we're going to run into totally different things
> being used for different devices (eg, armada-xp...)
>

+1 for using marvell,armada-510-lcd. I like the nick-name "dove" but
armada-510 is much easier to find on Marvell's website.

Sebastian
