From: tom@sharkbay.at (Thomas Scheiblauer)
Date: Fri, 08 Aug 2014 16:10:23 +0200
Subject: [BUG]: imx6q (wandboard): Very unstable ethernet since kernel 3.16
In-Reply-To: <20140808132754.GC30282@n2100.arm.linux.org.uk>
References: <1407503758.19455.1.camel@sharkbay.at>
 <20140808132754.GC30282@n2100.arm.linux.org.uk>
Message-ID: <1407507023.19455.3.camel@sharkbay.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fre, 2014-08-08 at 14:27 +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 08, 2014 at 03:15:58PM +0200, Thomas Scheiblauer wrote:
> > Since Kernel 3.16 (running on 3.16.0) the ethernet (fec) connection
> > stops working after exchanging very little data. Sometimes it comes back
> > again for some seconds and drops again. No clues in dmesg.
> > 
> > After increasing TX_RING_SIZE in "drivers/net/ethernet/freescale/fec.h"
> > from 512 to 1024 the connection seems to stay stable (judging after
> > about half an hour of testing) but I really don't have experience with
> > kernel driver hacking, so I'm not sure what I'm doing here.
> 
> Interesting.  There have been some other reports of instability in a
> similar manner to that which you report, and, like the wanboard, they
> too have this:
> 
>         interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
>                               <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
> 
> Could it be that gpio1 6 doesn't actually work very well?  What happens
> if you comment out the above property in
> arch/arm/boot/dts/imx6qdl-wandboard.dtsi so you're using the standard
> interrupt on GIC 150?
> 

These lines in arch/arm/boot/dts/imx6qdl-wandboard.dtsi already seem to
be a workaround for some hardware errata:
ERR006687 ?ENET: Only the ENET wake-up interrupt request can wake the
system from Wait mode?

See the original mail containing the patch:
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/221204.html
