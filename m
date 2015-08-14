From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 14 Aug 2015 14:15:23 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <CY1PR0301MB07488764C02CCA3F653ED6A5877D0@CY1PR0301MB0748.namprd03.prod.outlook.com>
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
 <BY2PR0301MB07436AC9C8D023DC7C67DE3D87730@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu-SH7MjkrgevfcUurPc7iQm+11cntfEo84opkqQoN2YPQ@mail.gmail.com>
 <CY1PR0301MB07488764C02CCA3F653ED6A5877D0@CY1PR0301MB0748.namprd03.prod.outlook.com>
Message-ID: <CAKv+Gu9gvrBwZry+pwXqsso9qg2vZcrYA8wgogRaRPhd6rsJuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2015 at 21:24, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>
>> -----Original Message-----
>> From: Ard Biesheuvel [mailto:ard.biesheuvel at linaro.org]
>> Sent: Saturday, August 08, 2015 3:21 AM
>> To: Yoder Stuart-B08248
>> Cc: Catalin Marinas; Mark Rutland; Marc Zyngier; Will Deacon; Newton Peter-RA3823; linux-arm-
>> kernel at lists.infradead.org; Sun York-R58495
>> Subject: Re: [RFC] arm64: defconfig: enable 48-bit VA by default
>>
>> On 7 aug. 2015, at 21:01, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>>
>> >> Whether defconfig supports your platform optimally has nothing to do
>> >> with that. Of course, we should deal with the unexpected memory layout
>> >> gracefully, which is why Mark Rutland and myself proposed patches to
>> >> fix the panic you reported. But in a development context, I think it
>> >> is perfectly acceptable to simply load the kernel at 0x80_8000_0000,
>> >> and be able to run defconfig fine while losing just 2 GB of your 16 GB
>> >> at the low end.
>> >
>> > I've done this experiment-- loading/running the kernel at 0x80_8000_0000
>> > and losing the lower 2GB of memory.  And in fact I can see the kernel
>> > ignoring the low memory:
>> >
>> >   [    0.000000] Ignoring memory block 0x80000000 - 0x100000000
>> >
>>
>> Yes that looks correct
>>
>> > However, this only works with 48-bit VA enabled.  With 39-bit VA
>> > enabled the kernel crashes before the early console is working
>> > and I see nothing.
>> >
>>
>> That may well be a kernel bug: the changes to allow 39-bit VA kernels
>> to execute on systems whose memory is outside the 39-bit VA range was
>> developed and tested on AMD Seattle only, which has its RAM at
>> 0x80_0000_0000. But it is hard to be sure, of course, with no output
>> at all ...
>>
>> > Does the linear mapping we've been talking about just need to cover
>> > all of _RAM_, or does it need to cover all of I/O as well in
>> > the same mapping.
>> >
>> > In our case we have various SoC I/O devices, like the UART
>> > in the space below 4 GB... at 0x0100_0000.
>> >
>>
>> The linear mapping only covers system RAM, so that should not matter at all.
>>
>> > Before debugging further I want to check whether this should
>> > work in theory.  I had the impression that the issue was
>> > discontiguous RAM regions, and I/O was a separate issue.
>>
>> Yes, it should work in theory. The linear region starts at the base of
>> the kernel Image, and extends all the way up to the end of DRAM (14 GB
>> in your case, IIRC)
>
> An update on this... in my original test where the kernel did not run from
> high memory I was using a 4.0.x kernel.  I re-tried with a 4.2-rc4 kernel
> and it booted fine.  So, there is no kernel bug it in the latest kernel,
> it appears.
>

OK, thanks for reporting back.

So we still need to decide how to fix the case where the linear region
is not of sufficient size to cover all of memory, considering that is
what got this discussion started in the first place.

RobH was not too happy about how I proposed to split off
early_init_dt_add_memory_arch () but there has been no movement on
this since.

-- 
Ard.
