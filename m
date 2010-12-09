From: shawn.gsc@gmail.com (Shawn Guo)
Date: Thu, 9 Dec 2010 16:51:08 +0800
Subject: [PATCH v3 03/15] ARM: mxs: Add reset routines
In-Reply-To: <20101208203148.GE17441@pengutronix.de>
References: <1290754154-9428-1-git-send-email-shawn.guo@freescale.com>
	<1291739523-25077-2-git-send-email-shawn.guo@freescale.com>
	<19711.13516.842225.349704@ipc1.ka-ro>
	<20101208203148.GE17441@pengutronix.de>
Message-ID: <AANLkTikQh4oGOo+mx8MZyBxuPfMJQA2mMQKjY-yCGQ4M@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/12/9 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hi Lothar,
>
> On Wed, Dec 08, 2010 at 08:33:32AM +0100, Lothar Wa?mann wrote:
>> Hi,
>>
>> Shawn Guo writes:
>> > ?- The mxs wdog is implemented in RTC block.
>> > ?- There is a generic software reset routine for most modules on mxs.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@freescale.com>
>> > ---
>> > Changes for v3:
>> > ?- Change wdog timeout to 10ms for safety
>> > ?- Simplify function mxs_reset_block() to get it look better
>> >
>> > Changes for v2:
>> > ?- Move rtc clock enabling from arch_reset() into mxs_arch_reset_init()
>> >
>> mxs_arch_reset_init() is currently being called from the .map_io hook
>> in mach-mxs/mm-mx23.c and mm-mx28.c which is called before clocks are
>> registered.
>> But IMO this should be removed from the .map_io hook anyway (as well
>> as mxs_iomux_init()).
> I assume you want to make this an initcall?
>
Here is how they look.

static int __init mxs_arch_reset_init(void)
{
        struct clk *clk;

        wdog_base = cpu_is_mx23() ? MX23_IO_ADDRESS(MX23_RTC_BASE_ADDR) :
                                    MX28_IO_ADDRESS(MX28_RTC_BASE_ADDR);

        clk = clk_get_sys("rtc", NULL);
        if (!IS_ERR(clk))
                clk_enable(clk);
        else

        return 0;
}
core_initcall(mxs_arch_reset_init);

static int __init mxs_iomux_init(void)
{
        iomux_base = MXS_IO_ADDRESS(MXS_PINCTRL_BASE_ADDR);

        return 0;
}
core_initcall(mxs_iomux_init);

-- 
Regards,
Shawn
