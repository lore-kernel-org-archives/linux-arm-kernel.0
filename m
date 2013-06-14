From: xiechao.mail@gmail.com (Chao Xie)
Date: Fri, 14 Jun 2013 17:15:33 +0800
Subject: [PATCH v2] ARM: mmp: bring up pxa988 with device tree support
In-Reply-To: <201306101035.20924.arnd@arndb.de>
References: <1369969115-4279-1-git-send-email-zhangwm@marvell.com>
 <201306061826.19551.arnd@arndb.de>
 <CADApbeixEKi984QED07LxA8vzfHmLGCGT8KxEbB5cqXzpW823Q@mail.gmail.com>
 <201306101035.20924.arnd@arndb.de>
Message-ID: <CADApbeh9EJDetkvx9Sq=y58mkhU_X1oo-e_hgZqeBV9nriqTiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

>
>> >> > __initdata = {
>> >> > >           .virtual        = (unsigned long)AXI_VIRT_BASE,
>> >> > >           .length         = AXI_PHYS_SIZE,
>> >> > >           .type           = MT_DEVICE,
>> >> > > - },
>> >> > > + }, {
>> >> > > +         .pfn            = __phys_to_pfn(MMP_CORE_PERIPH_PHYS_BASE),
>> >> > > +         .virtual        = (unsigned long)MMP_CORE_PERIPH_VIRT_BASE,
>> >> > > +         .length         = MMP_CORE_PERIPH_PHYS_SIZE,
>> >> > > +         .type           = MT_DEVICE,
>> >> > > + }
>> >> > >  };
>> >> > >
>> >> > >  void __init mmp_map_io(void)
>> >> >
>> >> > What is this needed for?
>> >>
>> >> This function is used to static map the device registers.
>> >
>> > I understand what map_io does. Why do you need a static mapping?
>> >
>>
>> The AXI and APB bus register mapping, It does not need to be static mapping.
>> Because we define the registers for each peripharals in device tree.
>> The device driver can map it.
>
> Ok. Please try if it all keeps working without these mappings (aside
> from the SCU). You can leave them in as a performance optimization
> since the registers will get mapped as large pages this way, but it
> should really work without them.
>
> I would also suggest defining the virtual base addresses locally in this
> file rather than globally, just to ensure that no driver starts relying
> on the static mapping.
>
>> There is a exception. The address space used by core for example CPU
>> SCU registers for CA9.
>> We have to read/write the registers even device tree has not been
>> build up in kernel, for example ->smp_prepare_cpus.
>> At this point, how can we get the base address for SCU?
>
> I guess that is a problem we have on other platforms as well, we should
> find a generic solution for that. It would be nice to reserve a page
> in "fixmap" and have common code map the SCU page into that.
>

So you mean that reserve a page in arch/arm/asm/include/fixmap.h?
This reserve will depend on the cpu type beacuse only A9 will have SCU part.
I do not know that in fixmap, the #ifdef is acceptable or not.
For the common code to map the SCU page, where do you suggest to put it?

>> >> > > +/* PXA988 */
>> >> > > +static const struct of_dev_auxdata pxa988_auxdata_lookup[] __initconst

>
>         Arnd
