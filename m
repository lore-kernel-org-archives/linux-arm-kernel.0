From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 01 Feb 2011 12:59:11 -0800
Subject: Locking in the clk API, part 2: clk_prepare/clk_unprepare
In-Reply-To: <20110201152458.GP31216@n2100.arm.linux.org.uk>
References: <201102011711.31258.jeremy.kerr@canonical.com>	<20110201105449.GY1147@pengutronix.de>	<20110201131512.GH31216@n2100.arm.linux.org.uk>	<20110201141837.GA1147@pengutronix.de>	<20110201143932.GK31216@n2100.arm.linux.org.uk>	<20110201151846.GD1147@pengutronix.de>
	<20110201152458.GP31216@n2100.arm.linux.org.uk>
Message-ID: <4D48741F.8060006@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01/2011 07:24 AM, Russell King - ARM Linux wrote:
>
> I'd also be tempted at this stage to build-in a no-op dummy clock,
> that being the NULL clk:
>
> int clk_prepare(struct clk *clk)
> {
> 	int ret = 0;
>
> 	if (clk) {
> 		mutex_lock(&clk->mutex);
> 		if (clk->prepared == 0)
> 			ret = clk->ops->prepare(clk);
> 		if (ret == 0)
> 			clk->prepared++;
> 		mutex_unlock(&clk->mutex);
> 	}
>
> 	return ret;
> }

I'm afraid this will hide enable/disable imbalances on some targets and
then expose them on others. Maybe its not a big problem though since
this also elegantly handles the root(s) of the tree.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
