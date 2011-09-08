From: bill4carson@gmail.com (bill4carson)
Date: Thu, 08 Sep 2011 18:32:21 +0800
Subject: KVM ARM interrupt virtualization
In-Reply-To: <20110908085449.GA29243@e102109-lin.cambridge.arm.com>
References: <CAOMgcGJoF74=q4uzuC+FGQYP3QiLEZvC+duJDAt0m8et8zmCqA@mail.gmail.com>
	<CAHkRjk6Vm2yNLm8Gzk3+4mYAfiXVjufv2xc0Kc-6ac-oS4zytw@mail.gmail.com>
	<CAOMgcGJBoeKJ8FjDW9eESfT+FiXmFF9PfShJ=a2adbESLD2YkA@mail.gmail.com>
	<20110908085449.GA29243@e102109-lin.cambridge.arm.com>
Message-ID: <4E6899B5.70608@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2011?09?08? 16:54, Catalin Marinas wrote:
> On Thu, Sep 08, 2011 at 02:44:45AM +0100, carson bill wrote:
>> 2011/9/7 Catalin Marinas<catalin.marinas@arm.com>:
>>> On 2 September 2011 04:01, carson bill<bill4carson@gmail.com>  wrote:
>>>> I am trying to put interrupt virtualization support into KVM ARM
>>>> implementation by Christoffer.
> ...
>>>> Problem:
>>>>     I did the experiment, and found the biggest obstoble on the way
>>>>     is creating the mapping.
>>>>
>>>>     arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
>>>>     #define CT_CA9X4_MPIC       (0x1e000000)
>>>>     #define A9_MPCORE_SCU       (CT_CA9X4_MPIC + 0x0000)
>>>>     #define A9_MPCORE_GIC_CPU   (CT_CA9X4_MPIC + 0x0100)
>>>>     #define A9_MPCORE_GIT       (CT_CA9X4_MPIC + 0x0200)
>>>>     #define A9_MPCORE_TWD       (CT_CA9X4_MPIC + 0x0600)
>>>>     #define A9_MPCORE_GIC_DIST  (CT_CA9X4_MPIC + 0x1000)
>>>>
>>>>     If I create an identical mapping at A9_MPCORE_GIC_CPU, all the iomem
>>>>     from CT_CA9X4_MPIC ~ CT_CA9X4_MPIC + 0x1000 could be access for
>>>>     Guest OS, which means access to SCU/GIT/TWD will not been trapped
>>>>     any more.
>>> Shouldn't you use the CT_CA15X4_MPIC base address? As for TWD, with
>>> A15 we use the generic timers (which also have support for
>>> virtualisation). The SCU doesn't need to be touched on A15, AFAIK.
> ...
>> Thanks Catalin for your reply :)
>>
>> Do you mean Guest OS have to be built with A15 too ?
> Only if you need to benefit from the virtual GIC interface. The GIC CPU
> interface on A9 starts at offset 0x100, which isn't multiple of
> PAGE_SIZE, so there is no way to map the GICV page (PAGE_SIZE aligned)
> there. As you noted, there are other private peripherals in the same
> page like TWD. This was cleaned up with A15 making the GIC interfaces
> page-aligned.
>
>> Currently Versatile Express Cortex-A9x4 tile is used as Guest OS.
>> That's why I have to map A9_MPCORE_GIC_CPU from Guest OS into
>> A15_MPCORE_GIC_CPU at host side.
> Can the guest OS not run with the VE/A15 memory map? You don't even need
> to have LPAE enabled, just the A15 core tile support for VE
> (unfortunately kernel.org is down now and cannot point you to the
> relevant patches).
>

Hi, Catalin

Thanks for your kindness.
I will wait for that.

There is much more involved if I want to use A15 as Guest OS,
cause Qemu haven't got any A15 support yet.
I'm trying to work on this first, apparently I need more detailed 
information
about FastModelPortfolio_6.1/examples/RTSM_VE/Build_Cortex-A15x1.
I didn't find any relevant A15 board doc/spec at arm site, especially 
memory map.
Could you please point it out for me?


tons of thanks


bill
