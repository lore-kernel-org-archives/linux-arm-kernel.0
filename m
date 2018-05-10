From: peda@axentia.se (Peter Rosin)
Date: Thu, 10 May 2018 21:16:33 +0200
Subject: [PATCH 2/2] i2c: exynos5: remove pointless initializers
In-Reply-To: <b69f6656-3831-86ea-5f13-fc805d86b288@samsung.com>
References: <20180509194532.28929-1-peda@axentia.se>
 <CGME20180509194552epcas3p4777026e41c7b34663eb11345e4f3d82d@epcas3p4.samsung.com>
 <20180509194532.28929-2-peda@axentia.se>
 <b69f6656-3831-86ea-5f13-fc805d86b288@samsung.com>
Message-ID: <6a6f56f7-7a85-b784-e847-f23a8ae41391@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-05-10 10:44, Andrzej Hajda wrote:
> On 09.05.2018 21:45, Peter Rosin wrote:
>> The variables are always assigned before use anyway.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
>> ---
>>  drivers/i2c/busses/i2c-exynos5.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/i2c/busses/i2c-exynos5.c b/drivers/i2c/busses/i2c-exynos5.c
>> index a2cbc779c33a..185fba37e830 100644
>> --- a/drivers/i2c/busses/i2c-exynos5.c
>> +++ b/drivers/i2c/busses/i2c-exynos5.c
>> @@ -707,7 +707,7 @@ static int exynos5_i2c_xfer(struct i2c_adapter *adap,
>>  			struct i2c_msg *msgs, int num)
>>  {
>>  	struct exynos5_i2c *i2c = adap->algo_data;
>> -	int i = 0, ret = 0, stop = 0;
>> +	int i, ret, stop;
> 
> I hope gcc is smart enough to not complain in case of ret.

I think any compiler is smart enough to see that; you must have missed
this line:

	ret = clk_enable(i2c->clk);

which is the first to touch ret in the function.

> I think you can merge both patches into one.

I could, but I wanted to make the patches totally obvious and easy to
review. The patches do independent things, so I prefer not to squash.

Cheers,
Peter

> 
> Regards
> Andrzej
> 
>>  
>>  	if (i2c->suspended) {
>>  		dev_err(i2c->dev, "HS-I2C is not initialized.\n");
> 
> 
