From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 25 Aug 2013 19:06:15 +0100
Subject: [PATCH v4 3/4] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <20130825164842.GF2748@intel.com>
References: <1376672707-24527-1-git-send-email-zonque@gmail.com>
 <1376672707-24527-4-git-send-email-zonque@gmail.com>
 <5214A601.1010607@marvell.com>
 <CAHp75VfFFq0kaf7wDt3WTwsx6peBmt=rDXaUGXz=cnn4-bBKZw@mail.gmail.com>
 <5214AC80.2090102@gmail.com> <20130825161104.GC2748@intel.com>
 <20130825170151.GW6617@n2100.arm.linux.org.uk>
 <20130825164842.GF2748@intel.com>
Message-ID: <20130825180615.GX6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 25, 2013 at 10:18:42PM +0530, Vinod Koul wrote:
> On Sun, Aug 25, 2013 at 06:01:51PM +0100, Russell King - ARM Linux wrote:
> > The descriptor is not assigned a cookie in the preparation function - it
> > is only assigned a cookie when it is submitted, which should always happen
> > shortly after preparation.  The submission call returns the assigned
> > cookie, so there's no reason for any driver to dereference the descriptor.
> > 
> > Any driver which does dereference the descriptor after submission is
> > potentially a bug; the DMA engine owns it, and can kfree that descriptor
> > any moment after submission, or even re-use it for another descriptor.
>
> I would say after callback is invoked in case when one is set. For the
> ones when no callback is set, yes after invoking tx_submit() is right one.

Even when there is a callback set, there's no requirement for the DMA
engine driver to keep the descriptor around after it has been submitted -
it is free to copy that data into whatever internal representation it
requires and then discard the descriptor if it so wishes.

> Clients should remeber the cookie value returned and use it to track
> the status of transactions.

Yes - and the correct way is:

	desc = dma_prepare_....()

	desc->callback = my_callback;
	desc->callback_param = my_callback_data;

	cookie = dmaengine_submit(desc);
	/* forget that desc exists */
