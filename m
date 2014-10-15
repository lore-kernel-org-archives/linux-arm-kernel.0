From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Wed, 15 Oct 2014 15:45:27 -0700
Subject: Regarding tx-nocache-copy in the Sheevaplug
In-Reply-To: <20141015215701.GA4109@f1.synalogic.ca>
References: <20141013105246.GD1972@vicerveza.homeunix.net>
 <20141015215701.GA4109@f1.synalogic.ca>
Message-ID: <1413413127.17186.5.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-10-15 at 14:57 -0700, Benjamin Poirier wrote:
> On 2014/10/13 12:52, Llu?s Batlle i Rossell wrote:
> > Hello,
> > 
> > on the 7th of January 2014 ths patch was applied:
> > https://lkml.org/lkml/2014/1/7/307
> > 
> > [PATCH v2] net: Do not enable tx-nocache-copy by default
> >         
> > In the Sheevaplug (ARM Feroceon 88FR131 from Marvell) this made packets to be
> > sent corrupted. I think this machine has something special about the cache.
> > 
> > Enabling back this tx-nocache-copy (as it used to be before the patch) the
> > transfers work fine again. I think that most people, encountering this problem,
> > completely disable the tx offload instead of enabling back this setting.
> > 
> > Is this an ARM kernel problem regarding this platform?
> 
> This is odd, only x86 defines ARCH_HAS_NOCACHE_UACCESS. On arm,
> skb_do_copy_data_nocache() should end up using __copy_from_user()
> regardless of tx-nocache-copy.

 kmap_atomic()/kunmap_atomic() is missing, so we lack
__cpuc_flush_dcache_area() operations.
