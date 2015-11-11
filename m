From: balbi@ti.com (Felipe Balbi)
Date: Wed, 11 Nov 2015 13:40:54 -0600
Subject: [PATCH v3 0/3] ARM: OMAP2+ McASP(3) support for DRA7xx family
In-Reply-To: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
References: <1446191700-11057-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <874mgss4s9.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Peter Ujfalusi <peter.ujfalusi@ti.com> writes:
> Hi Paul, Tony,
>
> Changes since v2:
> - DTS patch added which is needed because of the clock handling changes
>
> Felip Balbi reported that linux-next is broken right now since the DTS part of
> the earlier series has been applied, but we do not have the mcasp hwmod in the
> kernel:
> ...
> [    0.181029] platform 48468000.mcasp: Cannot lookup hwmod 'mcasp3'
> ...
> [    6.121072] davinci-mcasp 48468000.mcasp: _od_fail_runtime_resume: FIXME: missing hwmod/omap_dev info
> [    6.130790] ------------[ cut here ]------------
> [    6.135643] WARNING: CPU: 0 PID: 244 at drivers/bus/omap_l3_noc.c:147 l3_interrupt_handler+0x220/0x34c()
> [    6.145576] 44000000.ocp:L3 Custom Error: MASTER MPU TARGET L4_PER2_P3 (Read): Data Access in User mode during Functional access
> ...
>
> This is the followup series for the hwmod changes needed to get audio working
> on DRA7xx family based boards.
> The DTS patches has been applied by Tony from the original series:
> http://www.spinics.net/lists/linux-omap/msg121473.html
>
> I have addressed your comments in the hwmod data and did some research also
> regarding to the use of ahclkx as fclk in the original submission.
> It turned out that McASP _needs_ all clocks to be enabled (fclk, iclk and
> ahclkx/r) to be able to access registers. The original patch where we handled
> the ahclkx as fclk worked, because the fclk clock got enabled in the HW w/o
> any SW interaction.
> All in all, the McASP found in DRA7 needs all clocks to be enabled.
> To satisfy this I have introduced a new flag to hwmod, which means that the
> listed optional clocks need to be handled alongside with the fclk clock.
>
> Regards,
> Peter
> ---
> Peter Ujfalusi (3):
>   ARM: DTS: dra7: Fix McASP3 node regarding to clocks
>   ARM: OMAP2+: hwmod: Add hwmod flag for HWMOD_OPT_CLKS_NEEDED
>   ARM: OMAP: DRA7: hwmod: Add data for McASP3

I have tested these patches with today's HEAD + rtc 1307 fix. Boots fine
and I can't see the splat I was seeing with beagle x15.

Tested-by: Felipe Balbi <balbi@ti.com>

logs: http://hastebin.com/ololizojat

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151111/a5c358d0/attachment.sig>
