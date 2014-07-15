From: cl@gentwo.org (Christoph Lameter)
Date: Tue, 15 Jul 2014 09:26:08 -0500 (CDT)
Subject: [RFC/PATCH RESEND -next 14/21] mm: slub: kasan: disable kasan
 when touching unaccessible memory
In-Reply-To: <20140715081852.GL11317@js1304-P5Q-DELUXE>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
 <1404905415-9046-15-git-send-email-a.ryabinin@samsung.com>
 <20140715060405.GI11317@js1304-P5Q-DELUXE> <53C4DA54.3010502@samsung.com>
 <20140715081852.GL11317@js1304-P5Q-DELUXE>
Message-ID: <alpine.DEB.2.11.1407150924320.10593@gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Jul 2014, Joonsoo Kim wrote:

> > I think putting disable/enable only where we strictly need them might be a problem for future maintenance of slub.
> > If someone is going to add a new function call somewhere, he must ensure that it this call won't be a problem
> > for kasan.
>
> I don't agree with this.
>
> If someone is going to add a slab_pad_check() in other places in
> slub.c, we should disable/enable kasan there, too. This looks same
> maintenance problem to me. Putting disable/enable only where we
> strictly need at least ensures that we don't need to care when using
> slub internal functions.
>
> And, if memchr_inv() is problem, I think that you also need to add hook
> into validate_slab_cache().
>
> validate_slab_cache() -> validate_slab_slab() -> validate_slab() ->
> check_object() -> check_bytes_and_report() -> memchr_inv()

I think adding disable/enable is good because it separates the payload
access from metadata accesses. This may be useful for future checkers.
Maybe call it something different so that this is more generic.

metadata_access_enable()

metadata_access_disable()

?

Maybe someone else has a better idea?
