From: kernel@martin.sperl.org (Martin Sperl)
Date: Wed, 13 Jan 2016 15:24:59 +0100
Subject: [PATCH V2 3/8] dmaengine: bcm2835: use shared interrupt for
 channel 11 to 14.
In-Reply-To: <20160113134338.GH11130@localhost>
References: <1452187987-2605-1-git-send-email-kernel@martin.sperl.org>
 <1452187987-2605-4-git-send-email-kernel@martin.sperl.org>
 <20160113122621.GA11130@localhost> <56965178.7070700@martin.sperl.org>
 <20160113134338.GH11130@localhost>
Message-ID: <56965E3B.7060104@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 13.01.2016 14:43, Vinod Koul wrote:
> On Wed, Jan 13, 2016 at 02:30:32PM +0100, Martin Sperl wrote:
>> On 13.01.2016 13:26, Vinod Koul wrote:
>>> On Thu, Jan 07, 2016 at 05:33:01PM +0000, kernel at martin.sperl.org wrote:
>>>> @@ -638,13 +666,21 @@ static int bcm2835_dma_probe(struct platform_device *pdev)
>>>>   		goto err_no_dma;
>>>>   	}
>>>>
>>>> -	for (i = 0; i < pdev->num_resources; i++) {
>>>> -		irq = platform_get_irq(pdev, i);
>>>> +	for (i = 0; i <= BCM2835_DMA_MAX_CHANNEL_NUMBER; i++) {
>>>> +		if (BCM2835_DMA_IRQ_SHARED_MASK & BIT(i)) {
>>>
>>> Ideally this should be done thru DT data and not hard coded in kernel. I
>>> dont think this assumption will hold good for next gen of this device, so
>>> better to get this from DT!
>>
>> The ideal solution would be breaking the DT in such a way that we could
>> define a register range and interrupt per dma-channel looking something
>> like this:
>>
>> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
>> index 83d9787..9526b91 100644
>> --- a/arch/arm/boot/dts/bcm2835.dtsi
>> +++ b/arch/arm/boot/dts/bcm2835.dtsi
>> @@ -31,8 +31,28 @@
>>
>>                  dma: dma at 7e007000 {
>>                          compatible = "brcm,bcm2835-dma";
>> -                       reg = <0x7e007000 0xf00>;
>> -                       interrupts = <1 16>,
>> +                       reg = <0x7e007f00 0x100>, /* status reg */
>> +                             <0x7e007000 0x100>,
>> +                             <0x7e007100 0x100>,
>> +                             <0x7e007200 0x100>,
>> +                             <0x7e007300 0x100>,
>> +                             <0x7e007400 0x100>,
>> +                             <0x7e007500 0x100>,
>> +                             <0x7e007600 0x100>,
>> +                             <0x7e007700 0x100>,
>> +                             <0x7e007800 0x100>,
>> +                             <0x7e007900 0x100>,
>> +                             <0x7e007a00 0x100>,
>> +                             <0x7e007b00 0x100>,
>> +                             <0x7e007c00 0x100>,
>> +                             <0x7e007d00 0x100>,
>> +                             <0x7e007e00 0x100>,
>> +                             /* dma channel 15 uses a different base */
>> +                             <0x7ee05000 0x100>;
>> +                       interrupts = <1 28>, /* catch all DMA-interrupts */
>> +                                    /* dma channel 0-10 interrupts */
>> +                                    <1 16>,
>>                                       <1 17>,
>>                                       <1 18>,
>>                                       <1 19>,
>> @@ -43,9 +63,30 @@
>>                                       <1 24>,
>>                                       <1 25>,
>>                                       <1 26>,
>> +                                    /* dma channel 11-14 share irq */
>>                                       <1 27>,
>> -                                    <1 28>;
>> -
>> +                                    <1 27>,
>> +                                    <1 27>,
>> +                                    <1 27>,
>> +                                    /* no irq support for dma channel 15 */
>> +                                    < 0 >;
>> +                       dma-names = "shared",
>> +                                   "dma0",
>> +                                   "dma1",
>> +                                   "dma2",
>> +                                   "dma3",
>> +                                   "dma4",
>> +                                   "dma5",
>> +                                   "dma6",
>> +                                   "dma7",
>> +                                   "dma8",
>> +                                   "dma9",
>> +                                   "dma10",
>> +                                   "dma11",
>> +                                   "dma12",
>> +                                   "dma13",
>> +                                   "dma14",
>> +                                   "dma15";
>>                          #dma-cells = <1>;
>>                          brcm,dma-channel-mask = <0x7f35>;
>> (or similar)
>>
>> This actually would allow us to make "brcm,dma-channel-mask" redundant,
>> as we could remove those dma channels that are owned by the firmware
>> directly from the list.
>>
>> That way we could also map other capabilities via the DT.
>>
>> It would also allow a transparent addition of additional dma channels
>> with newer versions of the HW - mostly - by modifying the DT.
>
> Precisely
>
>>
>> But that would be frowned upon, so I had to come up with the approach
>> taken, which makes the following assumptions:
>
> DT was designed to move this info and hardcoding from kernel into
> DT, so why cant we do that?
We still need to be backwards-compatible - at least that is what
everyone tells me, so I need to hard-code fallbacks for those values.
>
>> * the DT maps only the interrupts that are assigned to the HW block
>> * the driver knows about the number of DMA channels in HW
that could be a DT property, yes.
>> * the driver knows about the mapping of shared interrupts
>>    (11-14 share irq).
OK - how would you define that "mapping" in a "sane" manner in the DT
that allows us to have multiple such mappings in the future?

>>
>> It is not optimal, but at least it works with the least amount of
>> change to the DT - and what about all those assumptions that we
>> would need to hard-code to be backwards compatible to the DT without?
>>
>> I guess we could replace BCM2835_DMA_MAX_CHANNEL_NUMBER with:
>>    /* we do not support dma channel 15 with this driver */
>>    #define BCM2835_DMA_MAX_CHANNEL_SUPPORTED 14
>>    ...
>>    for (i = 0;
>>         i <= min_t(int, flv(chans_available),
>> BCM2835_DMA_MAX_CHANNEL_SUPPORTED);
>>         i++) {
>>
>> So which way would you prefer this to go - I got another few days
>> before I leave on vacation.
>
> I still think DT is the right way to go here, unless I hear some other
> convincing answer..
>

The point is that the way the DT is right now it becomes very hard to
extend it in a sane manner - It would be bitmaps/lists here,
bitmaps/lists there...

Breaking the DT would make all of it go away.

If I think of it (reading your other comments), then here how the
"new" DT could look like:
dma: dma at 7e007f00 {
	/* new compatible name to map to new driver */
	compatible = "brcm,bcm2835-dma-v2";

	/* the status/enable registers */
	reg = <0x7e007f00 0x100>;

	/* the catch all interrupt */
	interrupts = <1 28>;

	dma0: dma-channel at 0x7e007000 {
		reg = <0x7e007000 0x100>;
		interrupts = <1 16>;
	};
	...
	dma7: dma-channel at 0x7e007700 {
		reg = <0x7e007700 0x100>;
		interrupts = <1 23>;
		dma-channel-type = <BCM2835_DMA_LITE>;
		dma-max-length = <65532>; /* 64K - 4 */
	};
	...
	dma11: dma-channel at 0x7e007b00 {
		reg = <0x7e007b00 0x100>;
		interrupts = <1 27>;
		shared-interrupt;
		dma-channel-type = <BCM2835_DMA_LITE>;
	};
	...
	dma14: dma-channel at 0x7e007e00 {
		reg = <0x7e007e00 0x100>;
		interrupts = <1 27>;
		shared-interrupt;
		dma-channel-type = <BCM2835_DMA_LITE>;
	};
	dma15: dma-channel at 0x7ee05000 {
		reg = <0x7ee05000 0x100>;
	};
};

Adding additional "features" would make it easy like:
* dma-channel priority on AXI bus
* setting warn/alert levels for DREQs
* eventually mapping of drivers to the explicit dma channel
   e.g: SPI has a limit of 65534 bytes per dma transfer in HW,
   so the use of a DMA-LITE engine would be sufficient - no need
   to waste a "normal" DMA-engine with 2D support,...
   So the spi dt node  could then look like this:
     dmas = <&dma11 BCM2835_DREQ_SPI_TX>, <&dma12 BCM2835_DREQ_SPI_RX>;
     dma-names = "tx", "rx";

Is this the approach I should try to take?

Or do you want me to continue on the "patchwork" route:
dma: dma at 7e007000 {
	interrupt-names = "dma0", ..., "dma10", "shared", "catch-all";

	bcrm,dma-lite-channel-mask = <0x7f80>;
	bcrm,dma-max-channels = 14;

	bcrm,catch-all-interrupt-name = "catch-all";
	bcrm,shared-interrupt-name = "shared";
	bcrm,shared-interrupt-channel-mapping = <0x7800>;
}

For all of the above we would need to define defaults in the driver
to make it work in a backwards compatible way.

That would not support the registers for each dma channel and not lend
itself towards extending only via the DT - say support DMA channel 15.

I have another 5 days before I leave on vacation - there is only so
much I can do...

Thanks,
	Martin
