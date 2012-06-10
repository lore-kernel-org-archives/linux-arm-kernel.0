From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 10 Jun 2012 18:40:18 +0800
Subject: [PATCH] pinctrl: sirf: mark of_device_id match table as
 __devinitconst
In-Reply-To: <CACRpkdZcnWO3YL2+hVUpuRh-psZHq61oAOh5sp9A91UJ732hAw@mail.gmail.com>
References: <1337569142-18756-1-git-send-email-Barry.Song@csr.com>
 <CACRpkdZcnWO3YL2+hVUpuRh-psZHq61oAOh5sp9A91UJ732hAw@mail.gmail.com>
Message-ID: <CAGsJ_4wHXMg_kM580xp=iPb+TDGDHvd48wZfNq0EPp=JL=dfnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

2012/6/7 Linus Walleij <linus.walleij@linaro.org>:
> On Mon, May 21, 2012 at 4:59 AM, Barry Song <Barry.Song@csr.com> wrote:
>
>> From: Barry Song <Baohua.Song@csr.com>
>>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>> ---
>> ?drivers/pinctrl/pinctrl-sirf.c | ? ?2 +-
>> ?1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/pinctrl/pinctrl-sirf.c b/drivers/pinctrl/pinctrl-sirf.c
>> index 6b3534c..5816cc3 100644
>> --- a/drivers/pinctrl/pinctrl-sirf.c
>> +++ b/drivers/pinctrl/pinctrl-sirf.c
>> @@ -1192,7 +1192,7 @@ out_no_gpio_remap:
>> ? ? ? ?return ret;
>> ?}
>>
>> -static const struct of_device_id pinmux_ids[] ?= {
>> +static const struct of_device_id pinmux_ids[] __devinitconst = {
>> ? ? ? ?{ .compatible = "sirf,prima2-gpio-pinmux" },
>> ? ? ? ?{}
>> ?};
>
> Hm Uwe poked me about this change, Barry are you sure the DT
> ID table can be __devinitconst? I would think so, but better check
> again.

__devinitconst is defined as __section(.devinit.rodata). at the same
time, .devinit sections are used for hotplug and __devinit is often
added as the head of probe() functions.

the devinit/devinitdata will be released after system initilizes when
the system dose not support HOTPLUG, without HOTPLUG, devinit = init.
If the system enables CONFIG_HOTPLUG, devinitdata, typical including
device table, should be useful all the time along.  then it seems
devinitconst is better for usb_device_id, pci_device_id,
sdio_device_id.

of_device_id is not too much related with HOTPLUG, so I am not 100%
sure it is the good place to use devinitconst for of match table, but
if we grep, lots of drivers have used it:

drivers/amba/tegra-ahb.c	
272 static const struct of_device_id tegra_ahb_of_match[] __devinitconst = {
drivers/block/xsysace.c	
1193 static const struct of_device_id ace_of_match[] __devinitconst = {
drivers/char/xilinx_hwicap/xilinx_hwicap.c	
788 static const struct of_device_id __devinitconst hwicap_of_match[];
832 static const struct of_device_id __devinitconst hwicap_of_match[] = {
drivers/clocksource/em_sti.c	
387 static const struct of_device_id em_sti_dt_ids[] __devinitconst = {
drivers/i2c/busses/i2c-sh_mobile.c	
717 static const struct of_device_id sh_mobile_i2c_dt_ids[] __devinitconst = {
drivers/i2c/busses/i2c-sirf.c	
436 static const struct of_device_id sirfsoc_i2c_of_match[] __devinitconst = {
drivers/i2c/busses/i2c-tegra.c	
755 static const struct of_device_id tegra_i2c_of_match[] __devinitconst = {
drivers/i2c/busses/i2c-xiic.c	
803 static const struct of_device_id xiic_of_match[] __devinitconst = {
drivers/i2c/muxes/i2c-mux-pinctrl.c	
258 static const struct of_device_id i2c_mux_pinctrl_of_match[]
__devinitconst = {
	
74 static const struct mpr121_init_register init_reg_table[] __devinitconst = {
drivers/input/serio/xilinx_ps2.c	
358 static const struct of_device_id xps2_of_match[] __devinitconst = {
drivers/input/touchscreen/st1232.c	
258 static const struct of_device_id st1232_ts_dt_ids[] __devinitconst = {
drivers/memory/tegra20-mc.c	
184 static const struct of_device_id tegra20_mc_of_match[] __devinitconst = {
drivers/memory/tegra30-mc.c	
306 static const struct of_device_id tegra30_mc_of_match[] __devinitconst = {
drivers/power/olpc_battery.c	
616 static const struct of_device_id olpc_battery_ids[] __devinitconst = {
drivers/regulator/fixed.c	
294 static const struct of_device_id fixed_of_match[] __devinitconst = {
drivers/regulator/twl-regulator.c	
1115 static const struct of_device_id twl_of_match[] __devinitconst = {
drivers/spi/spi-mpc52xx.c	
549 static const struct of_device_id mpc52xx_spi_match[] __devinitconst = {
drivers/staging/nvec/nvec.c	
914 static const struct of_device_id nvidia_nvec_of_match[] __devinitconst = {
...

sound/soc/tegra/tegra30_i2s.c	
510 static const struct of_device_id tegra30_i2s_of_match[] __devinitconst = {
515 static const struct dev_pm_ops tegra30_i2s_pm_ops __devinitconst = {
sound/soc/tegra/tegra_alc5632.c	
250 static const struct of_device_id tegra_alc5632_of_match[] __devinitconst = {
sound/soc/tegra/tegra_wm8753.c	
203 static const struct of_device_id tegra_wm8753_of_match[] __devinitconst = {
sound/soc/tegra/tegra_wm8903.c	
491 static const struct of_device_id tegra_wm8903_of_match[] __devinitconst = {
sound/soc/tegra/trimslice.c	
214 static const struct of_device_id trimslice_of_match[] __devinitconst = {
>
> Yours,
> Linus Walleij

Thanks
barry
