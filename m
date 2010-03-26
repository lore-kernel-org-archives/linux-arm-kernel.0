From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Mar 2010 18:15:46 +0000
Subject: AACI broken with commit 29a4f2d3
In-Reply-To: <1269602911.15413.6.camel@localhost.localdomain>
References: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
	<1269443418.29073.147.camel@e102109-lin.cambridge.arm.com>
	<s5h39zou023.wl%tiwai@suse.de>
	<20100325113019.GA6590@n2100.arm.linux.org.uk>
	<s5hvdckskev.wl%tiwai@suse.de> <4BAB4DE8.1030707@mvista.com>
	<1269518557.10064.14.camel@e102109-lin.cambridge.arm.com>
	<20100325121614.GC6590@n2100.arm.linux.org.uk>
	<1269602911.15413.6.camel@localhost.localdomain>
Message-ID: <20100326181545.GA21682@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 26, 2010 at 04:58:31PM +0530, Philby John wrote:
> On Thu, 2010-03-25 at 12:16 +0000, Russell King - ARM Linux wrote:
> > On Thu, Mar 25, 2010 at 12:02:37PM +0000, Catalin Marinas wrote:
> > > I can confirm that it solves the reset issue on other RealView boards as
> > > well. Whether it's the correct fix I can't tell.
> > 
> > Something else is going on then.  Whatever, this patch is totally
> > incorrect and needs to be reverted.  It's not even doing what the
> > description in the documentation requires.
> > 
> > I quote from page 3-18, which is mentioned in the commit message which
> > added this code:
> > 
> >   Data transmitted on slot 2 register, AACISL2TX The AACISL2TX register
> >   is a read/write register. When a write occurs to this register the data
> >   it contains is sent on the next available frame in slot 2. If a power
> >   down is required, then data must be written to AACISL1TX location
> >   address 0x26, which is recorded by the PrimeCell AACI. If the AACISL2TX
> >   bit 16 is set, then the PrimeCell AACI goes into power down mode.
> >   Table 3-11 shows the bit assignment of the AACISL2TX register.
> > 
> > And this is definitely NOT what Philby's code is doing.
> > 
> > The original commit is wrong on soo many levels.
> 
> Here is the background work I did previously for the original patch.
> 
> Dumped entire AACI registers when reading used to fail. The difference between
> a working and non-working probe is confined to just 4 registers.
> 
> Working                         Non-Working
> 
> 0007C000: SL1RX                 00000000: SL1RX
> 0004E530: SL2RX                 00000000: SL2RX
> 00000A80: slot flags            00000A02: slot flags
> 00000000: main flag register    00000002: main flag register
> 
> Of which what's interesting are the "slot flags" and the "main flag register".
> The slot flag register (AACISLFR) has its 1st bit set to 1, meaning Slot 1
> transceiver is busy, when reading vendor/product id (times out after 10 tries).
> 
> The manual mandates powering down of the aaci module to attain reset values
> (page 3-18, 2-7) by setting AACIRESET. But ofcourse to attain default state its useless
> putting them in any clean up routine. That's why I introduced them at probe time. Here is
> another way to solve the problem.
> 
> >From c10d6111657d881bea53d8559deb7422d0f46583 Mon Sep 17 00:00:00 2001
> From: Philby John <pjohn@in.mvista.com>
> Date: Fri, 26 Mar 2010 16:41:06 +0530
> Subject: [PATCH] Fix alignment faults on ARM Cortex introduced by commit 29a4f2d3
> 
> The commit 29a4f2d3 uses writel() on the AC97_POWERDOWN register
> which is half-word aligned causing unaligned exceptions on a
> Cortex-A8. The original patch solved the "aaci-pl041 fpga:04:
> ac97 read back fail" issue on a soft reset. Reading from 0x26
> also clears AACISL1TX/AACISL2TX slots for transmit.
> 
> Signed-off-by: Philby John <pjohn@mvista.com>
> ---
>  sound/arm/aaci.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/arm/aaci.c b/sound/arm/aaci.c
> index 656e474..6d677c2 100644
> --- a/sound/arm/aaci.c
> +++ b/sound/arm/aaci.c
> @@ -863,7 +863,11 @@ static int __devinit aaci_probe_ac97(struct aaci *aaci)
>  	struct snd_ac97 *ac97;
>  	int ret;
>  
> -	writel(0, aaci->base + AC97_POWERDOWN);
> +	/*
> +	 * Fix: ac97 read back fail errors by reading
> +	 * from Power down register
> +	 */
> +	readw(aaci->base + 0x26);

You are not reading from the power down register.  As I've explained
twice before, 0x26 is part of channel 2 interrupt enable register.

Register 0x26 is the power down register in the AC'97 codec.  This is not
addressable using readw nor writew or any other variant of the Linux MMIO
API.  It can only be read and written through the slot registers.

NAK.

When you've grasped the above fact, then we might be able to proceed on
this issue.  Until then, NAK NAK NAK NAK NAK NAK NAK.
