From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 11 Apr 2014 12:24:49 -0700
Subject: [RFC PATCH] uprobes: copy to user-space xol page with proper
 cache flushing
In-Reply-To: <20140411.145842.716571171033099617.davem@davemloft.net>
References: <CA+55aFwPR1XLRKiYya5wwxwbdnA_qiB4fZPL0i7+L4mpmzk5qA@mail.gmail.com>
 <20140411.141911.2103972187575537634.davem@davemloft.net>
 <CA+55aFwDKOs2XXVCsCi_tCSVTHt93uqzv-0qGEzRW6rCk0h9rw@mail.gmail.com>
 <20140411.145842.716571171033099617.davem@davemloft.net>
Message-ID: <CA+55aFxKGwMNGfXVeN78q54k1mmbm_0igaGAj2t35YWhsFfUsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 11:58 AM, David Miller <davem@davemloft.net> wrote:
>
> Since we do most of the cache flushing stuff during normal operations
> at the PTE modification point, perhaps a piece of page state could be
> used to handle this.  We already use such a thing for D-cache alias
> flushing.

So looking at the powerpc code, I thought ppc already did this, but it
seems to do something different: it lazily does the icache flush at
page fault time if the page has been marked by dcache flush (with the
PG_arch_1 bit indicating whether the page is coherent in the I$).

But I don't see it trying to actually flush the icache of already
mapped processes when modifying the dcache.

So while we *could* do that, apparently no architecture does this.
Even the one architecture that I thought did it doesn'r really try to
make things globally coherent.

(My "analysis" was mainly using "git grep", so maybe I missed something).

           Linus
