From: broonie@kernel.org (Mark Brown)
Date: Thu, 3 Dec 2015 14:56:12 +0000
Subject: [alsa-devel] [PATCH] ASoC: mediatek: Use current HW pointer for
 pointer callback
In-Reply-To: <s5hfuzjn635.wl-tiwai@suse.de>
References: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
 <s5h8u5b98dp.wl-tiwai@suse.de>
 <20151203110158.GD5727@sirena.org.uk>
 <s5hfuzjn635.wl-tiwai@suse.de>
Message-ID: <20151203145612.GF5727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 12:07:26PM +0100, Takashi Iwai wrote:
> Mark Brown wrote:
> > On Thu, Dec 03, 2015 at 10:41:38AM +0100, Takashi Iwai wrote:

> > > While reading this patch, I wondered how regmap can be used safely in
> > > an irq-disabled context.  Mark, do we have any API for that?

> > We can use user supplied locks or spin_lock_irqsave().

> I meant how to guarantee to make regmap_read() working in an already
> spin-locked context, typically in an irq handler?  regmap_read()
> involves with the regcache and it may invoke kmalloc().

I know that's what you meant - that should be done by preallocating the
cache (which can be done with defaults) and providing your own lock
if there's a spinlock already held (since we use _irqsave() which IIRC
isn't nestable).  We can also use GFP_ATOMIC for some of the allocations
in reasonable use cases but it's not in general supported.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151203/84bd11d3/attachment-0001.sig>
