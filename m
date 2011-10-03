From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 3 Oct 2011 17:31:08 +0100
Subject: [PATCH v2 1/7] clk: Add a generic clock infrastructure
In-Reply-To: <4E89D3C4.8090001@gmail.com>
References: <1316730422-20027-1-git-send-email-mturquette@ti.com>
	<1316730422-20027-2-git-send-email-mturquette@ti.com>
	<4E89C3FA.9020206@gmail.com>
	<20111003142524.GN3731@opensource.wolfsonmicro.com>
	<4E89D3C4.8090001@gmail.com>
Message-ID: <20111003163107.GQ3731@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2011 at 10:24:52AM -0500, Rob Herring wrote:
> On 10/03/2011 09:25 AM, Mark Brown wrote:

> > This isn't in any way specific to clocks, right now the likely solution
> > looks to be Grant's changes for retrying probe() as new devices come on
> > line.  With that devices can return a code from their probe() which
> > tells the driver core that they couldn't get all the resources they need
> > and that it should retry the probe() if more devices come on-line.

> Except SOC clocks are initialized very early before timers are up and
> there can be a very high number of dependencies (every clock except
> fixed clocks). With the driver probe retry, retrying is the exception,
> not the rule.

> Retrying would require every caller to maintain a list of clks to
> retry. With 2 stages, you can move that into the core clock code.

They don't need to maintain a list of clocks to retry, they need to
unwind when probe() fails.  But yes.

> There are not typically a large number of board-level/driver created
> clocks, so ensuring correct register order is not really a problem. In
> cases where there is a cross-driver dependency, the probe retry is a
> good solution.

I dunno, I get the impression that some of this is due to the current
limitations of the clock API rather than due to a lack of clocks -
perhaps that's specific to the applications I look at, though.
applications 
