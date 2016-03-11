From: kernel@martin.sperl.org (Martin Sperl)
Date: Fri, 11 Mar 2016 09:51:59 +0100
Subject: [PATCH v3 04/11] ARM: bcm2835: dt: add bindings for shared
 interrupt properties
In-Reply-To: <20160310085714.GA31313@svinekod>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
 <1457175142-28665-5-git-send-email-kernel@martin.sperl.org>
 <20160310085714.GA31313@svinekod>
Message-ID: <E60A6B56-0F3F-465C-8BF7-59EF35D41070@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 10.03.2016, at 09:57, Mark Rutland <mark.rutland@arm.com> wrote:
> 
> Hi,
> 
> As a general note, please put DT bindings patches before any patches
> implementing them, as per
> Documentation/devicetree/bindings/submitting-patches.txt.
> 
> That makes it possible to review a series in-order.
> 
> On Sat, Mar 05, 2016 at 10:52:15AM +0000, kernel at martin.sperl.org wrote:
>> From: Martin Sperl <kernel@martin.sperl.org>
>> 
>> Add binding documentation for the new shared interrupt properties:
>> * brcm,dma-channel-shared-mask
>> * brcm,dma-shared-irq-index
>> 
>> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>> ---
>> Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt | 6 ++++++
>> 1 file changed, 6 insertions(+)
>> 
>> diff --git a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> index 1396078..f9e84ee 100644
>> --- a/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> +++ b/Documentation/devicetree/bindings/dma/brcm,bcm2835-dma.txt
>> @@ -17,6 +17,10 @@ Required properties:
>> - brcm,dma-channel-mask: Bit mask representing the channels
>> 			 not used by the firmware in ascending order,
>> 			 i.e. first channel corresponds to LSB.
>> +- brcm,dma-channel-shared-mask: Bit mask representing the channels
>> +				that use a shared interrupt
> 
> Generally we don't like masks in DT (though I see this is in keeping with
> another property above). I won't push strongly here.
> 
> I take it that this is a fixed HW property rather than a software configuration
> option?

This is fixed HW property - the mask/mapping was originally proposed
to be ?hardcoded? inside the driver.

Maybe some background on the dma-channel-mask property:
it is changed during loading the dt by the firmware
to mask out the channels that the firmware is using.

> 
>> +- brcm,dma-shared-irq-index: index of which of the interrupts mentioned
>> +			     above is the shared interrupt
> 
> What is the usual order of the interrupts? How are they expected to be parsed
> if this is in the middle of the list, for example?
> 
> I think this needs a more thorough description.

The reason that it was done this way is mostly because of DT-backwards
compatibility the 11th irq is the shared interrupt -there were some
wrong assumptions by the original author on the interrupts
(i.e there is a dedicated interrupt per channel).

Just hardcoding it inside the driver was not what Vinod wanted - even
if the design stayed fixed for now 3 different chips:
bcm2835, bcm2836 and bcm2837

Alternative options that have been considered:
* there is unfortunately no ?interrupt-names? property (like it exists for
  reg, dma), because then I would have preferred to used:
     interrupts = <...>, <...>, ?;
     interrupt-name = ?dma0?, ?dma1?, ..., ?dma10?, ?dmashared?, ?dmaall?;
  with something like this we could probably have avoided both properties
  and just added a legacy mapping
  This would require some changes to the irq framework (which I wanted
  to avoid)
* I could have also written a custom parser in the driver to allow:
     interrupt-shared = <&int X>;
   but I would guess something like this to be frowned upon...
* a total restructure of the DT to a more expressive format so that 
  each channel would need to be described separately (with the 
  corresponding custom dt parser).
  The big advantage here would be that we can define the reg and irq
  range for each channel separately.
  Could look something like:
     dma: dma at 7e0070fe0 {
        reg = <0x7e0070fe0 0x20>;
        compatible = "brcm,bcm2835-dma?;
        interrupts = <irq-shared> <irq-all>;
        dma0: dma at 7e007000 {
	  reg = <0x7e007000 0x24>;
          interrupts = <irq-dma0>;
        };
        dma1: dma at 7e007100 {
	  reg = <0x7e007100 0x24>;
          interrupts = <irq-dma1>;
        };
   	...
        dma10: dma at 7e007a00 {
	  reg = <0x7e007a00 0x24>;
          interrupts = <irq-dma10>;
        };
        /* channel with shared interrupts */
        dma11: dma at 7e007b00 {
	  reg = <0x7e007b00 0x24>;
	  /* no irq - use shared */
        };
        dma14: dma at 7e007b00 {
	  reg = <0x7e007b00 0x24>;
	  /* no irq - use shared */
        };
	/*
         * dma channel 15 is a different type:
	 * only triggers irq-all (with all its problems)
         * is in a different memory location
         */
	dma15: dma at 7ee05000 {
	  reg = <0x7ee05000 0x24>;
	  /* potentially mark the use of the ?all? irq */
        };
     };
  It would make the device tree a lot longer (at least 60 lines) for
  minimal gains.
  In addition it is a lot of effort for something that has been fixed
  for 3 chip designs (bcm2835, bcm2836 and bcm2837)

  Something like this has been proposed as an option end of
  January, but there was never a feedback if something like
  this was preferred.

Please give guidance on the preferred solution.

We really would like to get the slave-dma feature into the kernel
so that we can start using it with the mmc/sdhost implementation.

Thanks,
	Martin
