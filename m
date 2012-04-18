From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Apr 2012 10:54:35 +0100
Subject: [PATCH 1/2] clk: Provide dummy clk_unregister()
In-Reply-To: <1334736433-3402-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1334736433-3402-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20120418095435.GX24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 09:07:12AM +0100, Mark Brown wrote:
> +/**
> + * clk_unregister - unregister a currently registered clock
> + * @clk: clock to unregister
> + *
> + * Currently unimplemented.
> + */
> +int clk_unregister(struct clk *clk)
> +{
> +	return -EINVAL;

Don't make unregister calls return values.  Think about this situation
for a moment:

	You call an unregister function in a drivers ->remove function.
	The unregister function fails.  However, the reason the ->remove
	function is being called is because the module is being removed.
	You can't stop the module being removed once the process has
	started.  What do you do with this error?

To put it another way, if an unregister function fails, you're buggered.
