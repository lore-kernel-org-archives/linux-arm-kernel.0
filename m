From: peda@axentia.se (Peter Rosin)
Date: Wed, 1 Aug 2018 11:01:12 +0200
Subject: [PATCH v2 0/7] tda998x: allow use with bridge based devices
In-Reply-To: <20180731111537.GJ17271@n2100.armlinux.org.uk>
References: <20180730164137.GD17271@n2100.armlinux.org.uk>
 <73adc630-21cd-5b14-cb47-f1a58ee3bc83@axentia.se>
 <20180731074114.GF17271@n2100.armlinux.org.uk>
 <9d48e374-be2f-fbc0-ca92-1b7e1b68e358@axentia.se>
 <20180731092343.GH17271@n2100.armlinux.org.uk>
 <9bf5e0e9-c1e8-5af2-7fea-40f9618d4d52@axentia.se>
 <20180731111537.GJ17271@n2100.armlinux.org.uk>
Message-ID: <59eeb1c4-163c-4fda-d51e-27f2f404fe3e@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-31 13:15, Russell King - ARM Linux wrote:
> On Tue, Jul 31, 2018 at 12:43:34PM +0200, Peter Rosin wrote:
>> On 2018-07-31 11:23, Russell King - ARM Linux wrote:
>>> On Tue, Jul 31, 2018 at 09:53:57AM +0200, Peter Rosin wrote:
>>>> On 2018-07-31 09:41, Russell King - ARM Linux wrote:
>>>>> On Tue, Jul 31, 2018 at 07:44:24AM +0200, Peter Rosin wrote:
>>>>>> On 2018-07-30 18:41, Russell King - ARM Linux wrote:
>>>>>>> Hi,
>>>>>>>
>>>>>>> This is a re-posting of the series I responded to Peter Rosin's May
>>>>>>> posting, with a few bugs fixed, and the bridge registered outside of
>>>>>>> the component helper.  This should allow Peter to use the driver
>>>>>>> while maintaining armada drm and tilcdc support.
>>>>>>>
>>>>>>> No comments (other than 0-day test results) were received on the
>>>>>>> previous posting.
>>>>>>
>>>>>> I of course meant to comment on this! I didn't because there was a rush
>>>>>> before vacation, then vacation, then a heap of important stuff that had
>>>>>> piled up. This one simply had too low priority to make a significant bleep
>>>>>> on the radar. Sorry for the silence...
>>>>>>
>>>>>> However, now that I do try to test, I get conflicts as I try to apply the
>>>>>> patches. I'm wondering what this was based on? I've tried next-20180730
>>>>>> drm-misc/drm-misc-next from some minutes ago.
>>>>>
>>>>> They're based on 4.17.
>>>>
>>>> Right, meanwhile I massaged the patches into a combo of some local patches,
>>>> next-20180730 and drm-misc-next, and tested that. The conflict was trivial
>>>> once I had a closer look...
>>>>
>>>> And it seems to work (with atmel-hlcdc), so you can add
>>>>
>>>> Tested-by: Peter Rosin <peda@axentia.se>
>>>
>>> Thanks, I've added your attributation, and fixed patch 2 as you pointed
>>> out.
>>>
>>> I have a four more tda998x patches if you're willing to test.  These
>>> follow on from this set - I've tweaked patch 2 in this follow on set to
>>> cater for the removal of "_mode_" in
>>> drm_mode_connector_update_edid_property.
>>
>> Sure thing. Those patches work for me too. So, feel free to add
>>
>> Tested-by: Peter Rosin <peda@axentia.se>
>>
>> However, a couple of notes:
>>
>> 1) I never succeeded in reading the edid, so I'm using a built-in edid.
>>
>> I noticed the patch adding the nxp,calib gpio and got my hopes up, but
>> if I just add that to the DT I get
>>
>> tda998x 2-0070: found TDA19988
>> gpio-21 (nxp,calib): gpiod_direction_output: tried to set a GPIO tied to an IRQ as output
>> tda9950 2-0034: TDA9950 CEC interface, hardware version 3.3
>>
>> Grepping the source, that comes from gpiod_direction_output, which
>> fails with -EIO after that message, so that can't be working...
>>
>> (Side note on that gpio; the way I read the patch I should specify
>> the gpio as GPIO_ACTIVE_HIGH, but that seems backwards? Isn't the
>> INT pin on the tda19988 active low?)
> 
> See below...
> 
>> ...and if I try to evade that by commenting out the interrupt stuff
>> from the DT, I instead get
>>
>> tda998x 2-0070: found TDA19988
>> tda9950 2-0034: driver requires an interrupt
>>
>> Are we supposed to wire the INT pin to two different pins on the CPU, or
>> what?
> 
> It's a problem with how some GPIO/IRQ drivers in Linux model GPIOs
> used as interrupts.  There is a school of thought that if an IRQ is
> requested, then the GPIO associated with it should be requested and
> forced as an input.  Not every GPIO/IRQ driver implements this, and
> the Dove driver does not.  So, TDA998x with CEC works there.
I guess I might have to live without CEC, which BTW is not the end of
the world...

> That's fine and dandy when you have "sensible" hardware, but the TDA998x
> uses the INT pin for more than just signalling an interrupt.  It is also
> used as a calibration mechanism for the CEC controller's free-running
> clock.  The CEC block requires various registers set, and then the INT
> pin being pulled low for exactly 10ms and then raised by the CPU.  It
> uses this pulse to count the number of cycles of the internal FRO to
> calculate the divider necessary to get the CEC bus clock.
> 
> The GPIO is "active high" because we drive it in "true" sense:
> 
>         local_irq_disable();
>         gpiod_set_value(calib, 0);
>         mdelay(10);
>         gpiod_set_value(calib, 1);
>         local_irq_enable();
> 
> Note that the GPIO sense is independent of the IRQ trigger sense.

Yes, I noticed this, but just mentioned that I thought it backwards. You
activate the special state by setting the pin low, which to me make it a
prime candidate for using active-low (especially when the INT function of
the pin is active-low, but that isn't really related). But of course,
active-low or active-high ultimately depends on *what* it is that is
active, so it will always be a matter of definition. Anyway, the ship has
sailed...

> Some TDA998x seem to function without calibration, but it depends on the
> temperature and supply voltage to the device, and the margins on other
> devices on the CEC bus.
> 
> The TDA998x and CEC implement what's required for CEC to work, which
> requires a GPIO/IRQ driver that does not subscribe to the above
> mentioned school of thought.
> 
> However, this should only cause the CEC part to fail, and should not be
> an issue for reading the EDID.
> 
> EDID reading works in two stages with the TDA998x - there is no direct
> access to the EEPROM in the HDMI sink.  Instead, the TDA998x is
> requested to read a block from the HDMI sink, and the received data
> then appears in the TDA998x registers.  The interrupt _is_ optional
> for the TDA998x non-CEC part, and when present will be used to deal with
> hotplug and EDID reading.  It is required for the CEC functionality
> though, so if there's no interrupt present in DT, the TDA9950 CEC
> controller driver will fail, but the TDA998x should continue to work.
> 
> If you have tried without an interrupt, and EDID reading still doesn't
> work, it suggests there's an electrical problem with the DDC bus between
> the TDA998x and the HDMI sink.

Interrupt or not does not seem to matter.

And yes, my plan is to try to hook up a oscilloscope to the DDC bus, but
it's a bit difficult since the HW designer didn't add any test points and
covered the interesting part of the board with the CPU module. Sigh. And a
microscope would be helpful, something which I don't have at this location.
So, it might be a while before I can actually do it...

>> Is edid reading know to work on 19988? The code suggests so, but maybe
>> it hasn't been tested? Or maybe it regressed?
> 
> I've been using the TDA998x pretty much constantly and EDID reading
> does work.  I've not had any reports that it fails on Juno nor with
> the TI hardware either, and I'm sure that I would've had some reports
> if it didnt' work there.
> 
> There is an issue I'm aware of with the Synopsis DesignWare I2C
> controller - attempts to read more than 16 bytes result in the I2C
> master hardware crapping out, but in that case you'll get:
> 
>   "transfer terminated early - interrupt latency too high"
> 
> in the kernel log - the problem there is that the hardware
> _automatically_ performs an I2C bus stop if the TX FIFO empties
> during a read, which means a high interrupt latency causes only the
> first TX FIFO-depth of data to be received.  The driver _used_ to
> report success with garbage in the receive buffer after the first
> 16 bytes, now it gracefully fails and reports the condition to the
> kernel log.
> 
> So, failure to read the EDID can have multiple reasons - it'll need
> some investigation - is it the TDA998x failing to read the EDID from
> the sink, or is it a failure to correctly read the EDID out of the
> TDA998x due to some bug in the I2C driver interacting with a large
> I2C receive request?

I don't think it's a problem with the atmel I2C driver. IIRC, the
tda998x driver issues the command a initiate the EDID read, but that
times out. So it appears to be the TDA19988 that fails to read the
EDID over the DDC bus? Which brings me to the double problem with the
scopes mentioned above...

Cheers,
Peter

>> 2) The lowest resolution on my monitor is 800x600, so I suppose I
>> can't really test 4/4?
> 
> No matter, it can stay as "experimental" for the time being.  However,
> I should probably arrange for the mode validation to reject pixel
> doubled modes while we don't support them.
> 
