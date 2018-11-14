From: Tudor.Ambarus@microchip.com (Tudor.Ambarus at microchip.com)
Date: Wed, 14 Nov 2018 13:45:29 +0000
Subject: Clock configuration for the SAMA5D2 NAND controller
In-Reply-To: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
References: <CAGkQfmNuROsD29jR_7opiXcfPB6=FuaoxaK-hF5Ezz7r-1pBZA@mail.gmail.com>
Message-ID: <63b44c97-1700-c8e4-0a26-c87e51572575@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Romain,

On 10/10/2018 08:05 PM, Romain Izard wrote:
> Hello,
> 
> While evaluating a new flash memory chip for my product based on a SAMA5D2
> chip, I tried to update my software to use the latest device tree bindings.
> 
> Until now, I was using the legacy bindings for the NAND controller, that
> preserved the timings configured by the bootloader in the EBI registers. The
> bindings introduced in Linux 4.13 are used together with the NAND driver to
> reconfigure the timings of the memory interface to match the speed profile
> declared by some NAND components.
> 
> However, when comparing the timings in the registers, there was a large
> difference between what I calculated by hand in the past and the values
> configured by the drivers. The difference was in fact a 2 factor.
> 
> For me, the issue is due to the clock configuration declared in the SAMA5D2
> device tree: The reference clock used by the nand-controller driver is the
> clock for its parent node, which is directly the Master Clock. And on my
> end, what I understood when writing the clock settings for my bootloader was
> that the reference clock was the HSMC clock, which derives from the H32MX
> clock, which runs at half the rate of the Master Clock.
> 
> The documentation for the SAMA5D2 is not very precise on this topic, so I
> would like to have some feedback. Is the clock used as a reference for the
> chip select configuration registers the Master Clock itself, or is it the
> peripheral clock for the HSMC module ?
> 

I would say that it's the HSMC peripheral clock because it's the only clock that
we describe for HSMC. If this is the case, then we will need to know the
derivation formula used by the Peripheral Clock Controller to derive the MCK2
(AHB 32-bit MATRIX system) clock to Periph_clk[17] HCLOCK_LS (HSMC), in order to
correctly configure the timings to match flashes capabilities.

I asked the hardware team for a clarification, will get back to you soon.

Thanks for your patience,
ta
