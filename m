From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Thu, 18 Feb 2016 22:31:31 +0300
Subject: [PATCH v2 5/5] ARM: dts: r8a7794: add sound support
In-Reply-To: <20160217234857.GA6886@verge.net.au>
References: <2543047.yYrDdYb9v5@wasted.cogentembedded.com>
 <874mdhtn7d.wl%kuninori.morimoto.gx@renesas.com>
 <20160210171455.GB17671@verge.net.au> <56BE0CB1.4070408@cogentembedded.com>
 <20160212184343.GA31655@verge.net.au> <56BE2DC6.4080802@cogentembedded.com>
 <20160212193347.GB23472@verge.net.au> <56BE3912.9000601@cogentembedded.com>
 <20160217053848.GC11534@verge.net.au> <56C4C506.8040803@cogentembedded.com>
 <20160217234857.GA6886@verge.net.au>
Message-ID: <56C61C13.8000301@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/18/2016 02:48 AM, Simon Horman wrote:

>>>>>>>>>>> Define the generic R8A7794 part of  the sound device node.
>>>>>>>>>>> This sound device  is a complex one and comprises the Audio Clock Generator
>>>>>>>>>>> (ADG), Sampling Rate Converter Unit (SCU), Serial Sound Interface [Unit]
>>>>>>>>>>> (SSI[U]), and Audio DMAC-Peripheral-Peripheral.
>>>>>>>>>>> It is up  to the board file to enable the device.
>>>>>>>>>>>
>>>>>>>>>>> This patch is based on the R8A7791 sound work by Kuninori Morimoto.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>>>>>>>>> (snip)
>>>>>>>>>>> +		rcar_sound,src {
>>>>>>>>>>> +			src1: src at 1 {
>>>>>>>>>>> +				interrupts = <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +				dmas = <&audma0 0x87>, <&audma0 0x9c>;
>>>>>>>>>>> +				dma-names = "rx", "tx";
>>>>>>>>>>> +			};
>>>>>>>>>>> +			src2: src at 2 {
>>>>>>>>>>> +				interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +				dmas = <&audma0 0x89>, <&audma0 0x9e>;
>>>>>>>>>>> +				dma-names = "rx", "tx";
>>>>>>>>>>> +			};
>>>>>>>>>>> +			src3: src at 3 {
>>>>>>>>>>> +				interrupts = <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +				dmas = <&audma0 0x8b>, <&audma0 0xa0>;
>>>>>>>>>>> +				dma-names = "rx", "tx";
>>>>>>>>>>> +			};
>>>>>>>>>>> +			src4: src at 4 {
>>>>>>>>>>> +				interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +				dmas = <&audma0 0x8d>, <&audma0 0xb0>;
>>>>>>>>>>> +				dma-names = "rx", "tx";
>>>>>>>>>>> +			};
>>>>>>>>>>> +			src5: src at 5 {
>>>>>>>>>>> +				interrupts = <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +				dmas = <&audma0 0x8f>, <&audma0 0xb2>;
>>>>>>>>>>> +				dma-names = "rx", "tx";
>>>>>>>>>>> +			};
>>>>>>>>>>> +			src6: src at 6 {
>>>>>>>>>>> +				interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
>>>>>>>>>>> +				dmas = <&audma0 0x91>, <&audma0 0xb4>;
>>>>>>>>>>> +				dma-names = "rx", "tx";
>>>>>>>>>>> +			};
>>>>>>>>>>> +		};
>>>>>>>>>>
>>>>>>>>>> I think this can't work correctly, because driver is assuming
>>>>>>>>>> DT has all channles (from 0). (see linux/sound/soc/sh/rcar/src.c :: rsnd_src_probe)
>>>>>>>>>> Can you adds dummy src0 with some comments ? or fix src.c driver ?
>>>>>>>>>
>>>>>>>>> I would prefer the driver to be fixed (I had a similar patchset locally
>>>>>>>>> and I found it doesn't work).
>>>>>>>>
>>>>>>>>     You mean you had R8A7794 sound patch set too?
>>>>>>>
>>>>>>> Yes, I was working on it recently.
>>>>>>> I suppose we should coordinate these things in future to avoid
>>>>>>> duplicated effort.
>>>>>>
>>>>>>     Yes, seems a good idea now. :-)
>>>>>>
>>>>>>>>> The reason is that DT should describe
>>>>>>>>> the hardware rather than the current state of the software.
>>>>>>>>
>>>>>>>>     Yes, of course. Just tell me do I have to fix the driver *before* this
>>>>>>>> patch set is accepted?
>>>>>>
>>>>>>> I did not entirely get to the bottom of the problem, but I think that at
>>>>>>> the very least something needs to be done about the for_each_rsnd_src()
>>>>>>> loop in rsnd_src_probe.
>>>>>>
>>>>>>     It's not that it replies to my question. :-)
>>>>>>     So you're looking at this issue yourself?
>>>>>
>>>>> I have not got very far, as you can see, but I was planning to look into it.
>>>>> I don't mind if you want to do so.
>>>>
>>>>     After consultation with the management, I'm going to look into this issue
>>>> myself. :-)
>>>
>>> Excellent.
>>
>>     But not immediately. I have some other things to look at before that (DU
>> and AVB), they'll going to take some (significant) time... :-(
>>
>>> FWIW, I can test anything you come up with for the r8a7794 an alt board
>>
>>     I have remote access to Alt now, in fact using it currently for the AVB work.
>>
>>> or post patches for it once you have r8a7794/silk sorted out.
>>
>>     I already have audio on these working. Or you're going to wait until I
>> fix the SRC issue?
>
> I'm happy to merge a subset of your r8a7794/silk patches,
> that don't touch the SRC issue if you think that is appropriate.

    I think you can merge everything R8A7794 specific. The SILK patch doesn't 
make use of SRCs yet but depends on the PFC patches, so makes sense to hold it 
up...

>  From there I could get similar functionality running on the Alt - I don't
> expect that to be a difficult task.

    Sure -- if you have direct access to the board.

> And then when you come back to the SRC
> issue we can enhance support for r8a7794/silk,alt.

    Yes.

MBR, Sergei
