From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 5 Sep 2013 11:34:40 +0200
Subject: [PATCH RFC v2 01/16] ARM: call clk_of_init from time_init
In-Reply-To: <cfedb014-695a-49cd-8e41-afabd585496a@DB8EHSMHS006.ehs.local>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <52279D79.9070408@gmail.com>
 <cfedb014-695a-49cd-8e41-afabd585496a@DB8EHSMHS006.ehs.local>
Message-ID: <201309051134.40421.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 September 2013, S?ren Brinkmann wrote:
> On Wed, Sep 04, 2013 at 10:52:09PM +0200, Sebastian Hesselbarth wrote:
> > On 09/04/2013 10:41 PM, S?ren Brinkmann wrote:
> > Anyways, having a custom .init_time gives you full control over
> > of_clk_init and clocksource_of_init back again thanks to your
> > suggestion.
> > 
> > I'll stop converting zynq and let you decide on your own ;)
> 
> As I said, currently it's rather messy and neither solution is perfect.
> Steffen seemed to already have looked towards syscon and regmap, which
> are probably the right ways of making the SLCR regs available to other users.

Yes, this seems fine. I suspect we will first have to find a way to have
"early" syscon mappings, which seem to be required for a few other use
cases as well, but are not trivial to implement in a nice way.

> Sure, passing down the pointer is not perfect, but having two drivers
> map the same memory region seems slightly worse to me. And it would even
> fail for one driver if you properly used request_mem_region() and friends.

I think the two approaches are equally hacky, no need to change it now
or rush to a better solution -- let's fix the other of_clk_init() users
first.

One suggestion though: it might be better to not use CLK_OF_DECLARE
with of_clk_init(NULL) in cases like this but have an explicit table
in the clk driver that does not get intermixed with the default table.

	Arnd
