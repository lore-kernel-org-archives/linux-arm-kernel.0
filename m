From: vm.rod25@gmail.com (Victor Rodriguez)
Date: Tue, 14 Dec 2010 09:39:55 -0600
Subject: [PATCH v10 4/6] davinci: MMC/SD support for Omapl138-Hawkboard
In-Reply-To: <AANLkTiktxX3X+qTmentd+gDE3zPSqkry72P8GE6SLvf9@mail.gmail.com>
References: <1291760089-5818-1-git-send-email-vm.rod25@gmail.com>
	<1291760089-5818-5-git-send-email-vm.rod25@gmail.com>
	<B85A65D85D7EB246BE421B3FB0FBB5930247C470AD@dbde02.ent.ti.com>
	<AANLkTi=VZQAhC=Hm7dGB8tW38FA-SqLUc-GCiNUX7iSw@mail.gmail.com>
	<AANLkTiktxX3X+qTmentd+gDE3zPSqkry72P8GE6SLvf9@mail.gmail.com>
Message-ID: <AANLkTikAQJ6fdqqUBxR4sGu0VMNE4WRiWM8RC9yRzCwb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 10, 2010 at 3:02 PM, Victor Rodriguez <vm.rod25@gmail.com> wrote:
> On Wed, Dec 8, 2010 at 9:55 AM, Victor Rodriguez <vm.rod25@gmail.com> wrote:
>> On Tue, Dec 7, 2010 at 11:20 PM, Nori, Sekhar <nsekhar@ti.com> wrote:
>>> On Wed, Dec 08, 2010 at 03:44:47, vm.rod25 at gmail.com wrote:
>>>
>>>> +static __init void omapl138_hawk_mmc_init(void)
>>>> +{
>>>> + ? ? int ret;
>>>> +
>>>> + ? ? ret = davinci_cfg_reg_list(hawk_mmcsd0_pins);
>>>> + ? ? if (ret) {
>>>> + ? ? ? ? ? ? pr_warning("%s: MMC/SD0 mux setup failed: %d\n",
>>>> + ? ? ? ? ? ? ? ? ? ? __func__, ret);
>>>> + ? ? ? ? ? ? return;
>>>> + ? ? }
>>>> +
>>>> + ? ? ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
>>>> + ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "MMC CD");
>>>> + ? ? if (ret < 0) {
>>>> + ? ? ? ? ? ? pr_warning("%s: can not open GPIO %d\n",
>>>> + ? ? ? ? ? ? ? ? ? ? __func__, DA850_HAWK_MMCSD_CD_PIN);
>>>> + ? ? ? ? ? ? goto mmc_setup_cd_fail;
>>>> + ? ? }
>>>
>>> A goto is only used when there is some recovery
>>> to be done. In this case, you should simply return
>>> here. The USB patch needs the same correction.
>>>
>>> Thanks,
>>> Sekhar
>>
>> Sorry for this my mistake
>>
>> It wil change to this
>>
>> +static __init void omapl138_hawk_mmc_init(void)
>> +{
>> + ? ? ? int ret;
>> +
>> + ? ? ? ret = davinci_cfg_reg_list(hawk_mmcsd0_pins);
>> + ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? pr_warning("%s: MMC/SD0 mux setup failed: %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? __func__, ret);
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? }
>> +
>> + ? ? ? ret = gpio_request_one(DA850_HAWK_MMCSD_CD_PIN,
>> + ? ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "MMC CD");
>> + ? ? ? if (ret < 0) {
>> + ? ? ? ? ? ? ? pr_warning("%s: can not open GPIO %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? __func__, DA850_HAWK_MMCSD_CD_PIN);
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? }
>> +
>> + ? ? ? ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
>> + ? ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "MMC WP");
>> + ? ? ? if (ret < 0) {
>> + ? ? ? ? ? ? ? pr_warning("%s: can not open GPIO %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? __func__, DA850_HAWK_MMCSD_WP_PIN);
>> + ? ? ? ? ? ? ? goto mmc_setup_wp_fail;
>> + ? ? ? }
>> +
>> + ? ? ? ret = da8xx_register_mmcsd0(&da850_mmc_config);
>> + ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? pr_warning("%s: MMC/SD0 registration failed: %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? __func__, ret);
>> + ? ? ? ? ? ? ? goto mmc_setup_mmcsd_fail;
>> + ? ? ? }
>> +
>> + ? ? ? return;
>> +
>> +mmc_setup_mmcsd_fail:
>> + ? ? ? gpio_free(DA850_HAWK_MMCSD_WP_PIN);
>> +mmc_setup_wp_fail:
>> + ? ? ? gpio_free(DA850_HAWK_MMCSD_CD_PIN);
>> +}
>> +
>>
>> And USB will be this
>>
>> +static __init void omapl138_hawk_usb_init(void)
>> +{
>> + ? ? ? int ret;
>> + ? ? ? u32 cfgchip2;
>> +
>> + ? ? ? ret = davinci_cfg_reg_list(da850_hawk_usb11_pins);
>> + ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? pr_warning("%s: USB 1.1 PinMux setup failed: %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? __func__, ret);
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? }
>> +
>> + ? ? ? /* Setup the Ref. clock frequency for the HAWK at 24 MHz. */
>> +
>> + ? ? ? cfgchip2 = __raw_readl(DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>> + ? ? ? cfgchip2 &= ~CFGCHIP2_REFFREQ;
>> + ? ? ? cfgchip2 |= ?CFGCHIP2_REFFREQ_24MHZ;
>> + ? ? ? __raw_writel(cfgchip2, DA8XX_SYSCFG0_VIRT(DA8XX_CFGCHIP2_REG));
>> +
>> + ? ? ? ret = gpio_request_one(DA850_USB1_VBUS_PIN,
>> + ? ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_OUT, "USB1 VBUS");
>> + ? ? ? if (ret < 0) {
>> + ? ? ? ? ? ? ? pr_err("%s: failed to request GPIO for USB 1.1 port "
>> + ? ? ? ? ? ? ? ? ? ? ? "power control: %d\n", __func__, ret);
>> + ? ? ? ? ? ? ? return;
>> + ? ? ? }
>> +
>> + ? ? ? ret = gpio_request_one(DA850_USB1_OC_PIN,
>> + ? ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "USB1 OC");
>> + ? ? ? if (ret < 0) {
>> + ? ? ? ? ? ? ? pr_err("%s: failed to request GPIO for USB 1.1 port "
>> + ? ? ? ? ? ? ? ? ? ? ? "over-current indicator: %d\n", __func__, ret);
>> + ? ? ? ? ? ? ? goto usb11_setup_oc_fail;
>> + ? ? ? }
>> +
>> + ? ? ? ret = da8xx_register_usb11(&omapl138_hawk_usb11_pdata);
>> + ? ? ? if (ret) {
>> + ? ? ? ? ? ? ? pr_warning("%s: USB 1.1 registration failed: %d\n",
>> + ? ? ? ? ? ? ? ? ? ? ? __func__, ret);
>> + ? ? ? ? ? ? ? goto usb11_setup_fail;
>> + ? ? ? }
>> +
>> + ? ? ? return;
>> +
>> +usb11_setup_fail:
>> + ? ? ? gpio_free(DA850_USB1_OC_PIN);
>> +usb11_setup_oc_fail:
>> + ? ? ? gpio_free(DA850_USB1_VBUS_PIN);
>> +}
>> +
>>
>> Thanks a lot for the comments
>>
>> Regards
>>
>> Victor Rodriguez
>
>
> Any update of this is Ok to resend the series with this small change?
>
>
> Regards
>
> Victor Rodriguez


Hi Sekhar and Kevin  I will resend the patches again with this changes is ok?

Thanks and regards

Victor Rodriguez


>
>>
>>>> +
>>>> + ? ? ret = gpio_request_one(DA850_HAWK_MMCSD_WP_PIN,
>>>> + ? ? ? ? ? ? ? ? ? ? GPIOF_DIR_IN, "MMC WP");
>>>> + ? ? if (ret < 0) {
>>>> + ? ? ? ? ? ? pr_warning("%s: can not open GPIO %d\n",
>>>> + ? ? ? ? ? ? ? ? ? ? __func__, DA850_HAWK_MMCSD_WP_PIN);
>>>> + ? ? ? ? ? ? goto mmc_setup_wp_fail;
>>>> + ? ? }
>>>> +
>>>> + ? ? ret = da8xx_register_mmcsd0(&da850_mmc_config);
>>>> + ? ? if (ret) {
>>>> + ? ? ? ? ? ? pr_warning("%s: MMC/SD0 registration failed: %d\n",
>>>> + ? ? ? ? ? ? ? ? ? ? __func__, ret);
>>>> + ? ? ? ? ? ? goto mmc_setup_mmcsd_fail;
>>>> + ? ? }
>>>> +
>>>> +mmc_setup_cd_fail:
>>>> + ? ? return;
>>>> +
>>>> +mmc_setup_mmcsd_fail:
>>>> + ? ? gpio_free(DA850_HAWK_MMCSD_WP_PIN);
>>>> +mmc_setup_wp_fail:
>>>> + ? ? gpio_free(DA850_HAWK_MMCSD_CD_PIN);
>>>> +}
>>>> +
>>>> ?static struct davinci_uart_config omapl138_hawk_uart_config __initdata = {
>>>> ? ? ? .enabled_uarts = 0x7,
>>>> ?};
>>>> @@ -127,6 +198,8 @@ static __init void omapl138_hawk_init(void)
>>>> ? ? ? ? ? ? ? pr_warning("%s: EDMA registration failed: %d\n",
>>>> ? ? ? ? ? ? ? ? ? ? ? __func__, ret);
>>>>
>>>> + ? ? omapl138_hawk_mmc_init();
>>>> +
>>>> ? ? ? ret = da8xx_register_watchdog();
>>>> ? ? ? if (ret)
>>>> ? ? ? ? ? ? ? pr_warning("omapl138_hawk_init: "
>>>> --
>>>> 1.7.0.4
>>>>
>>>> _______________________________________________
>>>> Davinci-linux-open-source mailing list
>>>> Davinci-linux-open-source at linux.davincidsp.com
>>>> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
>>>>
>>>
>>>
>>
>
