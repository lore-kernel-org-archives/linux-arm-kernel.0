From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 20 Mar 2015 17:16:45 +0100
Subject: exynos5800-peach-pi: suspend/resume (still) broken
In-Reply-To: <CAM4voakvhHuVXLY2DmdGexfrqSYUqhXhg1krLwO4CCxjHQ1NCw@mail.gmail.com>
References: <CAMAWPa_r04tAXAXosmLk+DfwvQV0qpD+=8O7T_pwFTAozcjOgQ@mail.gmail.com>	<550953ED.10508@collabora.co.uk>
 <CAM4voakvhHuVXLY2DmdGexfrqSYUqhXhg1krLwO4CCxjHQ1NCw@mail.gmail.com>
Message-ID: <550C47ED.3010301@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Abhilash,

On 03/20/2015 03:23 PM, Abhilash Kesavan wrote:
>> On 03/17/2015 06:35 PM, Kevin Hilman wrote:
>>>
>>> Anyone else having better luck with suspend/resume on peach-pi?
>>>
>>
>> # echo +2 > /sys/class/rtc/rtc0/wakealarm && echo mem > /sys/power/state
>>
>> Suspend and CPUs shutdown seems to succeed according to [0] but the system
>> never wakes up...
>>
>> I also tried to wakeup the system with the keyboard and the trackpad that is
>> a wake up source but it does not work either.
>>
>> I remember that when the 5420 s2r support series were posted, aclk200_disp1
>> and aclk300_disp1 clocks needed to be marked as CLK_IGNORE_UNUSED but afaiu
>> that was only because display support was not yet merged but it is now.
>>
>> I tried anyways both marking those clocks as CLK_IGNORE_UNUSED and passing
>> the clk_ignore_unused to the kernel command line but did not work either.
>>
>> Abhilash, Vikas, Pankaj,
>>
>> Any ideas of what could be causing this regression? It seems that by the
>> time the Exynos5420 S2R support landed in mainline, it was already not
>> working which makes it hard to bisect what caused the issue.
> 
> I remember the Pi power LED changing color from blue on suspend. Does

Thanks a lot for answering. Who manages that LED? is the kernel or the
firwmare in the EC? I tried suspend to ram using ChromeOS 3.8 kernel and
I see that the blue LED is indeed turned off on suspend but that does not
happen in mainline.

> that happen ? I'll try reproducing the issue and then probably use an
> old working s2r branch in one of my local repos to track this down.
>

If I checkout mainline with HEAD in your commit adc548d77c22
("ARM: EXYNOS: Use MCPM call-backs to support S2R on exynos5420") + the
patch you mentioned back then to keep the aclk200_disp1 and aclk300_disp1
clocks enabled even when not used [0], I have S2R working. But even with
that commit, I don't see the blue LED to be turn off like is the case in
the ChromeOS 3.8 kernel.

So I think you can use that as a base. I tried bisecting but it is tricky
due other issues masking the S2R regression. I also tried to compare the
diff between adc548d77c22 and v3.19-rc1 that is the first known bad afaict
but didn't find any relevant either.

By adding printouts I can tell that all the CPUs enter exynos_power_down()
in arch/arm/mach-exynos/mcpm-exynos.c and also the last man disables the
cluster for both Cortex A-15 and A-7 clusters.

So it seems that the problem is on the resume path.
 
> Regards,
> Abhilash
>>

Best regards,
Javier

[0]:
diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
index 848d602efc06..d8b66339d564 100644
--- a/drivers/clk/samsung/clk-exynos5420.c
+++ b/drivers/clk/samsung/clk-exynos5420.c
@@ -932,14 +932,14 @@ static struct samsung_gate_clock exynos5x_gate_clks[] __initdata = {
 	GATE(0, "aclk400_mscl", "mout_user_aclk400_mscl",
 			GATE_BUS_TOP, 17, 0, 0),
 	GATE(0, "aclk200_disp1", "mout_user_aclk200_disp1",
-			GATE_BUS_TOP, 18, 0, 0),
+			GATE_BUS_TOP, 18, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_MPHY_IXTAL24, "sclk_mphy_ixtal24", "mphy_refclk_ixtal24",
 			GATE_BUS_TOP, 28, 0, 0),
 	GATE(CLK_SCLK_HSIC_12M, "sclk_hsic_12m", "ff_hsic_12m",
 			GATE_BUS_TOP, 29, 0, 0),
 
 	GATE(0, "aclk300_disp1", "mout_user_aclk300_disp1",
-			SRC_MASK_TOP2, 24, 0, 0),
+			SRC_MASK_TOP2, 24, CLK_IGNORE_UNUSED, 0),
 
 	GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
 			SRC_MASK_TOP7, 20, 0, 0),
