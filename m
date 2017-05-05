From: tj@kernel.org (Tejun Heo)
Date: Fri, 5 May 2017 17:49:32 -0400
Subject: [PATCH] pinctrl: use non-devm kmalloc versions for free functions
In-Reply-To: <20170505195518.xbn5n7uzo2xherah@lukather>
References: <1493855857-4453-1-git-send-email-andre.przywara@arm.com>
 <20170504120314.lfmcv4cpsuz2igte@lukather>
 <20170504160032.GA5147@htj.duckdns.org>
 <20170505195518.xbn5n7uzo2xherah@lukather>
Message-ID: <20170505214932.GA29891@wtj.duckdns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, Maxime.

On Fri, May 05, 2017 at 09:55:18PM +0200, Maxime Ripard wrote:
> > It doesn't make any sense to use the managed functions from the
> > release functions and if you're always matching devm_kmalloc() with
> > devm_kfree(), the only thing it'd do is confusing its readers.
> 
> I wouldn't say that being able to recover and free whatever memory
> leak we might have not making sense, but ok. That was one of the
> options, let's discard it.
>
> The other one is: refactor the rest of the allocations so that you
> don't have a mix of devm_kmalloc / devm_kfree and kmalloc / kfree for
> the same purpose in the same function.

So, I think the issues here are

1. Use of devm functions in a devres release function.  This just
   doesn't make sense.

2. If a resource is always allocated and freed in the same function,
   there's no reason to use devres for it.  I understand that there
   can be exceptions for this, e.g. consistency, but it doesn't seem
   to apply here.

3. Last but not least, allocating memory to destroy a radix tree.  It
   should be able to do that without allocating any memory.

Thanks.

-- 
tejun
