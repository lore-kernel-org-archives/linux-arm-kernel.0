From: koro.chen@mediatek.com (Koro Chen)
Date: Thu, 3 Dec 2015 19:39:34 +0800
Subject: [alsa-devel] [PATCH] ASoC: mediatek: Use current HW pointer for
 pointer callback
In-Reply-To: <s5hfuzjn635.wl-tiwai@suse.de>
References: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
 <s5h8u5b98dp.wl-tiwai@suse.de> <20151203110158.GD5727@sirena.org.uk>
 <s5hfuzjn635.wl-tiwai@suse.de>
Message-ID: <1449142774.17544.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-12-03 at 12:07 +0100, Takashi Iwai wrote:
> On Thu, 03 Dec 2015 12:01:58 +0100,
> Mark Brown wrote:
> > 
> > On Thu, Dec 03, 2015 at 10:41:38AM +0100, Takashi Iwai wrote:
> > 
> > > While reading this patch, I wondered how regmap can be used safely in
> > > an irq-disabled context.  Mark, do we have any API for that?
> > 
> > We can use user supplied locks or spin_lock_irqsave().
> 
> I meant how to guarantee to make regmap_read() working in an already
> spin-locked context, typically in an irq handler?  regmap_read()
> involves with the regcache and it may invoke kmalloc().
> 
Yes, we were hit by this before. When using devm_regmap_init_mmio() for
regmap, it uses spin_lock_irqsave() before every read/write, and if
cache type is RBTREE, then kmalloc will occur after spin_lock_irqsave()
and it brings warning. That's why we changed RBTREE to NONE. Setting
cache type to FLAT will also work, but we think our register accessing
is fast enough without need of cache.

 

> 
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
