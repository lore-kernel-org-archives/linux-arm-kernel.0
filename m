From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 Mar 2015 14:14:38 +0100
Subject: [RFC PATCH 02/18] mmc: msm: move data mover into mmc driver
In-Reply-To: <1425497592-1831064-3-git-send-email-arnd@arndb.de>
References: <1425497592-1831064-1-git-send-email-arnd@arndb.de>
 <1425497592-1831064-3-git-send-email-arnd@arndb.de>
Message-ID: <CAPDyKFrXbpXL3-exjoqzhTj6MSMsZ54zN3c0-2FN+zyhutKE5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 March 2015 at 20:32, Arnd Bergmann <arnd@arndb.de> wrote:
> The msm_sdcc driver is the only user of the proprietary msm
> data mover interface. In order to simplify the multiplatform
> conversion, this patch moves the entire data mover code into
> the mmc driver.
>
> If against our expectations any other drivers should be added
> in the future that use the same data mover, the best approach
> would be to convert this code into a dmaengine driver and use
> the generic interfaces for that.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

> ---
>  arch/arm/mach-msm/Makefile           |   6 +-
>  arch/arm/mach-msm/board-msm7x30.c    |   1 -
>  arch/arm/mach-msm/devices-msm7x30.c  |   1 -
>  arch/arm/mach-msm/devices-qsd8x50.c  |   1 -
>  arch/arm/mach-msm/dma.c              | 298 -----------------------------
>  arch/arm/mach-msm/include/mach/dma.h | 151 ---------------
>  drivers/mmc/host/msm_sdcc.c          | 360 ++++++++++++++++++++++++++++++++++-
>  7 files changed, 362 insertions(+), 456 deletions(-)
>  delete mode 100644 arch/arm/mach-msm/dma.c
>  delete mode 100644 arch/arm/mach-msm/include/mach/dma.h
>
> diff --git a/arch/arm/mach-msm/Makefile b/arch/arm/mach-msm/Makefile
> index 27c078a568df..2fb46dc0ead8 100644
> --- a/arch/arm/mach-msm/Makefile
> +++ b/arch/arm/mach-msm/Makefile
> @@ -7,9 +7,9 @@ obj-$(CONFIG_ARCH_QSD8X50) += sirc.o
>
>  obj-$(CONFIG_MSM_PROC_COMM) += proc_comm.o clock-pcom.o vreg.o
>
> -obj-$(CONFIG_ARCH_MSM7X00A) += dma.o io.o
> -obj-$(CONFIG_ARCH_MSM7X30) += dma.o io.o
> -obj-$(CONFIG_ARCH_QSD8X50) += dma.o io.o
> +obj-$(CONFIG_ARCH_MSM7X00A) += io.o
> +obj-$(CONFIG_ARCH_MSM7X30) += io.o
> +obj-$(CONFIG_ARCH_QSD8X50) += io.o
>
>  obj-$(CONFIG_MSM_SMD) += smd.o smd_debug.o
>  obj-$(CONFIG_MSM_SMD) += last_radio_log.o
> diff --git a/arch/arm/mach-msm/board-msm7x30.c b/arch/arm/mach-msm/board-msm7x30.c
> index 8f5ecdc4f3ce..44a5bdbf0ee7 100644
> --- a/arch/arm/mach-msm/board-msm7x30.c
> +++ b/arch/arm/mach-msm/board-msm7x30.c
> @@ -32,7 +32,6 @@
>
>  #include <mach/clk.h>
>  #include <mach/msm_iomap.h>
> -#include <mach/dma.h>
>
>  #include <mach/vreg.h>
>  #include "devices.h"
> diff --git a/arch/arm/mach-msm/devices-msm7x30.c b/arch/arm/mach-msm/devices-msm7x30.c
> index c15ea8ab20a7..5a0705b55321 100644
> --- a/arch/arm/mach-msm/devices-msm7x30.c
> +++ b/arch/arm/mach-msm/devices-msm7x30.c
> @@ -20,7 +20,6 @@
>  #include <linux/clkdev.h>
>  #include <mach/irqs.h>
>  #include <mach/msm_iomap.h>
> -#include <mach/dma.h>
>
>  #include "devices.h"
>  #include "smd_private.h"
> diff --git a/arch/arm/mach-msm/devices-qsd8x50.c b/arch/arm/mach-msm/devices-qsd8x50.c
> index 9e1e9ce07b1a..dfc884521fc1 100644
> --- a/arch/arm/mach-msm/devices-qsd8x50.c
> +++ b/arch/arm/mach-msm/devices-qsd8x50.c
> @@ -20,7 +20,6 @@
>
>  #include <mach/irqs.h>
>  #include <mach/msm_iomap.h>
> -#include <mach/dma.h>
>
>  #include "devices.h"
>  #include "common.h"
> diff --git a/arch/arm/mach-msm/dma.c b/arch/arm/mach-msm/dma.c
> deleted file mode 100644
> index fb9762464718..000000000000
> --- a/arch/arm/mach-msm/dma.c
> +++ /dev/null
> @@ -1,298 +0,0 @@
> -/* linux/arch/arm/mach-msm/dma.c
> - *
> - * Copyright (C) 2007 Google, Inc.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#include <linux/clk.h>
> -#include <linux/err.h>
> -#include <linux/io.h>
> -#include <linux/interrupt.h>
> -#include <linux/completion.h>
> -#include <linux/module.h>
> -#include <mach/dma.h>
> -#include <mach/msm_iomap.h>
> -
> -#define MSM_DMOV_CHANNEL_COUNT 16
> -
> -#define DMOV_SD0(off, ch) (MSM_DMOV_BASE + 0x0000 + (off) + ((ch) << 2))
> -#define DMOV_SD1(off, ch) (MSM_DMOV_BASE + 0x0400 + (off) + ((ch) << 2))
> -#define DMOV_SD2(off, ch) (MSM_DMOV_BASE + 0x0800 + (off) + ((ch) << 2))
> -#define DMOV_SD3(off, ch) (MSM_DMOV_BASE + 0x0C00 + (off) + ((ch) << 2))
> -
> -#if defined(CONFIG_ARCH_MSM7X30)
> -#define DMOV_SD_AARM DMOV_SD2
> -#else
> -#define DMOV_SD_AARM DMOV_SD3
> -#endif
> -
> -#define DMOV_CMD_PTR(ch)      DMOV_SD_AARM(0x000, ch)
> -#define DMOV_RSLT(ch)         DMOV_SD_AARM(0x040, ch)
> -#define DMOV_FLUSH0(ch)       DMOV_SD_AARM(0x080, ch)
> -#define DMOV_FLUSH1(ch)       DMOV_SD_AARM(0x0C0, ch)
> -#define DMOV_FLUSH2(ch)       DMOV_SD_AARM(0x100, ch)
> -#define DMOV_FLUSH3(ch)       DMOV_SD_AARM(0x140, ch)
> -#define DMOV_FLUSH4(ch)       DMOV_SD_AARM(0x180, ch)
> -#define DMOV_FLUSH5(ch)       DMOV_SD_AARM(0x1C0, ch)
> -
> -#define DMOV_STATUS(ch)       DMOV_SD_AARM(0x200, ch)
> -#define DMOV_ISR              DMOV_SD_AARM(0x380, 0)
> -
> -#define DMOV_CONFIG(ch)       DMOV_SD_AARM(0x300, ch)
> -
> -enum {
> -       MSM_DMOV_PRINT_ERRORS = 1,
> -       MSM_DMOV_PRINT_IO = 2,
> -       MSM_DMOV_PRINT_FLOW = 4
> -};
> -
> -static DEFINE_SPINLOCK(msm_dmov_lock);
> -static struct clk *msm_dmov_clk;
> -static unsigned int channel_active;
> -static struct list_head ready_commands[MSM_DMOV_CHANNEL_COUNT];
> -static struct list_head active_commands[MSM_DMOV_CHANNEL_COUNT];
> -unsigned int msm_dmov_print_mask = MSM_DMOV_PRINT_ERRORS;
> -
> -#define MSM_DMOV_DPRINTF(mask, format, args...) \
> -       do { \
> -               if ((mask) & msm_dmov_print_mask) \
> -                       printk(KERN_ERR format, args); \
> -       } while (0)
> -#define PRINT_ERROR(format, args...) \
> -       MSM_DMOV_DPRINTF(MSM_DMOV_PRINT_ERRORS, format, args);
> -#define PRINT_IO(format, args...) \
> -       MSM_DMOV_DPRINTF(MSM_DMOV_PRINT_IO, format, args);
> -#define PRINT_FLOW(format, args...) \
> -       MSM_DMOV_DPRINTF(MSM_DMOV_PRINT_FLOW, format, args);
> -
> -void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful)
> -{
> -       writel((graceful << 31), DMOV_FLUSH0(id));
> -}
> -EXPORT_SYMBOL_GPL(msm_dmov_stop_cmd);
> -
> -void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd)
> -{
> -       unsigned long irq_flags;
> -       unsigned int status;
> -
> -       spin_lock_irqsave(&msm_dmov_lock, irq_flags);
> -       if (!channel_active)
> -               clk_enable(msm_dmov_clk);
> -       dsb();
> -       status = readl(DMOV_STATUS(id));
> -       if (list_empty(&ready_commands[id]) &&
> -               (status & DMOV_STATUS_CMD_PTR_RDY)) {
> -#if 0
> -               if (list_empty(&active_commands[id])) {
> -                       PRINT_FLOW("msm_dmov_enqueue_cmd(%d), enable interrupt\n", id);
> -                       writel(DMOV_CONFIG_IRQ_EN, DMOV_CONFIG(id));
> -               }
> -#endif
> -               if (cmd->execute_func)
> -                       cmd->execute_func(cmd);
> -               PRINT_IO("msm_dmov_enqueue_cmd(%d), start command, status %x\n", id, status);
> -               list_add_tail(&cmd->list, &active_commands[id]);
> -               if (!channel_active)
> -                       enable_irq(INT_ADM_AARM);
> -               channel_active |= 1U << id;
> -               writel(cmd->cmdptr, DMOV_CMD_PTR(id));
> -       } else {
> -               if (!channel_active)
> -                       clk_disable(msm_dmov_clk);
> -               if (list_empty(&active_commands[id]))
> -                       PRINT_ERROR("msm_dmov_enqueue_cmd(%d), error datamover stalled, status %x\n", id, status);
> -
> -               PRINT_IO("msm_dmov_enqueue_cmd(%d), enqueue command, status %x\n", id, status);
> -               list_add_tail(&cmd->list, &ready_commands[id]);
> -       }
> -       spin_unlock_irqrestore(&msm_dmov_lock, irq_flags);
> -}
> -EXPORT_SYMBOL_GPL(msm_dmov_enqueue_cmd);
> -
> -struct msm_dmov_exec_cmdptr_cmd {
> -       struct msm_dmov_cmd dmov_cmd;
> -       struct completion complete;
> -       unsigned id;
> -       unsigned int result;
> -       struct msm_dmov_errdata err;
> -};
> -
> -static void
> -dmov_exec_cmdptr_complete_func(struct msm_dmov_cmd *_cmd,
> -                              unsigned int result,
> -                              struct msm_dmov_errdata *err)
> -{
> -       struct msm_dmov_exec_cmdptr_cmd *cmd = container_of(_cmd, struct msm_dmov_exec_cmdptr_cmd, dmov_cmd);
> -       cmd->result = result;
> -       if (result != 0x80000002 && err)
> -               memcpy(&cmd->err, err, sizeof(struct msm_dmov_errdata));
> -
> -       complete(&cmd->complete);
> -}
> -
> -int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr)
> -{
> -       struct msm_dmov_exec_cmdptr_cmd cmd;
> -
> -       PRINT_FLOW("dmov_exec_cmdptr(%d, %x)\n", id, cmdptr);
> -
> -       cmd.dmov_cmd.cmdptr = cmdptr;
> -       cmd.dmov_cmd.complete_func = dmov_exec_cmdptr_complete_func;
> -       cmd.dmov_cmd.execute_func = NULL;
> -       cmd.id = id;
> -       init_completion(&cmd.complete);
> -
> -       msm_dmov_enqueue_cmd(id, &cmd.dmov_cmd);
> -       wait_for_completion(&cmd.complete);
> -
> -       if (cmd.result != 0x80000002) {
> -               PRINT_ERROR("dmov_exec_cmdptr(%d): ERROR, result: %x\n", id, cmd.result);
> -               PRINT_ERROR("dmov_exec_cmdptr(%d):  flush: %x %x %x %x\n",
> -                       id, cmd.err.flush[0], cmd.err.flush[1], cmd.err.flush[2], cmd.err.flush[3]);
> -               return -EIO;
> -       }
> -       PRINT_FLOW("dmov_exec_cmdptr(%d, %x) done\n", id, cmdptr);
> -       return 0;
> -}
> -
> -
> -static irqreturn_t msm_datamover_irq_handler(int irq, void *dev_id)
> -{
> -       unsigned int int_status, mask, id;
> -       unsigned long irq_flags;
> -       unsigned int ch_status;
> -       unsigned int ch_result;
> -       struct msm_dmov_cmd *cmd;
> -
> -       spin_lock_irqsave(&msm_dmov_lock, irq_flags);
> -
> -       int_status = readl(DMOV_ISR); /* read and clear interrupt */
> -       PRINT_FLOW("msm_datamover_irq_handler: DMOV_ISR %x\n", int_status);
> -
> -       while (int_status) {
> -               mask = int_status & -int_status;
> -               id = fls(mask) - 1;
> -               PRINT_FLOW("msm_datamover_irq_handler %08x %08x id %d\n", int_status, mask, id);
> -               int_status &= ~mask;
> -               ch_status = readl(DMOV_STATUS(id));
> -               if (!(ch_status & DMOV_STATUS_RSLT_VALID)) {
> -                       PRINT_FLOW("msm_datamover_irq_handler id %d, result not valid %x\n", id, ch_status);
> -                       continue;
> -               }
> -               do {
> -                       ch_result = readl(DMOV_RSLT(id));
> -                       if (list_empty(&active_commands[id])) {
> -                               PRINT_ERROR("msm_datamover_irq_handler id %d, got result "
> -                                       "with no active command, status %x, result %x\n",
> -                                       id, ch_status, ch_result);
> -                               cmd = NULL;
> -                       } else
> -                               cmd = list_entry(active_commands[id].next, typeof(*cmd), list);
> -                       PRINT_FLOW("msm_datamover_irq_handler id %d, status %x, result %x\n", id, ch_status, ch_result);
> -                       if (ch_result & DMOV_RSLT_DONE) {
> -                               PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n",
> -                                       id, ch_status);
> -                               PRINT_IO("msm_datamover_irq_handler id %d, got result "
> -                                       "for %p, result %x\n", id, cmd, ch_result);
> -                               if (cmd) {
> -                                       list_del(&cmd->list);
> -                                       dsb();
> -                                       cmd->complete_func(cmd, ch_result, NULL);
> -                               }
> -                       }
> -                       if (ch_result & DMOV_RSLT_FLUSH) {
> -                               struct msm_dmov_errdata errdata;
> -
> -                               errdata.flush[0] = readl(DMOV_FLUSH0(id));
> -                               errdata.flush[1] = readl(DMOV_FLUSH1(id));
> -                               errdata.flush[2] = readl(DMOV_FLUSH2(id));
> -                               errdata.flush[3] = readl(DMOV_FLUSH3(id));
> -                               errdata.flush[4] = readl(DMOV_FLUSH4(id));
> -                               errdata.flush[5] = readl(DMOV_FLUSH5(id));
> -                               PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> -                               PRINT_FLOW("msm_datamover_irq_handler id %d, flush, result %x, flush0 %x\n", id, ch_result, errdata.flush[0]);
> -                               if (cmd) {
> -                                       list_del(&cmd->list);
> -                                       dsb();
> -                                       cmd->complete_func(cmd, ch_result, &errdata);
> -                               }
> -                       }
> -                       if (ch_result & DMOV_RSLT_ERROR) {
> -                               struct msm_dmov_errdata errdata;
> -
> -                               errdata.flush[0] = readl(DMOV_FLUSH0(id));
> -                               errdata.flush[1] = readl(DMOV_FLUSH1(id));
> -                               errdata.flush[2] = readl(DMOV_FLUSH2(id));
> -                               errdata.flush[3] = readl(DMOV_FLUSH3(id));
> -                               errdata.flush[4] = readl(DMOV_FLUSH4(id));
> -                               errdata.flush[5] = readl(DMOV_FLUSH5(id));
> -
> -                               PRINT_ERROR("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> -                               PRINT_ERROR("msm_datamover_irq_handler id %d, error, result %x, flush0 %x\n", id, ch_result, errdata.flush[0]);
> -                               if (cmd) {
> -                                       list_del(&cmd->list);
> -                                       dsb();
> -                                       cmd->complete_func(cmd, ch_result, &errdata);
> -                               }
> -                               /* this does not seem to work, once we get an error */
> -                               /* the datamover will no longer accept commands */
> -                               writel(0, DMOV_FLUSH0(id));
> -                       }
> -                       ch_status = readl(DMOV_STATUS(id));
> -                       PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> -                       if ((ch_status & DMOV_STATUS_CMD_PTR_RDY) && !list_empty(&ready_commands[id])) {
> -                               cmd = list_entry(ready_commands[id].next, typeof(*cmd), list);
> -                               list_move_tail(&cmd->list, &active_commands[id]);
> -                               if (cmd->execute_func)
> -                                       cmd->execute_func(cmd);
> -                               PRINT_FLOW("msm_datamover_irq_handler id %d, start command\n", id);
> -                               writel(cmd->cmdptr, DMOV_CMD_PTR(id));
> -                       }
> -               } while (ch_status & DMOV_STATUS_RSLT_VALID);
> -               if (list_empty(&active_commands[id]) && list_empty(&ready_commands[id]))
> -                       channel_active &= ~(1U << id);
> -               PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> -       }
> -
> -       if (!channel_active) {
> -               disable_irq_nosync(INT_ADM_AARM);
> -               clk_disable(msm_dmov_clk);
> -       }
> -
> -       spin_unlock_irqrestore(&msm_dmov_lock, irq_flags);
> -       return IRQ_HANDLED;
> -}
> -
> -static int __init msm_init_datamover(void)
> -{
> -       int i;
> -       int ret;
> -       struct clk *clk;
> -
> -       for (i = 0; i < MSM_DMOV_CHANNEL_COUNT; i++) {
> -               INIT_LIST_HEAD(&ready_commands[i]);
> -               INIT_LIST_HEAD(&active_commands[i]);
> -               writel(DMOV_CONFIG_IRQ_EN | DMOV_CONFIG_FORCE_TOP_PTR_RSLT | DMOV_CONFIG_FORCE_FLUSH_RSLT, DMOV_CONFIG(i));
> -       }
> -       clk = clk_get(NULL, "adm_clk");
> -       if (IS_ERR(clk))
> -               return PTR_ERR(clk);
> -       clk_prepare(clk);
> -       msm_dmov_clk = clk;
> -       ret = request_irq(INT_ADM_AARM, msm_datamover_irq_handler, 0, "msmdatamover", NULL);
> -       if (ret)
> -               return ret;
> -       disable_irq(INT_ADM_AARM);
> -       return 0;
> -}
> -module_init(msm_init_datamover);
> diff --git a/arch/arm/mach-msm/include/mach/dma.h b/arch/arm/mach-msm/include/mach/dma.h
> deleted file mode 100644
> index a72d48d42342..000000000000
> --- a/arch/arm/mach-msm/include/mach/dma.h
> +++ /dev/null
> @@ -1,151 +0,0 @@
> -/* linux/include/asm-arm/arch-msm/dma.h
> - *
> - * Copyright (C) 2007 Google, Inc.
> - *
> - * This software is licensed under the terms of the GNU General Public
> - * License version 2, as published by the Free Software Foundation, and
> - * may be copied, distributed, and modified under those terms.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
> - */
> -
> -#ifndef __ASM_ARCH_MSM_DMA_H
> -
> -#include <linux/list.h>
> -
> -struct msm_dmov_errdata {
> -       uint32_t flush[6];
> -};
> -
> -struct msm_dmov_cmd {
> -       struct list_head list;
> -       unsigned int cmdptr;
> -       void (*complete_func)(struct msm_dmov_cmd *cmd,
> -                             unsigned int result,
> -                             struct msm_dmov_errdata *err);
> -       void (*execute_func)(struct msm_dmov_cmd *cmd);
> -       void *data;
> -};
> -
> -#ifndef CONFIG_ARCH_MSM8X60
> -void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd);
> -void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful);
> -int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr);
> -#else
> -static inline
> -void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd) { }
> -static inline
> -void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful) { }
> -static inline
> -int msm_dmov_exec_cmd(unsigned id, unsigned int cmdptr) { return -EIO; }
> -#endif
> -
> -#define DMOV_CMD_LIST         (0 << 29) /* does not work */
> -#define DMOV_CMD_PTR_LIST     (1 << 29) /* works */
> -#define DMOV_CMD_INPUT_CFG    (2 << 29) /* untested */
> -#define DMOV_CMD_OUTPUT_CFG   (3 << 29) /* untested */
> -#define DMOV_CMD_ADDR(addr)   ((addr) >> 3)
> -
> -#define DMOV_RSLT_VALID       (1 << 31) /* 0 == host has empties result fifo */
> -#define DMOV_RSLT_ERROR       (1 << 3)
> -#define DMOV_RSLT_FLUSH       (1 << 2)
> -#define DMOV_RSLT_DONE        (1 << 1)  /* top pointer done */
> -#define DMOV_RSLT_USER        (1 << 0)  /* command with FR force result */
> -
> -#define DMOV_STATUS_RSLT_COUNT(n)    (((n) >> 29))
> -#define DMOV_STATUS_CMD_COUNT(n)     (((n) >> 27) & 3)
> -#define DMOV_STATUS_RSLT_VALID       (1 << 1)
> -#define DMOV_STATUS_CMD_PTR_RDY      (1 << 0)
> -
> -#define DMOV_CONFIG_FORCE_TOP_PTR_RSLT (1 << 2)
> -#define DMOV_CONFIG_FORCE_FLUSH_RSLT   (1 << 1)
> -#define DMOV_CONFIG_IRQ_EN             (1 << 0)
> -
> -/* channel assignments */
> -
> -#define DMOV_NAND_CHAN        7
> -#define DMOV_NAND_CRCI_CMD    5
> -#define DMOV_NAND_CRCI_DATA   4
> -
> -#define DMOV_SDC1_CHAN        8
> -#define DMOV_SDC1_CRCI        6
> -
> -#define DMOV_SDC2_CHAN        8
> -#define DMOV_SDC2_CRCI        7
> -
> -#define DMOV_TSIF_CHAN        10
> -#define DMOV_TSIF_CRCI        10
> -
> -#define DMOV_USB_CHAN         11
> -
> -/* no client rate control ifc (eg, ram) */
> -#define DMOV_NONE_CRCI        0
> -
> -
> -/* If the CMD_PTR register has CMD_PTR_LIST selected, the data mover
> - * is going to walk a list of 32bit pointers as described below.  Each
> - * pointer points to a *array* of dmov_s, etc structs.  The last pointer
> - * in the list is marked with CMD_PTR_LP.  The last struct in each array
> - * is marked with CMD_LC (see below).
> - */
> -#define CMD_PTR_ADDR(addr)  ((addr) >> 3)
> -#define CMD_PTR_LP          (1 << 31) /* last pointer */
> -#define CMD_PTR_PT          (3 << 29) /* ? */
> -
> -/* Single Item Mode */
> -typedef struct {
> -       unsigned cmd;
> -       unsigned src;
> -       unsigned dst;
> -       unsigned len;
> -} dmov_s;
> -
> -/* Scatter/Gather Mode */
> -typedef struct {
> -       unsigned cmd;
> -       unsigned src_dscr;
> -       unsigned dst_dscr;
> -       unsigned _reserved;
> -} dmov_sg;
> -
> -/* Box mode */
> -typedef struct {
> -       uint32_t cmd;
> -       uint32_t src_row_addr;
> -       uint32_t dst_row_addr;
> -       uint32_t src_dst_len;
> -       uint32_t num_rows;
> -       uint32_t row_offset;
> -} dmov_box;
> -
> -/* bits for the cmd field of the above structures */
> -
> -#define CMD_LC      (1 << 31)  /* last command */
> -#define CMD_FR      (1 << 22)  /* force result -- does not work? */
> -#define CMD_OCU     (1 << 21)  /* other channel unblock */
> -#define CMD_OCB     (1 << 20)  /* other channel block */
> -#define CMD_TCB     (1 << 19)  /* ? */
> -#define CMD_DAH     (1 << 18)  /* destination address hold -- does not work?*/
> -#define CMD_SAH     (1 << 17)  /* source address hold -- does not work? */
> -
> -#define CMD_MODE_SINGLE     (0 << 0) /* dmov_s structure used */
> -#define CMD_MODE_SG         (1 << 0) /* untested */
> -#define CMD_MODE_IND_SG     (2 << 0) /* untested */
> -#define CMD_MODE_BOX        (3 << 0) /* untested */
> -
> -#define CMD_DST_SWAP_BYTES  (1 << 14) /* exchange each byte n with byte n+1 */
> -#define CMD_DST_SWAP_SHORTS (1 << 15) /* exchange each short n with short n+1 */
> -#define CMD_DST_SWAP_WORDS  (1 << 16) /* exchange each word n with word n+1 */
> -
> -#define CMD_SRC_SWAP_BYTES  (1 << 11) /* exchange each byte n with byte n+1 */
> -#define CMD_SRC_SWAP_SHORTS (1 << 12) /* exchange each short n with short n+1 */
> -#define CMD_SRC_SWAP_WORDS  (1 << 13) /* exchange each word n with word n+1 */
> -
> -#define CMD_DST_CRCI(n)     (((n) & 15) << 7)
> -#define CMD_SRC_CRCI(n)     (((n) & 15) << 3)
> -
> -#endif
> diff --git a/drivers/mmc/host/msm_sdcc.c b/drivers/mmc/host/msm_sdcc.c
> index 90c60fd4ff6e..83dc4e5d9963 100644
> --- a/drivers/mmc/host/msm_sdcc.c
> +++ b/drivers/mmc/host/msm_sdcc.c
> @@ -15,6 +15,7 @@
>   *
>   */
>
> +#include <linux/completion.h>
>  #include <linux/module.h>
>  #include <linux/moduleparam.h>
>  #include <linux/init.h>
> @@ -24,6 +25,7 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/highmem.h>
> +#include <linux/list.h>
>  #include <linux/log2.h>
>  #include <linux/mmc/host.h>
>  #include <linux/mmc/card.h>
> @@ -43,9 +45,365 @@
>  #include <asm/sizes.h>
>
>  #include <linux/platform_data/mmc-msm_sdcc.h>
> -#include <mach/dma.h>
> +#include <mach/msm_iomap.h>
>  #include <mach/clk.h>
>
> +/* data mover definitions */
> +
> +struct msm_dmov_errdata {
> +       uint32_t flush[6];
> +};
> +
> +struct msm_dmov_cmd {
> +       struct list_head list;
> +       unsigned int cmdptr;
> +       void (*complete_func)(struct msm_dmov_cmd *cmd,
> +                             unsigned int result,
> +                             struct msm_dmov_errdata *err);
> +       void (*execute_func)(struct msm_dmov_cmd *cmd);
> +       void *data;
> +};
> +
> +#define DMOV_CMD_LIST         (0 << 29) /* does not work */
> +#define DMOV_CMD_PTR_LIST     (1 << 29) /* works */
> +#define DMOV_CMD_INPUT_CFG    (2 << 29) /* untested */
> +#define DMOV_CMD_OUTPUT_CFG   (3 << 29) /* untested */
> +#define DMOV_CMD_ADDR(addr)   ((addr) >> 3)
> +
> +#define DMOV_RSLT_VALID       (1 << 31) /* 0 == host has empties result fifo */
> +#define DMOV_RSLT_ERROR       (1 << 3)
> +#define DMOV_RSLT_FLUSH       (1 << 2)
> +#define DMOV_RSLT_DONE        (1 << 1)  /* top pointer done */
> +#define DMOV_RSLT_USER        (1 << 0)  /* command with FR force result */
> +
> +#define DMOV_STATUS_RSLT_COUNT(n)    (((n) >> 29))
> +#define DMOV_STATUS_CMD_COUNT(n)     (((n) >> 27) & 3)
> +#define DMOV_STATUS_RSLT_VALID       (1 << 1)
> +#define DMOV_STATUS_CMD_PTR_RDY      (1 << 0)
> +
> +#define DMOV_CONFIG_FORCE_TOP_PTR_RSLT (1 << 2)
> +#define DMOV_CONFIG_FORCE_FLUSH_RSLT   (1 << 1)
> +#define DMOV_CONFIG_IRQ_EN             (1 << 0)
> +
> +/* channel assignments */
> +
> +#define DMOV_NAND_CHAN        7
> +#define DMOV_NAND_CRCI_CMD    5
> +#define DMOV_NAND_CRCI_DATA   4
> +
> +#define DMOV_SDC1_CHAN        8
> +#define DMOV_SDC1_CRCI        6
> +
> +#define DMOV_SDC2_CHAN        8
> +#define DMOV_SDC2_CRCI        7
> +
> +#define DMOV_TSIF_CHAN        10
> +#define DMOV_TSIF_CRCI        10
> +
> +#define DMOV_USB_CHAN         11
> +
> +/* no client rate control ifc (eg, ram) */
> +#define DMOV_NONE_CRCI        0
> +
> +
> +/* If the CMD_PTR register has CMD_PTR_LIST selected, the data mover
> + * is going to walk a list of 32bit pointers as described below.  Each
> + * pointer points to a *array* of dmov_s, etc structs.  The last pointer
> + * in the list is marked with CMD_PTR_LP.  The last struct in each array
> + * is marked with CMD_LC (see below).
> + */
> +#define CMD_PTR_ADDR(addr)  ((addr) >> 3)
> +#define CMD_PTR_LP          (1 << 31) /* last pointer */
> +#define CMD_PTR_PT          (3 << 29) /* ? */
> +
> +/* Single Item Mode */
> +typedef struct {
> +       unsigned cmd;
> +       unsigned src;
> +       unsigned dst;
> +       unsigned len;
> +} dmov_s;
> +
> +/* Scatter/Gather Mode */
> +typedef struct {
> +       unsigned cmd;
> +       unsigned src_dscr;
> +       unsigned dst_dscr;
> +       unsigned _reserved;
> +} dmov_sg;
> +
> +/* Box mode */
> +typedef struct {
> +       uint32_t cmd;
> +       uint32_t src_row_addr;
> +       uint32_t dst_row_addr;
> +       uint32_t src_dst_len;
> +       uint32_t num_rows;
> +       uint32_t row_offset;
> +} dmov_box;
> +
> +/* bits for the cmd field of the above structures */
> +
> +#define CMD_LC      (1 << 31)  /* last command */
> +#define CMD_FR      (1 << 22)  /* force result -- does not work? */
> +#define CMD_OCU     (1 << 21)  /* other channel unblock */
> +#define CMD_OCB     (1 << 20)  /* other channel block */
> +#define CMD_TCB     (1 << 19)  /* ? */
> +#define CMD_DAH     (1 << 18)  /* destination address hold -- does not work?*/
> +#define CMD_SAH     (1 << 17)  /* source address hold -- does not work? */
> +
> +#define CMD_MODE_SINGLE     (0 << 0) /* dmov_s structure used */
> +#define CMD_MODE_SG         (1 << 0) /* untested */
> +#define CMD_MODE_IND_SG     (2 << 0) /* untested */
> +#define CMD_MODE_BOX        (3 << 0) /* untested */
> +
> +#define CMD_DST_SWAP_BYTES  (1 << 14) /* exchange each byte n with byte n+1 */
> +#define CMD_DST_SWAP_SHORTS (1 << 15) /* exchange each short n with short n+1 */
> +#define CMD_DST_SWAP_WORDS  (1 << 16) /* exchange each word n with word n+1 */
> +
> +#define CMD_SRC_SWAP_BYTES  (1 << 11) /* exchange each byte n with byte n+1 */
> +#define CMD_SRC_SWAP_SHORTS (1 << 12) /* exchange each short n with short n+1 */
> +#define CMD_SRC_SWAP_WORDS  (1 << 13) /* exchange each word n with word n+1 */
> +
> +#define CMD_DST_CRCI(n)     (((n) & 15) << 7)
> +#define CMD_SRC_CRCI(n)     (((n) & 15) << 3)
> +
> +#define MSM_DMOV_CHANNEL_COUNT 16
> +
> +#define DMOV_SD0(off, ch) (MSM_DMOV_BASE + 0x0000 + (off) + ((ch) << 2))
> +#define DMOV_SD1(off, ch) (MSM_DMOV_BASE + 0x0400 + (off) + ((ch) << 2))
> +#define DMOV_SD2(off, ch) (MSM_DMOV_BASE + 0x0800 + (off) + ((ch) << 2))
> +#define DMOV_SD3(off, ch) (MSM_DMOV_BASE + 0x0C00 + (off) + ((ch) << 2))
> +
> +#if defined(CONFIG_ARCH_MSM7X30)
> +#define DMOV_SD_AARM DMOV_SD2
> +#else
> +#define DMOV_SD_AARM DMOV_SD3
> +#endif
> +
> +#define DMOV_CMD_PTR(ch)      DMOV_SD_AARM(0x000, ch)
> +#define DMOV_RSLT(ch)         DMOV_SD_AARM(0x040, ch)
> +#define DMOV_FLUSH0(ch)       DMOV_SD_AARM(0x080, ch)
> +#define DMOV_FLUSH1(ch)       DMOV_SD_AARM(0x0C0, ch)
> +#define DMOV_FLUSH2(ch)       DMOV_SD_AARM(0x100, ch)
> +#define DMOV_FLUSH3(ch)       DMOV_SD_AARM(0x140, ch)
> +#define DMOV_FLUSH4(ch)       DMOV_SD_AARM(0x180, ch)
> +#define DMOV_FLUSH5(ch)       DMOV_SD_AARM(0x1C0, ch)
> +
> +#define DMOV_STATUS(ch)       DMOV_SD_AARM(0x200, ch)
> +#define DMOV_ISR              DMOV_SD_AARM(0x380, 0)
> +
> +#define DMOV_CONFIG(ch)       DMOV_SD_AARM(0x300, ch)
> +
> +enum {
> +       MSM_DMOV_PRINT_ERRORS = 1,
> +       MSM_DMOV_PRINT_IO = 2,
> +       MSM_DMOV_PRINT_FLOW = 4
> +};
> +
> +static DEFINE_SPINLOCK(msm_dmov_lock);
> +static struct clk *msm_dmov_clk;
> +static unsigned int channel_active;
> +static struct list_head ready_commands[MSM_DMOV_CHANNEL_COUNT];
> +static struct list_head active_commands[MSM_DMOV_CHANNEL_COUNT];
> +static const unsigned int msm_dmov_print_mask = MSM_DMOV_PRINT_ERRORS;
> +
> +#define MSM_DMOV_DPRINTF(mask, format, args...) \
> +       do { \
> +               if ((mask) & msm_dmov_print_mask) \
> +                       printk(KERN_ERR format, args); \
> +       } while (0)
> +#define PRINT_ERROR(format, args...) \
> +       MSM_DMOV_DPRINTF(MSM_DMOV_PRINT_ERRORS, format, args);
> +#define PRINT_IO(format, args...) \
> +       MSM_DMOV_DPRINTF(MSM_DMOV_PRINT_IO, format, args);
> +#define PRINT_FLOW(format, args...) \
> +       MSM_DMOV_DPRINTF(MSM_DMOV_PRINT_FLOW, format, args);
> +
> +static void msm_dmov_stop_cmd(unsigned id, struct msm_dmov_cmd *cmd, int graceful)
> +{
> +       writel((graceful << 31), DMOV_FLUSH0(id));
> +}
> +
> +static void msm_dmov_enqueue_cmd(unsigned id, struct msm_dmov_cmd *cmd)
> +{
> +       unsigned long irq_flags;
> +       unsigned int status;
> +
> +       spin_lock_irqsave(&msm_dmov_lock, irq_flags);
> +       if (!channel_active)
> +               clk_enable(msm_dmov_clk);
> +       dsb();
> +       status = readl(DMOV_STATUS(id));
> +       if (list_empty(&ready_commands[id]) &&
> +               (status & DMOV_STATUS_CMD_PTR_RDY)) {
> +#if 0
> +               if (list_empty(&active_commands[id])) {
> +                       PRINT_FLOW("msm_dmov_enqueue_cmd(%d), enable interrupt\n", id);
> +                       writel(DMOV_CONFIG_IRQ_EN, DMOV_CONFIG(id));
> +               }
> +#endif
> +               if (cmd->execute_func)
> +                       cmd->execute_func(cmd);
> +               PRINT_IO("msm_dmov_enqueue_cmd(%d), start command, status %x\n", id, status);
> +               list_add_tail(&cmd->list, &active_commands[id]);
> +               if (!channel_active)
> +                       enable_irq(INT_ADM_AARM);
> +               channel_active |= 1U << id;
> +               writel(cmd->cmdptr, DMOV_CMD_PTR(id));
> +       } else {
> +               if (!channel_active)
> +                       clk_disable(msm_dmov_clk);
> +               if (list_empty(&active_commands[id]))
> +                       PRINT_ERROR("msm_dmov_enqueue_cmd(%d), error datamover stalled, status %x\n", id, status);
> +
> +               PRINT_IO("msm_dmov_enqueue_cmd(%d), enqueue command, status %x\n", id, status);
> +               list_add_tail(&cmd->list, &ready_commands[id]);
> +       }
> +       spin_unlock_irqrestore(&msm_dmov_lock, irq_flags);
> +}
> +
> +struct msm_dmov_exec_cmdptr_cmd {
> +       struct msm_dmov_cmd dmov_cmd;
> +       struct completion complete;
> +       unsigned id;
> +       unsigned int result;
> +       struct msm_dmov_errdata err;
> +};
> +
> +static irqreturn_t msm_datamover_irq_handler(int irq, void *dev_id)
> +{
> +       unsigned int int_status, mask, id;
> +       unsigned long irq_flags;
> +       unsigned int ch_status;
> +       unsigned int ch_result;
> +       struct msm_dmov_cmd *cmd;
> +
> +       spin_lock_irqsave(&msm_dmov_lock, irq_flags);
> +
> +       int_status = readl(DMOV_ISR); /* read and clear interrupt */
> +       PRINT_FLOW("msm_datamover_irq_handler: DMOV_ISR %x\n", int_status);
> +
> +       while (int_status) {
> +               mask = int_status & -int_status;
> +               id = fls(mask) - 1;
> +               PRINT_FLOW("msm_datamover_irq_handler %08x %08x id %d\n", int_status, mask, id);
> +               int_status &= ~mask;
> +               ch_status = readl(DMOV_STATUS(id));
> +               if (!(ch_status & DMOV_STATUS_RSLT_VALID)) {
> +                       PRINT_FLOW("msm_datamover_irq_handler id %d, result not valid %x\n", id, ch_status);
> +                       continue;
> +               }
> +               do {
> +                       ch_result = readl(DMOV_RSLT(id));
> +                       if (list_empty(&active_commands[id])) {
> +                               PRINT_ERROR("msm_datamover_irq_handler id %d, got result "
> +                                       "with no active command, status %x, result %x\n",
> +                                       id, ch_status, ch_result);
> +                               cmd = NULL;
> +                       } else
> +                               cmd = list_entry(active_commands[id].next, typeof(*cmd), list);
> +                       PRINT_FLOW("msm_datamover_irq_handler id %d, status %x, result %x\n", id, ch_status, ch_result);
> +                       if (ch_result & DMOV_RSLT_DONE) {
> +                               PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n",
> +                                       id, ch_status);
> +                               PRINT_IO("msm_datamover_irq_handler id %d, got result "
> +                                       "for %p, result %x\n", id, cmd, ch_result);
> +                               if (cmd) {
> +                                       list_del(&cmd->list);
> +                                       dsb();
> +                                       cmd->complete_func(cmd, ch_result, NULL);
> +                               }
> +                       }
> +                       if (ch_result & DMOV_RSLT_FLUSH) {
> +                               struct msm_dmov_errdata errdata;
> +
> +                               errdata.flush[0] = readl(DMOV_FLUSH0(id));
> +                               errdata.flush[1] = readl(DMOV_FLUSH1(id));
> +                               errdata.flush[2] = readl(DMOV_FLUSH2(id));
> +                               errdata.flush[3] = readl(DMOV_FLUSH3(id));
> +                               errdata.flush[4] = readl(DMOV_FLUSH4(id));
> +                               errdata.flush[5] = readl(DMOV_FLUSH5(id));
> +                               PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> +                               PRINT_FLOW("msm_datamover_irq_handler id %d, flush, result %x, flush0 %x\n", id, ch_result, errdata.flush[0]);
> +                               if (cmd) {
> +                                       list_del(&cmd->list);
> +                                       dsb();
> +                                       cmd->complete_func(cmd, ch_result, &errdata);
> +                               }
> +                       }
> +                       if (ch_result & DMOV_RSLT_ERROR) {
> +                               struct msm_dmov_errdata errdata;
> +
> +                               errdata.flush[0] = readl(DMOV_FLUSH0(id));
> +                               errdata.flush[1] = readl(DMOV_FLUSH1(id));
> +                               errdata.flush[2] = readl(DMOV_FLUSH2(id));
> +                               errdata.flush[3] = readl(DMOV_FLUSH3(id));
> +                               errdata.flush[4] = readl(DMOV_FLUSH4(id));
> +                               errdata.flush[5] = readl(DMOV_FLUSH5(id));
> +
> +                               PRINT_ERROR("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> +                               PRINT_ERROR("msm_datamover_irq_handler id %d, error, result %x, flush0 %x\n", id, ch_result, errdata.flush[0]);
> +                               if (cmd) {
> +                                       list_del(&cmd->list);
> +                                       dsb();
> +                                       cmd->complete_func(cmd, ch_result, &errdata);
> +                               }
> +                               /* this does not seem to work, once we get an error */
> +                               /* the datamover will no longer accept commands */
> +                               writel(0, DMOV_FLUSH0(id));
> +                       }
> +                       ch_status = readl(DMOV_STATUS(id));
> +                       PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> +                       if ((ch_status & DMOV_STATUS_CMD_PTR_RDY) && !list_empty(&ready_commands[id])) {
> +                               cmd = list_entry(ready_commands[id].next, typeof(*cmd), list);
> +                               list_move_tail(&cmd->list, &active_commands[id]);
> +                               if (cmd->execute_func)
> +                                       cmd->execute_func(cmd);
> +                               PRINT_FLOW("msm_datamover_irq_handler id %d, start command\n", id);
> +                               writel(cmd->cmdptr, DMOV_CMD_PTR(id));
> +                       }
> +               } while (ch_status & DMOV_STATUS_RSLT_VALID);
> +               if (list_empty(&active_commands[id]) && list_empty(&ready_commands[id]))
> +                       channel_active &= ~(1U << id);
> +               PRINT_FLOW("msm_datamover_irq_handler id %d, status %x\n", id, ch_status);
> +       }
> +
> +       if (!channel_active) {
> +               disable_irq_nosync(INT_ADM_AARM);
> +               clk_disable(msm_dmov_clk);
> +       }
> +
> +       spin_unlock_irqrestore(&msm_dmov_lock, irq_flags);
> +       return IRQ_HANDLED;
> +}
> +
> +static int __init msm_init_datamover(void)
> +{
> +       int i;
> +       int ret;
> +       struct clk *clk;
> +
> +       for (i = 0; i < MSM_DMOV_CHANNEL_COUNT; i++) {
> +               INIT_LIST_HEAD(&ready_commands[i]);
> +               INIT_LIST_HEAD(&active_commands[i]);
> +               writel(DMOV_CONFIG_IRQ_EN | DMOV_CONFIG_FORCE_TOP_PTR_RSLT | DMOV_CONFIG_FORCE_FLUSH_RSLT, DMOV_CONFIG(i));
> +       }
> +       clk = clk_get(NULL, "adm_clk");
> +       if (IS_ERR(clk))
> +               return PTR_ERR(clk);
> +       clk_prepare(clk);
> +       msm_dmov_clk = clk;
> +       ret = request_irq(INT_ADM_AARM, msm_datamover_irq_handler, 0, "msmdatamover", NULL);
> +       if (ret)
> +               return ret;
> +       disable_irq(INT_ADM_AARM);
> +       return 0;
> +}
> +module_init(msm_init_datamover);
> +
> +/* now the actual SD card driver */
> +
>  #include "msm_sdcc.h"
>
>  #define DRIVER_NAME "msm-sdcc"
> --
> 2.1.0.rc2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
