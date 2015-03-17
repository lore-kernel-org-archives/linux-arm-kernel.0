From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 17 Mar 2015 17:40:41 +0100
Subject: [RFC PATCH 0/3] arm64: relocatable kernel proof of concept
In-Reply-To: <20150317163554.GM23340@leverpostej>
References: <1426519423-28263-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAGXu5jJB8jQm+FOqwWLaA1zYsVYs4gMrgmdUH1LUxnoOcZdDrw@mail.gmail.com>
 <CAKv+Gu_A=_d+2=25WCOhAZnxTHQAWY4QZ2eVgyu03aweJvKjPQ@mail.gmail.com>
 <20150317163554.GM23340@leverpostej>
Message-ID: <CAKv+Gu8H61BSh6j7jd-MYXh6jS=ePPTj11L5Rs-Ce923te6mUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17 March 2015 at 17:35, Mark Rutland <mark.rutland@arm.com> wrote:
>> > Possibly related to running with/detecting an offset, we need a way to
>> > communicate that kASLR is active through the compressed kernel to
>> > uncompressed kernel. x86 is going to be using x86's setup_data, but we
>> > may need to generalize this. (The reasoning here is that when kaslr is
>> > disabled at runtime, we should turn off other kernel ASLR, like module
>> > offset ASLR, without duplicating kernel command line parameter parsing
>> > -- which is what x86 is currently doing now.) Just examining the
>> > offset isn't sufficient because perhaps we got randomized to offset 0.
>> > :)
>> >
>>
>> There is no decompressor on arm64, just the core kernel Image. So if
>> an offset needs to be chosen before branching into the kernel proper,
>> it needs to be the bootloader that chooses it.
>
> Agreed.
>
> Our equivalent to setup_data is the DT /chosen node, and I don't think
> we want to try parsing that before we've turned on the MMU.
>
> However, for the UEFI boot case we could have the stub do something more
> intelligent and choose a random physical offset itself.
>
>> > You mention the linear mappings in "performance", which I worry may be
>> > at odds with kASLR? Can large mappings still be used even when we've
>> > got smaller alignment goals? Since you mention the "upper half of the
>> > virtual address range", I assume ARM is built using the -2GB
>> > addressing as used by x86, is that right? So it sounds like it would
>> > be similar entropy to x86.
>> >
>>
>> I haven't quantified the performance gain, but it is arguably more
>> efficient to map RAM using 1 GB blocks than using 2 MB sections.
>> On the other part of the question, I really need to do more research
>> on what x86 implements in the first place before even trying to answer
>> it.
>
> That might not always be true, depending on the TLB implementation
> (though it's better to assume that it is, as it shouldn't result in a
> performance loss).
>

Exactly, but I didn't do any measurements at all.

> Also, if you use DEBUG_RODATA the kernel won't be mapped with 1GB
> mappings after early boot anyway.
>

That's not the point. The point is that, since physical memory starts
at the base of the kernel image, as far as the kernel is concerned,
the relative alignment of the virtual and physical address spaces may
result in *all* of memory being mapped using 2 MB sections rather than
1 GB blocks.
