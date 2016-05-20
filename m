From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 19 May 2016 23:47:55 -0300
Subject: mx6ul cannot reboot
In-Reply-To: <CAOMZO5A-y86T1HUVDMUnOC6BOKUw87EOCL5oinGu9XNLE-HucQ@mail.gmail.com>
References: <CAOMZO5DLz7vBARB+uweDG+tw0UM3EMDb9+_XcLaaBv0GN+im7g@mail.gmail.com>
 <CAOMZO5CF7g=GOXL_BMRQTZ6UPk+15z3hkxoM3j+KW033Dtp7wA@mail.gmail.com>
 <DB4PR04MB538C503553C02CE7DDA5385874B0@DB4PR04MB538.eurprd04.prod.outlook.com>
 <CAOMZO5A-y86T1HUVDMUnOC6BOKUw87EOCL5oinGu9XNLE-HucQ@mail.gmail.com>
Message-ID: <CAOMZO5CcykTOBqP=ukABnXzA=_1zYLMo_AN3buZn2zWvayvG8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 11:39 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Jacky,
>
> On Thu, May 19, 2016 at 11:25 PM, Ping Bai <ping.bai@nxp.com> wrote:
>> Hi Fabio,
>>
>> I have already add cpufreq driver support in imx6q-cpufreq.c before adding the cpufreq device.
>> Commit: a35fc5a33b62a6c658b8ffe7544c966c1776d128.
>
> Ok, I see. Can you try to run kernel 4.6 on a mx6ul board and run a
> 'reboot' command? You will see a crash related to cpufreq.
>
> cpufreq is broken for mx6ul. Could you please take a look?

Ok, here is the fix:

--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -212,7 +212,7 @@ static int imx6q_cpufreq_probe(struct platform_device *pdev)

        if (of_machine_is_compatible("fsl,imx6ul")) {
                pll2_bus_clk = clk_get(cpu_dev, "pll2_bus");
-               secondary_sel_clk = clk_get(cpu_dev, "secondary_sel");
+               secondary_sel_clk = clk_get(cpu_dev, "secondary_sel_clk");
                if (IS_ERR(pll2_bus_clk) || IS_ERR(secondary_sel_clk)) {
                        dev_err(cpu_dev, "failed to get clocks specific to imx6u
                        ret = -ENOENT;


Will send a proper patch.

Thanks
