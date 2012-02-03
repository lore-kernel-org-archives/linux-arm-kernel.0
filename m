From: neilb@suse.de (NeilBrown)
Date: Fri, 3 Feb 2012 23:11:13 +1100
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
Message-ID: <20120203231113.25ae2d3a@notabene.brown>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 3 Feb 2012 13:42:13 +0200 Grazvydas Ignotas <notasas@gmail.com> wrote:

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

I see that too - I'm glad someone else does :-)

If I look at the corruption as compared to the expected character, it is
always the case some it has been shifted down a few bits, with '1's shifted
in the top.
As bytes are sent lsb first followed by stop bits which are '1', this is
completely consistent with clocking the bits in a little bit late.

I see this with baud rates of 115200 and higher, but never with lower.

My theory is that there is a delay between the falling RX line waking the
system up, and the CPU enabling the UART - whether enabling the clocks or
doing a full config, I am not sure - though I think the former.

Maybe if we could enable the UART clocks immediately after returning from the
WFI instruction we could avoid the corruption....

NeilBrown

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 828 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120203/be690dea/attachment.sig>
