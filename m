From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 11:20:39 +0100
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <20110419175318.GB15233@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
	<4DADC45C.1020202@codeaurora.org>
	<20110419175318.GB15233@pengutronix.de>
Message-ID: <20110429102039.GD5126@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 19, 2011 at 07:53:18PM +0200, Sascha Hauer wrote:
> That's the current behaviour (except that ERR_PTR(-ENOSYS) is returned
> instead of NULL).

I think you're getting confused about clk being NULL.  Let's take a
step backwards shall we?

A NULL clk has no pointers to anything useful.  It gets treated by the
clk_* functions as a no-op.  So, if clk_get_parent() returns NULL, then
internally within the clk code, we know that it's going to be reated as
a no-op clock.  If it's a no-op clock then there is no parent.

The next point is - should clk_get_parent() return NULL?  It can do
as that's a valid return from clk_get() which is not an error case.
Any driver asking for the parent clock should treat it no different
from a non-NULL value:

/**
 * clk_get_parent - get the parent clock source for this clock
 * @clk: clock source
 *
 * Returns struct clk corresponding to parent clock source, or
 * valid IS_ERR() condition containing errno.
 */
struct clk *clk_get_parent(struct clk *clk);

However, internally within the clk API we can make the assumption that
a NULL return value means "no clk" because the clk internals is on the
clock implementation side of the API dividing line and can deal with
this knowledge.
