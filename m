From: jeffy.chen@rock-chips.com (jeffy)
Date: Wed, 28 Jun 2017 12:41:09 +0800
Subject: [PATCH v2] spi: rockchip: Disable Runtime PM when chip select
 is asserted
In-Reply-To: <CAD=FV=WwCiMySpC-SMFQmM_JFCMdcSGQLXut1rUVVe_8E96-ew@mail.gmail.com>
References: <1498530035-22070-1-git-send-email-jeffy.chen@rock-chips.com>
 <CAD=FV=WwCiMySpC-SMFQmM_JFCMdcSGQLXut1rUVVe_8E96-ew@mail.gmail.com>
Message-ID: <59533365.60003@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi doug,

thanx for your comments.

On 06/28/2017 03:27 AM, Doug Anderson wrote:
> Hi,
>
> On Mon, Jun 26, 2017 at 7:20 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
>> The rockchip spi would stop driving pins when runtime suspended, which
>> might break slave's xfer(for example cros_ec).
>>
>> Since we have pullups on those pins, we only need to care about the CS
>> asserted case.
>>
>> So let's keep the spi alive when chip select is asserted for that.
>>
>> Also change use pm_runtime_put instead of pm_runtime_put_sync.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> ---
>>
>> Changes in v2:
>> Improve commit message and comments and coding style.
>>
>>   drivers/spi/spi-rockchip.c | 23 ++++++++++++++++++-----
>>   1 file changed, 18 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
>> index acf31f3..ea0edd7 100644
>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c
>> @@ -264,7 +264,7 @@ static inline u32 rx_max(struct rockchip_spi *rs)
>>
>>   static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
>>   {
>> -       u32 ser;
>> +       u32 ser, new_ser;
>>          struct spi_master *master = spi->master;
>>          struct rockchip_spi *rs = spi_master_get_devdata(master);
>>
>> @@ -288,13 +288,26 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
>>           * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
>>           */
>>          if (!enable)
>> -               ser |= 1 << spi->chip_select;
>> +               new_ser = ser | BIT(spi->chip_select);
>>          else
>> -               ser &= ~(1 << spi->chip_select);
>> +               new_ser = ser & ~BIT(spi->chip_select);
>>
>> -       writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
>> +       if (new_ser != ser) {
>
> IMHO it's not a great idea to use the state of the hardware register
> here.  Using the state of the hardware register probably works OK, but
> it makes me just a little nervous.  If something happened to the state
> of the register (someone used /dev/mem to tweak, or the peripherals
> got reset, or ...) then you could end up with an unbalanced set of PM
> Runtime calls.  I know none of those things are common, but it still
> seems less than great to me.
>
> I'd rather we kept track in "struct rockchip_spi" whether we already
> called pm_runtime_get_sync().  AKA the following (untested):
>
> bool cs_asserted = !enable;
>
> /* Return immediately for no-op */
> if (cs_asserted == rs->cs_asserted)
>    return;
>
> /* Keep things powered as long as CS is asserted */
> if (cs_asserted) {
>    pm_runtime_get_sync(rs->dev);
>    rs->cs_asserted = true;
> }
>
> ser = ...
> ...
> ...
>
> if (!cs_asserted)
>    pm_runtime_put(rs->dev);
>
>
> NOTE: another advantage of storing the state in 'struct rockchip_spi'
> is that you can access it without pm_runtime_get_sync().
>
ok, that make sense :)
>
>> +               writel_relaxed(new_ser, rs->regs + ROCKCHIP_SPI_SER);
>>
>> -       pm_runtime_put_sync(rs->dev);
>> +               /*
>> +                * The rockchip spi would stop driving all pins when powered
>> +                * down.
>> +                * So hold a runtime PM reference as long as CS is asserted.
>> +                */
>> +               if (!enable)
>> +                       return;
>> +
>> +               /* Drop reference from when we first asserted CS */
>> +               pm_runtime_put(rs->dev);
>> +       }
>> +
>> +       pm_runtime_put(rs->dev);
>
> One note is that you should still submit your patch to add
> "SPI_MASTER_GPIO_SS" to spi-rockchip.c.  It's important that the SPI
> driver see the CS transitions so that it can do the PM Runtime get/put
> even when someone uses a GPIO chip select.  Even though the GPIO chip
> select will keep state, we don't want the rest of the lines to stop
> being driven.
ok, will do.
>
>
> -Doug
>
>
>
