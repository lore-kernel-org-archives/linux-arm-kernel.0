From: kristoffer.ericson@gmail.com (Kristoffer Ericson)
Date: Wed, 27 Oct 2010 23:04:51 +0200
Subject: hda interrupt timeouts on sa1110 + sa1111 board
In-Reply-To: <20101027202759.GC24573@n2100.arm.linux.org.uk>
References: <20101025211239.GD879@boggieman.bredbandsbolaget.se>
	<20101027202759.GC24573@n2100.arm.linux.org.uk>
Message-ID: <20101027210451.GB892@boggieman.bredbandsbolaget.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 27, 2010 at 09:27:59PM +0100, Russell King - ARM Linux wrote:
> On Mon, Oct 25, 2010 at 11:12:39PM +0200, Kristoffer Ericson wrote:
> > Greetings,
> > 
> > First off I havent bisected this yet, but sounds more than likely
> > that it comes with the sa1111.c changes. It works fine in v2.6.34 also.
> > 
> > As you can see it progresses a bit but keeps loosing interrupts.
> 
> I don't see anything in the sa1111 core, soc_common, or sa11* pcmcia
> code which would cause this change of behaviour.  I think it may
> require a bisect to find what change broke this.

Filip Zyzniewski did a bisect of this issue a couple of weeks ago (for v2.6.34)
and made 3 patches to get it going again. With these it works for me again.
Unfortunantly they are reverts rather than fixes, so it doesnt solve much
with the current layout.

Ill just drop them to the mailinglist and we can take it from there.

> 
> > [   37.136325] setting trigger mode 3 for irq 51 failed (sa1111_type_highirq+0x0/0x90)
> > [   37.182938] setting trigger mode 3 for irq 53 failed (sa1111_type_highirq+0x0/0x90)
> 
> These are fine - the soc_common code intentionally tries to set the type
> to rising, then both edges - the idea being that we get rising edge if
> the hardware doesn't support both edges.
> 
> > [   40.662432] jornada720_pcmcia_configure_socket(): config socket 1 vcc 33 vpp 0
> > [   40.767874] jornada720_pcmcia_configure_socket(): config socket 1 vcc 33 vpp 0
> > [   41.220300] hda: SanDisk SDCFX3-8192, CFA DISK drive
> > [   42.002086] ide0 at 0xc8840000-0xc8840007,0xc884000e on irq 49
> > [   42.071940] isa bounce pool size: 16 pages
> > [   42.133597] hda: max request size: 128KiB
> > [   42.191639] hda: 16007040 sectors (8195 MB) w/1KiB Cache, CHS=15880/16/63
> > [   72.340242] hda: lost interrupt
> 
> And this suggests no interrupts what so ever are coming from the drive.
