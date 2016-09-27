From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Tue, 27 Sep 2016 21:27:54 +0200
Subject: [PATCH v2 3/8] i2c: bcm2835: Use ratelimited logging on transfer
 errors
In-Reply-To: <74D9ED33-1B99-4ED6-88B5-879950D160C8@martin.sperl.org>
References: <1474977426-3272-1-git-send-email-noralf@tronnes.org>
 <1474977426-3272-4-git-send-email-noralf@tronnes.org>
 <74D9ED33-1B99-4ED6-88B5-879950D160C8@martin.sperl.org>
Message-ID: <66be95f1-3ed7-7abc-3def-b10582d609ea@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 27.09.2016 15:01, skrev Martin Sperl:
>> On 27 Sep 2016, at 13:57, Noralf Tr?nnes <noralf@tronnes.org> wrote:
>>
>> Writing to an AT24C32 generates on average 2x i2c transfer errors per
>> 32-byte page write. Which amounts to a lot for a 4k write. This is due
>> to the fact that the chip doesn't respond during it's internal write
>> cycle when the at24 driver tries and retries the next write.
>> Reduce this flooding of the log by using dev_err_ratelimited().
>>
>> Signed-off-by: Noralf Tr?nnes <noralf@tronnes.org>
>> Reviewed-by: Eric Anholt <eric@anholt.net>
>> ---
>> drivers/i2c/busses/i2c-bcm2835.c | 3 ++-
>> 1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
>> index df036ed..370a322 100644
>> --- a/drivers/i2c/busses/i2c-bcm2835.c
>> +++ b/drivers/i2c/busses/i2c-bcm2835.c
>> @@ -207,7 +207,8 @@ static int bcm2835_i2c_xfer_msg(struct bcm2835_i2c_dev *i2c_dev,
>>         (msg->flags & I2C_M_IGNORE_NAK))
>>         return 0;
>>
>> -    dev_err(i2c_dev->dev, "i2c transfer failed: %x\n", i2c_dev->msg_err);
>> +    dev_err_ratelimited(i2c_dev->dev, "i2c transfer failed: %x\n",
>> +                i2c_dev->msg_err);
> Do we really need this error message at all?
>
> Maybe just remove it instead, because error messages during
> "normal"/successfull operations of at24 seems  strange.
>
> Or make it a debug message instead.

I have looked through 64 i2c bus drivers, 8 use dev_err and 2 use dev_warn
on transfer errors (not timeouts). Several use dev_dbg.

I'll change it to dev_dbg instead. Thanks.

Noralf.
