From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 14 Feb 2014 23:03:22 +0300
Subject: [PATCH] ARM: shmobile: lager: Add internal USB PCI support
In-Reply-To: <CANqRtoSc7W9UXBaACnckWPhUGE5VPDN8JV9FFHZbW9ZwGhTt4Q@mail.gmail.com>
References: <20140214032948.3287.33351.sendpatchset@w520>	<52FE2026.8040801@cogentembedded.com>
 <CANqRtoSc7W9UXBaACnckWPhUGE5VPDN8JV9FFHZbW9ZwGhTt4Q@mail.gmail.com>
Message-ID: <52FE768A.4070404@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02/14/2014 06:30 PM, Magnus Damm wrote:

>>> From: Valentine Barshak <valentine.barshak@cogentembedded.com>

>>> This adds internal PCI USB host devices to R-Car H2 Lager board.

>>> Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
>>> [damm at opensource.se: Rebased and reworked to only include USB1 and USB2]
>>> Signed-off-by: Magnus Damm <damm@opensource.se>
>>> ---

>>>    Written against renesas-devel-v3.14-rc2-20140213

>>>    arch/arm/mach-shmobile/board-lager.c |   50
>>> ++++++++++++++++++++++++++++++++++
>>>    1 file changed, 50 insertions(+)

>>> --- 0001/arch/arm/mach-shmobile/board-lager.c
>>> +++ work/arch/arm/mach-shmobile/board-lager.c   2014-02-14
>>> 12:16:26.000000000 +0900
>>> @@ -638,6 +638,48 @@ static struct resource sdhi2_resources[]
>>>          DEFINE_RES_IRQ(gic_spi(167)),
>>>    };
>>>
>>> +/* Internal PCI1 */
>>> +static const struct resource pci1_resources[] __initconst = {
>>> +       DEFINE_RES_MEM(0xee0b0000, 0x10000),    /* CFG */
>>> +       DEFINE_RES_MEM(0xee0a0000, 0x10000),    /* MEM */
>>> +       DEFINE_RES_IRQ(gic_spi(112)),
>>> +};
>>> +
>>> +static const struct platform_device_info pci1_info __initconst = {
>>> +       .parent         = &platform_bus,
>>> +       .name           = "pci-rcar-gen2",
>>> +       .id             = 1,
>>> +       .res            = pci1_resources,
>>> +       .num_res        = ARRAY_SIZE(pci1_resources),
>>> +       .dma_mask       = DMA_BIT_MASK(32),
>>> +};
>>> +
>>> +static void __init lager_add_usb1_device(void)

>>     Actually, this adds PCI device, not USB, so the name is strange.
>> Also, I doubt that such functions are really necessary.

> Well there are only USB devices hanging off the PCI devices on the
> actual silicon, so this naming discussion seems like splitting hairs?

    I'm actually against introducing these functions in general. They're only 
wasting the LOCs.

>>> +{
>>> +       platform_device_register_full(&pci1_info);
>>> +}
>>> +
>>> +/* Internal PCI2 */
>>> +static const struct resource pci2_resources[] __initconst = {
>>> +       DEFINE_RES_MEM(0xee0d0000, 0x10000),    /* CFG */
>>> +       DEFINE_RES_MEM(0xee0c0000, 0x10000),    /* MEM */
>>> +       DEFINE_RES_IRQ(gic_spi(113)),
>>> +};
>>> +
>>> +static const struct platform_device_info pci2_info __initconst = {
>>> +       .parent         = &platform_bus,
>>> +       .name           = "pci-rcar-gen2",
>>> +       .id             = 2,
>>> +       .res            = pci2_resources,
>>> +       .num_res        = ARRAY_SIZE(pci2_resources),
>>> +       .dma_mask       = DMA_BIT_MASK(32),
>>> +};
>>> +

>>     I suspect the PCI resources and info could be wrapped by macros and then
>> instantiated by using only 2 lines.

> I suspect anything can be done. =) As you may know, I'm not the

    You're too optimistic. :-)

> original author of this patch. At this point in time I'm mainly
> focusing on getting device support merged, so please feel free to send
> either incremental patches or pick up this one and fix it yourself.
> I'm beyond caring.

    OK, I'll see what I can do when I have a time.

> Thanks,

> / magnus

WBR, Sergei
