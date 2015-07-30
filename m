From: stuart.yoder@freescale.com (Stuart Yoder)
Date: Thu, 30 Jul 2015 18:10:33 +0000
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <CAKv+Gu-Wbv3J9-2KbXrz_3W_=VXChrD+REo1-q1Ns_=RUM1BFw@mail.gmail.com>
References: <CY1PR0301MB07488D6DC5F0B171D6B290E187830@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <55B0E1AD.60409@arm.com>
 <BY2PR0301MB0743CBCFC5476E39A5D1EC0B878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu9LHBd7wM6P4H0X5WigzDETtpr2++_Ebo=adg5QtTOW2w@mail.gmail.com>
 <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
 <CY1PR0301MB074850E27D5D298D1B8495D2878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150730161210.GE407@e104818-lin.cambridge.arm.com>
 <CY1PR0301MB0748FA3A10AFA9BFC1AB0A39878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-Wbv3J9-2KbXrz_3W_=VXChrD+REo1-q1Ns_=RUM1BFw@mail.gmail.com>
Message-ID: <CY1PR0301MB0748CE5ADA1D0A41D78C592F878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
> Sent: Thursday, July 30, 2015 12:46 PM
> To: Yoder Stuart-B08248
> Cc: Catalin Marinas; Mark Rutland; Marc Zyngier; Will Deacon; Newton Peter-RA3823; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [RFC] arm64: defconfig: enable 48-bit VA by default
> 
> On 30 July 2015 at 18:32, Stuart Yoder <stuart.yoder@freescale.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> >>
> >> For the time being, I would keep defconfig to 39-bit VA. If we start
> >> seeing systems with lots of RAM (over 256GB), we'll probably change the
> >> defconfig.
> >
> > Somone who follows the "Principles" doc "correctly" will hit an issue
> > with the linear memory map after 32GB of RAM, right?   2 GB in 1st alias,
> > 30 GB in 2nd alias, and rest at the 544 GB offset.
> >
> > But, I guess it still remains to be seen who else will hit that
> > and when.
> >
> 
> Hi Stuart,
> 
> I think you may be overestimating the significance of defconfig.

I might be, it's just a paranoia point...which led to wondering
about what to expect with respect 48-bit VA and 64K pages going
forward.

> As you pointed out, distros have their own configs (and many out of tree
> patches) for the binary kernels they ship. Fedora currently ships with
> 64k pages because it was the only way to support Seattle before the
> 4-level 4kb pages implementation was introduced. They will likely keep
> doing that, or switch to 4-level 4 kB pages since, as you pointed out,
> it is fairly likely that servers have more than 32 GB DRAM, which
> means that they need more than 256 GB of virtual address space in the
> linear region if they follow the ARM recommendation.
> 
> Whether defconfig supports your platform optimally has nothing to do
> with that. Of course, we should deal with the unexpected memory layout
> gracefully, which is why Mark Rutland and myself proposed patches to
> fix the panic you reported. But in a development context, I think it
> is perfectly acceptable to simply load the kernel at 0x80_8000_0000,
> and be able to run defconfig fine while losing just 2 GB of your 16 GB
> at the low end. Of course, you would never ship a system like that,
> but that is not what defconfig is meant to cater for.

Thanks for the patch and all your input, the picture and options are
quite a bit clearer to me now.

Thanks,
Stuart
