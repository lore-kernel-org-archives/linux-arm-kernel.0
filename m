From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 6 Aug 2018 11:11:39 +0200
Subject: framebuffer corruption due to overlapping stp instructions on
 arm64
In-Reply-To: <20180806084451.GB19523@amd>
References: <alpine.LRH.2.02.1808021242320.31834@file01.intranet.prod.int.rdu2.redhat.com>
 <CA+=Sn1mWkjuwVnjw6OWWUM=UcP76bdFa680FebCseewHfx3NpA@mail.gmail.com>
 <20180805213615.GA1862@amd>
 <CAJA7tRZ69kbyA-Y0n4QBtz1JGFQdTXzNykewsySX0aj-CF5zqQ@mail.gmail.com>
 <20180806084451.GB19523@amd>
Message-ID: <CAKv+Gu8XX=MVhiO5H_0kWokB3vxEjTX_X41aR9N_WXqKwEUzkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2018 at 10:44, Pavel Machek <pavel@ucw.cz> wrote:
> On Mon 2018-08-06 09:04:33, Ramana Radhakrishnan wrote:
>> On Sun, Aug 5, 2018 at 10:36 PM, Pavel Machek <pavel@ucw.cz> wrote:
>> > Hi!
>> >
>> >> > I tried to use a PCIe graphics card on the MacchiatoBIN board and I hit a
>> >> > strange problem.
>> >> >
>> >> > When I use the links browser in graphics mode on the framebuffer, I get
>> >> > occasional pixel corruption. Links does memcpy, memset and 4-byte writes
>> >> > on the framebuffer - nothing else.
>> >> >
>> >> > I found out that the pixel corruption is caused by overlapping unaligned
>> >> > stp instructions inside memcpy. In order to avoid branching, the arm64
>> >> > memcpy implementation may write the same destination twice with different
>> >> > alignment. If I put "dmb sy" between the overlapping stp instructions, the
>> >> > pixel corruption goes away.
>> >> >
>> >> > This seems like a hardware bug. Is it a known errata? Do you have any
>> >> > workarounds for it?
>> >>
>> >> Yes fix Links not to use memcpy on the framebuffer.
>> >> It is undefined behavior to use device memory with memcpy.
>> >
>> > No, I don't think so. Why do you think so?
>>
>> It is undefined behaviour in the architecture.
>
> Why do you think so? Pointer to documentation would be helpful.
>
> Normal access is used for mmapped areas, and I don't think we want to
>  change that.

Pavel,

In this context, 'device mapping' specifically means one of the
Device-{G,nG}{R,nR}{E,nE} mapping attributes as defined by the ARM
ARM, where G, R and E stand for Gathering, Reordering and Early
acknowledgement, respectively.

There is no disagreement whether memcpy() is suitable for such regions
- it is not. These mappings are intended for memory mapped device
registers, not for memory.

The issue under discussion here is whether PCIe can provide outbound
windows with true memory semantics, which is the assumption that is
present all throughout the Linux graphics stack.
