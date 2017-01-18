From: broonie@kernel.org (Mark Brown)
Date: Wed, 18 Jan 2017 12:46:45 +0000
Subject: [PATCH v2 2/3] spi: pxa2xx: Prepare for edge-triggered interrupts
In-Reply-To: <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
References: <cover.1484592296.git.jan.kiszka@siemens.com>
 <cover.1484592296.git.jan.kiszka@siemens.com>
 <7b15a0910a3ad861fd32161c72559bafa7b71e29.1484592296.git.jan.kiszka@siemens.com>
 <87ziiqdstr.fsf@belgarion.home>
 <4d97e416-4d32-3b9f-0695-de116a4b26bd@siemens.com>
 <87r340eq28.fsf@belgarion.home>
 <b3e0d393-b841-1556-ddd2-5634f12b6f2c@siemens.com>
Message-ID: <20170118124645.6ugjwbfeq5vsh2to@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2017 at 10:33:07AM +0100, Jan Kiszka wrote:
> On 2017-01-18 09:21, Robert Jarzmik wrote:

> >>>> +	while (1) {

> >>> This bit worries me a bit, as this can be either :
> >>>  - hogging the SoC's CPU, endlessly running
> >>>  - or even worse, blocking the CPU for ever

> >>> The question behind is, should this be done in a top-half, or moved to a irq
> >>> thread ?

> >> Every device with a broken interrupt source can hog CPUs, nothing
> >> special with this one. If you don't close the loop in the handler
> >> itself, you close it over the hardware retriggering the interrupt over
> >> and over again.

> > I'm not speaking of a broken interrupt source, I'm speaking of a broken code,
> > such as in the handler, or broken status readback, or lack of understanding on
> > the status register which may imply the while(1) to loop forever.

> >> So, I don't see a point in offloading to a thread. The normal case is
> >> some TX done (FIFO available) event followed by an RX event, then the
> >> transfer is complete, isn't it?

> > The point is if you stay forever in the while(1) loop, you can at least have a
> > print a backtrace (LOCKUP_DETECTOR).

> I won't consider "debugability" as a good reason to move interrupt
> handlers into threads. There should be real workload that requires
> offloading or specific prioritization.

It's failure mitigation - you're translating a hard lockup into
something that will potentially allow the system to soldier on which is
likely to be less severe for the user as well as making things easier to
figure out.  If we're doing something like this I'd at least have a
limit on how long we allow the interrupt to scream.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170118/2d8e46dd/attachment-0001.sig>
