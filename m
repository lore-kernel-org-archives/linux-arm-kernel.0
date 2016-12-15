From: broonie@kernel.org (Mark Brown)
Date: Thu, 15 Dec 2016 11:17:27 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <7900ae24-6803-a271-944c-8830f718fef0@free.fr>
References: <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
 <20161208163755.GH6408@localhost>
 <yw1xy3zqxt7x.fsf@unicorn.mansr.com>
 <20161209065955.GJ6408@localhost>
 <6ce1ea97-1d68-2203-c7b4-73315e801655@laposte.net>
 <20161209171727.GK6408@localhost>
 <ec33d3f0-6474-2b13-8a26-077ce3785d31@free.fr>
 <20161209175606.GM6408@localhost>
 <7900ae24-6803-a271-944c-8830f718fef0@free.fr>
Message-ID: <20161215111727.35csnouwegedcmuu@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 09, 2016 at 07:23:17PM +0100, Mason wrote:
> On 09/12/2016 18:56, Vinod Koul wrote:

> > Right, but in that case the fallback would be PIO mode, and if that is
> > not availble (IIRC some f your devices don't) then reject the usage with
> > EAGAIN.

> Maybe I'm missing something, but I don't see how that would help.
> Take the NAND Flash controller driver, for instance. PIO is not
> an option, because the ECC engine is tied to DMA.

> And failing with -EAGAIN doesn't help the busy looping situation.
> The caller should be put on some kind of queue to wait for a
> "channel ready" event.

Even without the tie into ECC being an issue it seems like falling back
to PIO could produce poor results at the system level - it's likely that
the PIO would be very expensive and take longer than waiting would've
done, increasing the burden on the CPU and slowing things down overall
for userspace.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 484 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161215/e41e6df1/attachment.sig>
