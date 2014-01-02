From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 2 Jan 2014 12:49:24 -0700
Subject: [PATCH] ARM: Kirkwood: Add support for Excito Bubba B3
In-Reply-To: <20131228170114.GH19878@titan.lakedaemon.net>
References: <1388247131-19301-1-git-send-email-andrew@lunn.ch>
 <20131228170114.GH19878@titan.lakedaemon.net>
Message-ID: <20140102194924.GA3321@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 28, 2013 at 12:01:14PM -0500, Jason Cooper wrote:

> > + * Note: This requires a new'ish version of u-boot, which disables the
> > + * L2 cache. If your B3 silently fails to boot, u-boot is probably too
> > + * old. Either upgrade, or consider the following email:
> > + *
> > + * http://lists.debian.org/debian-arm/2012/08/msg00128.html
> 
> Nice, thanks for adding this.

Nifty.. But what is the root cause for the above?

I'm guessing that at some point the the L1 icache has been enabled,
the L1 dcache disabled, and the L2 cache enabled?

If the pv_fixup runs with both L1 caches off and an empty L2 then it
shouldn't cause a problem.

If it runs with the icache on lines will be pulled into the L2 by
icache fetching and won't be updated by uncached L1 dcache writes.

Is uboot running the kernel with the icache turned on but dcache
turned off?

>From a kernel side, a possible way to address this might be to move
the pv fixup (__fixup_a_pv_table?) after the mmu and caches are
switched on.

But really, any memory writes done prior to enabling the dcache would
risk getting lost...

Jason
