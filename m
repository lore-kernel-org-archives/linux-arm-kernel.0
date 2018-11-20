From: Tudor.Ambarus@microchip.com (Tudor.Ambarus at microchip.com)
Date: Tue, 20 Nov 2018 11:28:14 +0000
Subject: Clock configuration for the SAMA5D2 NAND controller
In-Reply-To: <63b44c97-1700-c8e4-0a26-c87e51572575@microchip.com>
References: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
 <63b44c97-1700-c8e4-0a26-c87e51572575@microchip.com>
Message-ID: <1eb26b47-49a7-c667-e986-824ee3d726d5@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Romain,

On 11/14/2018 03:45 PM, Tudor Ambarus wrote:
> Hi, Romain,
> 
> On 10/10/2018 08:05 PM, Romain Izard wrote:
>> Hello,
>>
>> While evaluating a new flash memory chip for my product based on a SAMA5D2
>> chip, I tried to update my software to use the latest device tree bindings.
>>
>> Until now, I was using the legacy bindings for the NAND controller, that
>> preserved the timings configured by the bootloader in the EBI registers. The
>> bindings introduced in Linux 4.13 are used together with the NAND driver to
>> reconfigure the timings of the memory interface to match the speed profile
>> declared by some NAND components.
>>
>> However, when comparing the timings in the registers, there was a large
>> difference between what I calculated by hand in the past and the values
>> configured by the drivers. The difference was in fact a 2 factor.
>>
>> For me, the issue is due to the clock configuration declared in the SAMA5D2
>> device tree: The reference clock used by the nand-controller driver is the
>> clock for its parent node, which is directly the Master Clock. And on my
>> end, what I understood when writing the clock settings for my bootloader was
>> that the reference clock was the HSMC clock, which derives from the H32MX
>> clock, which runs at half the rate of the Master Clock.
>>
>> The documentation for the SAMA5D2 is not very precise on this topic, so I
>> would like to have some feedback. Is the clock used as a reference for the
>> chip select configuration registers the Master Clock itself, or is it the
>> peripheral clock for the HSMC module ?
>>
> 
> I would say that it's the HSMC peripheral clock because it's the only clock that

The hardware team confirmed that the timings are based on MCK which is MCK/2.
The periph_clk is MCK/2 as well, but used to clock the logic of the IP.

The HSMC receives a AHB clock HCLOCK_LS (MCK/2) used to generate the timings and
a PCLOCK_LS used to clock the HSMC/NFC logic.


> we describe for HSMC. If this is the case, then we will need to know the
> derivation formula used by the Peripheral Clock Controller to derive the MCK2
> (AHB 32-bit MATRIX system) clock to Periph_clk[17] HCLOCK_LS (HSMC), in order to
> correctly configure the timings to match flashes capabilities.

I assumed that the on/off box from the Peripheral Clock Controller described at
33.3 Block Diagram implies some derivation formula. I was wrong, the on/off box
is there just to gate the clocks going to the peripherals.

Cheers,
ta
