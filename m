From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 22 Sep 2010 21:59:13 -0700
Subject: [PATCH 11/12] DMAENGINE: let PL08X memcpy TXDs wait
In-Reply-To: <1283256734-3408-12-git-send-email-linus.walleij@stericsson.com>
References: <1283256734-3408-1-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-2-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-3-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-4-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-5-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-6-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-7-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-8-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-9-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-10-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-11-git-send-email-linus.walleij@stericsson.com>
	<1283256734-3408-12-git-send-email-linus.walleij@stericsson.com>
Message-ID: <AANLkTimGu1R0vqpLK9X30CxkibO6N964D1Y-fQvAdA9D@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 31, 2010 at 5:12 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> This change makes the memcpy transfers wait for a physical channel
> to become available if no free channel is available when the job
> is submitted. When the first physical channel fires its tasklet,
> it will spin over the memcpy channels to see if one of these is
> waiting.
>
> This is necessary to get the memcpy semantics right: the generic
> memcpy API assume transfers never fail, and with our oversubscribed
> physical channels this becomes a problem: sometimes submit would
> fail. This fixes it by letting the memcpy channels pull a free
> channel ASAP.
>
> The slave channels shall however *fail* if no channel is available
> since the device will then either fall back to some PIO mode or
> retry.
>

This patch does not sit right with me.  It seems a bit arbitrary that
memcpy operations will be queued while slave operations are failed.
Is there anyway to know at prep time whether a subsequent submit will
fail?  Are there any cases where a slave might want its operation
queued?

The prep routine is meant to guarantee that all the resources for a
transaction have been acquired.  The only reason ->tx_submit() has a
return value is to support the net_dma usage model that uses opaque
cookies for tracking transactions.

If we make tx_submit() fallable we should go back and ensure that all
usages are prepared to handle failure.

--
Dan

sidenote: this driver needs to be converted to a dma descriptor pool
(allocated at device_alloc_chan_resources time), or at a minimum use
GFP_NOWAIT in device_prep_dma_memcpy because that routine may be
called from atomic contexts.
