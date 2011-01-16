From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 16 Jan 2011 12:36:15 +0000
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd
	and phychan structures
In-Reply-To: <AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
	<E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
	<AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
	<20110115092324.GX15996@n2100.arm.linux.org.uk>
	<AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
Message-ID: <20110116123615.GC27542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 11:17:04PM -0800, Dan Williams wrote:
> On Sat, Jan 15, 2011 at 1:23 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Fri, Jan 14, 2011 at 05:35:41PM -0800, Dan Williams wrote:
> >> On Mon, Jan 3, 2011 at 2:39 PM, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > As we now have all the code accessing the phychan {csrc,cdst,clli,cctl,
> >> > ccfg} members in one function, there's no point storing the data into
> >> > the struct. ?Get rid of the struct members. ?Re-order the register dump
> >> > in the dev_dbg() to reflect the order we write the registers to the DMA
> >> > device.
> >> >
> >> > The txd {csrc,cdst,clli,cctl} values are duplicates of the lli[0]
> >> > values, so there's no point duplicating these either. ?Program the DMAC
> >> > registers directly from the lli[0] values.
> >> >
> >> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> >>
> >> This one caused:
> >> drivers/dma/amba-pl08x.c: In function 'pl08x_start_txd':
> >> drivers/dma/amba-pl08x.c:205: warning: dereferencing 'void *' pointer
> >
> > That probably means you've got something out of order. ?I have them
> > ordered in my git tree, I'll recheck there.
> 
> I rechecked here and I think everything is in order.

Okay, something's screwed in the patch set - and I think I see what it is.
Patch 16 is missing a change.  I'll respin.
