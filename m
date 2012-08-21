From: gcembed@gmail.com (=?UTF-8?B?R2HDq3RhbiBDYXJsaWVy?=)
Date: Tue, 21 Aug 2012 17:14:47 +0200
Subject: mx27_3ds : Sound doesn't work anymore on linux-next
In-Reply-To: <502E6329.60308@gmail.com>
References: <502E6033.4010805@gmail.com> <502E6329.60308@gmail.com>
Message-ID: <5033A5E7.2030701@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On 08/17/2012 05:28 PM, Ga?tan Carlier wrote:
> Just some more informations, process enter in D+ state and this is so
> impossible to kill them.
> On 08/17/2012 05:16 PM, Ga?tan Carlier wrote:
>> Hi,
>> It is several days that I tried to make sound work on mx27_3ds platform
>> from linux-next (daily cloned/pulled) but each time I try start start
>> aplay or alsamixer, the process freeze and CTRL+C has not effect. I can
>> open another SSH session and execute other commands but alsa commands
>> always freeze.
>> The sound card is correctly installer at boot :
>>
>> imx_mc13783 imx_mc13783.0:  mc13783-hifi <-> imx-ssi.0 mapping ok
>> ALSA device list:
>>    #0: imx_mc13783
>>
>> I only apply the patch "[PATCH 1/2] ARM: mx27pdk: Add audio support". I
>> attach my config file.
>>
>> I try to apply patch on a previous commit when I told that this patch
>> was working but it didn't succeed the is still freezing.
>> I try to make it working on another mx27-based platform but same
>> problem. I try to update Alsa from version 1.0.23 to 1.0.25 but same
>> behaviour.
>> What is wrong ?
>>
>> Regards,
>> Ga?tan Carlier.
>
> Regards,
> Ga?tan.
>
I have more informations about the problem : freeze only occurs when I 
disable MMC device support (CONFIG_MMC_MXC=n).
I don't know why these two drivers affect each other (except that CSPI 
for MC13783 and SDHC use the same PERDIV1 clock).
So I enable it back and try put a "return 0" in mxcmmc.c (only for debug 
purpose) as following :

### This makes alsamixer working
@@ -913,10 +913,11 @@ static int mxcmci_probe(struct platform_device *pdev)
  		goto out_iounmap;
  	}

  	clk_prepare_enable(host->clk_per);
  	clk_prepare_enable(host->clk_ipg);
+return 0;

  	mxcmci_softreset(host);

  	host->rev_no = readw(host->base + MMC_REG_REV_NO);
  	if (host->rev_no != 0x400) {

### This makes alsamixer freezing
@@ -898,10 +898,11 @@ static int mxcmci_probe(struct platform_device *pdev)
  	else
  		host->default_irq_mask = 0;

  	host->res = r;
  	host->irq = irq;
+return 0;

  	host->clk_ipg = devm_clk_get(&pdev->dev, "ipg");
  	if (IS_ERR(host->clk_ipg)) {
  		ret = PTR_ERR(host->clk_ipg);
  		goto out_iounmap;


So I supposed that there is a problem in clock definition but I don't 
now how to solve it. I try to replace in clk-imx27.c
clk_register_clkdev(clk[ssi1_ipg_gate], NULL, "imx-ssi.0");
by
clk_register_clkdev(clk[ssi1_ipg_gate], "ipg", "imx-ssi.0");

and in imx-ssi.c in imx_ssi_probe(), replaced
ssi->clk = devm_clk_get(&pdev->dev, "ipg");
by
ssi->clk = devm_clk_get(&pdev->dev, "ipg");

This has no effect. I don't fully know how clock mechanism for imx27 
works so I am not able to solve this problem and send a patch.
Regards,
Ga?tan Carlier.
