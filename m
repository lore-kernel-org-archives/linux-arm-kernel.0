From: jbrunet@baylibre.com (Jerome Brunet)
Date: Thu, 15 Feb 2018 13:19:59 +0100
Subject: [PATCH v2] clk: Properly update prepare/enable count on orphan
 clock reparent
In-Reply-To: <20180127004917.GI28313@codeaurora.org>
References: <CGME20180126091902eucas1p2b3ad9978e3ab09bd7a2bd9123c9eecaa@eucas1p2.samsung.com>
 <20180126091845.11902-1-m.szyprowski@samsung.com>
 <20180127004917.GI28313@codeaurora.org>
Message-ID: <1518697199.2883.91.camel@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2018-01-26 at 16:49 -0800, Stephen Boyd wrote:
> On 01/26, Marek Szyprowski wrote:
> > If orphaned clock has been already prepared/enabled (for example if it or
> > one of its children has CLK_IS_CRITICAL flag), then the prepare/enable
> > counters of the newly assigned parent are not updated correctly. This
> > might later cause warnings during changing clock parents.
> 
> This doesn't feel right. Perhaps we should delay enabling a clk
> if it's CRITICAL until we adopt an orphaned clk.

It does not sounds right. A critical clock should be enabled as soon as
possible, regardless of current knowledge of the clock tree.

How would you decide when is right time anyway ?
The orphaned critical clock could be reparented to clock that is orphan itself,
you would get into the same count issue again.

> Good news is we
> have orphan status tracking now so this should be pretty simple.
> Otherwise migrating the count up is complicated and requires us
> to call the prepare/enable ops on a critical clk and then keep
> doing that each time it gets re-parented.

What is the problem with this ? We are going to have call those enable ops
anyway. Whether it is done one at a time or all at once, does it really matter ?

> Do you have this case,
> where some clk is marked as CRITICAL, and then we need to migrate
> that enable/prepare count to the parent?

yes.

> 
> Hopefully it isn't the worser case, where the clk is handed out
> to some consumer but it's still orphaned at that point, and then
> we have little control over the migration of state to the parent.
> 

This should not be a problem if the clock reparenting  and count migration is
done properly. To do  this, the __clk_set_parent_before() and
__clk_set_parent_after() function look good to me,  have I missed anything ? 
