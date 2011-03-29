From: jamie@jamieiles.com (Jamie Iles)
Date: Tue, 29 Mar 2011 12:30:32 +0100
Subject: CPUv6K (ARM1176) and wfi()
In-Reply-To: <007001cbee04$1a6b4a70$4f41df50$@deacon@arm.com>
References: <20110328122557.GB2738@pulham.picochip.com>
	<AANLkTimahGgupW-b370664jXKhyv+NEh1+TwX=PVCb3G@mail.gmail.com>
	<006d01cbedf0$c60d1070$52273150$@deacon@arm.com>
	<20110329105846.GD2738@pulham.picochip.com>
	<007001cbee04$1a6b4a70$4f41df50$@deacon@arm.com>
Message-ID: <20110329113032.GF2738@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2011 at 12:26:09PM +0100, Will Deacon wrote:
> > On Tue, Mar 29, 2011 at 10:07:47AM +0100, Will Deacon wrote:
> > > > On Mon, Mar 28, 2011 at 1:25 PM, Jamie Iles <jamie@jamieiles.com> wrote:
> > > > > Hi Catalin, Will,
> > > > >
> > > > > I'm respinning some PM patches for my platform (ARM1176JZ-S) and looking
> > > > > at arch/arm/include/asm/system.h, for CPU_32v6K wfi() uses the "wfi"
> > > > > instruction, but when I use this on my system the instruction returns
> > > > > immediately. ?Replacing this with:
> > > > >
> > > > > ? ? ? ?asm volatile("mcr ? p15, 0, %0, c7, c0, 4\n" :: "r"(0));
> > > > >
> > > > > makes everything work properly. ?The ARM1176 TRM doesn't mention the wfi
> > > > > instruction afaict but does say to use the cp15 instruction in section
> > > > > 10.2.2 (Standby mode). ?It doesn't look to me that the SEV or WFE
> > > > > instructions are implemented on ARM1176 so I'm guessing that these are
> > > > > only in mpcore?
> > > >
> > > > I think WFI/SEV/WFE are encoded as NOP-synonyms, so they may do
> > > > nothing on non-multicore platforms; so I think the MCR is the correct
> > > > mechanism to use for 1176... unless Will or Catalin have better ideas.
> > >
> > > Would using the mcr get in the way of a combined v6/v7 kernel image?
> > > I notice that the behaviour on A9 is the exact opposite (wfi works, mcr
> > > is a NOP).
> > 
> > Wouldnet it also be a problem for smp-on-up for a v6K only kernel?  It
> > doesn't look like arm11 mpcore supports the cp15 access...
> 
> Section 3.4.18 (table 3.29) in the 11MPCore TRM mentions WFI using the mcr
> instruction so it should be all present and correct. Are you seeing issues
> in hardware?

OK, I missed that!  I don't have access to an mpcore system so I haven't 
tried this on hardware, just the problem with wfi on 1176.

Jamie
