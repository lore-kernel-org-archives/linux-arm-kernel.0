From: eric@anholt.net (Eric Anholt)
Date: Thu, 02 Jun 2016 11:02:32 -0700
Subject: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
In-Reply-To: <25336b03-76d1-2466-fbc0-9f363d3e7638@i2se.com>
References: <1464818845-5348-1-git-send-email-eric@anholt.net>
 <25336b03-76d1-2466-fbc0-9f363d3e7638@i2se.com>
Message-ID: <8760trbhaf.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stefan Wahren <stefan.wahren@i2se.com> writes:

> Hi Eric,
>
> Am 02.06.2016 um 00:07 schrieb Eric Anholt:
>> The register at poweron contains 0x40, which at our typical 100khz bus
>> rate means .64ms instead of the desired 25ms.
>>
>> Fixes many clock stretching timeouts when talking to the DSI panel's
>> bridge chip, and will hopefully fix talking to the FXL6408 GPIO
>> expander on the Pi3 as well.
>>
>> Signed-off-by: Eric Anholt <eric@anholt.net>
>> ---
>>  drivers/i2c/busses/i2c-bcm2835.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/i2c/busses/i2c-bcm2835.c b/drivers/i2c/busses/i2c-bcm2835.c
>> index 818b051d25e6..1348f224013d 100644
>> --- a/drivers/i2c/busses/i2c-bcm2835.c
>> +++ b/drivers/i2c/busses/i2c-bcm2835.c
>> @@ -28,6 +28,11 @@
>>  #define BCM2835_I2C_FIFO	0x10
>>  #define BCM2835_I2C_DIV		0x14
>>  #define BCM2835_I2C_DEL		0x18
>> +/*
>> + * 16-bit field for the number of SCL cycles to wait after rising SCL
>> + * before deciding the slave is not responding.  0 disables the
>> + * timeout detection.
>> + */
>>  #define BCM2835_I2C_CLKT	0x1c
>>  
>>  #define BCM2835_I2C_C_READ	BIT(0)
>> @@ -238,6 +243,7 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>>  	u32 bus_clk_rate, divider;
>>  	int ret;
>>  	struct i2c_adapter *adap;
>> +	u32 clkt;
>>  
>>  	i2c_dev = devm_kzalloc(&pdev->dev, sizeof(*i2c_dev), GFP_KERNEL);
>>  	if (!i2c_dev)
>> @@ -280,6 +286,15 @@ static int bcm2835_i2c_probe(struct platform_device *pdev)
>>  	}
>>  	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_DIV, divider);
>>  
>> +	/*
>> +	 * SMBUS says "Devices participating in a transfer will
>> +	 * timeout when any clock low exceeds the value of
>> +	 * T_TIMEOUT,MIN of 25 ms."
>> +	 */
>> +	clkt = DIV_ROUND_UP(25 * bus_clk_rate, 1000);
>> +	clkt = min(clkt, 0xffffu);
>> +	bcm2835_i2c_writel(i2c_dev, BCM2835_I2C_CLKT, clkt);
>> +
>
> could we really assume that the clk rate never change after driver probing?
>
> This also affects Gerd's patch [PATCH 28/32] i2c: bcm2835: Set up the
> rising/falling edge delays.

The I2C_DIV register setup you see in this hunk is what is producing the
SCL clock, so this code is in the right place.  If we need to add
switching of bus rates at runtime then we'd have to move all of it,
which would be a separate change.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160602/9907ea19/attachment.sig>
