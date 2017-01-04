From: markus.mayer@broadcom.com (Markus Mayer)
Date: Wed, 4 Jan 2017 15:04:54 -0800
Subject: [PATCH] arm64: errata: Check for --fix-cortex-a53-843419 and
 --fix-cortex-a53
In-Reply-To: <a45e7e0b-0e94-547e-7763-fd5aee38ef08@gmail.com>
References: <20161031194414.61287-1-code@mmayer.net>
 <20161102210331.GJ22791@arm.com>
 <CAGt4E5tKHNQw=eLzFx-+g6yLwJ=xCTQEqNZHFZu6aOVpKm7X7w@mail.gmail.com>
 <20161102212747.GL22791@arm.com>
 <CAGt4E5sxMcyizwAjwEZd6zepOAyr05WCgtstoRDfNjkNQtnJCA@mail.gmail.com>
 <2d72cbbb-df03-267c-53b0-e3083a746175@gmail.com>
 <20161103141559.GQ22791@arm.com>
 <ae71bdc0-23c7-ce0d-7264-930ab7f405ec@gmail.com>
 <c4f5b650-b210-8332-e6f2-4ad9634818b9@gmail.com>
 <20170104114920.GB18193@arm.com>
 <a45e7e0b-0e94-547e-7763-fd5aee38ef08@gmail.com>
Message-ID: <CAGt4E5st6RZwVXtLAa0Hm+H+O5qHqGWp9AqL4ri83AyEJ70r3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2017 at 14:39, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 01/04/2017 03:49 AM, Will Deacon wrote:
>> Hi Florian,
>>
>> On Wed, Dec 28, 2016 at 12:17:23PM -0800, Florian Fainelli wrote:
>>> On 11/03/2016 10:20 AM, Florian Fainelli wrote:
>>>> On 11/03/2016 07:16 AM, Will Deacon wrote:
>>>>> If you can't change toolchain and you want this worked around, why can't you
>>>>> either build gold with it enabled by default, or pass the extra flag on the
>>>>> command line to the kernel build system?
>>>>
>>>> Because that creates a distribution problem and now we have to document
>>>> this for people who want to build a kernel on their own, without
>>>> necessarily understanding if this is something they might need, or why
>>>> this is needed, and why the kernel is not taking care of that on its
>>>> own? So yes, this comes down to who is responsible for what, in that
>>>> case the kernel's Makefile is the best place where to put such knowledge
>>>> as to which workaround needs to be enabled by the linker and it
>>>> simplifies things a lot for people.
>>>
>>> Was this convincing enough for Catalin to pick Markus' patch or does
>>> that mean this patch needs to remain out of tree for us because of using
>>> a slightly older toolchain?
>>
>> I thought more about this last night, and there are two questions that
>> might sway me:
>>
>>   1. How prevalent is the binary toolchain with this issue? Is it, for
>>      example, shipping as part of a publicly available LTS distribution?
>>      I know you quoted some Linaro build, but I can't actually find those
>>      binaries on their website.
>
> The toolchain is available for download from Broadcom's website at
> https://www.broadcom.com/support/download-search/?pg=Broadband:+CPE-Gateway,+Infrastructure,+and+Set-top+Box&pf=Set-top+Box+Solutions
> (working on the download agreement as we speak) and is used by the large
> majority of our customers today, it's hard to give you numbers, but
> several hundreds if not more people definitively use it AFAICT.
>
>>
>>   2. Could we extend the Makefile magic to detect that, not only is
>>      --fix-cortex-a53-843419 unsupported, but also that the linker is
>>      in fact gold?
>
> I suppose we could do that, Markus do you mind update your original
> patch? Thanks!

Hm. Unfortunately, the linker doesn't identify as "gold." I could try
to use "Linaro 2014" or similar from the version string as an
additional test, but I don't know if that would catch all cases. It
would certainly catch ours, so it may be good enough.

$ aarch64-linux-gnu-ld -v
GNU ld (GNU Binutils) Linaro 2014.11-2 2.24.0.20141017

$ aarch64-linux-gnu-ld --fix-cortex-a53-843419
aarch64-linux-gnu-ld: unrecognized option '--fix-cortex-a53-843419'
aarch64-linux-gnu-ld: use the --help option for usage information

$ aarch64-linux-gnu-ld --fix-cortex-a53
aarch64-linux-gnu-ld: no input files

Regards,
-Markus

> --
> Florian
