From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Mar 2013 10:06:01 -0700
Subject: [PATCH 2/2] ARM: OMAP2+: clocks: Pass static parent pointers
 to common clock core
In-Reply-To: <1363264618-5071-3-git-send-email-rnayak@ti.com>
References: <1363264618-5071-1-git-send-email-rnayak@ti.com>
 <1363264618-5071-3-git-send-email-rnayak@ti.com>
Message-ID: <20130314170601.GH26093@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rajendra Nayak <rnayak@ti.com> [130314 05:44]:
> OMAP clock inits happen quite early, even before the slab is available.
> As part of the clock init, the common clock core tries to cache parent
> pointers (if not passed by the caller registering the clock) which
> fails in case of OMAP since the slab isn't initied.
> Without CONFIG_DEBUG_SLAB enabled, this just results in the common clock core
> retrying the caching attempt at some point later.
> However with CONFIG_DEBUG_SLAB enabled this results in a BUG() as reported
> in the link below by Tony..
> http://www.mail-archive.com/linux-omap at vger.kernel.org/msg85932.html
> 
> Fix this by passing static parent pointers to the common clock core
> while registering clocks.

I wonder if we could easily fix this by initializing only some of the
clocks that early?

If we had a two stage initialization we could dynamically allocate the
rest of the parent clocks without having to add all the static data.

Regards,

Tony
