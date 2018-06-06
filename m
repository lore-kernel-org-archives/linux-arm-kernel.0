From: ptesarik@suse.cz (Petr Tesarik)
Date: Wed, 6 Jun 2018 09:58:58 +0200
Subject: panic kexec broken on ARM64?
In-Reply-To: <CACi5LpMJ9whXxpMvQDw4_4kRNaATGGq4fWt7nRRJTMrdN_q_nQ@mail.gmail.com>
References: <20180605100151.7fd54381@ezekiel.suse.cz>
 <CACi5LpMJ9whXxpMvQDw4_4kRNaATGGq4fWt7nRRJTMrdN_q_nQ@mail.gmail.com>
Message-ID: <20180606095858.04b800a0@ezekiel.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jun 2018 11:06:28 +0530
Bhupesh Sharma <bhsharma@redhat.com> wrote:

> Hello Petr,
> 
> On Tue, Jun 5, 2018 at 1:31 PM, Petr Tesarik <ptesarik@suse.cz> wrote:
> > Hi all,
> >
> > I have observed hangs after crash on a Raspberry Pi 3 Model B+ board
> > when a panic kernel is loaded. I attached a hardware debugger and found
> > out that all CPU cores were stopped except one which was stuck in the
> > idle thread. It seems that irq_set_irqchip_state() may sleep, which is
> > definitely not safe after a kernel panic.  
>[...]
> Also do you get any console output from the crash kernel (you can try
> passing earlycon to the crash kernel to see if it crashes early
> enough)? If yes, can you please share the same.

Maybe I wasn't clear enough. The crashed kernel does not even get to
the kexec's purgatory code, so there cannot be any output from the
crash kernel.

>[...]
> > #12 0xffff000001001cd0 in lan78xx_read_reg (index=152, data=0xffff000008e5396c <init_thread_union+14700>, dev=<optimized out>, dev=<optimized out>)
> >     at ../drivers/net/usb/lan78xx.c:425  
> 
> Hmmm, this seems a bit misplaced, but are you using a usb-ethernet
> adapter which causes a URB submission to timeout?

Yes, RPi 3 B+ contains an on-board Microchip LAN7515, which is indeed a
USB device.

>[...]
> > #26 0xffff000008081478 in do_mem_abort (addr=0, esr=2248146948, regs=0xffff000008e53d70 <init_thread_union+15728>) at ../arch/arm64/mm/fault.c:657
> > #27 0xffff000008082dd0 in el1_sync () at ../arch/arm64/kernel/entry.S:548  
> 
> The ESR value from the logs (2248146948) indicates the following about
> the panic causes (see ARMv8 Architecture Reference Manual for more
> details):

Thank you for all the detailx, but that's not relevant here. I am
crashing my system intentionally to debug the kexec/kdump
infrastructure...

Petr T
