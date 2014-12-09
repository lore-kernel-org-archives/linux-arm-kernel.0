From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Dec 2014 09:57:42 +0100
Subject: [PATCH] arm: imx: correct the hardware clock gate setting for
 shared nodes
In-Reply-To: <1418111885-3623-1-git-send-email-b20788@freescale.com>
References: <1418111885-3623-1-git-send-email-b20788@freescale.com>
Message-ID: <20141209085742.GE13486@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Anson,

[Cc += Mike Turquette]

On Tue, Dec 09, 2014 at 03:58:05PM +0800, Anson Huang wrote:
> For those clk gates which hold share count, since its is_enabled
> callback is only checking the share count rather than reading
> the hardware register setting, in the late phase of kernel bootup,
> the clk_disable_unused action will NOT handle the scenario of
> share_count is 0 but the hardware setting is enabled, actually,
> uboot normally enables all clk gates, then those shared clk gates
s/uboot/U-Boot/ IIRC

> will be always enabled until they are used by some modules.
What is the purpose of the shared clocks? Just to have different names
for a single gate?

Wouldn't it be better to fix this problem at the framework level? Then
ideally clk_disable_unused would handle these shared clocks just fine.

I guess the problem is that this shared clk implementation doesn't
fulfill the expectations of the clk framework.

This is found in arch/arm/mach-imx/clk-imx6q.c
>  	clk[IMX6QDL_CLK_ASRC]         = imx_clk_gate2_shared("asrc",         "asrc_podf",   base + 0x68, 6, &share_count_asrc);
>  	clk[IMX6QDL_CLK_ASRC_IPG]     = imx_clk_gate2_shared("asrc_ipg",     "ahb",         base + 0x68, 6, &share_count_asrc);
>  	clk[IMX6QDL_CLK_ASRC_MEM]     = imx_clk_gate2_shared("asrc_mem",     "ahb",         base + 0x68, 6, &share_count_asrc);

For these clks is_enabled returns just enable_count instead of the
status of the corresponding bit in the corresponding register. The
reason for that probably is that "asrc" must not be disabled even if
unused if "asrc_ipg" is in use. So the problem is there are three struct
clk s with a common enable count for a single register bit. Interesting
enough these clocks have different parents (the 2nd parameter to
imx_clk_gate2_shared) which makes the easy solution to just make
asrc_ipg and asrc_mem children of asrc not applicable. Any idea for a
sane solution? A multi-parent-dummy-clk would do I think.

Other than that the following might work: Ignore share_count in the
is_enabled callback (i.e. report if the register bit is set as in the
share_count == NULL case) and implement clk->ops->disable_unused that
only unsets the bit if share_count == 0? Ugly but IMHO better and more
robust than the idea implemented in this patch. Still I'd prefer to make
the usual assumptions of the clk framework just work.

> So the problem would be: when kernel boot up, the usecount cat
> from clk tree is 0, but the clk gates actually is enabled in
> hardware register, it will confuse user and bring unnecessary power
> consumption, take i.MX6SX for example, the ESAI clk info
> is as below, the use count is 0, but the hardware register read
> from CCM_CCGR1_CG8 is ungated.
> 
> cat /sys/kernel/debug/clk/clk_summary | grep esai
Just a very minor nitpick: Unnecessary usage of cat,

	grep esai /sys/kernel/debug/clk/clk_summary

just produces the same result. :-)

> 
> esai_sel            0            0   393216000          0 0
>    esai_pred           0            0   196608000          0 0
>       esai_podf           0            0    24576000          0 0
>          esai_extal           0            0    24576000          0 0
>       esai_mem           0            0   132000000          0 0
>       esai_ipg           0            0   132000000          0 0
> 
> Read CCM_CCGR1:
> 
> 0x020C406C:  F33FFF00
This is hardly useful if you don't have the reference manual at hand.
I'd believe the commit log even without the examples.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
