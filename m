From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 12 Dec 2011 13:45:48 +0530
Subject: [PATCH 7/8] OMAP4: clock: Add CPU local timer clock node.
In-Reply-To: <CAJOA=zP0zs=eKsQXQPt5dj8EHQFnZ50Jnm_Ho425yH-NZkgY5A@mail.gmail.com>
References: <1315459327-3285-1-git-send-email-santosh.shilimkar@ti.com>
 <1315459327-3285-8-git-send-email-santosh.shilimkar@ti.com>
 <CAKnu2Mp4QnQPwcGJCrfMqS6VcfvvvAxginjJkLG1mPLO0WJBUw@mail.gmail.com>
 <CAMQu2gyBq61jcP1sLDEs8+zGfdAa6Pur1fSec9Wfzs48CX5zjA@mail.gmail.com>
 <CAJOA=zP0zs=eKsQXQPt5dj8EHQFnZ50Jnm_Ho425yH-NZkgY5A@mail.gmail.com>
Message-ID: <CAMQu2gxvYNjL2rrzs=H+ougB16po6GL-31hNd_wV42kNDBYBvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 9, 2011 at 4:32 AM, Turquette, Mike <mturquette@ti.com> wrote:
> On Fri, Sep 30, 2011 at 2:15 AM, Shilimkar, Santosh
> <santosh.shilimkar@ti.com> wrote:
>> On Fri, Sep 30, 2011 at 3:00 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
>>> 2011/9/8 Santosh Shilimkar <santosh.shilimkar@ti.com>:
>>>
>>>> Local timer clock is sourced from the CPU clock and hence changes
>>>> along with CPU clock. These per CPU local timers are used as
>>>> clock-events, so they need to be reconfigured on CPU frequency
>>>> change as part of CPUfreq governor.
>>>
>>> This requires patch 6956/2 right?
>>> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=6956/2
>>>
>>> Can I add your Tested-by: to the patch as well?
>>>
>> Sure.
>
> Santosh,
>
> I've taken in Linus' patch as well as this patch while testing clk
> notifiers (part of common clk framework code).
>
> Linus' patch matches the clk based on dev_id, but the clkdev entry in
> your patch populated dev_id with NULL and con_id with "smp_twd" so
> things never worked correctly. ?Below changed fixed it for me:
>
You are right.
When I picked up the patch while changing the
OMAP44XX stuff to OMAP4430, looks like I miss-placed it.

> diff --git a/arch/arm/mach-omap2/clock44xx_data.c
> b/arch/arm/mach-omap2/clock44xx_data.c
> index ae8c292..0f8cf68 100644
> --- a/arch/arm/mach-omap2/clock44xx_data.c
> +++ b/arch/arm/mach-omap2/clock44xx_data.c
> @@ -4114,7 +4114,7 @@ static struct omap_clk omap44xx_clks[] = {
> ? ? ? ?CLK(NULL, ? ? ? "l4_div_ck",
> &l4_div_ck_hw.clk, ? ? ?CK_443X),
> ? ? ? ?CLK(NULL, ? ? ? "lp_clk_div_ck",
> &lp_clk_div_ck_hw.clk, ?CK_443X),
> ? ? ? ?CLK(NULL, ? ? ? "l4_wkup_clk_mux_ck",
> &l4_wkup_clk_mux_ck_hw.clk, ? ? CK_443X),
> - ? ? ? CLK(NULL, ? ? ? "smp_twd",
> &mpu_periphclk_hw.clk, ?CK_443X),
> + ? ? ? CLK("smp_twd", ?NULL, ? ? ? ? ? ? ? ? ? &mpu_periphclk_hw.clk,
> ?CK_443X),
> ? ? ? ?CLK(NULL, ? ? ? "ocp_abe_iclk",
> &ocp_abe_iclk_hw.clk, ? CK_443X),
> ? ? ? ?CLK(NULL, ? ? ? "per_abe_24m_fclk",
> &per_abe_24m_fclk_hw.clk, ? ? ? CK_443X),
> ? ? ? ?CLK(NULL, ? ? ? "per_abe_nc_fclk",
> &per_abe_nc_fclk_hw.clk, ? ? ? ?CK_443X),
>
> A better change might be for the code in smp_twd.c to match on con_id
> but I'll let you guys sort that out.

I guess we can stick to what Linus and others have followed.
Will post an updated patch. Thanks for catch.

Regards
Santosh
