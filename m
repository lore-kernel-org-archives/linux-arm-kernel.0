From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Mar 2012 00:17:18 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <alpine.LFD.2.02.1203222348210.24151@xanadu.home>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203222348210.24151@xanadu.home>
Message-ID: <CAKON4OxjX94js19KqMx3W_hvqj8VwacAwFLMQF_BahME4XH-3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 12:00 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 22 Mar 2012, jonsmirl at gmail.com wrote:
>
>> When iotable is used to initially map memory you can specify the
>> mapping address. In this case IO_SDMMC_PHYS is 0x18000000 and it gets
>> mapped to ?0xf1800000
>>
>> NXP has supplied this handly macro
>> #define io_p2v(x) (0xf0000000 | (((x) & 0xff000000) >> 4) | ((x) & 0x000fffff))
>>
>> iotable_init(lpc313x_io_desc, ARRAY_SIZE(lpc313x_io_desc));
>>
>> ? ? ? {
>> ? ? ? ? ? ? ? .virtual ? ? ? ?= io_p2v(IO_SDMMC_PHYS),
>> ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(IO_SDMMC_PHYS),
>> ? ? ? ? ? ? ? .length ? ? ? ? = IO_SDMMC_SIZE,
>> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
>> ? ? ? },
>>
>> The supplied kernel is full of code that uses this type of addressing.
>> It has macros for register definition that all depend on the registers
>> being mapped to a well know location - io_p2v(x).
>>
>> I'd like to move the map out of the core code and into the SDMMC
>> device driver and then only do it if the driver loads.
>
> Why would you do that? ?Those static mappings are meant to be global and
> remain there. ?The handy macro is in fact not handy at all as it forces
> virtual addresses on you.

I'm ok with global static mappings. What I'd like to do is build the
static iotable from the device tree instead of repeating every device
in the map_desc array. I suppose I could dynamically allocate it, fill
it in from the device tree and call iotable_init().

What is the right way to make the initial static mappings?

>
> It is OK to keep the static mappings as you can use 1MB regions and the
> mapping code will use first level mappings which are better with TLB
> usage.

CPU is arm926ejs. Peripherals are small blocks spread out on 16MB
boundaries. There are eleven groups.

>
> But drivers should really be using:

This is the style I'm used too. I'll assess how much work it is to
convert everything.

>
> ? ? ? ?iobase = ioremap(IO_SDMMC_PHYS);
>
> and the various registers should be defined as offsets from that base.
> Then you would use:
>
> ? ? ? ?val = readl(iobase + SDMMC_FOO_REG);
>
> where you could have:
>
> #define SDMMC_FOO_REG ? 0x10
>
> With a recent kernel, the ioremap code will reuse any static mappings
> that matches the physical address you give it, or create a new mapping
> otherwise. ?But in either cases the actual virtual address used
> shouldn't matter anymore.
>
>
> Nicolas



-- 
Jon Smirl
jonsmirl at gmail.com
