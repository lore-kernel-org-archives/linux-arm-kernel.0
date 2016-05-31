From: dongas86@gmail.com (Dong Aisheng)
Date: Tue, 31 May 2016 18:18:23 +0800
Subject: [PATCH 10/23] mmc: core: disable auto retune during card
 detection process
In-Reply-To: <573185FC.5060506@intel.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
 <1460741387-23815-11-git-send-email-aisheng.dong@nxp.com>
 <571A1D85.3020200@intel.com>
 <CAA+hA=R9JfV4ScuM=OZ3VHdSiQiMO9io8mQQDNXfkTwNv7RVvg@mail.gmail.com>
 <5721B602.6010306@intel.com>
 <20160428132249.GB27560@shlinux2.ap.freescale.net>
 <57230515.9030602@intel.com>
 <20160429074258.GA28427@shlinux2.ap.freescale.net>
 <573185FC.5060506@intel.com>
Message-ID: <20160531101823.GB4096@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2016 at 09:55:56AM +0300, Adrian Hunter wrote:
> On 29/04/16 10:42, Dong Aisheng wrote:
> > And IMX6DL ARD is even worser due to it's using common
> > mmc_send_tuning() function.
> > root at imx6qdlsolo:~# 
> > root at imx6qdlsolo:~# [  129.462564] sysrq: SysRq : Changing Loglevel
> > [  129.466902] sysrq: Loglevel set to 8
> > [  131.616078] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
> > [  131.625311] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 6
> > [  131.632133] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
> > [  131.642121] mmc0: starting CMD13 arg 59b40000 flags 00000195
> > [  131.648925] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x0 ESDHC_TUNE_CTRL_STATUS 0x0
> > [  131.657818] mmc0: starting CMD19 arg 00000000 flags 00000035
> > [  131.663518] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
> > [  131.670835] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
> 
> You should stop here because -123 is -ENOMEDIUM
> 

Hi Adrian,

This is the last issue before V2.
I just tried the way you proposed (see detailed log below).

A few questions if we decide to let tuning routine to handle
the card remove case:
1) we may have to fix it for all platforms tuning code.

Below is the example i did for IMX uSDHC and common SDHCI.
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -757,7 +757,11 @@ static void esdhc_post_tuning(struct sdhci_host *host)
 
 static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
 {
-       int min, max, avg, ret;
+       int min, max, avg, ret, present;
+
+       present = host->mmc->ops->get_cd(host->mmc);
+       if (!present)
+               return -ENOMEDIUM;
 
        /* find the mininum delay first which can pass tuning */
        min = ESDHC_TUNE_CTRL_MIN;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 0027b8707ebd..7b7545dd1a4b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1767,6 +1767,11 @@ static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
        unsigned long flags;
        unsigned int tuning_count = 0;
        bool hs400_tuning;
+       int present;
+
+       present = mmc->ops->get_cd(mmc);
+       if (!present)
+               return -ENOMEDIUM;

And if we need fix all platforms, do you think we should
do it in MMC core mmc_execute_tuning()?

If yes, then we probably could move all the normal host CD check
before sending CMD in MMC core (__mmc_start_request()) as well?

2) MMC core will print out tuning error for card remove case
which is not before.
e.g
[   98.730597] mmc0: tuning execution failed: -123
We probably may need make it debug level since it's meaningless
for card removed case.

Detailed log below:
After the fix, card remove with calling mmc_send_tuning():
root at imx6qdlsolo:~# [   98.664049] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[   98.673280] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 6
[   98.680102] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[   98.689560] mmc0: starting CMD13 arg aaaa0000 flags 00000195
[   98.696336] sdhci-esdhc-imx 2198000.usdhc: tunning with delay 0x0 ESDHC_TUNE_CTRL_STATUS 0x0
[   98.705407] mmc0: starting CMD19 arg 00000000 flags 00000035
[   98.711121] mmc0:     blksz 64 blocks 1 flags 00000200 tsac 150 ms nsac 0
[   98.718144] mmc0: req done (CMD19): -123: 00000000 00000000 00000000 00000000
[   98.725351] mmc0:     0 bytes transferred: 0
[   98.730597] mmc0: tuning execution failed: -123
[   98.735255] mmc0: req failed (CMD13): -123, retrying...
[   98.740921] mmc0: req failed (CMD13): -123, retrying...
[   98.746344] mmc0: req failed (CMD13): -123, retrying...
[   98.751909] mmc0: req done (CMD13): -123: 00000000 00000000 00000000 00000000
[   98.759206] mmc0: card remove detected
[   98.763514] mmc0: card aaaa removed
[   98.780475] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
[   98.787730] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[   99.028432] FAT-fs (mmcblk0p1): FAT read failed (blocknr 32)q


card remove with calling standard sdhci_execute_tuning():
root at imx6qdlsolo:~# [  210.555330] sysrq: SysRq : Changing Loglevel
[  210.559665] sysrq: Loglevel set to 8
[  212.244148] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[  212.253376] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 6
[  212.260199] sdhci-esdhc-imx 2198000.usdhc: desired SD clock: 198000000, actual: 198000000
[  212.269637] mmc0: starting CMD13 arg aaaa0000 flags 00000195
[  212.275399] mmc0: tuning execution failed: -123
[  212.280601] mmc0: req failed (CMD13): -123, retrying...
[  212.286094] mmc0: req failed (CMD13): -123, retrying...
[  212.291763] mmc0: req failed (CMD13): -123, retrying...
[  212.297226] mmc0: req done (CMD13): -123: 00000000 00000000 00000000 00000000
[  212.304899] mmc0: card remove detected
[  212.308948] mmc0: card aaaa removed
[  212.318162] mmc0: clock 0Hz busmode 2 powermode 0 cs 0 Vdd 0 width 1 timing 0
[  212.325415] sdhci-esdhc-imx 2198000.usdhc: change pinctrl state for uhs 0
[  212.580621] FAT-fs (mmcblk0p1): FAT read failed (blocknr 32)

Regards
Dong Aisheng
