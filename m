From: romain.perier@free-electrons.com (Romain Perier)
Date: Wed, 30 Nov 2016 11:38:11 +0100
Subject: [PATCH v5 1/3] i2c: pxa: Add support for the I2C units found in
 Armada 3700
In-Reply-To: <20161129211716.GA15594@katana>
References: <20161121133247.29889-1-romain.perier@free-electrons.com>
 <20161121133247.29889-2-romain.perier@free-electrons.com>
 <20161129211716.GA15594@katana>
Message-ID: <e5c36597-d917-0555-89cd-35f68087c1c5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Le 29/11/2016 ? 22:17, Wolfram Sang a ?crit :
>> +	if (of_device_is_compatible(np, "marvell,armada-3700-i2c")) {
>> +		i2c->fm_mask = ICR_BUSMODE_FM;
>> +		i2c->hs_mask = ICR_BUSMODE_HS;
>> +	} else {
>> +		i2c->fm_mask = ICR_FM;
>> +		i2c->hs_mask = ICR_HS;
>> +	}
>>
>>  	*i2c_types = (enum pxa_i2c_types)(of_id->data);
>>
>> @@ -1181,6 +1194,13 @@ static int i2c_pxa_probe_pdata(struct platform_device *pdev,
>>  			i2c->master_code = 0xe;
>>  		i2c->rate = plat->rate;
>>  	}
>> +	if (!strcmp(id->name, "armada-3700-i2c")) {
>> +		i2c->fm_mask = ICR_BUSMODE_FM;
>> +		i2c->hs_mask = ICR_BUSMODE_HS;
>> +	} else {
>> +		i2c->fm_mask = ICR_FM;
>> +		i2c->hs_mask = ICR_HS;
>> +	}
>
> Okay, having the same code twice is not nice as well.
>
> Sorry for missing this in the first review and going a step back, but I
> think now the best solution is to have again a REGS_A3700 struct, but we
> should extend it with new entries for the shifted bits. Then in the init
> code, you can do something like:
>
> 	i2c->fm_mask = pxa_reg_layout[i2c_type].fm_mask ?: ICR_FM;
>
> Makes sense?

Mhhhh... makes sense yes, it is simpler and would remove the duplicated 
code, yes (no no need to modify probe_dt and probe_pdata in this case).
What do you prefer everything in one commit or two seperated commit ? 
(one including the new fields for fm_mask and another one to add support 
for a3700-i2c).

Thanks,
Romain

-- 
Romain Perier, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
