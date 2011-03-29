From: will.deacon@arm.com (Will Deacon)
Date: Tue, 29 Mar 2011 10:07:47 +0100
Subject: CPUv6K (ARM1176) and wfi()
In-Reply-To: <AANLkTimahGgupW-b370664jXKhyv+NEh1+TwX=PVCb3G@mail.gmail.com>
References: <20110328122557.GB2738@pulham.picochip.com>
	<AANLkTimahGgupW-b370664jXKhyv+NEh1+TwX=PVCb3G@mail.gmail.com>
Message-ID: <006d01cbedf0$c60d1070$52273150$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Mon, Mar 28, 2011 at 1:25 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > Hi Catalin, Will,
> >
> > I'm respinning some PM patches for my platform (ARM1176JZ-S) and looking
> > at arch/arm/include/asm/system.h, for CPU_32v6K wfi() uses the "wfi"
> > instruction, but when I use this on my system the instruction returns
> > immediately. ?Replacing this with:
> >
> > ? ? ? ?asm volatile("mcr ? p15, 0, %0, c7, c0, 4\n" :: "r"(0));
> >
> > makes everything work properly. ?The ARM1176 TRM doesn't mention the wfi
> > instruction afaict but does say to use the cp15 instruction in section
> > 10.2.2 (Standby mode). ?It doesn't look to me that the SEV or WFE
> > instructions are implemented on ARM1176 so I'm guessing that these are
> > only in mpcore?
> 
> I think WFI/SEV/WFE are encoded as NOP-synonyms, so they may do
> nothing on non-multicore platforms; so I think the MCR is the correct
> mechanism to use for 1176... unless Will or Catalin have better ideas.

Would using the mcr get in the way of a combined v6/v7 kernel image?
I notice that the behaviour on A9 is the exact opposite (wfi works, mcr
is a NOP).

Will
