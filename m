From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 5 Aug 2016 10:26:34 +0200
Subject: [PATCH 2/2] regmap: debugfs: Add support for dumping write only
 device registers
In-Reply-To: <20160804202646.GH10383@sirena.org.uk>
References: <1470322558-7501-1-git-send-email-cristian.birsan@microchip.com>
 <1470322558-7501-3-git-send-email-cristian.birsan@microchip.com>
 <20160804202646.GH10383@sirena.org.uk>
Message-ID: <3e42070f-a480-dbf4-1a97-b7172bebb1cc@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/08/2016 ? 22:26, Mark Brown a ?crit :
> On Thu, Aug 04, 2016 at 05:55:58PM +0300, Cristian Birsan wrote:
>> Add support for dumping write only device registers in debugfs. This is
>> useful for audio codecs that have write only registers (like WM8731).
>> The logic that decides if a value can be printed is moved to
>> regmap_printable() function to allow for easier future updates.
> 
> Please check your CC list when sending things upstream - try to ensure
> that people you're sending patches to are relevant to the patch.
> Maintainers often get lots of mail and having to sort out mail that's
> not really relevant to them can make it easier for relevant mail to get
> missed.

Mark,

Just FYI, I gave Cristian the CC list he could use: In fact the Atmel /
Microchip / Free-Electons people are in the list because we are all
working together on the AT91 platforms now. And these platforms use the
audio codec Cristian is working on.


>> +static bool regmap_printable(struct regmap *map, unsigned int reg)
>> +{
>> +	if (regmap_precious(map, reg))
>> +		return false;
>> +
>> +	if (!regmap_readable(map, reg) && !regmap_cached(map, reg))
>> +		return false;
>> +
>> +	return true;
>> +}
> 
> This only has one user...
> 
>>  	for (i = start_reg; i <= to; i += map->reg_stride) {
>> -		if (!regmap_readable(map, i))
>> +		if (!regmap_readable(map, i) && !regmap_cached(map, i))
>>  			continue;
>>  
> 
> ...though it could have more.
> 
>> -			ret = regmap_read(map, i, &val);
>> +			if (regmap_readable(map, i))
>> +				ret = regmap_read(map, i, &val);
>> +			else
>> +				ret = regcache_read(map, i, &val);
>> +
> 
> I don't understand this change, a read will go to cache anyway.
> 


-- 
Nicolas Ferre

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160805/b0d40700/attachment.sig>
