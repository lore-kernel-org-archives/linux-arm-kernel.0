From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 28 Mar 2011 15:32:07 +0100
Subject: CPUv6K (ARM1176) and wfi()
In-Reply-To: <20110328122557.GB2738@pulham.picochip.com>
References: <20110328122557.GB2738@pulham.picochip.com>
Message-ID: <AANLkTimahGgupW-b370664jXKhyv+NEh1+TwX=PVCb3G@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 28, 2011 at 1:25 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> Hi Catalin, Will,
>
> I'm respinning some PM patches for my platform (ARM1176JZ-S) and looking
> at arch/arm/include/asm/system.h, for CPU_32v6K wfi() uses the "wfi"
> instruction, but when I use this on my system the instruction returns
> immediately. ?Replacing this with:
>
> ? ? ? ?asm volatile("mcr ? p15, 0, %0, c7, c0, 4\n" :: "r"(0));
>
> makes everything work properly. ?The ARM1176 TRM doesn't mention the wfi
> instruction afaict but does say to use the cp15 instruction in section
> 10.2.2 (Standby mode). ?It doesn't look to me that the SEV or WFE
> instructions are implemented on ARM1176 so I'm guessing that these are
> only in mpcore?

I think WFI/SEV/WFE are encoded as NOP-synonyms, so they may do
nothing on non-multicore platforms; so I think the MCR is the correct
mechanism to use for 1176... unless Will or Catalin have better ideas.

Cheers
---Dave

>
> Jamie
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
