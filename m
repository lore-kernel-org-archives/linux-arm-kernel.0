From: stefan@agner.ch (Stefan Agner)
Date: Wed, 27 Nov 2013 22:44:52 +0100
Subject: [PATCH 1/3] mfd: tps6586x: add version detection
In-Reply-To: <529624CA.6030604@wwwdotorg.org>
References: <cover.1385508112.git.stefan@agner.ch>
 <ef881d39f78b75b4badeebb5be0264edc3906d86.1385508112.git.stefan@agner.ch>
 <529624CA.6030604@wwwdotorg.org>
Message-ID: <ddd65b4d645cb99c3288960ea2dbe7a3@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 2013-11-27 17:58, schrieb Stephen Warren:
<snip>
>> +	tps6586x = devm_kzalloc(&client->dev, sizeof(*tps6586x), GFP_KERNEL);
>> +	if (tps6586x == NULL) {
>> +		dev_err(&client->dev, "memory for tps6586x alloc failed\n");
>> +		return -ENOMEM;
>> +	}
> 
>> +	tps6586x->version = (enum tps6586x_version)ret;
> 
> Why not make the version variable an integer of some kind. Then, the
> cast wouldn't be required. The values like TPS658621A can be #defines or
> const u32.
> 
Yep this would work too. Whatever is preferred, maybe define would be
more consistent since SLEW_RATE are defines too (both, the VERSIONCRC
and SLEW_RATE values are possible content of registers).

>> +	switch (ret) {
> 
> That should switch on tps6586x->version since that's been assigned;
> it'll make the purpose a bit clearer.
> 
>> +	default:
>> +		name = "TPS6586X";
>> +		break;
>>  	}
> 
> I hope the rest of the code deals with unknown values of
> tps6586x->version OK.
>
Well, the tps6586x->version is not completly unknown, its something
valid which is returned by i2c_smbus_read_byte_data. According to the
data sheet this should be a 8-Bit value.

However, the patch should handle every version, since I tried to make
the change backward compatible: The driver now and then supports every
device version, just the default voltage table are applied if there are
no specific tables available.
