From: yuvaraj.cd@gmail.com (Yuvaraj Kumar)
Date: Tue, 1 Jul 2014 16:47:20 +0530
Subject: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
In-Reply-To: <001101cf91f9$84111530$8c333f90$%jun@samsung.com>
References: <1403520321-2431-1-git-send-email-yuvaraj.cd@samsung.com>
 <1403520321-2431-4-git-send-email-yuvaraj.cd@samsung.com>
 <001501cf9076$9de45000$d9acf000$%jun@samsung.com>
 <CAD=FV=UE2LkXZb-UuR8t9kS2+odeVHU59K5fN=veMU8Y513w=A@mail.gmail.com>
 <005001cf912b$27fb8510$77f28f30$%jun@samsung.com>
 <CAD=FV=X7h75ktaLG1MYa9Rs0Repu0QNq-p0-4TU2cforgjCdtw@mail.gmail.com>
 <CAKuRcOJ0=GxmfBTu=Ax0yjLvbXJRjbVDJzHLR=f1nxkGZh9tAg@mail.gmail.com>
 <001101cf91f9$84111530$8c333f90$%jun@samsung.com>
Message-ID: <CAKuRcOL=iQ8_67Bjhd+xpWUxnGmGfrSca1ZwnJm+zqRaapQgmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 27, 2014 at 4:48 PM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Hi Yuvaraj,
>
> On Fri, June 27, 2014, Yuvaraj Kumar wrote:
>> On Thu, Jun 26, 2014 at 10:20 PM, Doug Anderson <dianders@chromium.org> wrote:
>> > Seungwon,
>> >
>> > On Thu, Jun 26, 2014 at 3:41 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >> On Thu, June 26, 2014, Doug Anderson wrote:
>> >>> Seungwon,
>> >>>
>> >>> On Wed, Jun 25, 2014 at 6:08 AM, Seungwon Jeon <tgih.jun@samsung.com> wrote:
>> >>> > On Mon, June 23, 2014, Yuvaraj Kumar C D wrote:
>> >>> >> Subject: [PATCH 3/3] mmc: dw_mmc: Support voltage changes
>> >>> >>
>> >>> >> From: Doug Anderson <dianders@chromium.org>
>> >>> >>
>> >>> >> For UHS cards we need the ability to switch voltages from 3.3V to
>> >>> >> 1.8V.  Add support to the dw_mmc driver to handle this.  Note that
>> >>> >> dw_mmc needs a little bit of extra code since the interface needs a
>> >>> >> special bit programmed to the CMD register while CMD11 is progressing.
>> >>> >> This means adding a few extra states to the state machine to track.
>> >>> >
>> >>> > Overall new additional states makes it complicated.
>> >>> > Can we do that in other way?
>> >>>
>> >>> That was the best I was able to figure out when I thought this
>> >>> through.  If you have ideas for doing it another way I'd imagine that
>> >>> Yuvaraj would be happy to take your feedback.
>> >> Let's clean up SDMMC_CMD_VOLT_SWITCH.
>> >> In turn, we may remove state-handling simply.
>> >>
>> >>>
>> >>>
>> >>> >> Signed-off-by: Doug Anderson <dianders@chromium.org>
>> >>> >> Signed-off-by: Yuvaraj Kumar C D <yuvaraj.cd@samsung.com>
>> >>> >>
>> >>> >> ---
>> >>> >>  drivers/mmc/host/dw_mmc.c  |  145 +++++++++++++++++++++++++++++++++++++++++---
>> >>> >>  drivers/mmc/host/dw_mmc.h  |    5 +-
>> >>> >>  include/linux/mmc/dw_mmc.h |    2 +
>> >>> >>  3 files changed, 142 insertions(+), 10 deletions(-)
>> >>> >>
>> >>> >> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> >>> >> index e034bce..38eb548 100644
>> >>> >> --- a/drivers/mmc/host/dw_mmc.c
>> >>> >> +++ b/drivers/mmc/host/dw_mmc.c
>> >>> >> @@ -29,6 +29,7 @@
>> >>> >>  #include <linux/irq.h>
>> >>> >>  #include <linux/mmc/host.h>
>> >>> >>  #include <linux/mmc/mmc.h>
>> >>> >> +#include <linux/mmc/sd.h>
>> >>> >>  #include <linux/mmc/sdio.h>
>> >>> >>  #include <linux/mmc/dw_mmc.h>
>> >>> >>  #include <linux/bitops.h>
>> >>> >> @@ -235,10 +236,13 @@ err:
>> >>> >>  }
>> >>> >>  #endif /* defined(CONFIG_DEBUG_FS) */
>> >>> >>
>> >>> >> +static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg);
>> >>> >> +
>> >>> >>  static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command *cmd)
>> >>> >>  {
>> >>> >>       struct mmc_data *data;
>> >>> >>       struct dw_mci_slot *slot = mmc_priv(mmc);
>> >>> >> +     struct dw_mci *host = slot->host;
>> >>> >>       const struct dw_mci_drv_data *drv_data = slot->host->drv_data;
>> >>> >>       u32 cmdr;
>> >>> >>       cmd->error = -EINPROGRESS;
>> >>> >> @@ -254,6 +258,32 @@ static u32 dw_mci_prepare_command(struct mmc_host *mmc, struct mmc_command
>> >>> *cmd)
>> >>> >>       else if (cmd->opcode != MMC_SEND_STATUS && cmd->data)
>> >>> >>               cmdr |= SDMMC_CMD_PRV_DAT_WAIT;
>> >>> >>
>> >>> >> +     if (cmd->opcode == SD_SWITCH_VOLTAGE) {
>> >>> >> +             u32 clk_en_a;
>> >>> >> +
>> >>> >> +             /* Special bit makes CMD11 not die */
>> >>> >> +             cmdr |= SDMMC_CMD_VOLT_SWITCH;
>> >>> >> +
>> >>> >> +             /* Change state to continue to handle CMD11 weirdness */
>> >>> >> +             WARN_ON(slot->host->state != STATE_SENDING_CMD);
>> >>> >> +             slot->host->state = STATE_SENDING_CMD11;
>> >>> >> +
>> >>> >> +             /*
>> >>> >> +              * We need to disable clock stop while doing voltage switch
>> >>> >> +              * according to 7.4.1.2 Voltage Switch Normal Scenario.
>> >>> >> +              *
>> >>> >> +              * It's assumed that by the next time the CLKENA is updated
>> >>> >> +              * (when we set the clock next) that the voltage change will
>> >>> >> +              * be over, so we don't bother setting any bits to synchronize
>> >>> >> +              * with dw_mci_setup_bus().
>> >>> >> +              */
>> >>> >> +             clk_en_a = mci_readl(host, CLKENA);
>> >>> >> +             clk_en_a &= ~(SDMMC_CLKEN_LOW_PWR << slot->id);
>> >>> >> +             mci_writel(host, CLKENA, clk_en_a);
>> >>> >> +             mci_send_cmd(slot, SDMMC_CMD_UPD_CLK |
>> >>> >> +                          SDMMC_CMD_PRV_DAT_WAIT, 0);
>> >>> > dw_mci_disable_low_power() can be used here.
>> >>>
>> >>> Ah.  I guess we don't have that locally anymore.  Locally we have variants on:
>> >> I'm checking on cjb/mmc branch.
>> >>
>> >>> * https://patchwork.kernel.org/patch/3070311/
>> >>> * https://patchwork.kernel.org/patch/3070251/
>> >>> * https://patchwork.kernel.org/patch/3070221/
>> >>>
>> >>> ...which removed that function.  ...but I guess upstream never picked
>> >>> up those patches, huh?  Looking back it looks like you had some
>> >>> feedback and it needed another spin but somehow fell off my plate.  :(
>> >>>
>> >>> Maybe this is something Yuvaraj would like to pick up?
>> >> It's long ago. I remember that there is no progress since my last comment.
>> >> In case of patch "3070221", I want to pick up for next Kernel.
>> >
>> > Sounds like Yuvaraj has agreed to look at addressing your comments.  Thanks!
>> >
>> >
>> >>> >> +     }
>> >>> >> +
>> >>> >>       if (cmd->flags & MMC_RSP_PRESENT) {
>> >>> >>               /* We expect a response, so set this bit */
>> >>> >>               cmdr |= SDMMC_CMD_RESP_EXP;
>> >>> >> @@ -776,11 +806,15 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
>> >>> >>       unsigned int clock = slot->clock;
>> >>> >>       u32 div;
>> >>> >>       u32 clk_en_a;
>> >>> >> +     u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
>> >>> >> +
>> >>> >> +     /* We must continue to set bit 28 in CMD until the change is complete */
>> >>> >> +     if (host->state == STATE_WAITING_CMD11_DONE)
>> >>> >> +             sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
>> >>> > I didn't get the reason SDMMC_CMD_VOLT_SWITCH is needed during clock update(enable/disable)
>> >>> > Can you explain it in details?
>> >>>
>> >>> Simply put: if I didn't do this then the system hung during voltage
>> >>> switch.  It was not documented in the version of the IP manual that I
>> >>> had access to and it took me a bunch of digging / trial and error to
>> >>> figure this out.  Whatever this bit does internally it's important to
>> >>> set it while the voltage change is happening.  Note that this need was
>> >>> the whole reason for adding the extra state to the state machine.
>> >>>
>> >>> Perhaps Yuvaraj can try without it and I'd assume he'll report the
>> >>> same freeze.
>> >> Clarify the necessity of SDMMC_CMD_VOLT_SWITCH.
>> >> As far as I experience, we didn't apply this bit for several projects.
>> >
>> > I just tried this locally on our ChromeOS 3.8 kernel (which has quite
>> > a few backports and matches dw_mmc upstream pretty closely).  When I
>> > take out "sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH" and bootup it fails
>> > to bringup WiFi chip.  It prints messages like:
>> >
>> > [    4.400842] mmc_host mmc1: Timeout sending command (cmd 0x202000
>> > arg 0x0 status 0x80202000)
>> >
>> > I will let Yuvaraj comment about his testing too.
>> To make it simple and verify, i have just enabled eMMC and SD channels
>> on 3.16-rc1 and tested.
>> Without "sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH" bootup fails.
>> [    3.015971] mmc_host mmc1: Timeout sending command (cmd 0x202000
>> arg 0x0 status 0x80202000)
>> [    3.530974] mmc_host mmc1: Timeout sending command (cmd 0x202000
>> arg 0x0 status 0x80202000)
> Thank you for test.
> Hmm, it failed during clock update, right?.
> Can you check HLE interrupt at this time?
> I'll investigate for this.
Yes, it failed during clock update.I am dumping the register contents
just before the dev_err statement.I can observe that 1st timeout does
not have HLE interrupt.But once we set bit 0 of UHS_REG subsequent
timeout's have HLE bit set.I am attaching the complete log.
>
>> >
>> >
>> >>> >> +static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
>> >>> >> +{
>> >>> >> +     struct dw_mci_slot *slot = mmc_priv(mmc);
>> >>> >> +     struct dw_mci *host = slot->host;
>> >>> >> +     u32 uhs;
>> >>> >> +     u32 v18 = SDMMC_UHS_18V << slot->id;
>> >>> >> +     int min_uv, max_uv;
>> >>> >> +     int ret;
>> >>> >> +
>> >>> >> +     /*
>> >>> >> +      * Program the voltage.  Note that some instances of dw_mmc may use
>> >>> >> +      * the UHS_REG for this.  For other instances (like exynos) the UHS_REG
>> >>> >> +      * does no harm but you need to set the regulator directly.  Try both.
>> >>> >> +      */
>> >>> >> +     uhs = mci_readl(host, UHS_REG);
>> >>> >> +     if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
>> >>> >> +             min_uv = 2700000;
>> >>> >> +             max_uv = 3600000;
>> >>> >> +             uhs &= ~v18;
>> >>> >> +     } else {
>> >>> >> +             min_uv = 1700000;
>> >>> >> +             max_uv = 1950000;
>> >>> >> +             uhs |= v18;
>> >>> >> +     }
>> >>> >> +     if (!IS_ERR(mmc->supply.vqmmc)) {
>> >>> >> +             ret = regulator_set_voltage(mmc->supply.vqmmc, min_uv, max_uv);
>> >>> >> +
>> >>> >> +             /*
>> >>> >> +              * Only complain if regulator claims that it's not in the 1.8V
>> >>> >> +              * range.  This avoids a bunch of errors in the case that
>> >>> >> +              * we've got a fixed 1.8V regulator but the core SD code still
>> >>> >> +              * thinks it ought to try to switch to 3.3 and then back to 1.8
>> >>> >> +              */
>> >>> >> +             if (ret) {
>> >>> > I think if ret is error, printing message and returning error is good.
>> >>> > Currently, just returning '0' though it fails.
>> >> Any feedback?
>> >
>> > Whoops, right.  I think you're right that in the case it warns it
>> > should also return the error code.  In the case it doesn't warn it
>> > shouldn't.  Also: possibly we should use a trick like the mmc core
>> > does and use "regulator_count_voltages" to figure out if we're going
>> > to be able to switch voltages...
>> >
>> >>> > Artificially adding SDMMC_INT_CMD_DONE to pending is needed to complete cmd handling?
>> >>> > Is there any reason?
>> >>>
>> >>> I don't remember this for sure since I wrote this a long time ago.
>> >>> Maybe it's not needed?  I may have just been modeling on other
>> >>> interrupts.
>> >> If there is no specific reason, please remove it.
>> >
>> > OK, we'll see how Yuvaraj's testing goes without it.  My incredibly
>> > brief testing in our local Chrome OS 3.8 tree shows that the WiFi is
>> > not detected properly if I comment out the line:
>> >   dw_mci_cmd_interrupt(host,
>> >     pending | SDMMC_INT_CMD_DONE);
>> >
>> > It may be sufficient to simply schedule the tasklet or to do some
>> > other subset of dw_mci_cmd_interrupt().  Yuvaraj can confirm on the
>> > latest kernel and also investigate further.
> How about completing CMD without SDMMC_INT_CMD_DONE?
Without this tuning fails.
[    2.525284] mmc_host mmc0: Bus speed (slot 0) = 200000000Hz (slot
req 200000000Hz, actual 200000000HZ div = 0)
[  198.556573] random: nonblocking pool is initialized
[  240.226044] INFO: task kworker/u8:0:6 blocked for more than 120 seconds.
[  240.231276]       Not tainted 3.16.0-rc1-00010-g2f7a756-dirty #55
[  240.237359] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[  240.245150] kworker/u8:0    D c03a58a0     0     6      2 0x00000000
[  240.251487] Workqueue: kmmcd mmc_rescan
[  240.255297] [<c03a58a0>] (__schedule) from [<c03a5330>]
(schedule_timeout+0x130/0x170)
[  240.263201] [<c03a5330>] (schedule_timeout) from [<c03a6540>]
(wait_for_common+0xbc/0x14c)
[  240.271441] [<c03a6540>] (wait_for_common) from [<c02ca6e4>]
(mmc_wait_for_req_done+0x6c/0xf0)
[  240.280031] [<c02ca6e4>] (mmc_wait_for_req_done) from [<c02e3f10>]
(dw_mci_exynos_execute_tuning+0x1d4/0x2c4)
[  240.289919] [<c02e3f10>] (dw_mci_exynos_execute_tuning) from
[<c02e0198>] (dw_mci_execute_tuning+0x54/0xb4)
[  240.299635] [<c02e0198>] (dw_mci_execute_tuning) from [<c02cf47c>]
(mmc_init_card+0xeec/0x14ac)
[  240.308309] [<c02cf47c>] (mmc_init_card) from [<c02cfc34>]
(mmc_attach_mmc+0x8c/0x160)
[  240.316202] [<c02cfc34>] (mmc_attach_mmc) from [<c02cca0c>]
(mmc_rescan+0x2b0/0x308)
[  240.323924] [<c02cca0c>] (mmc_rescan) from [<c0032f60>]
(process_one_work+0xf8/0x364)
[  240.331732] [<c0032f60>] (process_one_work) from [<c0033800>]
(worker_thread+0x50/0x5a0)
[  240.339799] [<c0033800>] (worker_thread) from [<c0038e7c>]
(kthread+0xd8/0xf0)
[  240.346999] [<c0038e7c>] (kthread) from [<c000e438>]
(ret_from_fork+0x14/0x3c)

>
> Thanks,
> Seungwon Jeon
>
-------------- next part --------------
[  360.231140] INFO: task swapper/0:1 blocked for more than 120 seconds.
[  360.236113]       Not tainted 3.16.0-rc1-00010-g2f7a756-dirty #52
[  360.242183] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  360.249991] swapper/0       D c03a5858     0     1      0 0x00000000
[  360.256329] [<c03a5858>] (__schedule) from [<c03a52c8>] (schedule_timeout+0x110/0x170)
[  360.264222] [<c03a52c8>] (schedule_timeout) from [<c0028540>] (msleep+0x2c/0x38)
[  360.271596] [<c0028540>] (msleep) from [<c0503394>] (prepare_namespace+0x13c/0x1d4)
[  360.279229] [<c0503394>] (prepare_namespace) from [<c0502d54>] (kernel_init_freeable+0x1cc/0x1dc)
[  360.288077] [<c0502d54>] (kernel_init_freeable) from [<c03a0bcc>] (kernel_init+0xc/0xe8)
[  360.296145] [<c03a0bcc>] (kernel_init) from [<c000e438>] (ret_from_fork+0x14/0x3c)
[  480.231101] INFO: task swapper/0:1 blocked for more than 120 seconds.
[  480.236069]       Not tainted 3.16.0-rc1-00010-g2f7a756-dirty #52
[  480.242138] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  480.249949] swapper/0       D c03a5858     0     1      0 0x00000000
[  480.256284] [<c03a5858>] (__schedule) from [<c03a52c8>] (schedule_timeout+0x110/0x170)
[  480.264178] [<c03a52c8>] (schedule_timeout) from [<c0028540>] (msleep+0x2c/0x38)
[  480.271551] [<c0028540>] (msleep) from [<c0503394>] (prepare_namespace+0x13c/0x1d4)
[  480.279185] [<c0503394>] (prepare_namespace) from [<c0502d54>] (kernel_init_freeable+0x1cc/0x1dc)
[  480.288033] [<c0502d54>] (kernel_init_freeable) from [<c03a0bcc>] (kernel_init+0xc/0xe8)
[  480.296101] [<c03a0bcc>] (kernel_init) from [<c000e438>] (ret_from_fork+0x14/0x3c)
[  600.231135] INFO: task swapper/0:1 blocked for more than 120 seconds.
[  600.236103]       Not tainted 3.16.0-rc1-00010-g2f7a756-dirty #52
[  600.242173] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  600.249981] swapper/0       D c03a5858     0     1      0 0x00000000
[  600.256319] [<c03a5858>] (__schedule) from [<c03a52c8>] (schedule_timeout+0x110/0x170)
[  600.264212] [<c03a52c8>] (schedule_timeout) from [<c0028540>] (msleep+0x2c/0x38)
[  600.271585] [<c0028540>] (msleep) from [<c0503394>] (prepare_namespace+0x13c/0x1d4)
[  600.279219] [<c0503394>] (prepare_namespace) from [<c0502d54>] (kernel_init_freeable+0x1cc/0x1dc)
[  600.288068] [<c0502d54>] (kernel_init_freeable) from [<c03a0bcc>] (kernel_init+0xc/0xe8)
[  600.296136] [<c03a0bcc>] (kernel_init) from [<c000e438>] (ret_from_fork+0x14/0x3c)


U-Boot 2013.04 (Feb 21 2014 - 15:29:10) for Peach

CPU:	Exynos5420 at 900MHz

Board: Google Peach Pit, rev 6.0
I2C:   ready
DRAM:  2 GiB
PMIC max77802-pmic initialized
CPU:	Exynos5420 at 1800MHz
TPS65090 PMIC EC init
MMC:   EXYNOS DWMMC: 0, EXYNOS DWMMC: 1
SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
In:    cros-ec-keyb
Out:   lcd
Err:   lcd
SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
ELOG: Event(17) added with size 13
Net:   No ethernet found.
Hit any key to stop autoboot:  3  2  1  0 
mmc1 is current device
2935183 bytes read in 158 ms (17.7 MiB/s)
## Loading kernel from FIT Image at 20008000 ...
   Using 'conf at 1' configuration
   Trying 'kernel at 1' kernel subimage
     Description:  unavailable
     Type:         Kernel Image (no loading done)
     Compression:  uncompressed
     Data Start:   0x200080a4
     Data Size:    2893976 Bytes = 2.8 MiB
   Verifying Hash Integrity ... OK
## Loading fdt from FIT Image at 20008000 ...
   Using 'conf at 1' configuration
   Trying 'fdt at 1' fdt subimage
     Description:  exynos5420-peach-pit.dtb
     Type:         Flat Device Tree
     Compression:  uncompressed
     Data Start:   0x202ca9f4
     Data Size:    40098 Bytes = 39.2 KiB
     Architecture: ARM
   Verifying Hash Integrity ... OK
   Booting using the fdt blob at 0x202ca9f4
   XIP Kernel Image (no loading done) ... OK
   Loading Device Tree to 3ffe6000, end 3ffff1d1 ... OK
boot_kernel.c: ft_board_setup: warning: g_crossystem_data is NULL

Starting kernel ...

Timer summary in microseconds:
       Mark    Elapsed  Stage
          0          0  reset
    114,935    114,935  board_init_f
    158,743     43,808  board_init_r
    245,247     86,504  id=64
    247,201      1,954  main_loop
  3,720,769  3,473,568  bootm_start
  3,720,770          1  id=1
  3,725,417      4,647  id=100
  3,725,420          3  id=101
  3,725,420          0  id=102
  3,728,731      3,311  id=110
  3,753,507     24,776  id=105
  3,753,508          1  id=106
  3,753,512          4  id=107
  3,753,513          1  id=109
  3,753,513          0  id=108
  3,757,905      4,392  id=90
  3,757,907          2  id=92
  3,757,907          0  id=91
  3,787,512     29,605  id=95
  3,787,515          3  id=96
  3,787,516          1  id=97
  3,787,518          2  id=98
  3,787,519          1  id=99
  3,796,747      9,228  id=7
  3,808,661     11,914  id=15
  3,811,322      2,661  start_kernel

Accumulated time:
                 6,921  SPI read
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 3.16.0-rc1-00010-g2f7a756-dirty (chromeos at yuvaraj) (gcc version 4.8.3 20140106 (prerelease) (crosstool-NG linaro-1.13.1-4.8-2014.01 - Linaro GCC 2013.11) ) #53 SMP PREEMPT Tue Jul 1 14:55:34 IST 2014
[    0.000000] CPU: ARMv7 Processor [412fc0f3] revision 3 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] Machine model: Google Peach Pit Rev 6+
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat c0583300, node_mem_map ee7f4000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 2576 pages used for memmap
[    0.000000]   HighMem zone: 329728 pages, LIFO batch:31
[    0.000000] PERCPU: Embedded 7 pages/cpu @ee79f000 s7104 r8192 d13376 u32768
[    0.000000] pcpu-alloc: s7104 r8192 d13376 u32768 alloc=8*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522768
[    0.000000] Kernel command line: console=ttySAC3,115200 debug no_console_suspend root=/dev/mmcblk1p3 rootwait rw no_console_suspend clk_ignore_unused
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2073612K/2097152K available (3849K kernel code, 255K rwdata, 1244K rodata, 258K init, 271K bss, 23540K reserved, 1318912K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xffe00000   (2048 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc05017bc   (5094 kB)
[    0.000000]       .init : 0xc0502000 - 0xc0542bc0   ( 259 kB)
[    0.000000]       .data : 0xc0544000 - 0xc0583ea0   ( 256 kB)
[    0.000000]        .bss : 0xc0583eac - 0xc05c7d40   ( 272 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C: failed to init: -19
[    0.000004] sched_clock: 64 bits at 24MHz, resolution 41ns, wraps every 2863311519744ns
[    0.000196] Console: colour dummy device 80x30
[    0.000211] Calibrating delay loop... 3594.64 BogoMIPS (lpj=8986624)
[    0.030003] pid_max: default: 32768 minimum: 301
[    0.030103] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.030111] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.030434] CPU: Testing write buffer coherency: ok
[    0.030577] CPU0: update cpu_capacity 1024
[    0.030584] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.030681] Setting up static identity map for 0x203aa130 - 0x203aa188
[    0.030779] ARM CCI driver probed
[    0.030814] Exynos MCPM support installed
[    0.060235] CPU1: Booted secondary processor
[    0.090006] CPU1: update cpu_capacity 1024
[    0.090010] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.100228] CPU2: Booted secondary processor
[    0.130007] CPU2: update cpu_capacity 1024
[    0.130011] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.140237] CPU3: Booted secondary processor
[    0.170008] CPU3: update cpu_capacity 1024
[    0.170011] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.170070] Brought up 4 CPUs
[    0.170088] SMP: Total of 4 processors activated.
[    0.170093] CPU: All CPU(s) started in SVC mode.
[    0.170441] devtmpfs: initialized
[    0.175525] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.175844] pinctrl core: initialized pinctrl subsystem
[    0.176196] regulator-dummy: no parameters
[    0.188219] NET: Registered protocol family 16
[    0.188367] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.191769] gpiochip_add: registered GPIOs 0 to 7 on device: gpy7
[    0.191778] gpiochip_add: registered GPIOs 8 to 15 on device: gpx0
[    0.191787] gpiochip_add: registered GPIOs 16 to 23 on device: gpx1
[    0.191794] gpiochip_add: registered GPIOs 24 to 31 on device: gpx2
[    0.191802] gpiochip_add: registered GPIOs 32 to 39 on device: gpx3
[    0.192475] gpiochip_add: registered GPIOs 40 to 47 on device: gpc0
[    0.192484] gpiochip_add: registered GPIOs 48 to 55 on device: gpc1
[    0.192491] gpiochip_add: registered GPIOs 56 to 62 on device: gpc2
[    0.192498] gpiochip_add: registered GPIOs 63 to 66 on device: gpc3
[    0.192505] gpiochip_add: registered GPIOs 67 to 68 on device: gpc4
[    0.192513] gpiochip_add: registered GPIOs 69 to 76 on device: gpd1
[    0.192520] gpiochip_add: registered GPIOs 77 to 82 on device: gpy0
[    0.192526] gpiochip_add: registered GPIOs 83 to 86 on device: gpy1
[    0.192534] gpiochip_add: registered GPIOs 87 to 92 on device: gpy2
[    0.192541] gpiochip_add: registered GPIOs 93 to 100 on device: gpy3
[    0.192548] gpiochip_add: registered GPIOs 101 to 108 on device: gpy4
[    0.192555] gpiochip_add: registered GPIOs 109 to 116 on device: gpy5
[    0.192562] gpiochip_add: registered GPIOs 117 to 124 on device: gpy6
[    0.193044] gpiochip_add: registered GPIOs 125 to 132 on device: gpe0
[    0.193052] gpiochip_add: registered GPIOs 133 to 134 on device: gpe1
[    0.193060] gpiochip_add: registered GPIOs 135 to 140 on device: gpf0
[    0.193067] gpiochip_add: registered GPIOs 141 to 148 on device: gpf1
[    0.193073] gpiochip_add: registered GPIOs 149 to 156 on device: gpg0
[    0.193080] gpiochip_add: registered GPIOs 157 to 164 on device: gpg1
[    0.193087] gpiochip_add: registered GPIOs 165 to 166 on device: gpg2
[    0.193095] gpiochip_add: registered GPIOs 167 to 170 on device: gpj4
[    0.193533] gpiochip_add: registered GPIOs 171 to 178 on device: gpa0
[    0.193542] gpiochip_add: registered GPIOs 179 to 184 on device: gpa1
[    0.193549] gpiochip_add: registered GPIOs 185 to 192 on device: gpa2
[    0.193556] gpiochip_add: registered GPIOs 193 to 197 on device: gpb0
[    0.193563] gpiochip_add: registered GPIOs 198 to 202 on device: gpb1
[    0.193570] gpiochip_add: registered GPIOs 203 to 206 on device: gpb2
[    0.193578] gpiochip_add: registered GPIOs 207 to 214 on device: gpb3
[    0.193584] gpiochip_add: registered GPIOs 215 to 216 on device: gpb4
[    0.193592] gpiochip_add: registered GPIOs 217 to 224 on device: gph0
[    0.194166] gpiochip_add: registered GPIOs 225 to 231 on device: gpz
[    0.195182] exynos-audss-clk 3810000.audss-clock-controller: setup completed
[    0.202280] EXYNOS5420 PMU Initialized
[    0.225885] of_get_named_gpiod_flags exited with status 0
[    0.225989] P5.0V_USB3CON0: 5000 mV 
[    0.226120] of_get_named_gpiod_flags exited with status 0
[    0.226218] P5.0V_USB3CON1: 5000 mV 
[    0.226338] of_get_named_gpiod_flags exited with status 0
[    0.226435] mask-tpm-reset : no parameters
[    0.226534] of_get_named_gpiod_flags: can't parse gpios property of node '/fixed-regulator[0]'
[    0.226619] vbat-supply: no parameters
[    0.227865] SCSI subsystem initialized
[    0.228201] usbcore: registered new interface driver usbfs
[    0.228278] usbcore: registered new interface driver hub
[    0.228365] usbcore: registered new device driver usb
[    0.228679] s3c-i2c 12c80000.i2c: slave address 0x50
[    0.228691] s3c-i2c 12c80000.i2c: bus frequency set to 65 KHz
[    0.228819] s3c-i2c 12c80000.i2c: i2c-2: S3C I2C adapter
[    0.229783] Switched to clocksource mct-frc
[    0.239452] NET: Registered protocol family 2
[    0.239861] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.239909] TCP bind hash table entries: 8192 (order: 5, 163840 bytes)
[    0.240000] TCP: Hash tables configured (established 8192 bind 8192)
[    0.240042] TCP: reno registered
[    0.240051] UDP hash table entries: 512 (order: 2, 24576 bytes)
[    0.240074] UDP-Lite hash table entries: 512 (order: 2, 24576 bytes)
[    0.240203] NET: Registered protocol family 1
[    0.241230] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.251484] ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.251664] msgmni has been set to 1474
[    0.252030] bounce: pool size: 64 pages
[    0.252039] io scheduler noop registered
[    0.252048] io scheduler deadline registered
[    0.252394] io scheduler cfq registered (default)
[    0.254527] dma-pl330 3880000.adma: Loaded driver for PL330 DMAC-2364208
[    0.254536] dma-pl330 3880000.adma: 	DBUFF-4x8bytes Num_Chans-6 Num_Peri-16 Num_Events-6
[    0.257230] dma-pl330 121a0000.pdma: Loaded driver for PL330 DMAC-2364208
[    0.257239] dma-pl330 121a0000.pdma: 	DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.259761] dma-pl330 121b0000.pdma: Loaded driver for PL330 DMAC-2364208
[    0.259770] dma-pl330 121b0000.pdma: 	DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.260576] dma-pl330 10800000.mdma: Loaded driver for PL330 DMAC-2364208
[    0.260585] dma-pl330 10800000.mdma: 	DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[    0.323551] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.324867] 12c00000.serial: ttySAC0 at MMIO 0x12c00000 (irq = 83, base_baud = 0) is a S3C6400/10
[    0.325182] 12c10000.serial: ttySAC1 at MMIO 0x12c10000 (irq = 84, base_baud = 0) is a S3C6400/10
[    0.325489] 12c20000.serial: ttySAC2 at MMIO 0x12c20000 (irq = 85, base_baud = 0) is a S3C6400/10
[    0.325802] 12c30000.serial: ttySAC3 at MMIO 0x12c30000 (irq = 86, base_baud = 0) is a S3C6400/10
[    1.218428] console [ttySAC3] enabled
[    1.229272] brd: module loaded
[    1.233958] loop: module loaded
[    1.236558] of_get_named_gpiod_flags exited with status 0
[    1.241505] cros-ec-spi spi2.0: Chrome EC (SPI)
[    1.245893] usbcore: registered new interface driver asix
[    1.250963] usbcore: registered new interface driver ax88179_178a
[    1.257022] usbcore: registered new interface driver cdc_ether
[    1.262858] usbcore: registered new interface driver smsc75xx
[    1.268577] usbcore: registered new interface driver smsc95xx
[    1.274292] usbcore: registered new interface driver net1080
[    1.279929] usbcore: registered new interface driver cdc_subset
[    1.285828] usbcore: registered new interface driver zaurus
[    1.291402] usbcore: registered new interface driver cdc_ncm
[    1.297421] usb at 12000000 supply vdd33 not found, using dummy regulator
[    1.303517] usb at 12000000 supply vdd10 not found, using dummy regulator
[    1.310228] platform 12000000.dwc3: Driver dwc3 requests probe deferral
[    1.316791] usb at 12400000 supply vdd33 not found, using dummy regulator
[    1.323129] usb at 12400000 supply vdd10 not found, using dummy regulator
[    1.329836] platform 12400000.dwc3: Driver dwc3 requests probe deferral
[    1.336239] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.342692] ehci-exynos: EHCI EXYNOS driver
[    1.346967] of_get_named_gpiod_flags: can't parse gpios property of node '/usb at 12110000[0]'
[    1.355197] exynos-ehci 12110000.usb: no usb2 phy configured
[    1.360825] platform 12110000.usb: Driver exynos-ehci requests probe deferral
[    1.368067] usbcore: registered new interface driver usb-storage
[    1.374492] mousedev: PS/2 mouse device common for all mice
[    1.379894] input: cros-ec-spi as /devices/12d40000.spi/spi_master/spi2/spi2.0/cros-ec-keyb.1/input/input0
[    1.389624] s3c-rtc 101e0000.rtc: rtc disabled, re-enabling
[    1.394891] s3c-rtc 101e0000.rtc: rtc core: registered s3c as rtc0
[    1.400821] s3c-rtc 101e0000.rtc: warning: invalid RTC value so initializing it
[    1.408986] of_get_named_gpiod_flags exited with status 0
[    1.413480] of_get_named_gpiod_flags exited with status 0
[    1.418861] of_get_named_gpiod_flags exited with status 0
[    1.424234] of_get_named_gpiod_flags exited with status 0
[    1.429617] of_get_named_gpiod_flags exited with status 0
[    1.434993] of_get_named_gpiod_flags exited with status 0
[    1.440377] of_get_named_gpiod_flags exited with status 0
[    1.445751] of_get_named_gpiod_flags exited with status 0
[    1.451343] max77xxx 4-0009: device found
[    1.455624] max77xxx 4-0009: no regulator-op-mode property property at LDO2
[    1.462165] max77xxx 4-0009: no regulator-op-mode property property at LDO4
[    1.469161] max77xxx 4-0009: no regulator-op-mode property property at LDO7
[    1.476474] max77xxx 4-0009: no regulator-op-mode property property at LDO18
[    1.483023] max77xxx 4-0009: no regulator-op-mode property property at LDO19
[    1.490094] max77xxx 4-0009: no regulator-op-mode property property at LDO21
[    1.497073] max77xxx 4-0009: no regulator-op-mode property property at LDO23
[    1.504093] max77xxx 4-0009: no regulator-op-mode property property at LDO24
[    1.511130] max77xxx 4-0009: no regulator-op-mode property property at LDO25
[    1.518149] max77xxx 4-0009: no regulator-op-mode property property at LDO26
[    1.525194] max77xxx 4-0009: no regulator-op-mode property property at LDO27
[    1.532201] max77xxx 4-0009: no regulator-op-mode property property at LDO28
[    1.539228] max77xxx 4-0009: no regulator-op-mode property property at LDO29
[    1.546309] max77xxx 4-0009: no regulator-op-mode property property at LDO32
[    1.553281] max77xxx 4-0009: no regulator-op-mode property property at LDO33
[    1.560309] max77xxx 4-0009: no regulator-op-mode property property at LDO34
[    1.567335] max77xxx 4-0009: no regulator-op-mode property property at LDO35
[    1.574924] max77xxx 4-0009: no regulator-op-mode property property at EN32KHZ_AP
[    1.581822] max77xxx 4-0009: no regulator-op-mode property property at EN32KHZ_CP
[    1.589543] vdd_1v0: 1000 mV 
[    1.592477] vdd_1v2_2: 1200 mV 
[    1.595686] vdd_1v8_3: 1800 mV 
[    1.598693] vdd_sd: 1800 <--> 2800 mV at 2800 mV 
[    1.603481] vdd_1v8_5: 1800 mV 
[    1.606606] vdd_1v8_6: 1800 mV 
[    1.609631] vdd_1v8_7: 1800 mV 
[    1.612863] vdd_ldo8: 1000 mV 
[    1.615895] vdd_ldo9: 1800 mV 
[    1.618909] vdd_ldo10: 1800 mV 
[    1.622054] vdd_ldo11: 1800 mV 
[    1.625181] vdd_ldo12: 3000 mV 
[    1.628276] vdd_ldo13: 1800 mV 
[    1.631426] vdd_ldo14: 1800 mV 
[    1.634524] vdd_ldo15: 1000 mV 
[    1.637674] vdd_g3ds: 900 <--> 1400 mV at 1000 mV 
[    1.642354] ldo_18: 1800 mV 
[    1.645212] ldo_19: 1800 mV 
[    1.648067] ldo_20: 1800 mV 
[    1.650936] ldo_21: 2800 mV 
[    1.653786] ld0_23: 3300 mV 
[    1.656673] ldo_24: 2800 mV 
[    1.659510] ldo_25: 3300 mV 
[    1.662477] ldo_26: 1200 mV 
[    1.665259] ldo_27: 1200 mV 
[    1.668104] ldo_28: 1800 mV 
[    1.670984] ldo_29: 1800 mV 
[    1.673910] vdd_mifs: 900 <--> 1300 mV at 1000 mV 
[    1.678615] ldo_32: 3000 mV 
[    1.681475] ldo_33: 2800 mV 
[    1.684321] ldo_34: 3000 mV 
[    1.687209] ldo_35: 1200 mV 
[    1.690485] vdd_mif: 800 <--> 1300 mV at 1000 mV 
[    1.695157] vdd_arm: 800 <--> 1500 mV at 1262 mV 
[    1.699826] vdd_int: 800 <--> 1400 mV at 1000 mV 
[    1.704487] vdd_g3d: 700 <--> 1400 mV at 1000 mV 
[    1.709013] vdd_1v2: 1200 mV 
[    1.712150] vdd_kfc: 800 <--> 1500 mV at 1000 mV 
[    1.716556] vdd_1v35: 1350 mV 
[    1.719673] vdd_emmc: 2850 mV 
[    1.722634] vdd_2v: 2000 mV 
[    1.725510] vdd_1v8: 1800 mV 
[    1.728283] en32khz_ap: no parameters
[    1.731792] en32khz_cp: no parameters
[    1.737923] tpm_i2c_infineon 9-0020: 1.2 TPM (device-id 0x1A)
[    1.764175] tpm_i2c_infineon 9-0020: Issuing TPM_STARTUP
[    1.930850] tps65090 0-0048: No cache defaults, reading back from HW
[    1.942070] of_get_named_gpiod_flags: can't parse gpios property of node '/spi at 12d40000/cros-ec at 0/i2c-tunnel/power-regulator at 48[0]'
[    1.952419] of_get_named_gpiod_flags: can't parse gpios property of node '/spi at 12d40000/cros-ec at 0/i2c-tunnel/power-regulator at 48[0]'
[    1.964221] of_get_named_gpiod_flags: can't parse gpios property of node '/spi at 12d40000/cros-ec at 0/i2c-tunnel/power-regulator at 48[0]'
[    1.976108] TPS65090_RAILSDCDC1: no parameters
[    1.980471] TPS65090_RAILSDCDC1: supplied by vbat-supply
[    1.989278] TPS65090_RAILSDCDC2: no parameters
[    1.992276] TPS65090_RAILSDCDC2: supplied by vbat-supply
[    2.001153] TPS65090_RAILSDCDC3: no parameters
[    2.004134] TPS65090_RAILSDCDC3: supplied by vbat-supply
[    2.012944] vcd_led: no parameters
[    2.014904] vcd_led: supplied by vbat-supply
[    2.033160] video_mid: no parameters
[    2.035298] video_mid: supplied by vbat-supply
[    2.053727] wwan_r: no parameters
[    2.055597] wwan_r: supplied by vbat-supply
[    2.063332] sdcard: no parameters
[    2.065211] sdcard: supplied by vbat-supply
[    2.072853] camout: no parameters
[    2.074709] camout: supplied by vbat-supply
[    2.082378] lcd_vdd: no parameters
[    2.084321] lcd_vdd: supplied by vbat-supply
[    2.102596] video_mid_1a: no parameters
[    2.104993] video_mid_1a: supplied by vbat-supply
[    2.113145] TPS65090_RAILSLDO1: no parameters
[    2.116061] TPS65090_RAILSLDO1: supplied by vbat-supply
[    2.121384] TPS65090_RAILSLDO2: no parameters
[    2.125599] TPS65090_RAILSLDO2: supplied by vbat-supply
[    2.131707] tps65090-charger tps65090-charger: Unable to get charger irq = -22
[    2.149999] tps65090-charger: probe of tps65090-charger failed with error -22
[    2.156234] device-mapper: ioctl: 4.27.0-ioctl (2013-10-30) initialised: dm-devel at redhat.com
[    2.164121] sdhci: Secure Digital Host Controller Interface driver
[    2.170240] sdhci: Copyright(c) Pierre Ossman
[    2.174712] Synopsys Designware Multimedia Card Interface Driver
[    2.180967] dwmmc_exynos 12200000.mmc: Using internal DMA controller.
[    2.186989] dwmmc_exynos 12200000.mmc: Version ID is 250a
[    2.192480] dwmmc_exynos 12200000.mmc: DW MMC controller at irq 107, 64 bit host data width, 64 deep fifo
[    2.201922] dwmmc_exynos 12200000.mmc: No vmmc regulator found
[    2.207718] dwmmc_exynos 12200000.mmc: No vqmmc regulator found
[    2.213616] of_get_named_gpiod_flags: can't parse gpios property of node '/mmc at 12200000[0]'
[    2.249863] dwmmc_exynos 12200000.mmc: 1 slots initialized
[    2.254040] dwmmc_exynos 12220000.mmc: Using internal DMA controller.
[    2.260311] dwmmc_exynos 12220000.mmc: Version ID is 250a
[    2.265803] dwmmc_exynos 12220000.mmc: DW MMC controller at irq 109, 64 bit host data width, 64 deep fifo
[    2.275314] dwmmc_exynos 12220000.mmc: Failed getting OCR mask: -22
[    2.281472] of_get_named_gpiod_flags: can't parse gpios property of node '/mmc at 12220000[0]'
[    2.289797] of_get_named_gpiod_flags: can't parse gpios property of node '/mmc at 12220000[0]'
[    2.292724] mmc0: BKOPS_EN bit is not set
[    2.294818] mmc_host mmc0: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    2.295201] mmc_host mmc0: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    2.295442] mmc0: new DDR MMC card at address 0001
[    2.296456] mmcblk0: mmc0:0001 MAG2GC 14.5 GiB 
[    2.296729] mmcblk0boot0: mmc0:0001 MAG2GC partition 1 4.00 MiB
[    2.296968] mmcblk0boot1: mmc0:0001 MAG2GC partition 2 4.00 MiB
[    2.297201] mmcblk0rpmb: mmc0:0001 MAG2GC partition 3 4.00 MiB
[    2.301775]  mmcblk0: p1 p2 p3 p4 p5 p6 p7
[    2.309324]  mmcblk0boot1: unknown partition table
[    2.311649]  mmcblk0boot0: unknown partition table
[    2.394847] dwmmc_exynos 12220000.mmc: 1 slots initialized
[    2.399552] usbcore: registered new interface driver usbhid
[    2.404439] usbhid: USB HID core driver
[    2.408354] TCP: cubic registered
[    2.412561] NET: Registered protocol family 17
[    2.418000] NET: Registered protocol family 15
[    2.421158] Registering SWP/SWPB emulation handler
[    2.426354] platform 12000000.dwc3: Driver dwc3 requests probe deferral
[    2.432445] platform 12400000.dwc3: Driver dwc3 requests probe deferral
[    2.439030] of_get_named_gpiod_flags: can't parse gpios property of node '/usb at 12110000[0]'
[    2.447354] exynos-ehci 12110000.usb: no usb2 phy configured
[    2.453092] platform 12110000.usb: Driver exynos-ehci requests probe deferral
[    2.460375] of_get_named_gpiod_flags exited with status 0
[    2.465468] gpio-18 (Power): gpiod_set_debounce: missing set() or set_debounce() operations
[    2.475279] input: gpio-keys as /devices/gpio-keys/input/input1
[    2.480647] s3c-rtc 101e0000.rtc: setting system clock to 2000-01-01 00:00:01 UTC (946684801)
[    2.480650] platform 12000000.dwc3: Driver dwc3 requests probe deferral
[    2.480979] platform 12400000.dwc3: Driver dwc3 requests probe deferral
[    2.481285] of_get_named_gpiod_flags: can't parse gpios property of node '/usb at 12110000[0]'
[    2.481321] exynos-ehci 12110000.usb: no usb2 phy configured
[    2.481361] platform 12110000.usb: Driver exynos-ehci requests probe deferral
[    2.685427] TPS65090_RAILSLDO2: disabling
[    2.687991] TPS65090_RAILSLDO1: disabling
[    2.705531] TPS65090_RAILSDCDC3: disabling
[    2.708187] TPS65090_RAILSDCDC2: disabling
[    2.712305] TPS65090_RAILSDCDC1: disabling
[    2.716674] vdd_1v2_2: disabling
[    2.719861] P5.0V_USB3CON1: disabling
[    2.723210] P5.0V_USB3CON0: disabling
[    2.726898] clk: Not disabling unused clocks
[    2.735415] Waiting for root device /dev/mmcblk1p3...
[    2.944793] dwmmc_exynos 12220000.mmc: : ============== REGISTER DUMP ==============
[    2.951066] dwmmc_exynos 12220000.mmc: : CTRL:	0x00000010
[    2.956445] dwmmc_exynos 12220000.mmc: : PWREN:	0x00000001
[    2.961910] dwmmc_exynos 12220000.mmc: : CLKDIV:	0x0000003f
[    2.967461] dwmmc_exynos 12220000.mmc: : CLKSRC:	0x00000000
[    2.973013] dwmmc_exynos 12220000.mmc: : CLKENA:	0x00000000
[    2.978566] dwmmc_exynos 12220000.mmc: : TMOUT:	0xffffffff
[    2.984031] dwmmc_exynos 12220000.mmc: : CTYPE:	0x00000000
[    2.989496] dwmmc_exynos 12220000.mmc: : BLKSIZ:	0x00000200
[    2.995048] dwmmc_exynos 12220000.mmc: : BYTCNT:	0x00000200
[    3.000600] dwmmc_exynos 12220000.mmc: : INTMSK:	0x0000b7ff
[    3.006152] dwmmc_exynos 12220000.mmc: : CMDARG:	0x00000000
[    3.011704] dwmmc_exynos 12220000.mmc: : CMD:	0x80202000
[    3.016995] dwmmc_exynos 12220000.mmc: : RESP0:	0x00000320
[    3.022461] dwmmc_exynos 12220000.mmc: : RESP1:	0x3ac57f80
[    3.027926] dwmmc_exynos 12220000.mmc: : RESP2:	0x5b590000
[    3.033391] dwmmc_exynos 12220000.mmc: : RESP3:	0x400e0032
[    3.038857] dwmmc_exynos 12220000.mmc: : MINTSTS:	0x00000000
[    3.044496] dwmmc_exynos 12220000.mmc: : RINTSTS:	0x00010000
[    3.050135] dwmmc_exynos 12220000.mmc: : STATUS:	0x00005a06
[    3.055686] dwmmc_exynos 12220000.mmc: : FIFOTH:	0x201f0020
[    3.061238] dwmmc_exynos 12220000.mmc: : CDETECT:	0x00000000
[    3.066877] dwmmc_exynos 12220000.mmc: : WRTPRT:	0x00000000
[    3.072429] dwmmc_exynos 12220000.mmc: : GPIO:	0x00000000
[    3.077808] dwmmc_exynos 12220000.mmc: : TCBCNT:	0x00000200
[    3.083359] dwmmc_exynos 12220000.mmc: : TBBCNT:	0x00000000
[    3.088911] dwmmc_exynos 12220000.mmc: : DEBNCE:	0x00ffffff
[    3.094463] dwmmc_exynos 12220000.mmc: : USRID:	0xffffffff
[    3.099930] dwmmc_exynos 12220000.mmc: : VERID:	0x5342250a
[    3.105394] dwmmc_exynos 12220000.mmc: : HCON:	0x00e42541
[    3.110772] dwmmc_exynos 12220000.mmc: : UHS_REG:	0x00000000
[    3.116413] dwmmc_exynos 12220000.mmc: : BMOD:	0x00000200
[    3.121790] dwmmc_exynos 12220000.mmc: : PLDMND:	0x00000000
[    3.127341] dwmmc_exynos 12220000.mmc: : DBADDR:	0x4dbbb000
[    3.132894] dwmmc_exynos 12220000.mmc: : IDSTS:	0x00000000
[    3.138359] dwmmc_exynos 12220000.mmc: : IDINTEN:	0x00000103
[    3.143998] dwmmc_exynos 12220000.mmc: : DSCADDR:	0x00000000
[    3.149636] dwmmc_exynos 12220000.mmc: : BUFADDR:	0x00000000
[    3.155273] dwmmc_exynos 12220000.mmc: : CLKSEL:	0x03030002
[    3.160827] dwmmc_exynos 12220000.mmc: : ================= CMD REG =================
[    3.168547] dwmmc_exynos 12220000.mmc: : read/write        : read
[    3.174620] dwmmc_exynos 12220000.mmc: : data expected     : 0
[    3.180432] dwmmc_exynos 12220000.mmc: : cmd index         : 0
[    3.186245] dwmmc_exynos 12220000.mmc: : ================ STATUS REG ===============
[    3.193965] dwmmc_exynos 12220000.mmc: : fifocount         : 0
[    3.199785] dwmmc_exynos 12220000.mmc: : response index    : 11
[    3.205677] dwmmc_exynos 12220000.mmc: : data state mc busy: 0
[    3.211488] dwmmc_exynos 12220000.mmc: : data busy         : 1
[    3.217301] dwmmc_exynos 12220000.mmc: : data 3 state      : 0
[    3.223113] dwmmc_exynos 12220000.mmc: : command fsm state : 0
[    3.228926] dwmmc_exynos 12220000.mmc: : fifo full         : 0
[    3.234738] dwmmc_exynos 12220000.mmc: : fifo empty        : 1
[    3.240550] dwmmc_exynos 12220000.mmc: : fifo tx watermark : 1
[    3.246362] dwmmc_exynos 12220000.mmc: : fifo rx watermark : 0
[    3.252174] dwmmc_exynos 12220000.mmc: : ============== STATUS DUMP ================
[    3.259894] dwmmc_exynos 12220000.mmc: : cmd_status:      0x00000000
[    3.266228] dwmmc_exynos 12220000.mmc: : data_status:     0x00000000
[    3.272561] dwmmc_exynos 12220000.mmc: : pending_events:  0x00000000
[    3.278893] dwmmc_exynos 12220000.mmc: : completed_events:0x00000001
[    3.285226] dwmmc_exynos 12220000.mmc: : state:           7
[    3.290778] dwmmc_exynos 12220000.mmc: : ===========================================
[    3.298500] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
[    3.347603] random: nonblocking pool is initialized
[    3.814791] dwmmc_exynos 12220000.mmc: : ============== REGISTER DUMP ==============
[    3.821068] dwmmc_exynos 12220000.mmc: : CTRL:	0x00000010
[    3.826447] dwmmc_exynos 12220000.mmc: : PWREN:	0x00000001
[    3.831913] dwmmc_exynos 12220000.mmc: : CLKDIV:	0x0000003f
[    3.837465] dwmmc_exynos 12220000.mmc: : CLKSRC:	0x00000000
[    3.843015] dwmmc_exynos 12220000.mmc: : CLKENA:	0x00000000
[    3.848569] dwmmc_exynos 12220000.mmc: : TMOUT:	0xffffffff
[    3.854034] dwmmc_exynos 12220000.mmc: : CTYPE:	0x00000000
[    3.859499] dwmmc_exynos 12220000.mmc: : BLKSIZ:	0x00000200
[    3.865050] dwmmc_exynos 12220000.mmc: : BYTCNT:	0x00000200
[    3.870601] dwmmc_exynos 12220000.mmc: : INTMSK:	0x0000b7ff
[    3.876153] dwmmc_exynos 12220000.mmc: : CMDARG:	0x00000000
[    3.881707] dwmmc_exynos 12220000.mmc: : CMD:	0x80202000
[    3.886998] dwmmc_exynos 12220000.mmc: : RESP0:	0x00000320
[    3.892462] dwmmc_exynos 12220000.mmc: : RESP1:	0x3ac57f80
[    3.897929] dwmmc_exynos 12220000.mmc: : RESP2:	0x5b590000
[    3.903395] dwmmc_exynos 12220000.mmc: : RESP3:	0x400e0032
[    3.908858] dwmmc_exynos 12220000.mmc: : MINTSTS:	0x00001000
[    3.914498] dwmmc_exynos 12220000.mmc: : RINTSTS:	0x00011000
[    3.920136] dwmmc_exynos 12220000.mmc: : STATUS:	0x00005a06
[    3.925689] dwmmc_exynos 12220000.mmc: : FIFOTH:	0x201f0020
[    3.931240] dwmmc_exynos 12220000.mmc: : CDETECT:	0x00000000
[    3.936879] dwmmc_exynos 12220000.mmc: : WRTPRT:	0x00000000
[    3.942432] dwmmc_exynos 12220000.mmc: : GPIO:	0x00000000
[    3.947811] dwmmc_exynos 12220000.mmc: : TCBCNT:	0x00000200
[    3.953362] dwmmc_exynos 12220000.mmc: : TBBCNT:	0x00000000
[    3.958913] dwmmc_exynos 12220000.mmc: : DEBNCE:	0x00ffffff
[    3.964466] dwmmc_exynos 12220000.mmc: : USRID:	0xffffffff
[    3.969931] dwmmc_exynos 12220000.mmc: : VERID:	0x5342250a
[    3.975395] dwmmc_exynos 12220000.mmc: : HCON:	0x00e42541
[    3.980775] dwmmc_exynos 12220000.mmc: : UHS_REG:	0x00000001
[    3.986414] dwmmc_exynos 12220000.mmc: : BMOD:	0x00000200
[    3.991792] dwmmc_exynos 12220000.mmc: : PLDMND:	0x00000000
[    3.997343] dwmmc_exynos 12220000.mmc: : DBADDR:	0x4dbbb000
[    4.002895] dwmmc_exynos 12220000.mmc: : IDSTS:	0x00000000
[    4.008362] dwmmc_exynos 12220000.mmc: : IDINTEN:	0x00000103
[    4.014000] dwmmc_exynos 12220000.mmc: : DSCADDR:	0x00000000
[    4.019639] dwmmc_exynos 12220000.mmc: : BUFADDR:	0x00000000
[    4.025278] dwmmc_exynos 12220000.mmc: : CLKSEL:	0x03030002
[    4.030830] dwmmc_exynos 12220000.mmc: : ================= CMD REG =================
[    4.038549] dwmmc_exynos 12220000.mmc: : read/write        : read
[    4.044622] dwmmc_exynos 12220000.mmc: : data expected     : 0
[    4.050435] dwmmc_exynos 12220000.mmc: : cmd index         : 0
[    4.056247] dwmmc_exynos 12220000.mmc: : ================ STATUS REG ===============
[    4.063968] dwmmc_exynos 12220000.mmc: : fifocount         : 0
[    4.069789] dwmmc_exynos 12220000.mmc: : response index    : 11
[    4.075679] dwmmc_exynos 12220000.mmc: : data state mc busy: 0
[    4.081491] dwmmc_exynos 12220000.mmc: : data busy         : 1
[    4.087303] dwmmc_exynos 12220000.mmc: : data 3 state      : 0
[    4.093116] dwmmc_exynos 12220000.mmc: : command fsm state : 0
[    4.098929] dwmmc_exynos 12220000.mmc: : fifo full         : 0
[    4.104740] dwmmc_exynos 12220000.mmc: : fifo empty        : 1
[    4.110553] dwmmc_exynos 12220000.mmc: : fifo tx watermark : 1
[    4.116365] dwmmc_exynos 12220000.mmc: : fifo rx watermark : 0
[    4.122176] dwmmc_exynos 12220000.mmc: : ============== STATUS DUMP ================
[    4.129898] dwmmc_exynos 12220000.mmc: : cmd_status:      0x00000000
[    4.136230] dwmmc_exynos 12220000.mmc: : data_status:     0x00000000
[    4.142563] dwmmc_exynos 12220000.mmc: : pending_events:  0x00000000
[    4.148895] dwmmc_exynos 12220000.mmc: : completed_events:0x00000001
[    4.155229] dwmmc_exynos 12220000.mmc: : state:           7
[    4.160779] dwmmc_exynos 12220000.mmc: : ===========================================
[    4.168502] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
[    4.674791] dwmmc_exynos 12220000.mmc: : ============== REGISTER DUMP ==============
[    4.681065] dwmmc_exynos 12220000.mmc: : CTRL:	0x00000010
[    4.686442] dwmmc_exynos 12220000.mmc: : PWREN:	0x00000001
[    4.691907] dwmmc_exynos 12220000.mmc: : CLKDIV:	0x0000003f
[    4.697460] dwmmc_exynos 12220000.mmc: : CLKSRC:	0x00000000
[    4.703012] dwmmc_exynos 12220000.mmc: : CLKENA:	0x00000000
[    4.708563] dwmmc_exynos 12220000.mmc: : TMOUT:	0xffffffff
[    4.714029] dwmmc_exynos 12220000.mmc: : CTYPE:	0x00000000
[    4.719493] dwmmc_exynos 12220000.mmc: : BLKSIZ:	0x00000200
[    4.725047] dwmmc_exynos 12220000.mmc: : BYTCNT:	0x00000200
[    4.730598] dwmmc_exynos 12220000.mmc: : INTMSK:	0x0000b7ff
[    4.736150] dwmmc_exynos 12220000.mmc: : CMDARG:	0x00000000
[    4.741701] dwmmc_exynos 12220000.mmc: : CMD:	0x80202000
[    4.746994] dwmmc_exynos 12220000.mmc: : RESP0:	0x00000320
[    4.752459] dwmmc_exynos 12220000.mmc: : RESP1:	0x3ac57f80
[    4.757925] dwmmc_exynos 12220000.mmc: : RESP2:	0x5b590000
[    4.763389] dwmmc_exynos 12220000.mmc: : RESP3:	0x400e0032
[    4.768856] dwmmc_exynos 12220000.mmc: : MINTSTS:	0x00001000
[    4.774494] dwmmc_exynos 12220000.mmc: : RINTSTS:	0x00011000
[    4.780133] dwmmc_exynos 12220000.mmc: : STATUS:	0x00005a06
[    4.785685] dwmmc_exynos 12220000.mmc: : FIFOTH:	0x201f0020
[    4.791236] dwmmc_exynos 12220000.mmc: : CDETECT:	0x00000000
[    4.796876] dwmmc_exynos 12220000.mmc: : WRTPRT:	0x00000000
[    4.802428] dwmmc_exynos 12220000.mmc: : GPIO:	0x00000000
[    4.807806] dwmmc_exynos 12220000.mmc: : TCBCNT:	0x00000200
[    4.813358] dwmmc_exynos 12220000.mmc: : TBBCNT:	0x00000000
[    4.818909] dwmmc_exynos 12220000.mmc: : DEBNCE:	0x00ffffff
[    4.824462] dwmmc_exynos 12220000.mmc: : USRID:	0xffffffff
[    4.829927] dwmmc_exynos 12220000.mmc: : VERID:	0x5342250a
[    4.835392] dwmmc_exynos 12220000.mmc: : HCON:	0x00e42541
[    4.840770] dwmmc_exynos 12220000.mmc: : UHS_REG:	0x00000001
[    4.846410] dwmmc_exynos 12220000.mmc: : BMOD:	0x00000200
[    4.851788] dwmmc_exynos 12220000.mmc: : PLDMND:	0x00000000
[    4.857340] dwmmc_exynos 12220000.mmc: : DBADDR:	0x4dbbb000
[    4.862893] dwmmc_exynos 12220000.mmc: : IDSTS:	0x00000000
[    4.868357] dwmmc_exynos 12220000.mmc: : IDINTEN:	0x00000103
[    4.873996] dwmmc_exynos 12220000.mmc: : DSCADDR:	0x00000000
[    4.879636] dwmmc_exynos 12220000.mmc: : BUFADDR:	0x00000000
[    4.885274] dwmmc_exynos 12220000.mmc: : CLKSEL:	0x03030002
[    4.890826] dwmmc_exynos 12220000.mmc: : ================= CMD REG =================
[    4.898545] dwmmc_exynos 12220000.mmc: : read/write        : read
[    4.904619] dwmmc_exynos 12220000.mmc: : data expected     : 0
[    4.910430] dwmmc_exynos 12220000.mmc: : cmd index         : 0
[    4.916243] dwmmc_exynos 12220000.mmc: : ================ STATUS REG ===============
[    4.923963] dwmmc_exynos 12220000.mmc: : fifocount         : 0
[    4.929793] dwmmc_exynos 12220000.mmc: : response index    : 11
[    4.935675] dwmmc_exynos 12220000.mmc: : data state mc busy: 0
[    4.941487] dwmmc_exynos 12220000.mmc: : data busy         : 1
[    4.947298] dwmmc_exynos 12220000.mmc: : data 3 state      : 0
[    4.953112] dwmmc_exynos 12220000.mmc: : command fsm state : 0
[    4.958923] dwmmc_exynos 12220000.mmc: : fifo full         : 0
[    4.964736] dwmmc_exynos 12220000.mmc: : fifo empty        : 1
[    4.970548] dwmmc_exynos 12220000.mmc: : fifo tx watermark : 1
[    4.976361] dwmmc_exynos 12220000.mmc: : fifo rx watermark : 0
[    4.982173] dwmmc_exynos 12220000.mmc: : ============== STATUS DUMP ================
[    4.989893] dwmmc_exynos 12220000.mmc: : cmd_status:      0x00000000
[    4.996226] dwmmc_exynos 12220000.mmc: : data_status:     0x00000000
[    5.002559] dwmmc_exynos 12220000.mmc: : pending_events:  0x00000000
[    5.008891] dwmmc_exynos 12220000.mmc: : completed_events:0x00000001
[    5.015225] dwmmc_exynos 12220000.mmc: : state:           7
[    5.020777] dwmmc_exynos 12220000.mmc: : ===========================================
[    5.028498] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)
[    5.534791] dwmmc_exynos 12220000.mmc: : ============== REGISTER DUMP ==============
[    5.541069] dwmmc_exynos 12220000.mmc: : CTRL:	0x00000010
[    5.546447] dwmmc_exynos 12220000.mmc: : PWREN:	0x00000001
[    5.551913] dwmmc_exynos 12220000.mmc: : CLKDIV:	0x0000003f
[    5.557465] dwmmc_exynos 12220000.mmc: : CLKSRC:	0x00000000
[    5.563017] dwmmc_exynos 12220000.mmc: : CLKENA:	0x00000000
[    5.568569] dwmmc_exynos 12220000.mmc: : TMOUT:	0xffffffff
[    5.574034] dwmmc_exynos 12220000.mmc: : CTYPE:	0x00000000
[    5.579499] dwmmc_exynos 12220000.mmc: : BLKSIZ:	0x00000200
[    5.585051] dwmmc_exynos 12220000.mmc: : BYTCNT:	0x00000200
[    5.590603] dwmmc_exynos 12220000.mmc: : INTMSK:	0x0000b7ff
[    5.596155] dwmmc_exynos 12220000.mmc: : CMDARG:	0x00000000
[    5.601707] dwmmc_exynos 12220000.mmc: : CMD:	0x80202000
[    5.607000] dwmmc_exynos 12220000.mmc: : RESP0:	0x00000320
[    5.612464] dwmmc_exynos 12220000.mmc: : RESP1:	0x3ac57f80
[    5.617929] dwmmc_exynos 12220000.mmc: : RESP2:	0x5b590000
[    5.623395] dwmmc_exynos 12220000.mmc: : RESP3:	0x400e0032
[    5.628861] dwmmc_exynos 12220000.mmc: : MINTSTS:	0x00001000
[    5.634498] dwmmc_exynos 12220000.mmc: : RINTSTS:	0x00011000
[    5.640138] dwmmc_exynos 12220000.mmc: : STATUS:	0x00005a06
[    5.645688] dwmmc_exynos 12220000.mmc: : FIFOTH:	0x201f0020
[    5.651242] dwmmc_exynos 12220000.mmc: : CDETECT:	0x00000000
[    5.656881] dwmmc_exynos 12220000.mmc: : WRTPRT:	0x00000000
[    5.662432] dwmmc_exynos 12220000.mmc: : GPIO:	0x00000000
[    5.667810] dwmmc_exynos 12220000.mmc: : TCBCNT:	0x00000200
[    5.673362] dwmmc_exynos 12220000.mmc: : TBBCNT:	0x00000000
[    5.678914] dwmmc_exynos 12220000.mmc: : DEBNCE:	0x00ffffff
[    5.684467] dwmmc_exynos 12220000.mmc: : USRID:	0xffffffff
[    5.689932] dwmmc_exynos 12220000.mmc: : VERID:	0x5342250a
[    5.695396] dwmmc_exynos 12220000.mmc: : HCON:	0x00e42541
[    5.700775] dwmmc_exynos 12220000.mmc: : UHS_REG:	0x00000001
[    5.706415] dwmmc_exynos 12220000.mmc: : BMOD:	0x00000200
[    5.711793] dwmmc_exynos 12220000.mmc: : PLDMND:	0x00000000
[    5.717345] dwmmc_exynos 12220000.mmc: : DBADDR:	0x4dbbb000
[    5.722897] dwmmc_exynos 12220000.mmc: : IDSTS:	0x00000000
[    5.728363] dwmmc_exynos 12220000.mmc: : IDINTEN:	0x00000103
[    5.734001] dwmmc_exynos 12220000.mmc: : DSCADDR:	0x00000000
[    5.739640] dwmmc_exynos 12220000.mmc: : BUFADDR:	0x00000000
[    5.745279] dwmmc_exynos 12220000.mmc: : CLKSEL:	0x03030002
[    5.750830] dwmmc_exynos 12220000.mmc: : ================= CMD REG =================
[    5.758550] dwmmc_exynos 12220000.mmc: : read/write        : read
[    5.764623] dwmmc_exynos 12220000.mmc: : data expected     : 0
[    5.770436] dwmmc_exynos 12220000.mmc: : cmd index         : 0
[    5.776248] dwmmc_exynos 12220000.mmc: : ================ STATUS REG ===============
[    5.783969] dwmmc_exynos 12220000.mmc: : fifocount         : 0
[    5.789791] dwmmc_exynos 12220000.mmc: : response index    : 11
[    5.795680] dwmmc_exynos 12220000.mmc: : data state mc busy: 0
[    5.801492] dwmmc_exynos 12220000.mmc: : data busy         : 1
[    5.807303] dwmmc_exynos 12220000.mmc: : data 3 state      : 0
[    5.813116] dwmmc_exynos 12220000.mmc: : command fsm state : 0
[    5.818929] dwmmc_exynos 12220000.mmc: : fifo full         : 0
[    5.824740] dwmmc_exynos 12220000.mmc: : fifo empty        : 1
[    5.830553] dwmmc_exynos 12220000.mmc: : fifo tx watermark : 1
[    5.836365] dwmmc_exynos 12220000.mmc: : fifo rx watermark : 0
[    5.842182] dwmmc_exynos 12220000.mmc: : ============== STATUS DUMP ================
[    5.842187] dwmmc_exynos 12220000.mmc: : cmd_status:      0x00000000
[    5.842193] dwmmc_exynos 12220000.mmc: : data_status:     0x00000000
[    5.842197] dwmmc_exynos 12220000.mmc: : pending_events:  0x00000000
[    5.842202] dwmmc_exynos 12220000.mmc: : completed_events:0x00000001
[    5.842211] dwmmc_exynos 12220000.mmc: : state:           7
[    5.842220] dwmmc_exynos 12220000.mmc: : ===========================================
[    5.842230] mmc_host mmc1: Timeout sending command (cmd 0x202000 arg 0x0 status 0x80202000)


U-Boot 2013.04 (Feb 21 2014 - 15:29:10) for Peach

CPU:	Exynos5420 at 900MHz

Board: Google Peach Pit, rev 6.0
I2C:   ready
DRAM:  2 GiB
PMIC max77802-pmic initialized
CPU:	Exynos5420 at 1800MHz
TPS65090 PMIC EC init
MMC:   EXYNOS DWMMC: 0, EXYNOS DWMMC: 1
SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
In:    cros-ec-keyb
Out:   lcd
Err:   lcd
SF: Detected W25Q32DW with page size 4 KiB, total 32 MiB
ELOG: Event(17) added with size 13
Net:   No ethernet found.
Hit any key to stop autoboot:  3  0 
Exynos DP init done
Peach # 
Peach # 
