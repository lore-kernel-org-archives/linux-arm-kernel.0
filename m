From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 6 Aug 2013 21:02:19 +0100
Subject: [PATCH 1/3] clk: exynos4: Make exynos4_plls static
In-Reply-To: <1375788675-2638-1-git-send-email-sachin.kamat@linaro.org>
References: <1375788675-2638-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <20130806200219.GD23006@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Also note:

On Tue, Aug 06, 2013 at 05:01:13PM +0530, Sachin Kamat wrote:
> @@ -984,7 +984,7 @@ static __initdata struct of_device_id ext_clk_match[] = {

For the declaration above...

> -struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {
> +static struct __initdata samsung_pll_clock exynos4_plls[nr_plls] = {

And this one... __initdata should come just before the '=', not at the
start, not in the middle and not before the variable.

The reasoning is that with how you have it above, the attributes are
applied to the structure.  You want to apply the attributes to the
declaration instead, so it should come after the variable name.

So, for example:

	struct foo *foo __attribute__((section(".foo"))) = (void *)1;

will place the "foo" variable into a section called ".foo", but:

	struct __attribute__((section(".foo"))) foo *foo = (void *)1;

will place "foo" into the normal .data section.

So, the rule with variable declarations is that the __ specifiers we
have as macros in the kernel always come after the variable name being
declared and nowhere else.  We consider anywhere else buggy.
