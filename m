From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 26 Aug 2016 17:55:23 +0530
Subject: [PATCH] ARM: dts: da850: Add missing pin muxing for the UARTs
In-Reply-To: <20160824082934.GA20246@gobelin>
References: <20160804110656.25318-1-kbeldan@baylibre.com>
 <m2eg64pchw.fsf@baylibre.com> <20160804210045.GD15013@gobelin>
 <m2fuqknnqk.fsf@baylibre.com> <fe36e8d1-f371-b093-de15-5e03370ea38c@ti.com>
 <dd4712ba-6144-8c64-59a6-7673936af53c@ti.com>
 <20160824082934.GA20246@gobelin>
Message-ID: <a076cc95-d338-ec13-ba05-360c1857cda5@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 August 2016 02:08 PM, Karl Beldan wrote:
> On Tue, Aug 23, 2016 at 04:46:03PM +0530, Sekhar Nori wrote:
>> On Tuesday 23 August 2016 04:39 PM, Sekhar Nori wrote:
>>> On Friday 05 August 2016 04:30 AM, Kevin Hilman wrote:
>>>> Karl Beldan <kbeldan@baylibre.com> writes:
>>>>
>>>>> On Thu, Aug 04, 2016 at 12:20:27PM -0700, Kevin Hilman wrote:
>>>>>> Karl Beldan <kbeldan@baylibre.com> writes:
>>>>>>
>>>>>>> This adds 2 pinctrl groups (rtscts, rxtx) for each of the 3 UARTs.
>>>>>>>
>>>>>>> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
>>>>>>
>>>>>> Should da850-evm be updated to use the serial2_rxtx_pins also?
>>>>>>
>>>>> I could not find the EVM schematics on the net and I only have an LCDK,
>>>>> but according to the code it should, however I can't tell whether flow
>>>>> control pins are used.
>>>>
>>>> Ok, let's just leave it for now, since it's working fine.  Sekhar can
>>>> fix that up if he can dig up the schematics.
>>>
>>> Looks like the flow control pins are being used for McASP also on the
>>> EVM. So lets leave the EVM as-is.
>>
>> Rather, the EVM dts file should be updated to use serial2_rxtx_pins like
>> the LCDK. Right now it seems to be relying on bootloader to serial2
>> setup pimux correctly. I can make a patch to fix that. Or if you can do
>> it, that will be great too.
>>
> 
> Indeed ATM the EVM relies on the bootloader to setup the pin muxing.
> 
> I just checked the uart pins routing of the EVM, the dts:
> - should reclaim serial2_rxtx_pins and serial2_rtscts_pins

Agree.

> - can reclaim serial1_rxtx_pins (out on Audio connector but very
>   unlikely used for audio)

I would leave alone pins which are unused on the board. Most likely the
SPI pins are being send to audio connector for codec control over SPI.

> - should leave serial1_rtscts_pins (out on Audio connector but used by
>   McASP so used for audio)

Agree.

> Also I think it would be better for the serial nodes to reclaim the rxtx
> pins in the dtsi, and override the reclaimed pins in the .dts only for
> the nodes reclaiming flow control (some other pins could also be
> directly reclaimed in the dtsi).

You lost me here. I guess I will benefit from a code snippet to
illustrate the intention.

> 
> Some other cleanups would also be in order for the da850*:
> - use labels for non dtsi (like I did for the LCDK)

Agree. That would be better and more modern.

> - add chosen,memory nodes (I guess currently only the LCDK can
>   dispense with ATAGS)

ok.

> - use a null range translation in the da850 dtsi for the soc node
>   (computing the offsets is error prone and is there a point)

I do agree its easier to read if offsets directly matches addresses
specified in the technical reference manual than doing the math with
offsets and making sure they are correct.

That said, I am not sure null range translation is really the preferred
approach. I would go with what DT maintainers say here.

> 
> Sure I could fix that, along with some of the above suggestions if you
> are ok with it.

It would be nice if you could fixup mcasp0_pins in da850-evm.dts. Surely
it is doing more than what is needed.

Regards,
Sekhar
