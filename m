From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 6 Dec 2016 17:25:12 +0000
Subject: [PATCHv4 08/10] mm/kasan: Switch to using __pa_symbol and lm_alias
In-Reply-To: <2f3ac043-c4cc-5c5a-8ac7-1396b6bb193f@virtuozzo.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-9-git-send-email-labbott@redhat.com>
 <2f3ac043-c4cc-5c5a-8ac7-1396b6bb193f@virtuozzo.com>
Message-ID: <20161206172512.GF24177@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 01, 2016 at 02:36:05PM +0300, Andrey Ryabinin wrote:
> On 11/29/2016 09:55 PM, Laura Abbott wrote:
> > __pa_symbol is the correct API to find the physical address of symbols.
> > Switch to it to allow for debugging APIs to work correctly.
> 
> But __pa() is correct for symbols. I see how __pa_symbol() might be a little
> faster than __pa(), but there is nothing wrong in using __pa() on symbols.

While it's true today that __pa() works on symbols, this is for
pragmatic reasons (allowing existing code to work until it is all
cleaned up), and __pa_symbol() is the correct API to use.

Relying on this means that __pa() can't be optimised for the (vastly
common) case of translating linear map addresses.

Consistent use of __pa_symbol() will allow for subsequent optimisation
of __pa() in the common case, in adition to being necessary for arm64's
DEBUG_VIRTUAL.

> > Other functions such as p*d_populate may call __pa internally.
> > Ensure that the address passed is in the linear region by calling
> > lm_alias.
> 
> Why it should be linear mapping address? __pa() translates kernel
> image address just fine.

As above, while that's true today, but is something that we wish to
change. 

> Generated code is probably worse too.

Even if that is the case, given this is code run once at boot on a debug
build, I think it's outweighed by the gain from DEBUG_VIRTUAL, and as a
step towards optimising __pa().

Thanks,
Mark.
