From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Feb 2011 10:19:57 +0000
Subject: [PATCH] ARM: gic: use handle_fasteoi_irq for SPIs
In-Reply-To: <alpine.LFD.2.00.1102171032580.2701@localhost6.localdomain6>
References: <1297697188-5206-1-git-send-email-will.deacon@arm.com>
	<AANLkTik-0SaVbtiXZ-iefvvgLq=7KqRTGi7XPLPEKx85@mail.gmail.com>
	<-4413647205110644369@unknownmsgid>
	<AANLkTikaZkRMHH1bUmO0pWYT1FgTC+83F5KxPySasG-S@mail.gmail.com>
	<146267380211262372@unknownmsgid>
	<AANLkTimPDNv+2n2-QHtBq0X+Vkj21yQCPh8iKZkYjfqG@mail.gmail.com>
	<alpine.LFD.2.00.1102162008490.2701@localhost6.localdomain6>
	<20110217091741.GA24627@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1102171032580.2701@localhost6.localdomain6>
Message-ID: <20110217101957.GC24627@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 17, 2011 at 10:38:08AM +0100, Thomas Gleixner wrote:
> On Thu, 17 Feb 2011, Russell King - ARM Linux wrote:
> > That's a result of genirq.  With the ARM non-genirq implementation
> > where we had just ack, mask and unmask, it all turned out much easier.
> > In fact, we hardly ever called any of these functions in chained
> > handlers (except ack) - the only time when mask and unmask were called
> > was when we had an IRQ multiplexer which didn't allow us to mask the
> > individual interrupts.
> > 
> > With the advent of genirq and its expansion of the irq chip methods it's
> > become much more complicated.  That's one of the faults of trying to
> > generalize this across different architectures.
> > 
> > You can't do without chained handlers on ARM - we used to do it without
> > them and it was proven to be a complete disaster.  Dropped interrupts
> > and various drivers just didn't work with chained interrupt controllers.
> 
> I really have a hard time to see the difference between doing:
> 
>   chained_handler()
> 	fiddle_with_primary_chip()
> 	demux()
> 	fiddle_with_primary_chip()
> 	
> and
> 
>   handle_xxxx_irq()
> 	fiddle_with_primary_chip()
> 
> 	chained_handler()
> 		demux()
> 
> 	fiddle_with_primary_chip()
> 
> Why should that drop more interrupt? The only difference is that you
> make the demux handler oblivious of the underlying primary chip and
> let the chip chose the appropriate flow handler which issues the right
> chip methods.

The difference is that properly implemented chained handlers do *not*
mask the interrupt on the parent IRQ controller, thereby allowing
other interrupts to be serviced as appropriate.

The issue that this whole implementation was designed in the first place
to fix was lost IDE interrupts for CF cards connected to the PCMCIA/CF
interfaces of SA1111 devices.  These were lost because the CF interrupt
output is a level-based output, but the SA11xx interrupt inputs are all
edge based.

When the CF interrupt is connected to a SA1111 GPIO, and using the old
interrupt system, edge transitions were _often_ missed resulting in
frequent 'lost interrupt' complaints from the IDE layer.  Exactly why
this was could never be ascertained (probably because the hardware
combination I had at the time did not allow me to setup this scenario.)

With the chained interrupt handler implementation, things were setup to
ensure that as much of the interrupt levels were left enabled so that
there was symetrical handling across the entire interrupt tree, and the
result of that was no more lost interrupts.

There is a lot of difference between using a conventional 'flow' handler
which does masking/unmasking of the parent interrupt and a properly
written chained handler which avoids that masking.
