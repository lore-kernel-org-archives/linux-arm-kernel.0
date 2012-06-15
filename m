From: wmb@firmworks.com (Mitch Bradley)
Date: Fri, 15 Jun 2012 06:11:59 -1000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <201206151127.24386.arnd@arndb.de>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201206150900.50866.arnd@arndb.de>
 <Pine.LNX.4.64.1206151107480.11729@axis700.grange>
 <201206151127.24386.arnd@arndb.de>
Message-ID: <4FDB5ECF.3000701@firmworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/15/2012 1:27 AM, Arnd Bergmann wrote:
> On Friday 15 June 2012, Guennadi Liakhovetski wrote:
>>> In the common case, you could have one device connected to the third
>>> slave ID of the first controller but the fifth slave ID of the
>>> second controller. In this case, you really have to specify each
>>> controller with its slave ID separately, even if that means a lot
>>> of duplicate data for shmobile.
>>
>> So, you don't think it's worth making a short-cut possible to specify a
>> DMAC type instead of each instance phandle? It really would mean __a lot__
>> of duplication - with 3 generic controllers on (some) current chips and
>> possibly more on those, that I'm not aware about.
>
> It's certainly possible to make that short-cut, but I'm not convinced
> if it's worth it. One thing you can do is create a meta-device for
> all of the identical DMA controllers, and refer to that one from the
> devices, but make it a separate device node from the actual controllers,
> of which you can have more than one. This makes the binding for your
> dma controller more complex but reduces the amount of data required
> in the other device nodes.
>
> In case of sh7372, this could look something like
>
> 	dma: dmac-mux {
> 		compatible = "renesas,sh-dma-mux";
> 		#dma-cells =<4>; /* slave-id, addr, chcr, mid-rid */
> 		#address-cells =<1>;
> 		#size-cells =<1>;
> 		ranges;

In light of the reg entries below, perhaps #size-cells=0 ?
>
>
> 		dmae at 0xfe008020{
> 			compatible = "renesas,sh-dma";
> 			reg =<0xfe008020 0xfe00828f
> 				0xfe009000 0xfe00900b>
> 			interrupts =<0x20c0 0x2000 0x2020 0x2040 0x2060 0x2080 0x20a0>;
> 		};
>
> 		dmae at 0xfe018020{
> 			compatible = "renesas,sh-dma";
> 			reg =<0xfe018020 0xfe01828f
> 				0xfe019000 0xfe01900b>
> 			interrupts =<0x21c0 0x2100 0x2120 0x2140 0x2160 0x2180 0x21a0>;
> 		};
>
> 		dmae at 0xfe028020{
> 			compatible = "renesas,sh-dma";
> 			reg =<0xfe028020 0xfe02828f
> 				0xfe029000 0xfe02900b>
> 			interrupts =<0x22c0 0x2200 0x2220 0x2240 0x2260 0x2280 0x22a0>;
> 		};
> 	};
>
> This way, a slave would refer to the dmac-mux node and while
> the device driver binds to the child nodes.
>
>>> I'm not sure I understand what the "configuration register values"
>>> above are.
>>
>> As I explained in an earlier mail, those include transfer size and other
>> parameters, but cannot be completely calculated in device drivers, because
>> they also vary between SoCs.
>
> Yes, but they can be part of the device tree source, because when writing
> that, you know both the requirements of the device and the capabilities
> of the controller.
>
> 	Arnd
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>
