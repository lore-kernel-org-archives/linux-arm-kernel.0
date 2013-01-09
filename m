From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 09 Jan 2013 13:44:03 -0700
Subject: [PATCH v3 0/9] Migrate Tegra to common clock framework
In-Reply-To: <50EDAA39.3040609@wwwdotorg.org>
References: <1357292453-28418-1-git-send-email-pgaikwad@nvidia.com>
 <50E70FE5.9010001@wwwdotorg.org> <50EB6403.5090300@wwwdotorg.org>
 <50EC1CD3.3070308@nvidia.com> <50EC6A37.4000206@wwwdotorg.org>
 <50EC8947.4080704@wwwdotorg.org> <50ED4DA9.3090406@nvidia.com>
 <50EDAA39.3040609@wwwdotorg.org>
Message-ID: <50EDD693.2060905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 10:34 AM, Stephen Warren wrote:
> On 01/09/2013 03:59 AM, Prashant Gaikwad wrote:
>> On Wednesday 09 January 2013 02:31 AM, Stephen Warren wrote:
>>> On 01/08/2013 11:49 AM, Stephen Warren wrote:
>>>> On 01/08/2013 06:19 AM, Prashant Gaikwad wrote:
>>>>> On Tuesday 08 January 2013 05:40 AM, Stephen Warren wrote:
>>>>>> On 01/04/2013 10:22 AM, Stephen Warren wrote:
>>>>>>> On 01/04/2013 02:40 AM, Prashant Gaikwad wrote:
>>>>>>>> This patchset does following:
>>>>>>>> 1. Decompose single tegra clock structure into multiple clocks.
>>>>>>>> 2. Try to use standard clock types supported by common clock
>>>>>>>> framework.
>>>>>>>> 3. Use dynamic initialization.
>>>>>>>> 4. Move all clock code to drivers/clk/tegra from mach-tegra.
>>>>>>>> 5. Add device tree support for Tegra20 and Tegra30 clocks.
>>>>>>>> 6. Remove all legacy clock code from mach-tegra.
>>>>>>> I think there are bugs here. I applied all your clock patches on
>>>>>>> top of
>>>>>>> Tegra's for-next (see list below), and found that the following don't
>>>>>>> work on Springbank:
>>>>>>>
>>>>>>> * HDMI display
>>>>>>> * Audio playback
>>>>>>> * WiFi
>>>>>> (BTW, I stopped Cc'ing linux-kernel@, but added linux-tegra@
>>>>>> instead...)
>>>>>>
>>>>>> Prashant, some updated testing results based off the "dev/ccf" branch
>>>>>> you sent me on our internal git server:
>>>> ...
>>>>> I have updated the internal branch with all the above mentioned fixes.
>>> ...
>>>> The remaining item is the display issue on Tegra30, which I'll go look
>>>> at now.
>>> The USB3 clock, which isn't used by any drivers on Tegra30, and hence
>>> was disabled at boot, was set up incorrectly and ended up mapping to the
>>> disp1 clock, and hence turned off the display. The following fixes it:
>>
>> Stephen, thanks for the fix!! I have included this and PLLE fix; updated
>> internal branch.
> 
> Almost everything works great now.

I noticed a couple more issues.

First, the clock rate rounding behaviour changes with your patch series
for at least the I2C clocks.

With I2C, you specify how fast you want the bus to go. The bus shouldn't
run any faster than that since the rate matches the max specification
for the attached devices. So the clock framework should pick the
smallest divider that yields a clock that doesn't exceed the request
from clk_set_rate(). However, the new code seems to pick the smallest
divider that yields at least the requested clock. I can certainly see
that other clocks (say memory, CPU, or other internal
performance-related clocks) might want to round the other way though.

The I2C driver sets its module clock to 8 times the desired bus rate.
This yields a request of:

desired bus rate: 100 KHz
desired clock rate: 800 KHz
actual clock rate before your change: 800 KHz
actual clock rate after your change: 800 KHz
-> OK

desired bus rate: 400 KHz
desired clock rate: 3.2 MHz
actual clock rate before your change: 3 MHz (so 375 KHz bus rate, OK)
actual clock rate after your change: 4 MHZ (so 500 KHz bus rate, BAD)

desired bus rate: 80 KHz (Toshiba AC100's nvec/I2C slave driver)
desired clock rate: 640 KHz
actual clock rate before your change: ~632 KHz (so ~79 KHz bus rate, OK)
actual clock rate after your change: ~706 KHz (so ~88 KHz bus rate, BAD)

Can this be fixed?

Second, the Toshiba AC100 uses an alternative driver for the I2C HW,
since it operates in I2C slave mode. So, the DT node for that driver
needs to include the clocks properties so the driver can get the clocks
through DT:

> diff --git a/arch/arm/boot/dts/tegra20-paz00.dts b/arch/arm/boot/dts/tegra20-paz00.dts
> index edef66c..6495425 100644
> --- a/arch/arm/boot/dts/tegra20-paz00.dts
> +++ b/arch/arm/boot/dts/tegra20-paz00.dts
> @@ -278,6 +278,8 @@
>                 clock-frequency = <50000>;
>                 request-gpios = <&gpio 170 0>; /* gpio PV2 */
>                 slave-addr = <138>;
> +               clocks = <&tegra_car 67>, <&tegra_car 124>;
> +               clock-names = "div-clk", "fast-clk";
>         };
>  
>         i2c at 7000d000 {

Your changes don't actually cause the driver to break though, since it
abuses clk_get_sys() to retrieve clocks under a different driver name,
which matches what the clock driver provides. However, I think you
should also include the following patch at the end of your series to fix
this up, so the clock looking happens through device tree:

> diff --git a/drivers/staging/nvec/nvec.c b/drivers/staging/nvec/nvec.c
> index d8826ed..6d44076 100644
> --- a/drivers/staging/nvec/nvec.c
> +++ b/drivers/staging/nvec/nvec.c
> @@ -770,7 +770,7 @@ static int tegra_nvec_probe(struct platform_device *pdev)
>                 return -ENODEV;
>         }
>  
> -       i2c_clk = clk_get_sys("tegra-i2c.2", "div-clk");
> +       i2c_clk = clk_get(&pdev->dev, "div-clk");
>         if (IS_ERR(i2c_clk)) {
>                 dev_err(nvec->dev, "failed to get controller clock\n");
>                 return -ENODEV;

Thanks.
