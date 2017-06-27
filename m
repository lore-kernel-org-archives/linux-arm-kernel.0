From: jeffy.chen@rock-chips.com (jeffy)
Date: Tue, 27 Jun 2017 10:22:47 +0800
Subject: [PATCH] spi: rockchip: Keep master alive when CS asserted
In-Reply-To: <20170626221736.GA126468@google.com>
References: <1498446606-5529-1-git-send-email-jeffy.chen@rock-chips.com>
 <20170626221736.GA126468@google.com>
Message-ID: <5951C177.4000600@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi brian,

thanx for your comments.

On 06/27/2017 06:17 AM, Brian Norris wrote:
> Hi Jeffy,
>
> On Mon, Jun 26, 2017 at 11:10:06AM +0800, Jeffy Chen wrote:
>> The cros_ec requires CS line to be active after last message. But the CS
>> would be toggled when powering off/on rockchip spi, which breaks ec xfer.
>
> I believe Doug's point was larger than just the CS line. He was
> guessing that you're also stopping driving any of the other pins (e.g.,
> CLK), which could cause more problems. Seems like it'd be good to note
> that in the second sentence here.
right, i need to rewrite this.
>
>> Keep spi alive after CS asserted to prevent that.
>>
>> Suggested-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>
>> ---
>>
>>   drivers/spi/spi-rockchip.c | 22 +++++++++++++++++-----
>>   1 file changed, 17 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
>> index acf31f3..df016a1 100644
>> --- a/drivers/spi/spi-rockchip.c
>> +++ b/drivers/spi/spi-rockchip.c
>> @@ -264,7 +264,7 @@ static inline u32 rx_max(struct rockchip_spi *rs)
>>
>>   static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
>>   {
>> -	u32 ser;
>> +	u32 ser, new_ser;
>>   	struct spi_master *master = spi->master;
>>   	struct rockchip_spi *rs = spi_master_get_devdata(master);
>>
>> @@ -288,13 +288,25 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
>>   	 * Note: enable(rockchip_spi_set_cs) = !enable(spi_set_cs)
>>   	 */
>>   	if (!enable)
>> -		ser |= 1 << spi->chip_select;
>> +		new_ser = ser | BIT(spi->chip_select);
>>   	else
>> -		ser &= ~(1 << spi->chip_select);
>> +		new_ser = ser & ~BIT(spi->chip_select);
>>
>> -	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
>> +	if (new_ser == ser)
>> +		goto out;
>
> Hmm, this doens't exactly feel like a situation for 'goto'. Personally,
> an indented 'if' block would make this clearer:
>
> 	if (new_ser != ser) {
> 		... // all the stuff you do only on CS edges
> 	}
>
ok, will do.
>>
>> -	pm_runtime_put_sync(rs->dev);
>> +	writel_relaxed(new_ser, rs->regs + ROCKCHIP_SPI_SER);
>> +
>> +	/*
>> +	 * The rockchip spi would stop driving CS when power down.
>
> Replace "CS" with "all pins"? And:
> s/power/powered/
done
>
>> +	 * So we need to keep it alive after CS asserted
>
> To make this clearer, note that we're keeping an unbalanced runtime PM
> reference on purpose. Like instead of "we need to keep it alive after CS
> asserted", maybe "we hold a runtime PM reference as long as CS is
> asserted."?
done
>
>> +	 */
>> +	if (!enable)
>> +		return;
>> +	pm_runtime_put(rs->dev);
>
> I still had to read this through a few times to be sure it was right (I
> think it's correct?). Maybe to make this extra clear, a comment like
> "Drop reference from when we first asserted CS" could go above this?
>
done
>> +
>> +out:
>> +	pm_runtime_put(rs->dev);
>
> You've dropped the "_sync()" that used to be here. I think that's
> probably fine, but I wanted to call it out.
right, i'll mention it in commit message too.
>
> Brian
>
>>
>>   static int rockchip_spi_prepare_message(struct spi_master *master,
>> --
>> 2.1.4
>>
>>
>
>
>
