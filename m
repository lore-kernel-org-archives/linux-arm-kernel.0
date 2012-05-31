From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 31 May 2012 08:46:28 +0800
Subject: [RFC 04/34] dmaengine: PL08x: remove runtime PM support
In-Reply-To: <E1SZIr0-0006yy-98@rmk-PC.arm.linux.org.uk>
References: <20120529093015.GF12217@n2100.arm.linux.org.uk>
 <E1SZIr0-0006yy-98@rmk-PC.arm.linux.org.uk>
Message-ID: <CACRpkdbMhTuQSADHJb_0ivyXregbGH1eEhjFk1i-S3Bs5oi0UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 29, 2012 at 5:36 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:

> The runtime PM support conflicts with the generic AMBA bus PM, and also
> causes a potential deadlock with the PL011 driver as it results in
> interrupts being enabled beneath a spinlock.
>
> I don't presently see any solution to this other than by removing the
> runtime PM support entirely from the DMA engine driver. ?Alternative
> suggestions welcome.

I took a look again and cannot see any simple way to do this.

It basically looks like we need to have job submission put stuff
in a queue and kick a worker or kthread to have that do the
get_sync() operation and proceed to submit the descriptors,
lest we always run the risk of being in irq context.

Perfectly doable, but can be done at some other time.

So: Acked-by.

Yours,
Linus Walleij
