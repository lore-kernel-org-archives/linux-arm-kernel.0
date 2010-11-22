From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 14:40:40 +0000
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<AANLkTi=jXuupD+_t663_8haxgB-7Agf7UVcnjBQk+Z-Y@mail.gmail.com>
Message-ID: <20101122144040.GM31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 03:31:24PM +0100, Per Fransson wrote:
> On Mon, Nov 22, 2010 at 12:27 PM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Mon, Nov 22, 2010 at 10:47:40AM +0000, Russell King - ARM Linux wrote:
> >> However, we do need smp_send_stop() to wait for a limited time for the
> >> other CPUs to respond to the request.
> >
> > ARM: smp: make smp_send_stop() wait for secondary CPUs to stop
> >
> > Wait up to one second for secondary CPUs to respond to a request to
> > stop. ?This avoids the sender CPU continuing and possibly destroying
> > state before the recipients have had a chance to respond to the stop.
> > However, if the recipients have crashed, we won't hang the sender
> > CPU indefinitely.
> >
> 
> The point of the crash kernel functionality is to make it possible to grab a
> snapshot of the system at the time of the crash. smp_send_stop() will
> take the other cores offline, which makes the snapshot differ from the
> crash state more than it has to. To be more concrete, any core dump
> analysis tool which reads the cpu_online_mask to determine the number
> of cpus in use will get an incorrect picture.

Well, you can't go around randomly enabling interrupts to call functions
that require interrupts to be enabled, so I guess it's not possible to
save the state of the other cores.

I guess you're going to have to come up with another solution.
