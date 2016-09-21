From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 21 Sep 2016 21:06:01 +0100
Subject: [PATCH] arm64: Correctly bounds check virt_addr_valid
In-Reply-To: <b8f34fc7-76ac-5681-085a-8c007cd40e98@redhat.com>
References: <1474478928-25022-1-git-send-email-labbott@redhat.com>
 <20160921175855.GG18176@leverpostej>
 <b8f34fc7-76ac-5681-085a-8c007cd40e98@redhat.com>
Message-ID: <20160921200601.GA24734@remoulade>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2016 at 12:34:46PM -0700, Laura Abbott wrote:
> On 09/21/2016 10:58 AM, Mark Rutland wrote:
> >Are there other potentially-broken users of virt_addr_valid? It's not
> >clear to me what some drivers are doing with this, and therefore whether
> >we need to cc stable.
> 
> The number of users is pretty limited. Some of them use it as a debugging
> check, others are using it more like hardened usercopy. The number of
> users that would actually affect arm64 seems so small I don't think it's
> worth trying to backport to stable.

Ok.

> Hardened usercopy was getting hit particularly hard because usercopy was
> happening on all types of memory whereas the drivers tend to be more limited
> in scope.

Sure.

> >Given the common sub-expression, perhaps it would be better to leave
> >these as-is, but prefix them with '_', and after the #endif, have
> >something like:
> >
> >#define _virt_addr_is_linear(kaddr)	(((u64)(kaddr)) >= PAGE_OFFSET)
> >#define virt_addr_valid(kaddr)		(_virt_addr_is_linear(kaddr) && _virt_addr_valid(kaddr))
> >
> 
> Good suggestion.

FWIW, with that, feel free to add:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.
