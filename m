From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 07 Mar 2017 01:28:42 +0800
Subject: [PATCH] mmc: sunxi: mask all Response Timeout error messages
In-Reply-To: <20170306155313.nqxnhtsl4o5yrv33@lukather>
References: <20170305164535.36259-1-icenowy@aosc.xyz>
 <20170306100437.sr7mrvssdwnt7aaz@lukather>
 <1597991488796361@web24m.yandex.ru> <20170306155313.nqxnhtsl4o5yrv33@lukather>
Message-ID: <364721488821322@web5o.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



06.03.2017, 23:53, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
> On Mon, Mar 06, 2017 at 06:32:41PM +0800, Icenowy Zheng wrote:
>> ?06.03.2017, 18:04, "Maxime Ripard" <maxime.ripard@free-electrons.com>:
>> ?> Hi,
>> ?>
>> ?> On Mon, Mar 06, 2017 at 12:45:35AM +0800, Icenowy Zheng wrote:
>> ?>> ?Response Timeout is very usual: it will happen when trying to run some
>> ?>> ?commands that do not belong to the card; it will happen when some SDIO
>> ?>> ?card transfer beyond its SDIO bandwidth; and when the MMC controller is
>> ?>> ?set to poll the card with "broken-cd" property (the Lichee Pi series of
>> ?>> ?boards do this), it will flood to the console and make the console
>> ?>> ?unusable.
>> ?>>
>> ?>> ?Mask all response-timeout-only error messages, only show it when another
>> ?>> ?error happens.
>> ?>>
>> ?>> ?Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
>> ?>> ?---
>> ?>> ??drivers/mmc/host/sunxi-mmc.c | 13 +++++++++----
>> ?>> ??1 file changed, 9 insertions(+), 4 deletions(-)
>> ?>>
>> ?>> ?diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
>> ?>> ?index 6ffcd2838272..7828e1f57cf0 100644
>> ?>> ?--- a/drivers/mmc/host/sunxi-mmc.c
>> ?>> ?+++ b/drivers/mmc/host/sunxi-mmc.c
>> ?>> ?@@ -483,10 +483,15 @@ static void sunxi_mmc_dump_errinfo(struct sunxi_mmc_host *host)
>> ?>> ??????????struct mmc_command *cmd = host->mrq->cmd;
>> ?>> ??????????struct mmc_data *data = host->mrq->data;
>> ?>>
>> ?>> ?- /* For some cmds timeout is normal with sd/mmc cards */
>> ?>> ?- if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) ==
>> ?>> ?- SDXC_RESP_TIMEOUT && (cmd->opcode == SD_IO_SEND_OP_COND ||
>> ?>> ?- cmd->opcode == SD_IO_RW_DIRECT))
>> ?>> ?+ /*
>> ?>> ?+ * Reading timeout is usually normal, especially when doing
>> ?>> ?+ * card-polling with "broken-cd" in device tree.
>> ?>> ?+ * If do not mask it, the RTO error message will flood the console
>> ?>> ?+ * and even hide useful error messages.
>> ?>> ?+ *
>> ?>> ?+ * Some SDIO commands will also normally timeout with non-SDIO cards.
>> ?>> ?+ */
>> ?>> ?+ if ((host->int_sum & SDXC_INTERRUPT_ERROR_BIT) == SDXC_RESP_TIMEOUT)
>> ?>
>> ?> We really shouldn't silence legit errors.
>> ?>
>> ?> The actual problem here is that we log them as error, we could
>> ?> probably reduce it to debug.
>>
>> ?Even if it's reduced to debug, it will still flush dmesg buffers.
>
> No, it will not even be compiled by default.
>
>> ?Or make it only visible when "debug" parameter is present in kernel
>> ?cmdline?
>
> debug messages are visible in dmesg only if DEBUG is defined, which is
> only happening if CONFIG_MMC_DEBUG is set. This won't affect the
> general case in any way.
>
> And it is output only if loglevel is set higher than 7.

Should I make all error messages debug level or only make "RTO"-only
error to debug level like I currently do?

>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
