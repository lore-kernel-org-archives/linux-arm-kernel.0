From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 14 Aug 2015 15:55:19 +0200
Subject: [RFC] arm64: defconfig: enable 48-bit VA by default
In-Reply-To: <20150814132428.GE16368@e104818-lin.cambridge.arm.com>
References: <BY2PR0301MB074300C5F31701D9211827F0878C0@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <20150730101358.GA30796@e104818-lin.cambridge.arm.com>
 <CY1PR0301MB074850E27D5D298D1B8495D2878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <20150730161210.GE407@e104818-lin.cambridge.arm.com>
 <CY1PR0301MB0748FA3A10AFA9BFC1AB0A39878B0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu-Wbv3J9-2KbXrz_3W_=VXChrD+REo1-q1Ns_=RUM1BFw@mail.gmail.com>
 <BY2PR0301MB07436AC9C8D023DC7C67DE3D87730@BY2PR0301MB0743.namprd03.prod.outlook.com>
 <CAKv+Gu-SH7MjkrgevfcUurPc7iQm+11cntfEo84opkqQoN2YPQ@mail.gmail.com>
 <CY1PR0301MB07488764C02CCA3F653ED6A5877D0@CY1PR0301MB0748.namprd03.prod.outlook.com>
 <CAKv+Gu9gvrBwZry+pwXqsso9qg2vZcrYA8wgogRaRPhd6rsJuw@mail.gmail.com>
 <20150814132428.GE16368@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu_4d+cSE_ynsBmk4KmdiEKCT9hv_HWgU0+6e+1ra8OT7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 August 2015 at 15:24, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Fri, Aug 14, 2015 at 02:15:23PM +0200, Ard Biesheuvel wrote:
>> >> On 7 aug. 2015, at 21:01, Stuart Yoder <stuart.yoder@freescale.com> wrote:
>> >>
>> >> >> Whether defconfig supports your platform optimally has nothing to do
>> >> >> with that. Of course, we should deal with the unexpected memory layout
>> >> >> gracefully, which is why Mark Rutland and myself proposed patches to
>> >> >> fix the panic you reported. But in a development context, I think it
>> >> >> is perfectly acceptable to simply load the kernel at 0x80_8000_0000,
>> >> >> and be able to run defconfig fine while losing just 2 GB of your 16 GB
>> >> >> at the low end.
> [...]
>> So we still need to decide how to fix the case where the linear region
>> is not of sufficient size to cover all of memory, considering that is
>> what got this discussion started in the first place.
>
> We already have a solution, just enable 4-levels of page tables (only
> that I don't think we should change defconfig as well).
>
> If we want to do any tricks like compacting the memory range, it needs
> to be backed by benchmarks to prove that it's worth compared to a full
> 48-bit VA.
>

If you run a 39-bit VA kernel on a system whose DRAM configuration
covers a larger area than what the linear mapping can support, you
currently get a panic since phys_to_virt() overflows into the user
range. So at the very least, we need to clip the range to a size the
kernel can manage.
