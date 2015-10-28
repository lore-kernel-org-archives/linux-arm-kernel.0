From: nicola@corna.info (Nicola Corna)
Date: Wed, 28 Oct 2015 20:19:07 +0000
Subject: [PATCH v4 4/4] iio: humidity: si7020: added No Hold read mode
In-Reply-To: <563117FB.5030506@metafoo.de>
References: <563117FB.5030506@metafoo.de> <5630977D.2020102@metafoo.de>
 <f113de76b2369d404909cfc5158feca4@rainloop.corna.info>
 <1446015506-21371-1-git-send-email-nicola@corna.info>
 <aa9c6c7ffdd5083c110cb35723081dbf@rainloop.corna.info>
Message-ID: <ba63445a2f9af32bcbad698039041cbf@rainloop.corna.info>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

October 28 2015 7:46 PM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:

> On 10/28/2015 07:35 PM, Nicola Corna wrote:
> 
>> October 28 2015 10:38 AM, "Lars-Peter Clausen" <lars@metafoo.de> wrote:
>> 
>>> On 10/28/2015 07:58 AM, Nicola Corna wrote:
>>> [...]
>>> 
>>>> + holdmode = !((*client)->adapter->quirks &&
>>>> + (*client)->adapter->quirks->flags &
>>> 
>>> [...]
>>> 
>>>> + client->adapter->quirks &&
>>>> + client->adapter->quirks->flags & I2C_AQ_NO_CLK_STRETCH)
>>> 
>>> This is rather ugly, can we get a helper in the I2C core something along the
>>> lines of
>>> 
>>> i2c_check_quirks(client->adapter, I2C_AQ_NO_CLK_STRETCH)
>>> 
>>> - Lars
>> 
>> Something like this?
>> 
>> ---
>> diff --git a/include/linux/i2c.h b/include/linux/i2c.h
>> index a69a9a0..a06ffc0 100644
>> --- a/include/linux/i2c.h
>> +++ b/include/linux/i2c.h
>> @@ -613,6 +613,12 @@ static inline int i2c_check_functionality(struct i2c_adapter *adap, u32 func)
>> return (func & i2c_get_functionality(adap)) == func;
>> }
>> 
>> +/* Return 1 if adapter has the specified quirks, 0 if not. */
>> +static inline int i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
>> +{
>> + return (quirks & (adap->quirks ? adap->quirks->flags : 0)) == quirks;
>> +}
> 
> This is not a code obfuscation contest ;)

I love one-liners ;)

> So maybe more like this:
> 
> static inline bool i2c_check_quirks(struct i2c_adapter *adap, u64 quirks)
> {
> if (!adap->quirks)
> return false;
> return (adap->quirks->flags & quirks) == quirks;
> }

Should I use bool (like in your snippet) or int (like i2c_check_functionality) as return type?

> And please use kernel-doc for the documentation.
