From: david@lechnology.com (David Lechner)
Date: Thu, 11 Jan 2018 15:04:28 -0600
Subject: [PATCH v5 01/44] dt-bindings: clock: Add new bindings for TI
 Davinci PLL clocks
In-Reply-To: <CAHCN7x+EtQs6NHAYbVga7vU1U+qQLqOxdf+1MW6HewaT+ZF_Xg@mail.gmail.com>
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
 <a79184c5-3e28-bbac-0783-992615d49fae@lechnology.com>
 <CAHCN7x+EtQs6NHAYbVga7vU1U+qQLqOxdf+1MW6HewaT+ZF_Xg@mail.gmail.com>
Message-ID: <5832fd62-16aa-e167-7e52-2ce493e33cdc@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/11/2018 02:58 PM, Adam Ford wrote:
> On Thu, Jan 11, 2018 at 2:04 PM, David Lechner <david@lechnology.com> wrote:
>> On 01/11/2018 12:50 PM, Adam Ford wrote:
>>>
>>> On Thu, Jan 11, 2018 at 12:29 PM, David Lechner <david@lechnology.com>
>>> wrote:
>>>>
>>>> If removing the "clk_ignore_unused" option causes the board to not boot,
>>>> then we still have problems that need to be fixed, so please also test
>>>> without this option.
>>>
>>>
>>> Without this option, it still does not boot.  Without device tree it
>>> hangs after:
>>>
>>> [snip]
>>>
>>> NET: Registered protocol family 17
>>> Loading compiled-in X.509 certificates
>>> console [netcon0] enabled
>>> netconsole: network logging started
>>> davinci_emac davinci_emac.1: using random MAC addr: 5e:38:1a:1f:4f:77
>>> mmc0: host does not support reading read-only switch, assuming
>>> write-enable
>>> hctosys: unable to open rtc device (rtc0)
>>> mmc0: new high speed SDHC card at address b368
>>>
>>>
>>> With device tree it hangs after:
>>>
>>> [snip]
>>> mmc0: host does not support reading read-only switch, assuming
>>> write-enable
>>> mmc0: new high speed SDHC card at address b368
>>> mmcblk0: mmc0:b368 00000 3.75 GiB
>>>    mmcblk0: p1 p2
>>> pca953x 0-0020: 0-0020 supply vcc not found, using dummy regulator
>>> pca953x 0-0020: failed reading register
>>> pca953x: probe of 0-0020 failed with error -121
>>> console [netcon0] enabled
>>> netconsole: network logging started
>>> davinci_emac 1e20000.ethernet: incompatible machine/device type for
>>> reading mac address
>>> hctosys: unable to open rtc device (rtc0)
>>>
>>>
>>
>> Please try this change:
>>
>> diff --git a/drivers/clk/davinci/psc-da850.c
>> b/drivers/clk/davinci/psc-da850.c
>> index 3fd6b49..a526cc2 100644
>> --- a/drivers/clk/davinci/psc-da850.c
>> +++ b/drivers/clk/davinci/psc-da850.c
>> @@ -17,7 +17,7 @@ static const struct davinci_psc_clk_info da850_psc0_info[]
>> __initconst = {
>>          LPSC(0, 0, tpcc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>          LPSC(1, 0, tptc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>>          LPSC(2, 0, tptc1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
>> -       LPSC(3, 0, aemif, pll0_sysclk3, 0),
>> +       LPSC(3, 0, aemif, pll0_sysclk3, LPSC_ALWAYS_ENABLED),
>>          LPSC(4, 0, spi0, pll0_sysclk2, 0),
>>          LPSC(5, 0, mmcsd0, pll0_sysclk2, 0),
>>          LPSC(6, 0, aintc, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
>>
>>
>>
>> If that does not work, try adding LPSC_ALWAYS_ENABLED to all of the clocks
>> in this file and then eliminate them one by one until you find which one is
>> preventing boot.
>>
> Unfortunately, that didn't work.  I switch all the entries in both
> tables that had a 0 to LPSC_ALWAYS_ENABLED, but no luck booting.
> 
>> If it still does not boot, there is a similar DIVCLK_ALWAYS_ENABLED flag in
>> drivers/clk/davinci/pll-da850.c that you can repeat the exercise with. Add
>> DIVCLK_ALWAYS_ENABLED to all of the clocks there and then eliminate it one
>> by one until you find the clock that is causing the problem.
> 
> Still no good news.  I switched all the entries with a 0 to
> DIVCLK_ALWAYS_ENABLED and it still didn't finish booting.
> 
> I wonder if Sekhar Nori might have some suggestions.  I didn't look at
> the code or try to understand it.  I just changed the settings.
>>

Even if a clock had another flag besides zero, you will need to add
LPSC_ALWAYS_ENABLED by or-ing it with the other flag.

diff --git a/drivers/clk/davinci/psc-da850.c b/drivers/clk/davinci/psc-da850.c
index 3fd6b49..3375df6a1 100644
--- a/drivers/clk/davinci/psc-da850.c
+++ b/drivers/clk/davinci/psc-da850.c
@@ -17,38 +17,38 @@ static const struct davinci_psc_clk_info da850_psc0_info[] __initconst = {
  	LPSC(0, 0, tpcc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
  	LPSC(1, 0, tptc0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
  	LPSC(2, 0, tptc1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
-	LPSC(3, 0, aemif, pll0_sysclk3, 0),
-	LPSC(4, 0, spi0, pll0_sysclk2, 0),
-	LPSC(5, 0, mmcsd0, pll0_sysclk2, 0),
+	LPSC(3, 0, aemif, pll0_sysclk3, LPSC_ALWAYS_ENABLED),
+	LPSC(4, 0, spi0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(5, 0, mmcsd0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
  	LPSC(6, 0, aintc, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
  	LPSC(7, 0, arm_rom, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
-	LPSC(9, 0, uart0, pll0_sysclk2, 0),
-	LPSC(13, 0, pruss, pll0_sysclk2, 0),
+	LPSC(9, 0, uart0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(13, 0, pruss, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
  	LPSC(14, 0, arm, pll0_sysclk6, LPSC_ALWAYS_ENABLED),
-	LPSC(15, 1, dsp, pll0_sysclk1, LPSC_FORCE | LPSC_LOCAL_RESET),
+	LPSC(15, 1, dsp, pll0_sysclk1, LPSC_FORCE | LPSC_LOCAL_RESET | LPSC_ALWAYS_ENABLED),
  	{ }
  };
  
  static const struct davinci_psc_clk_info da850_psc1_info[] __initconst = {
  	LPSC(0, 0, tpcc1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
-	LPSC(1, 0, usb0, pll0_sysclk2, 0),
-	LPSC(2, 0, usb1, pll0_sysclk4, 0),
-	LPSC(3, 0, gpio, pll0_sysclk4, 0),
-	LPSC(5, 0, emac, pll0_sysclk4, 0),
+	LPSC(1, 0, usb0, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(2, 0, usb1, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
+	LPSC(3, 0, gpio, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
+	LPSC(5, 0, emac, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
  	LPSC(6, 0, emif3, pll0_sysclk5, LPSC_ALWAYS_ENABLED),
-	LPSC(7, 0, mcasp0, async3, 0),
-	LPSC(8, 0, sata, pll0_sysclk2, LPSC_FORCE),
-	LPSC(9, 0, vpif, pll0_sysclk2, 0),
-	LPSC(10, 0, spi1, async3, 0),
-	LPSC(11, 0, i2c1, pll0_sysclk4, 0),
-	LPSC(12, 0, uart1, async3, 0),
-	LPSC(13, 0, uart2, async3, 0),
-	LPSC(14, 0, mcbsp0, async3, 0),
-	LPSC(15, 0, mcbsp1, async3, 0),
-	LPSC(16, 0, lcdc, pll0_sysclk2, 0),
-	LPSC(17, 0, ehrpwm, async3, 0),
-	LPSC(18, 0, mmcsd1, pll0_sysclk2, 0),
-	LPSC(20, 0, ecap, async3, 0),
+	LPSC(7, 0, mcasp0, async3, LPSC_ALWAYS_ENABLED),
+	LPSC(8, 0, sata, pll0_sysclk2, LPSC_FORCE | LPSC_ALWAYS_ENABLED),
+	LPSC(9, 0, vpif, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(10, 0, spi1, async3, LPSC_ALWAYS_ENABLED),
+	LPSC(11, 0, i2c1, pll0_sysclk4, LPSC_ALWAYS_ENABLED),
+	LPSC(12, 0, uart1, async3, LPSC_ALWAYS_ENABLED),
+	LPSC(13, 0, uart2, async3, LPSC_ALWAYS_ENABLED),
+	LPSC(14, 0, mcbsp0, async3, LPSC_ALWAYS_ENABLED),
+	LPSC(15, 0, mcbsp1, async3, LPSC_ALWAYS_ENABLED),
+	LPSC(16, 0, lcdc, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(17, 0, ehrpwm, async3, LPSC_ALWAYS_ENABLED),
+	LPSC(18, 0, mmcsd1, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
+	LPSC(20, 0, ecap, async3, LPSC_ALWAYS_ENABLED),
  	LPSC(21, 0, tptc2, pll0_sysclk2, LPSC_ALWAYS_ENABLED),
  	{ }
  };


diff --git a/drivers/clk/davinci/pll-da850.c b/drivers/clk/davinci/pll-da850.c
index 77a7223..f334e69 100644
--- a/drivers/clk/davinci/pll-da850.c
+++ b/drivers/clk/davinci/pll-da850.c
@@ -22,21 +22,21 @@
  
  static const struct davinci_pll_divclk_info
  da850_pll0_divclk_info[] __initconst = {
-	DIVCLK(1, pll0_sysclk1, pll0, DIVCLK_FIXED_DIV),
-	DIVCLK(2, pll0_sysclk2, pll0, DIVCLK_FIXED_DIV),
-	DIVCLK(3, pll0_sysclk3, pll0, 0),
-	DIVCLK(4, pll0_sysclk4, pll0, DIVCLK_FIXED_DIV),
-	DIVCLK(5, pll0_sysclk5, pll0, 0),
-	DIVCLK(6, pll0_sysclk6, pll0, DIVCLK_ARM_RATE | DIVCLK_FIXED_DIV),
-	DIVCLK(7, pll0_sysclk7, pll0, 0),
+	DIVCLK(1, pll0_sysclk1, pll0, DIVCLK_FIXED_DIV | DIVCLK_ALWAYS_ENABLED),
+	DIVCLK(2, pll0_sysclk2, pll0, DIVCLK_FIXED_DIV | DIVCLK_ALWAYS_ENABLED),
+	DIVCLK(3, pll0_sysclk3, pll0, DIVCLK_ALWAYS_ENABLED),
+	DIVCLK(4, pll0_sysclk4, pll0, DIVCLK_FIXED_DIV | DIVCLK_ALWAYS_ENABLED),
+	DIVCLK(5, pll0_sysclk5, pll0, DIVCLK_ALWAYS_ENABLED),
+	DIVCLK(6, pll0_sysclk6, pll0, DIVCLK_ARM_RATE | DIVCLK_FIXED_DIV| DIVCLK_ALWAYS_ENABLED),
+	DIVCLK(7, pll0_sysclk7, pll0, DIVCLK_ALWAYS_ENABLED),
  	{ }
  };
  
  static const struct davinci_pll_divclk_info
  da850_pll1_divclk_info[] __initconst = {
  	DIVCLK(1, pll1_sysclk1, pll1, DIVCLK_ALWAYS_ENABLED),
-	DIVCLK(2, pll1_sysclk2, pll1, 0),
-	DIVCLK(3, pll1_sysclk3, pll1, 0),
+	DIVCLK(2, pll1_sysclk2, pll1, DIVCLK_ALWAYS_ENABLED),
+	DIVCLK(3, pll1_sysclk3, pll1, DIVCLK_ALWAYS_ENABLED),
  	{ }
  };
  
