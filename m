From: peda@axentia.se (Peter Rosin)
Date: Thu, 10 May 2018 21:16:28 +0200
Subject: [PATCH 1/2] i2c: exynos5: remove some dead code
In-Reply-To: <b3915e40-895f-2a72-27a2-dcffe504456d@samsung.com>
References: <CGME20180509194548epcas2p25579e969e21707afe2435b1f568ff005@epcas2p2.samsung.com>
 <20180509194532.28929-1-peda@axentia.se>
 <b3915e40-895f-2a72-27a2-dcffe504456d@samsung.com>
Message-ID: <fa946b32-99b2-c59b-e4d0-7188fdc7bfc0@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-10 10:36, Andrzej Hajda wrote:
> On 09.05.2018 21:45, Peter Rosin wrote:
>> The else branch cannot be taken as i will always equal num.
>> Get rid of the whole construct.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/i2c/busses/i2c-exynos5.c | 12 +-----------
>>  1 file changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
>> index 12ec8484e653..a2cbc779c33a 100644
>> --- a/drivers/i2c/busses/i2c-exynos5.c
>> +++ b/drivers/i2c/busses/i2c-exynos5.c
>> @@ -727,17 +727,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>>  			goto out;
>>  	}
>>  
>> -	if (i == num) {
>> -		ret = num;
>> -	} else {
>> -		/* Only one message, cannot access the device */
>> -		if (i == 1)
>> -			ret = -EREMOTEIO;
>> -		else
>> -			ret = i;
>> -
>> -		dev_warn(i2c->dev, "xfer message failed\n");
>> -	}
>> +	ret = num;
>>  
>>   out:
>>  	clk_disable(i2c->clk);
> 
> You can go further and remove "out:" label, use break instead, and at
> the end use "return (i == num) ? num : ret;" or sth similar.
> 
> With this change you can add:
> 
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

But then the patch wouldn't be so obviously safe. If I would write
a function equivalent to the original function, I think I'd write
something like:

static int exynos5_i2c_xfer(struct i2c_adapter *adap,
			    struct i2c_msg *msgs, int num)
{
	struct exynos5_i2c *i2c = adap->algo_data;
	int i, ret;

	if (i2c->suspended) {
		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
		return -EIO;
	}

	ret = clk_enable(i2c->clk);
	if (ret)
		return ret;

	for (i = 0; !ret && i < num; i++)
		ret = exynos5_i2c_xfer_msg(i2c, msgs + i, i == num - 1);

	clk_disable(i2c->clk);

	return ret ?: num;
}

And I think that is safe because I don't see any possibility for
exynos_i2c_xfer_msg to return anything but zero success or negative
errors. Since I can only compile-test, so I do not feel all that
good about going further than I did.

But if you or anyone can test the above function, feel free to make
a patch out of it. I don't care enough to make a bunch of iterations
on these trivialities. I just spotted dead code and dumb initializers
while looking for other things. So, take it or leave it. I.e. it was
just a couple of drive-by patches.

Cheers,
Peter
