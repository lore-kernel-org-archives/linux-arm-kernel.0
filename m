From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Fri, 23 Mar 2012 09:25:30 -0400
Subject: ioremap to a specific virtual address
In-Reply-To: <alpine.LFD.2.02.1203230023060.24151@xanadu.home>
References: <CAKON4Ox5YXvbGwbsYRetOPxV+HVDwmEd-mbqj2fyDfnCcBjaRA@mail.gmail.com>
 <alpine.LFD.2.02.1203222348210.24151@xanadu.home>
 <CAKON4OxjX94js19KqMx3W_hvqj8VwacAwFLMQF_BahME4XH-3A@mail.gmail.com>
 <alpine.LFD.2.02.1203230023060.24151@xanadu.home>
Message-ID: <CAKON4Ox6sp5YMryr2jzOAqYNmJG9RyahLTusrHZ_jcNQ40DAfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 23, 2012 at 12:28 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Fri, 23 Mar 2012, jonsmirl at gmail.com wrote:
>
>> On Fri, Mar 23, 2012 at 12:00 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Thu, 22 Mar 2012, jonsmirl at gmail.com wrote:
>> >
>> >> When iotable is used to initially map memory you can specify the
>> >> mapping address. In this case IO_SDMMC_PHYS is 0x18000000 and it gets
>> >> mapped to ?0xf1800000
>> >>
>> >> NXP has supplied this handly macro
>> >> #define io_p2v(x) (0xf0000000 | (((x) & 0xff000000) >> 4) | ((x) & 0x000fffff))
>> >>
>> >> iotable_init(lpc313x_io_desc, ARRAY_SIZE(lpc313x_io_desc));
>> >>
>> >> ? ? ? {
>> >> ? ? ? ? ? ? ? .virtual ? ? ? ?= io_p2v(IO_SDMMC_PHYS),
>> >> ? ? ? ? ? ? ? .pfn ? ? ? ? ? ?= __phys_to_pfn(IO_SDMMC_PHYS),
>> >> ? ? ? ? ? ? ? .length ? ? ? ? = IO_SDMMC_SIZE,
>> >> ? ? ? ? ? ? ? .type ? ? ? ? ? = MT_DEVICE
>> >> ? ? ? },
>> >>
>> >> The supplied kernel is full of code that uses this type of addressing.
>> >> It has macros for register definition that all depend on the registers
>> >> being mapped to a well know location - io_p2v(x).
>> >>
>> >> I'd like to move the map out of the core code and into the SDMMC
>> >> device driver and then only do it if the driver loads.
>> >
>> > Why would you do that? ?Those static mappings are meant to be global and
>> > remain there. ?The handy macro is in fact not handy at all as it forces
>> > virtual addresses on you.
>>
>> I'm ok with global static mappings. What I'd like to do is build the
>> static iotable from the device tree instead of repeating every device
>> in the map_desc array. I suppose I could dynamically allocate it, fill
>> it in from the device tree and call iotable_init().
>
> Well, if you have a device tree with that stuff, then you may as well
> just forget about the static mappings.
>
>> What is the right way to make the initial static mappings?
>
> Typically by declaring it in the code. ?Otherwise there is some
> infrastructure already in place for drivers to map their hardware
> dynamically from DT information.

So there are two ways to build these mappings..

1) At init time. I can extract the 11 regions, dynamically build a
'struct map_desc' and call iotable_init. Doing it at init time via the
device tree will work, but it is complicated by the existence of nodes
in the device tree that have their status set to disabled. The init
time code will need to sort this out which duplicates what the driver
load system does.

2) Driver load time. This is why I asked the initial question about
how to do ioremap to the specific virtual address. I didn't want to
rewrite all of the existing code to use the more normal style of
mapping. So is there some way to create the static mapping at a
specific address when the driver first loads?

Is there any real advantage to doing the mapping at init time other
than being able to control which virtual address you get?

I can start looking at how much code needs to be converted to the base
+ offset model. One advantage to converting is that I'll get an
immediate GPF each time I mess up. Converting the code will let it
work with the random address from ioremap.

This is a NXP BSP for the lpc31xx from about three years ago. I've
forward ported it up to v3.3 and I want to get device tree going in
it. We have products based on this chip and I'd like to be able to
build a single kernel that works in all of the various configurations.






-- 
Jon Smirl
jonsmirl at gmail.com
