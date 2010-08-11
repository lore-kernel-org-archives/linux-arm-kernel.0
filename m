From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 12 Aug 2010 01:19:41 +0300
Subject: [PATCH v4 2/8] wireless: wl1271: support return value for the set
	power func
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB0324110ABB@dbde02.ent.ti.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-3-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABB@dbde02.ent.ti.com>
Message-ID: <AANLkTikXOu5R7+9RXxLty2aVKWpJLXY4-J6f9g9GHRXd@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 11, 2010 at 9:35 PM, DebBarma, Tarun Kanti
<tarun.kanti@ti.com> wrote:
>> - ? ? wl->if_ops->power(wl, true);
>> - ? ? set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
>> + ? ? int ret = wl->if_ops->power(wl, true);
> Just a minor comment, need a blank line here?


Can't hurt, thanks.


>> + ? ? if (ret == 0)
>> + ? ? ? ? ? ? set_bit(WL1271_FLAG_GPIO_POWER, &wl->flags);
>> + ? ? return ret;
>> ?}
>>
>>
>> diff --git a/drivers/net/wireless/wl12xx/wl1271_main.c
>> b/drivers/net/wireless/wl12xx/wl1271_main.c
>> index 9d68f00..e6e0852 100644
>> --- a/drivers/net/wireless/wl12xx/wl1271_main.c
>> +++ b/drivers/net/wireless/wl12xx/wl1271_main.c
>> @@ -621,7 +621,9 @@ static int wl1271_chip_wakeup(struct wl1271 *wl)
>> ? ? ? int ret = 0;
>>
>> ? ? ? msleep(WL1271_PRE_POWER_ON_SLEEP);
>> - ? ? wl1271_power_on(wl);
>> + ? ? ret = wl1271_power_on(wl);
>> + ? ? if (ret < 0)
>> + ? ? ? ? ? ? goto out;
>> ? ? ? msleep(WL1271_POWER_ON_SLEEP);
>> ? ? ? wl1271_io_reset(wl);
>> ? ? ? wl1271_io_init(wl);
>> diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c
>> b/drivers/net/wireless/wl12xx/wl1271_sdio.c
>> index 7059b5c..c41293a 100644
>> --- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
>> +++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
>> @@ -152,7 +152,7 @@ static void wl1271_sdio_raw_write(struct wl1271 *wl,
>> int addr, void *buf,
>>
>> ?}
>>
>> -static void wl1271_sdio_set_power(struct wl1271 *wl, bool enable)
>> +static int wl1271_sdio_set_power(struct wl1271 *wl, bool enable)
>> ?{
>> ? ? ? struct sdio_func *func = wl_to_func(wl);
>>
>> @@ -167,6 +167,8 @@ static void wl1271_sdio_set_power(struct wl1271 *wl,
>> bool enable)
>> ? ? ? ? ? ? ? sdio_disable_func(func);
>> ? ? ? ? ? ? ? sdio_release_host(func);
>> ? ? ? }
>> +
>> + ? ? return 0;
>> ?}
>>
>> ?static struct wl1271_if_operations sdio_ops = {
>> diff --git a/drivers/net/wireless/wl12xx/wl1271_spi.c
>> b/drivers/net/wireless/wl12xx/wl1271_spi.c
>> index c3fdab7..de56d8d 100644
>> --- a/drivers/net/wireless/wl12xx/wl1271_spi.c
>> +++ b/drivers/net/wireless/wl12xx/wl1271_spi.c
>> @@ -312,10 +312,12 @@ static irqreturn_t wl1271_irq(int irq, void *cookie)
>> ? ? ? return IRQ_HANDLED;
>> ?}
>>
>> -static void wl1271_spi_set_power(struct wl1271 *wl, bool enable)
>> +static int wl1271_spi_set_power(struct wl1271 *wl, bool enable)
>> ?{
>> ? ? ? if (wl->set_power)
>> ? ? ? ? ? ? ? wl->set_power(enable);
>> +
>> + ? ? return 0;
>> ?}
>>
>> ?static struct wl1271_if_operations spi_ops = {
>> --
>> 1.7.0.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
