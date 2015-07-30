From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 30 Jul 2015 21:27:03 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu-G9Vpmt_c84OsG0JNRKopJ44uneJaAEpY3AMq6oS-Qdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30 July 2015 at 12:13, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Wed, Jul 29, 2015 at 08:49:57PM +0000, Stuart Yoder wrote:
>> > From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
[...]
>> > To be honest, I think this is poorly designed, and I am not sure we
>> > should cater for such configurations in the defconfig.
>>
>> Agree, if this is a one-off weird platform then we shouldn't.
>>
>> But, the 'Principles of ARM Memory Maps' doc proposes this:
>> 2 GB at 0x8000_0000
>> 30 GB at 0x8_8000_0000
>> 480 GB at 0x88_0000_0000
>
> I'm not particularly recommending this layout, at least not without some
> clarifications on DRAM aliases (I'll ping people internally about it
> again). The original layout pre-dates ARMv8, it was meant for ARMv7/LPAE
> and all the memory beyond 32-bit was highmem anyway. It was later
> updated for AArch64 but only to allow 44/48-bit PA (a few sections
> added).
>

As an aside, is there any reason why the direct mapping *must* be a
linear mapping?
Other than the performance concerns regarding phys_to_virt/virt_to_phys, I mean?

> How I understood it at the time is that in hardware you place the large
> DRAM (chip select) at high addresses, e.g. 64GB would be at a 512GB
> offset, but lower 2GB+30GB aliased in the lower space with the
> corresponding high address remaining a hole (that produces external
> aborts if accessed). The first alias at 2GB was meant for 32-bit
> initialisation code before the MMU is enabled. With AArch64, you don't
> really need this low alias (assuming your EL3/EL2/secure-EL1 code is
> 64-bit) since PC can use >32-bit addresses.
>
>> ...i.e. if you have > 32 GB then your RAM regions are split into 3
>> chunks.  The aarch64 kernel will support > than 32GB right?  A
>> basic server will have that much or more.
>>
>> How will we deal with systems with > 32GB of memory that follow that
>> map?
>
> My recommendation would be to avoid the lower alias (in hardware or some
> EL3 configuration change) and keep all the RAM at 0x80_0000_0000, just
> boot the system in AArch64 mode.
>
>> When do we expect the default page size for the aarch64 kernel to be
>> changed to 64KB?  Any workload that puts pressure on the TLBs will benefit
>> from this.
>
> This comes with its own set problems. 64KB is useful for specific
> use-cases (e.g. large databases) but not general purpose where you waste
> a large amount of RAM. So there are no plans to change the default page
> size to 64KB.
>
> --
> Catalin
