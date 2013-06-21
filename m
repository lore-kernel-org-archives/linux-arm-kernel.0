From: ithamar@upgrade-android.com (Ithamar R. Adema)
Date: Fri, 21 Jun 2013 09:41:13 +0200
Subject: [PATCH] pinctrl-sunxi: fix pin attribute handling.
In-Reply-To: <20130620204908.GG2987@lukather>
References: <1371748373-10519-1-git-send-email-ithamar@upgrade-android.com>
 <20130620204908.GG2987@lukather>
Message-ID: <A06309D9-3340-4F5B-AFB5-4B3DC3997411@upgrade-android.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime,

On Jun 20, 2013, at 10:49 , Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> Hi Ithamar,
> 
> You should probably put in the recipients Linus Walleij that will
> probably be the one that will merge this patch anyway.

Ah okay, thanks for the heads-up.
>> +		strength = 0;
>> 		if (!of_property_read_u32(node, "allwinner,drive", &val)) {
>> -			u16 strength = (val + 1) * 10;
>> -			pinconfig[j++] =
>> -				pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
>> -							 strength);
>> +			strength = (val + 1) * 10;
>> 		}
>> +		pinconfig[0] =
>> +			pinconf_to_config_packed(PIN_CONFIG_DRIVE_STRENGTH,
>> +						 strength);
> 
> Why are you making the configuration of the strength in any cases? It's
> an optional property, it should be treated as such.

My reasoning, which I can see is very subjective, is that if those properties (same for pull up/down) are not specified, you still want them to be in a defined state. Setting the drive strength (and pull up/down) to the default 0 value is just so that any configuration that might have been done the kernel started is undone.

I can understand your reasoning here, but are you sure you would want them left in undefined state?

> 
>> -		if (!of_property_read_u32(node, "allwinner,pull", &val)) {
>> -			enum pin_config_param pull = PIN_CONFIG_END;
>> -			if (val == 1)
>> -				pull = PIN_CONFIG_BIAS_PULL_UP;
>> -			else if (val == 2)
>> -				pull = PIN_CONFIG_BIAS_PULL_DOWN;
>> -			pinconfig[j++] = pinconf_to_config_packed(pull, 0);
>> -		}
>> +		val = 0;
>> +		of_property_read_u32(node, "allwinner,pull", &val);
>> +		pinconfig[1] = pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_UP, val == 1);
>> +		pinconfig[2] = pinconf_to_config_packed(PIN_CONFIG_BIAS_PULL_DOWN, val == 2);
> 
> I'm not sure this is actually right. The pins are either configured to
> have a pull-up, a pull-down, or none of it, in the same register, in the
> same bitfield, so why adding it in any cases? we only care about at most
> one of the two, and those two options are mutually exclusive.

True, this is my fault. I guess I thought that settings the pull up didn't clear the pull down, but after looking at the code, this is properly handled. I'll fix this properly in the next version of the patch.

> 
>> 		(*map)[i].data.configs.configs = pinconfig;
>> -		(*map)[i].data.configs.num_configs = configlen;
>> +		(*map)[i].data.configs.num_configs = 3;
>> 
>> 		i++;
>> 	}
>> @@ -1563,6 +1555,7 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
>> {
>> 	struct sunxi_pinctrl *pctl = pinctrl_dev_get_drvdata(pctldev);
>> 	struct sunxi_pinctrl_group *g = &pctl->groups[group];
>> +	u32 arg = pinconf_to_config_argument(config);
>> 	u32 val, mask;
>> 	u16 strength;
>> 	u8 dlevel;
>> @@ -1586,15 +1579,17 @@ static int sunxi_pconf_group_set(struct pinctrl_dev *pctldev,
>> 			pctl->membase + sunxi_dlevel_reg(g->pin));
>> 		break;
>> 	case PIN_CONFIG_BIAS_PULL_UP:
>> +		arg = !!arg;
> 
> Ouch, nope.
> 
> Put this next to the call to pinconf_to_config_argument

Fair enough, will fix.
> 
>> 		val = readl(pctl->membase + sunxi_pull_reg(g->pin));
>> 		mask = PULL_PINS_MASK << sunxi_pull_offset(g->pin);
>> -		writel((val & ~mask) | 1 << sunxi_pull_offset(g->pin),
>> +		writel((val & ~mask) | arg << sunxi_pull_offset(g->pin),
> 
> I'd rather see an obvious assignment of 1 here. It's the value that is
> documented in the datasheet, it pops to the mind. You can always put
> this inside an if(arg) statement if you want to.

Just to make sure I understand, are you suggesting to stretch that writel() onliner into an if (arg) writel() else writel() ?

Thanks for taking the time to review!

Regards,

Ithamar.


-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/pkcs7-signature
Size: 4163 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130621/1f7ae23f/attachment-0001.p7s>
