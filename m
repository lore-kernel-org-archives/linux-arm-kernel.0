From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Dec 2012 09:26:36 +0000
Subject: Inconsistency in clk framework
In-Reply-To: <1355890233.25599.4.camel@gitbox>
References: <1355890233.25599.4.camel@gitbox>
Message-ID: <20121219092636.GW14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 19, 2012 at 05:10:33PM +1300, Tony Prisk wrote:
> Hi Mike,
> 
> In attempting to remove some IS_ERR_OR_NULL references, it was pointed
> out that clk_get() can return NULL if CONFIG_HAVE_CLK is not defined.

That is correct - but why is that a problem?  As far as users are
concerned, NULL is a valid clock.  If HAVE_CLK is undefined, do you
want all your drivers to suddenly stop working?

> This seems to contradict the kernel docs associated with the normal
> clk_get (when HAVE_CLK is defined) which states:
> 
> * Returns a struct clk corresponding to the clock producer, or
> * valid IS_ERR() condition containing errno.
> 
> Wouldn't a return code of ERR_PTR(-ENOENT) make more sense and be inline
> with the empty of_ versions as well (which return -ENOENT when CONFIG_OF
> is undefined).

No.

> Also, I noticed that clk_get_sys() doesn't appear to be defined in clk.h
> when HAVE_CLK is undefined - is this correct?

It was never promoted to an official API because its only platform code
which should be using it; no device driver (which should have a struct
device to pass into clk_get()) should ever use clk_get_sys().
