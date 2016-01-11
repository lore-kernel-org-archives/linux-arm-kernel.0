From: afd@ti.com (Andrew F. Davis)
Date: Mon, 11 Jan 2016 08:44:59 -0600
Subject: /sys/class/power_supply/bq27200-0/capacity changed meaning
 between 4.1 and 4.4?
In-Reply-To: <20160110080621.GA3929@amd>
References: <20160109230709.GA30551@amd> <20160110080621.GA3929@amd>
Message-ID: <5693BFEB.3020500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/2016 02:06 AM, Pavel Machek wrote:
> Hi!
>
>> Did /sys/class/power_supply/bq27200-0/capacity change meaning between
>> 4.1 and 4.4?
>>
>> It used to report battery capacity remaining in percent.
>>
>> Not sure what it reports now, but ain't in percent....
>
>> The patch does not compile, but I should be sleeping, not trying to
>> understand crazy code. Whoever wrote it, please fix it. Maybe you can
>> just do
>
> ...and more crazy code :-(.
>
>          cache.flags = bq27xxx_read(di, BQ27XXX_REG_FLAGS, has_singe_flag);
> 		if ((cache.flags & 0xff) == 0xff)
> 		                cache.flags = -1; /* read error */
> 				        /* WTF? bq27xxx returns -ERRNO
>          on error, we mask some bits off it, and then make it -1... */
> 	

This is probably left over from when the driver was 1wire only, which seems
to fail by just reading back all ones. Not sure why the -1 though?

>
> ...and one crazy optimalization...
>
>          if (memcmp(&di->cache, &cache, sizeof(cache)) != 0)
> 	                di->cache = cache;
>

Hmmm, I think the lines above it:

	if (di->cache.capacity != cache.capacity)
		power_supply_changed(di->bat);

were at one point rolled into this as so:

	if (memcmp(&di->cache, &cache, sizeof(cache)) != 0) {
		di->cache = cache;
		power_supply_changed(di->bat);
	}

Otherwise that isn't an optimization, it probably takes more
time comparing than just doing the copy every time...

> ...are we playing obfuscated C code contest, yet?
>
>          case POWER_SUPPLY_PROP_PRESENT:
> 	                val->intval = di->cache.flags < 0 ? 0 : 1;
>
> ...to decidegree C?
>                  if (ret == 0)
> 		   	        pval->intval -= 2731; /* convert decidegree k to c */
>
> as read takes enum, make it enum like this?
> static inline int bq27xxx_read(struct bq27xxx_device_info *di, enum bq27xxx_reg_index reg_index,
> 		                         bool single)
> 					

ACK

>
> 									Pavel
>
