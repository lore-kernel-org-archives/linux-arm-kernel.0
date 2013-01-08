From: pgaikwad@nvidia.com (Prashant Gaikwad)
Date: Tue, 8 Jan 2013 18:49:15 +0530
Subject: [PATCH v3 0/9] Migrate Tegra to common clock framework
In-Reply-To: <50EB6403.5090300@wwwdotorg.org>
References: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
 <50E70FE5.9010001@wwwdotorg.org> <50EB6403.5090300@wwwdotorg.org>
Message-ID: <50EC1CD3.3070308@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 January 2013 05:40 AM, Stephen Warren wrote:
> On 01/04/2013 10:22 AM, Stephen Warren wrote:
>> On 01/04/2013 02:40 AM, Prashant Gaikwad wrote:
>>> This patchset does following:
>>> 1. Decompose single tegra clock structure into multiple clocks.
>>> 2. Try to use standard clock types supported by common clock framework.
>>> 3. Use dynamic initialization.
>>> 4. Move all clock code to drivers/clk/tegra from mach-tegra.
>>> 5. Add device tree support for Tegra20 and Tegra30 clocks.
>>> 6. Remove all legacy clock code from mach-tegra.
>> I think there are bugs here. I applied all your clock patches on top of
>> Tegra's for-next (see list below), and found that the following don't
>> work on Springbank:
>>
>> * HDMI display
>> * Audio playback
>> * WiFi
> (BTW, I stopped Cc'ing linux-kernel@, but added linux-tegra@ instead...)
>
> Prashant, some updated testing results based off the "dev/ccf" branch
> you sent me on our internal git server:

Stephen, thanks a lot for the extensive testing and fix!!

> The following work, on both Tegra20/30 unless otherwise specified:
>
> * MMC/SD, I2C, audio, HDMI display (Tegra20 only; on Springbank), USB
> (Tegra20 only; not implemented on Tegra30).
>
> I didn't test the following yet:
>
> * LCD display on Tegra20.
>
> The following are broken:
>
> 1)
>
> SPI on either chip. This is because the SPI drivers call clk_get() with
> a specific clock name, and the DT patches you created don't have a
> clk-names property for any of the SPI nodes, hence this fails. However,
> since there's only a single clock to the SPI controllers, I think the
> drivers should be fixed not to request a specific clock name. The
> following makes SPI work on TrimSlice (Tegra20) and Cardhu (Tegra30):
>
>> diff --git a/drivers/spi/spi-tegra20-sflash.c b/drivers/spi/spi-tegra20-sflash.c
>> index 02feaa5..e5dce91 100644
>> --- a/drivers/spi/spi-tegra20-sflash.c
>> +++ b/drivers/spi/spi-tegra20-sflash.c
>> @@ -525,7 +525,7 @@ static int tegra_sflash_probe(struct platform_device *pdev)
>>                  goto exit_free_master;
>>          }
>>   
>> -       tsd->clk = devm_clk_get(&pdev->dev, "spi");
>> +       tsd->clk = devm_clk_get(&pdev->dev, NULL);
>>          if (IS_ERR(tsd->clk)) {
>>                  dev_err(&pdev->dev, "can not get clock\n");
>>                  ret = PTR_ERR(tsd->clk);
>> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
>> index fa208a5..e255e7a 100644
>> --- a/drivers/spi/spi-tegra20-slink.c
>> +++ b/drivers/spi/spi-tegra20-slink.c
>> @@ -1191,7 +1191,7 @@ static int tegra_slink_probe(struct platform_device *pdev)
>>                  goto exit_free_master;
>>          }
>>   
>> -       tspi->clk = devm_clk_get(&pdev->dev, "slink");
>> +       tspi->clk = devm_clk_get(&pdev->dev, NULL);
>>          if (IS_ERR(tspi->clk)) {
>>                  dev_err(&pdev->dev, "can not get clock\n");
>>                  ret = PTR_ERR(tspi->clk);
> I think you should include that in your series before the patches which
> add clocks into the DT.

Included.

> 2)
>
> HDMI and LCD display are both broken on Cardhu/Tegra30.
>
> I found that the DT lists the HDMI clock's parent as pll_d2_out0, yet
> the clock driver lists pll_d2 as a valid parent. I think the following
> patch fixes this correctly?
>
>> diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
>> index a52b80c..661b9e1 100644
>> --- a/drivers/clk/tegra/clk-tegra30.c
>> +++ b/drivers/clk/tegra/clk-tegra30.c
>> @@ -1385,8 +1385,8 @@ static const char *mux_pllpc_clkm_clk32k[] = { "pll_p", "pll_c", "clk_m",
>>   static const char *mux_pllmcpa[] = { "pll_m", "pll_c", "pll_p", "pll_a" };
>>   static const char *mux_pllpdc_clkm[] = { "pll_p", "pll_d", "pll_c", "clk_m" };
>>   static const char *mux_pllp_clkm[] = { "pll_p", "unused", "unused", "clk_m" };
>> -static const char *mux_pllpmdacd2_clkm[] = { "pll_p", "pll_m", "pll_d",
>> -                                            "pll_a", "pll_c", "pll_d2",
>> +static const char *mux_pllpmdacd2_clkm[] = { "pll_p", "pll_m", "pll_d_out0",
>> +                                            "pll_a", "pll_c", "pll_d2_out0",
>>                                               "clk_m" };
>>   static const char *mux_plla_clk32k_pllp_clkm_plle[] = { "pll_a_out0",
>>                                                          "clk_32k", "pll_p",
> (are there any other similar problems in the code?)

Included fix and reviewed code for more instances. There were some.

> After that, if I comment out:
>
> late_initcall(clk_disable_unused);
>
> ... then either HDMI or LCD output on Cardhu work OK (or rather in
> HDMI's case, as well as can be expected due incorrect memory controller
> programming and hence display underflow at the moment). I haven't had a
> chance to investigate why that initcall is causing problems (the problem
> being a HW hang during boot in the HDMI case, and simply no visible
> output in the LCD case, but the system otherwise works OK).
>
> For reference, the patches to enable LCD/HDMI on Cardhu can be found in:
>
> git://nv-tegra.nvidia.com/user/swarren/linux-2.6 linux-next_common

Not able to test LCD/HDMI even using above branch. Not sure what is missing.
In kernel log I can see that Tegra DRM is initialized properly. Tried 
"dmesg > /dev/fb0".

> 3)
>
> WiFi doesn't work on either chip (Springbank or Cardhu, but I expect
> Ventana has the same issue). I haven't been able to investigate why yet.

Probable fix included, can not test.

> 4)
>
> I noticed that the PCIe driver (on Trimslice/Tegra20) was complaining
> about clk_get() failing or similar. I haven't been able to investigate
> why yet.

Fix included, pcie_xclk clock was missing

> For reference, all of these problems are all introduced by your commit
> "arm: tegra: Migrate to new clock code"; everything works immediately
> before that.
>
> Let me know if you find any solutions to these; I guess just update your
> branch. Otherwise, I'll keep investigating tomorrow.

I have updated the internal branch with all the above mentioned fixes.
