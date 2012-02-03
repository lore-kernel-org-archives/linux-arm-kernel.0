From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 3 Feb 2012 12:42:22 -0700 (MST)
Subject: patch "tty: serial: OMAP: ensure FIFO levels are set correctly
 in non-DMA" added to tty tree
In-Reply-To: <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
References: <13274430881471@kroah.org>
 <alpine.DEB.2.00.1201251156361.5324@utopia.booyaka.com>
 <20120126042155.GA3185@suse.de>
 <alpine.DEB.2.00.1201252124470.11174@utopia.booyaka.com>
 <20120126191604.GA15516@suse.de>
 <alpine.DEB.2.00.1201261225520.32667@utopia.booyaka.com>
 <alpine.DEB.2.00.1202021302070.586@utopia.booyaka.com>
 <20120203150708.386951d2@notabene.brown>
 <alpine.DEB.2.00.1202022137150.586@utopia.booyaka.com>
 <20120203205401.5ddf241d@notabene.brown>
 <CANOLnONsZKHJPbEx2+ic3EZ1PqcD30VT4Z2bR5iW-JNQJQL0GA@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1202031234120.27947@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012, Grazvydas Ignotas wrote:

> On Fri, Feb 3, 2012 at 11:54 AM, NeilBrown <neilb@suse.de> wrote:
> > On Thu, 2 Feb 2012 22:45:53 -0700 (MST) Paul Walmsley <paul@pwsan.com> wrote:
> >> On Fri, 3 Feb 2012, NeilBrown wrote:
> >>
> >> > then CPUIDLE enters lower states and I think it uses less power but I
> >> > sometimes lose the first char I type (that is known) but also I sometimes get
> >> > corruption on output.
> >>
> >> I don't see any output corruption on 35xx BeagleBoard, either with or
> >> without these patches. ?So this is presumably a 37xx-centric problem, and
> >> unrelated to these patches, I would guess.
> >
> > Maybe it is 37xx specific. ?I think this is a DM3730.
> 
> Not sure if it's the same problem but with 3530 on 3.2 with
> sleep_timeout set, I usually get first char dropped (as expected) but
> sometimes I get corrupted char instead too. Corrupt char seems to
> almost always happen if I set cpufreq to powersave, on performace it's
> almost always ok, so maybe it's some timing problem,

OK so let's distinguish between two corruption situations:

1. The first character transmitted to the OMAP UART in a serial console 
when the UART powerdomain is in a non-functional, low power state (e.g., 
RET or below) is corrupted.  This is not actually output corruption, this 
is input corruption.

2. Characters are corrupted while the OMAP UART is transmitting data, but 
there has been no recent data sent to the OMAP.

Case 1 is expected and is almost certainly not a bug.  As Neil mentioned 
it should be bps-rate dependent.  It occurs when the first character 
transmitted to the OMAP wakes the chip up via I/O ring/chain wakeup.
I/O ring/chain wakeup is driven by a 32KiHz clock and is therefore 
relatively high-latency.  So this could easily cause the first character 
or first few characters to be lost or corrupted, depending on the exact 
sequence of events, the low power state that the chip was in, etc.

Case 2 is not expected.  That is likely a bug somewhere.  Neil, this is 
what I understood that you are experiencing.  Is that correct?

Gra?vydas, are you seeing case 1 or 2 (or something completely different 
;-) ?


- Paul
