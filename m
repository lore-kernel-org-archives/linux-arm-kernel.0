From: robherring2@gmail.com (Rob Herring)
Date: Thu, 30 Jun 2011 10:03:26 -0500
Subject: [PATCH v2] ARM: CSR: Adding CSR SiRFprimaII board support
In-Reply-To: <201106301236.25822.arnd@arndb.de>
References: <1309231954-23260-1-git-send-email-bs14@csr.com>
	<201106292329.44447.arnd@arndb.de>
	<BANLkTinfKCMcutMDQ+mpdD4EUy9mCpZs+w@mail.gmail.com>
	<201106301236.25822.arnd@arndb.de>
Message-ID: <4E0C903E.7040508@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/30/2011 05:36 AM, Arnd Bergmann wrote:
> On Thursday 30 June 2011, Barry Song wrote:
> 
>>> Is this really just one bus with a huge address space, or rather some
>>> nested buses? I'd prefer to have the device tree representation as
>>> close as possible to the actual layout.
>>
>> there are two AXI buses in prima2. AXI-1 connect to memory, AXI-2 is
>> transferred to CSR self-defined IOBUS by CPUIF, then 1 intterupt
>> controller and 9 IO bridges are connected to the IOBUS .
>> The 9 IO bridges are SYSIOBG, PERIIOBG,CPURTCIOBG, UUSIOBG, GRAPHIOBG,
>> MEDIAIOBG, DSPIOBG, DISPIOBG, MEMIOBG. Every iobrg connect to a group
>> of controllers.
>> For example, DISPIOBG connect to VPP and LCD, SYSIOBG connect to CLKC,
>> RSTC, RSC and CPHIFBG, DSPIOBG connect to DSPIF, GPS and DSP.
>> PERIIOBG connect to TIMER, NAND, AUDIO, UART0, UART1, UART2, USP0,
>> USP1, USP2, SPI0, I2C0, I2C1, GPIO, *SYS2PCI* and so on. Then
>> *SYS2PCI* connect to SD.
>>
>> The indendation descible the device hierarchy
>> AXI-1
>>          Memory
>> AXI-2
>>          interrupt controller
>>          IOBG...
>>                   xxxx
>>          IOBG...
>>                   xxxx
>>          IOBG...
>>                   xxxx
>>          IOBG...
>>                   xxxx
>>          IOBG...
>>                   xxxx
>>          IOBG...
>>                   SYS2PCI
>>                             SD
>>
>> i have get the IC guy Weizeng involved, maybe he can explain better than me :-)
> 
> I think it would be good to represent the IOBG devices in the device tree then.
> You don't need to represent AXI-1 because memory is special anyway, and I would
> not bother to list SYS2PCI if the intention of that block was to hide the fact
> that it's PCI behind it. Properly instantiating it as a PCI bridge would be
> a lot of work that is probably not worth it.
> 
> My usual plea to hardware developers: Please make the registers
> autodiscoverable from software! On an AMBA bus, please use the PrimeCell
> register layout. If you always have an IOBG device behind, they should
> all have the same identifier for that kind of bus bridge.
> 
> For the IOBG, it would be ideal to have a similar way of finding and
> configuring the connected hardware, including:
> 
> * unique identifier for each distinct IP block
> * revision of that block
> * MMIO ranges and sizes, relative to the bus
> * interrupt numbers, relative to a local interrupt controller
> * location identifier (like PCI bus/device/fn number) that can be
>   referred to by other devices
> * clock management for that device
> * power management for that device
> 
> If your IODB infrastructure already has this, you should create a new
> bus-type for this in Linux, which will let you detect all devices
> in a consistent manner without having to list them in the device tree.
> 
>>> I think the namespace for the compatible values is supposed to start with
>>> the stock ticker name of the company making the device as a unique
>>> identifier. This means you'd have to use
>>> "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" as the value, instead
>>> of starting with the product name. I don't know exactly how strictly
>>> we apply that rule, but I've taken the devicetree-discuss at lists.ozlabs.org
>>> mailing list on Cc, maybe someone can clarify.
>>
>> in fact, SiRF is a company name. it was merged into CSR 4 years ago.
>> Due to history reason, now the SoC names are still headed by sirf.
>> the logo in SiRFprimaII chip is CSR.
>> So the "SiRF" of SiRFprimaII should mean two things: old company name,
>>  heritable CPU production-line. Anyway, "csr, sirf-intc" seems to make
>> more senses than "sirf, intc".
>>
>> could we change "csrxf,sirf-intc", "csrxf,sirf-prima2-intc" to
>> "csr,sirf-intc", "csr,sirf-prima2-intc"?
> 
> Not sure how strict we interpret the rules about stock ticker symbols.
> 'CSR' on wallstreet is 'China Security & Surveillance Tech. Inc'. If they
> ever decide to produce embedded Linux machines, we'd get a conflict, unless
> they also use "csst" (their .com domain name) as a prefix.
> 
>>> better put these in a list with one file per line, like
>>>
>>> obj-y   += timer.o
>>> obj-y   += irq.o
>>>
>>> That makes the list more consistent when you add conditional files.
>>
>> Then it could be:
>> obj-y += timer.o
>> obj-y += irq.o
>> obj-y += clock.o
>> obj-y += common.o
>> obj-$(CONFIG_CACHE_L2X0) := l2x0.o
> 
> 
> Right. Note that you have a := in there, which needs to be +=.
> 
> 
>>> It probably makes sense to pick a new name for the combined file, too, but I
>>> can't think of a good one. Maybe one of platform.c, prima2.c or core.c.
>>
>> i am not sure the original purpose of board_dt.c. and i am guessing
>> whether Grant created that single board file to contain multiple
>> boards. For example:
>>
>> MACHINE_START(PRIMA2_XXX, "prima2xxx")
>>        .boot_params    = SIRFSOC_SDRAM_PA + 0x100,
>>        .init_early     = sirfsoc_init_clk,
>>        .map_io         = sirfsoc_map_io,
>>        .init_irq       = sirfsoc_of_init_irq,
>>        .timer          = &sirfsoc_timer,
>>        .init_machine   = sirfsoc_mach_init,
>>        .dt_compat      = prima2xxx_dt_match,
>> MACHINE_END
>>
>> MACHINE_START(PRIMA2_YYY, "prima2yyy")
>>        .boot_params    = SIRFSOC_SDRAM_PA + 0x100,
>>        .init_early     = sirfsoc_init_clk,
>>        .map_io         = sirfsoc_map_io,
>>        .init_irq       = sirfsoc_of_init_irq,
>>        .timer          = &sirfsoc_timer,
>>        .init_machine   = sirfsoc_mach_init,
>>        .dt_compat      = prima2yyy_dt_match,
>> MACHINE_END
> 
> No, this wouldn't make any sense when the only difference is the dt_compat
> field: At that point you would just list all the possible boards in the
> global dt_match table.
> 
>> after creating a new file named mach-prima2/l2x0.c,  it seems we only
>> need to change Makefile to:
>> obj-$(CONFIG_CACHE_L2X0) := l2x0.o
>> the head file is not needed.
>>
>> Currently, rob's OF-based L2 cache is not merged yet. then i only
>> write the following:
>>
>> static int __init sirfsoc_of_l2x_init(void)
>> {
>>         struct device_node *np;
>>         void __iomem *sirfsoc_l2x_base;
>>
>>         np = of_find_matching_node(NULL, l2x_ids);
>>         if (!np)
>>                 panic("unable to find compatible intc node in dtb\n");
>>
>>         sirfsoc_l2x_base = of_iomap(np, 0);
>>         if (!sirfsoc_l2x_base)
>>                 panic("unable to map l2x cpu registers\n");
>>
>>         of_node_put(np);
>>
>>         if (!(readl_relaxed(sirfsoc_l2x_base + L2X0_CTRL) & 1)) {
>>                 /*
>>                  * set the physical memory windows L2 cache will cover
>>                  */
>>                 writel_relaxed(PLAT_PHYS_OFFSET + 1024 * 1024 * 1024,
>>                         sirfsoc_l2x_base + L2X0_ADDR_FILTERING_END);
>>                 writel_relaxed(PLAT_PHYS_OFFSET | 0x1,
>>                         sirfsoc_l2x_base + L2X0_ADDR_FILTERING_START);
>>
>>                 writel_relaxed(0,
>>                         sirfsoc_l2x_base + L2X0_TAG_LATENCY_CTRL);
>>                 writel_relaxed(0,
>>                         sirfsoc_l2x_base + L2X0_DATA_LATENCY_CTRL);
>>         }
>>         l2x0_init((void __iomem *)sirfsoc_l2x_base, 0x00040000,
>>                 0x00000000);
>>
>>         return 0;
>> }
>> early_initcall(sirfsoc_of_l2x_init);
>>
>> After Rob's patch is merged, i think sirfsoc_of_l2x_init can be much simpler.
>>
> Yes. Rob/Olof, what's the status of that patch?

I need to send out a new version that drops aux value/mask from
device-tree. However, as is it won't help much with the above code
because of the extra register setup. Perhaps I can add the following
bindings:

tag-ram-latency = <>;
data-ram-latency = <>;
filter-ranges = <start end>;

Any comments on these? Is there anything already defined in this area
for latency/waitstates? I'll have to go back and check, but I think
these are all pl310 specific.

Rob
