From: khilman@baylibre.com (Kevin Hilman)
Date: Thu, 20 Oct 2016 12:39:34 -0700
Subject: [PATCH 2/3] ARM: bus: da8xx-syscfg: new driver
In-Reply-To: <1867292.F3aGJTmS2t@avalon> (Laurent Pinchart's message of "Thu,
 20 Oct 2016 21:05:50 +0300")
References: <1476721850-454-1-git-send-email-bgolaszewski@baylibre.com>
 <2278105.geKhb8xoNC@avalon> <7h8ttj6jqo.fsf@baylibre.com>
 <1867292.F3aGJTmS2t@avalon>
Message-ID: <7h8tti6c95.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Laurent Pinchart <laurent.pinchart@ideasonboard.com> writes:

> On Thursday 20 Oct 2016 09:57:51 Kevin Hilman wrote:
>> Laurent Pinchart <laurent.pinchart@ideasonboard.com> writes:
>> > On Wednesday 19 Oct 2016 10:26:57 Bartosz Golaszewski wrote:
>> >> 2016-10-18 22:49 GMT+02:00 Laurent Pinchart:
>> >>> On Monday 17 Oct 2016 18:30:49 Bartosz Golaszewski wrote:
>> >>>> Create the driver for the da8xx System Configuration and implement
>> >>>> support for writing to the three Master Priority registers.
>> >>>> 
>> >>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> >> 
>> >> [snip]
>> >> 
>> >>>> +
>> >>>> +Documentation:
>> >>>> +OMAP-L138 (DA850) - http://www.ti.com/lit/ug/spruh82c/spruh82c.pdf
>> >>>> +
>> >>>> +Required properties:
>> >>>> +
>> >>>> +- compatible:                "ti,da850-syscfg"
>> >>> 
>> >>> Don't you need a reg property ?
>> >> 
>> >> Yes, Kevin already pointed that out. I'll add it in v2. Same for [1/3].
>> >> 
>> >>>> +Optional properties:
>> >>>> +
>> >>>> +The below properties are used to specify the priority of master
>> >>>> peripherals.
>> >>>> +They must be between 0-7 where 0 is the highest priority and 7 is the
>> >>>> lowest.
>> >>>> +
>> >>>> +- ti,pri-arm-i:              ARM_I port priority.
>> >>>> +
>> >>>> +- ti,pri-arm-d:              ARM_D port priority.
>> >>>> +
>> >>>> +- ti,pri-upp:                uPP port priority.
>> >>>> +
>> >>>> +- ti,pri-sata:               SATA port priority.
>> >>>> +
>> >>>> +- ti,pri-pru0:               PRU0 port priority.
>> >>>> +
>> >>>> +- ti,pri-pru1:               PRU1 port priority.
>> >>>> +
>> >>>> +- ti,pri-edma30tc0:  EDMA3_0_TC0 port priority.
>> >>>> +
>> >>>> +- ti,pri-edma30tc1:  EDMA3_0_TC1 port priority.
>> >>>> +
>> >>>> +- ti,pri-edma31tc0:  EDMA3_1_TC0 port priority.
>> >>>> +
>> >>>> +- ti,pri-vpif-dma-0: VPIF DMA0 port priority.
>> >>>> +
>> >>>> +- ti,pri-vpif-dma-1: VPIF DMA1 port priority.
>> >>>> +
>> >>>> +- ti,pri-emac:               EMAC port priority.
>> >>>> +
>> >>>> +- ti,pri-usb0cfg:    USB0 CFG port priority.
>> >>>> +
>> >>>> +- ti,pri-usb0cdma:   USB0 CDMA port priority.
>> >>>> +
>> >>>> +- ti,pri-uhpi:               HPI port priority.
>> >>>> +
>> >>>> +- ti,pri-usb1:               USB1 port priority.
>> >>>> +
>> >>>> +- ti,pri-lcdc:               LCDC port priority.
>> >>> 
>> >>> I'm afraid this looks more like system configuration than hardware
>> >>> description to me.
>> >> 
>> >> While you're certainly right, this approach is already implemented in
>> >> several other memory and bus drivers and it was also suggested by
>> >> Sekhar in one of the tilcdc rev1 threads. There's also no real
>> >> alternative that I know of.
>> > 
>> > The fact that other drivers get it wrong is no excuse for copying them :-)
>> 
>> What exactly is "wrong" with the way other drivers are doing it?
>> 
>> I'm sure there may be other ideas, and possibly some better ones, but
>> that doesn't make it wrong, and doesn't change he fact that the kernel
>> has existing drivers SoC-bus-specific system performance knobs like
>> this.
>
> It's not the drivers I'm concerned about, but the DT bindings.

I see, thanks for the clarification.

> The proposed DT binding contains a large number of properties that
> don't describe the hardware but contain configuration data.

I agree that there ought to be some more generic way for devices to
request performance constraints from their busses at runtime based on
their current operating critera, but unfortunately that doesn't exist
yet.

However, after our discussion on IRC, we'll respin this without the DT
bindings at all.  Next version will just use static configuration data
in the drivers/bus driver based on SoC compatible string, since for the
use-cases I'm aware of, the settings are boot-time only.

Thanks again for the review,

Kevin
