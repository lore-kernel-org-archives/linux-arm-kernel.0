From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 14:04:43 -0600
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <CAHCN7x+G5pxOeD7TahqiQUePEu1Z4Hyinkjq_bcSM+Hz36xoSg@mail.gmail.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-2-git-send-email-david@lechnology.com>
 <ebd677dc-44a4-5053-2509-e3ee948ccf98@ti.com>
 <22409e49-5c14-4068-b137-7535afaf90d7@lechnology.com>
 <0f90b5f7-f21e-5f81-1154-9a815bbb786d@ti.com>
 <ba7fa842-cfc5-6f6f-f9bf-09c74ab08ec2@lechnology.com>
 <5aacc350-6236-2e4f-35bb-a681fc9d47e7@ti.com>
 <CAHCN7x+ZYezmEU_0mF=6_gF14DZxKnuDp1Cx=aC2=eN_QLNdJQ@mail.gmail.com>
 <fd162516-cddc-e857-ce60-2cd89303971e@lechnology.com>
 <CAHCN7xKORFriQ2Gjx85OsCUzHO-mavCQXLOzh5D3n4kEG=i-Yg@mail.gmail.com>
 <40501635-6f5b-20c9-f8bc-d17e26b58426@lechnology.com>
 <CAHCN7xL=h_g6HK2ey82r_w5qRbXg9+68Og+84YUYuePsjYd-Vg@mail.gmail.com>
 <f20267f2-be4c-e031-1c5f-76490164c60d@lechnology.com>
 <CAHCN7x+G5pxOeD7TahqiQUePEu1Z4Hyinkjq_bcSM+Hz36xoSg@mail.gmail.com>
Message-ID: <a79184c5-3e28-bbac-0783-992615d49fae@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 12:50 PM, Adam Ford wrote:
> On Thu, Jan 11, 2018 at 12:29 PM, David Lechner <david@lechnology.com> wrote:
>> If removing the "clk_ignore_unused" option causes the board to not boot,
>> then we still have problems that need to be fixed, so please also test
>> without this option.
> 
> Without this option, it still does not boot.  Without device tree it
> hangs after:
> 
> [snip]
> 
> NET: Registered protocol family 17
> Loading compiled-in X.509 certificates
> console [netcon0] enabled
> netconsole: network logging started
> davinci_emac davinci_emac.1: using random MAC addr: 5e:38:1a:1f:4f:77
> mmc0: host does not support reading read-only switch, assuming write-enable
> hctosys: unable to open rtc device (rtc0)
> mmc0: new high speed SDHC card at address b368
> 
> 
> With device tree it hangs after:
> 
> [snip]
> mmc0: host does not support reading read-only switch, assuming write-enable
> mmc0: new high speed SDHC card at address b368
> mmcblk0: mmc0:b368 00000 3.75 GiB
>   mmcblk0: p1 p2
> pca953x 0-0020: 0-0020 supply vcc not found, using dummy regulator
> pca953x 0-0020: failed reading register
> pca953x: probe of 0-0020 failed with error -121
> console [netcon0] enabled
> netconsole: network logging started
> davinci_emac 1e20000.ethernet: incompatible machine/device type for
> reading mac address
> hctosys: unable to open rtc device (rtc0)
> 
> 

Please try this change:

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index 3fd6b49..a526cc2 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -17,7 +17,7 @@ static const struct davinci_psc_clk_info da850_psc0_info[] __initconst = {
  	LPSC(0, 0, tpcc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
  	LPSC(1, 0, tptc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
  	LPSC(2, 0, tptc1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
-	LPSC(3, 0, aemif, pll0_sysclk3, 0),
+	LPSC(3, 0, aemif, pll0_sysclk3, LPSC_ALWAYS_ENABLED),
  	LPSC(4, 0, spi0, pll0_sysclk2, 0),
  	LPSC(5, 0, mmcsd0, pll0_sysclk2, 0),
  	LPSC(6, 0, aintc, pll0_sysclk4, LPSC_ALWAYS_ENABLED),



If that does not work, try adding LPSC_ALWAYS_ENABLED to all of the clocks
in this file and then eliminate them one by one until you find which one is
preventing boot.

If it still does not boot, there is a similar DIVCLK_ALWAYS_ENABLED flag in
drivers/clk/davinci/pll-da850.c that you can repeat the exercise with. Add
DIVCLK_ALWAYS_ENABLED to all of the clocks there and then eliminate it one
by one until you find the clock that is causing the problem.
