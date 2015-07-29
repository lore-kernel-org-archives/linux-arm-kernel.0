From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 29 Jul 2015 17:48:30 +0200
Subject: bug in identity map for 4KB pages?
In-Reply-To: <BY2PR0301MB0743FFE35289BF228DBCE4C8878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
References: <CY1PR0301MB0748B85327B6501BE7987B03878C0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu_PMvbeKRnx8t3P+44q1pt-NiUcCMTq6vK-8yUMRjQPdA@mail.gmail.com>
 <20150729114258.GK15213@leverpostej>
 <BY2PR0301MB0743FFE35289BF228DBCE4C8878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
Message-ID: <CAKv+Gu8GgANoC0u_UK+cGAG=hpfMKx842KiPwkm=jmY6Pxaspw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 July 2015 at 17:45, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>
>
>> -----Original Message-----
>> From: Mark Rutland [mailto:mark.rutland at arm.com]
>> Sent: Wednesday, July 29, 2015 6:43 AM
>> To: Ard Biesheuvel; Yoder Stuart-B08248
>> Cc: Marc Zyngier; Catalin Marinas; Newton Peter-RA3823; Will Deacon; linux-arm-kernel at lists.infradead.org
>> Subject: Re: bug in identity map for 4KB pages?
>>
>> On Wed, Jul 29, 2015 at 08:47:10AM +0100, Ard Biesheuvel wrote:
>> > On 29 July 2015 at 04:37, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>> > > Our system has RAM at a high address, and previously required using 48-bit VA
>> > > in order to have an idmap that covered all of RAM.
>> > >
>> > > In testing on 4.2-rc4, which now contains support for the increased VA range
>> > > of the idmap without using 48-bit VA, I'm finding that things work for
>> > > 64KB pages, but do not for 4KB pages.
>> > >
>> > > Is there any known limitation here with 4KB pages?  Any ideas?
>> > >
>> >
>> > You probably have memory at 0x8000_0000 and at 0x80_8000_0000, right?
>
> Yes.  We have 2GB of memory at 0x8000_0000 and the remainder at
> 0x80_8000_0000.
>
>> > So the physical arrangement still requires more than the 39 bits of
>> > virtual address space you get with 3 levels, even if the ID map can
>> > cope now. That is why you get the 0x40_0000_0000 virtual address:
>> > __phys_to_virt() just wraps to a positive number.
>>
>> Ah, I see. So it's the linear mapping rather than the idmap which is the
>> problem.
>>
>> We cut memory which would fall below the start of the linear map in
>> early_init_dt_add_memory_arch, by cutting memory below phys_offset.
>>
>> It looks like we already have the logic for cutting memory beyond the
>> end of the linear map, so we should just need to override the limit.
>
> What is the effect of cutting that memory?  ...are we losing something?
>

Yes, you will lose everything above 2 GB in the current configuration.

>> Stuart, does the below patch prevent the panic you see?
>
> I will try it and let you know...can try the suggested patch by
> Ard as well.
>

Is it possible to load the kernel at 0x80_0000_0000? I think your
system will just boot fine in that case, and you will only lose the
lower 2 GB in that case.

Re patch: I am working on a more comprehensive patch atm. Could you
perhaps try that instead (~15 min)?

Thanks,
Ard.
