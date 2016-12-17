From: peda@axentia.se (Peter Rosin)
Date: Sat, 17 Dec 2016 07:50:32 +0100
Subject: [PATCH] i2c: mux: pca954x: fix i2c mux selection caching
In-Reply-To: <20161216232355.GO14217@n2100.armlinux.org.uk>
References: <E1cHylf-00071o-KZ@rmk-PC.armlinux.org.uk>
 <251c31e3-141c-8884-d56a-fa539714d1ff@axentia.se>
 <20161216232355.GO14217@n2100.armlinux.org.uk>
Message-ID: <c8201ae8-baad-1cbd-c6ff-feaa5510a977@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-12-17 00:23, Russell King - ARM Linux wrote:
> On Fri, Dec 16, 2016 at 10:20:35PM +0100, Peter Rosin wrote:
>> On 2016-12-16 21:06, Russell King wrote:
>>> smbus functions return -ve on error, 0 on success.  However,
>>> __i2c_transfer() have a different return signature - -ve on error, or
>>> number of buffers transferred (which may be zero or greater.)
>>>
>>> The upshot of this is that the sense of the test is reversed when using
>>> the mux on a bus supporting the master_xfer method: we cache the value
>>> and never retry if we fail to transfer any buffers, but if we succeed,
>>> we clear the cached value.
>>
>> Ouch! Thanks for catching this.
>>
>>> Fix this.
>>
>> But lets fix the corner case of __i2c_transfer returning 0 instead of
>> the expected 1 as well (not sure if that's even possible, but lets close
>> the possibility just in case), so I'd prefer if you could fix
>> pca954x_reg_write() to return 0 iff __i2c_transfer(...) returns 1
>> instead, and -EREMOTEIO on other non-negative return values. Thanks!
> 
> So you want something like this instead?

Yes, but I was originally thinking that the second hunk was no
longer needed...

Either way,
Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
peda


> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 8bc3d36d2837..9c4ac26c014e 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -151,6 +151,9 @@ static int pca954x_reg_write(struct i2c_adapter *adap,
>  		buf[0] = val;
>  		msg.buf = buf;
>  		ret = __i2c_transfer(adap, &msg, 1);
> +
> +		if (ret >= 0 && ret != 1)
> +			ret = -EREMOTEIO;
>  	} else {
>  		union i2c_smbus_data data;
>  		ret = adap->algo->smbus_xfer(adap, client->addr,
> @@ -179,7 +182,7 @@ static int pca954x_select_chan(struct i2c_mux_core *muxc, u32 chan)
>  	/* Only select the channel if its different from the last channel */
>  	if (data->last_chan != regval) {
>  		ret = pca954x_reg_write(muxc->parent, client, regval);
> -		data->last_chan = ret ? 0 : regval;
> +		data->last_chan = ret < 0 ? 0 : regval;
>  	}
>  
>  	return ret;
> 
> 
