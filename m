From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 25 Jan 2010 22:13:31 -0500
Subject: [PATCH 4/4] power_supply: enable power supply of max8925
In-Reply-To: <20100125120543.GF22909@sirena.org.uk>
References: <771cded01001250309k64efaa98n6a68f56678986228@mail.gmail.com>
	<20100125120543.GF22909@sirena.org.uk>
Message-ID: <771cded01001251913x31e98129h895c92b9c0a0e0bc@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2010 at 7:05 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jan 25, 2010 at 06:09:50AM -0500, Haojian Zhuang wrote:
>
>> + ? ? case MAX8925_IRQ_VCHG_DC_R:
>> + ? ? ? ? ? ? info->ac_online = 1;
>> + ? ? ? ? ? ? __set_charger(info, 1);
>> + ? ? ? ? ? ? dev_dbg(chip->dev, "Adapter is insertion\n");
>
> Grammar nit "Adapter inserted".
>
>> + ? ? case MAX8925_IRQ_VCHG_SYSLOW_R:
>> + ? ? ? ? ? ? /* VSYS is low */
>> + ? ? ? ? ? ? dev_dbg(chip->dev, "Sys power is too low\n");
>> + ? ? ? ? ? ? break;
>
> This probably ought to be printed by default - with most PMICs if the
> system power rail goes low this is an indication of impending system
> power failure so it'd be good to make an effort to get the message out
> on the console. ?Not much use in production but it can be very helpful
> during development.
>
>> +static ssize_t charger_state_show(struct device *dev,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? struct device_attribute *attr, char *buf)
>> +{
>> + ? ? struct max8925_power_info *info = dev_get_drvdata(dev);
>> + ? ? char *charge = NULL;
>> + ? ? int ret;
>> +
>> + ? ? ret = max8925_reg_read(info->gpm, MAX8925_CHG_STATUS);
>> + ? ? ret = (ret & MAX8925_CHG_STAT_MODE_MASK) >> 2;
>> + ? ? switch (ret) {
>> + ? ? case 1:
>> + ? ? ? ? ? ? charge = "Fast charging";
>> + ? ? ? ? ? ? break;
>
> There's now a standard power supply property for this so this sysfs file
> could be removed and that used instead - POWER_SUPPLY_PROP_CHARGE_TYPE.
>

Update the patch now.

Thanks
Haojian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0004-power_supply-enable-power-supply-of-max8925.patch
Type: text/x-patch
Size: 16296 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100125/e9f628a2/attachment.bin>
