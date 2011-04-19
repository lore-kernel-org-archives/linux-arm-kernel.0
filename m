From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 19 Apr 2011 10:20:28 -0700
Subject: [PATCH 04/10] clk: implement parent pass through functions
In-Reply-To: <1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
References: <1302894495-6879-1-git-send-email-s.hauer@pengutronix.de>
	<1302894495-6879-5-git-send-email-s.hauer@pengutronix.de>
Message-ID: <4DADC45C.1020202@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/15/2011 12:08 PM, Sascha Hauer wrote:
> A common case for clocks is that certain operations are not implemented
> and shall be passed through to the parent. Add convenience functions
> for this purpose
>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Jeremy Kerr <jeremy.kerr@canonical.com>
>

I was hoping we could just build the parent handling into the core
instead of having every clk_ops->enable call the parent ops.

Something like: if the clk_ops doesn't have a get_parent,
clk_get_parent() would return NULL, and if the clk_ops doesn't have a
set_parent, clk_set_parent() would do nothing.

Then clk_enable()/clk_disable() would call clk_get_parent() and then
clk_enable() on that (whatever it is) before calling down into the
ops->enable() function. Of course this means NULL is now the "no parent"
value as opposed to ERR_PTR(-ENOSYS) but I'm willing to live with that
since it makes things a bit simpler when you only have to check for NULL
in the clk_enable()/clk_disable() path as opposed to NULL and IS_ERR.

I'm afraid this patch means every time the clk_ops wants to enable its
parent (which is almost always the case), it has to do so explicitly
when we really just want to concentrate on what enabling means for that
clock (namely setting some bits in some registers). Thoughts?

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
