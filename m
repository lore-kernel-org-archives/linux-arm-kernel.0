From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Wed, 16 Apr 2014 19:16:14 +0200
Subject: [PATCH] regmap: i2c: fallback to SMBus if the adapter does not
 support standard I2C
In-Reply-To: <20140416170638.GT12304@sirena.org.uk>
References: <20140415223849.GJ12304@sirena.org.uk>
 <1397636170-664-1-git-send-email-boris.brezillon@free-electrons.com>
 <20140416170638.GT12304@sirena.org.uk>
Message-ID: <534EBADE.1000608@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

On 16/04/2014 19:06, Mark Brown wrote:
> On Wed, Apr 16, 2014 at 10:16:10AM +0200, Boris BREZILLON wrote:
>
>> +	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C)) {
>> +		return &regmap_i2c;
>> +	} else if (config->val_bits == 16 &&
>> +		   i2c_check_functionality(i2c->adapter,
>> +					   I2C_FUNC_SMBUS_WORD_DATA)) {
>> +                config->reg_read = regmap_smbus_word_reg_read;
>> +                config->reg_write = regmap_smbus_word_reg_write;
>> +		return NULL;
> This all looks good to me except we shouldn't be modifying the config
> struct (it's supposed to be const).  We should instead add the ability
> for the bus to set these ops - that'll also be useful for things like
> AC'97.

Actually I do not modify the passed config struct, I copy the config
values into a local instance and then modify this local instance
appropriately.
But I agree that having a proper way to overload config parameters would
be better.
Any suggestion on how this should be done ?

Best Regards,

Boris

-- 
Boris Brezillon, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
