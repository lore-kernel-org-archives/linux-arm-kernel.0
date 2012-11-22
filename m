From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Nov 2012 16:08:07 -0800
Subject: [PATCH v5 05/10] pinctrl: single: support pinconf generic
In-Reply-To: <CAN1soZzzET1tNVJVgaocDnbzjQZsD8AkA-P=q0YF=09SFy6wzw@mail.gmail.com>
References: <1352968600-15345-1-git-send-email-haojian.zhuang@gmail.com>
 <1352968600-15345-6-git-send-email-haojian.zhuang@gmail.com>
 <20121117004313.GN6801@atomide.com>
 <CAN1soZxUr4uO3fheKpRU_oc-GjjYfo2ZY5YZ0hRgwB2ph+b-qw@mail.gmail.com>
 <CAN1soZzzET1tNVJVgaocDnbzjQZsD8AkA-P=q0YF=09SFy6wzw@mail.gmail.com>
Message-ID: <20121122000807.GD5279@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121118 06:25]:
> 
> pin_config_set() sets the config value into pinmux register. The upper 16-bit
> is config argument, and the lower 16-bit is config parameter. The
> pinmux register
> is 32-bit in Marvell's silicon. I think it's 32-bit value in most silicons.

Well what if we soon have a 64-bit mux register? We should probably
reserve more than 5 bits for the shift to handle those cases as
well.
 
> And real field value could be lower 16-bit. So I have to pack mask,
> shift, config value
> & config parameter into 32-bit data. The limitation is mask, shift,
> value are all 5-bit
> value. And this is also the reason that I define pinctrl_lookup_map()
> into consumer.h.

Yes this might be problematic for 64-bit systems..

> How could consumer driver know mask & shift? It has to lookup map to
> get the real
> configuration.

I think the consumer driver should not know anything about the
mask & shift.
 
> We also need to keep pin_config_get() compatible with pin_config_set(). I define
> the config data as packed mask, shift, config value & config parameter.
> 
> The conclusion is that we have two choices.
> 1. Use packed way. It's a little complex.

I think the packed way won't work well for consumer drivers.

> 2. Change the interface of pin_config_set()/pin_config_get(). We need
> to use the new
> interface in below.
>     pin_config_set(const char *dev_name, const char *name, unsigned
> long parameter,
>                           unsigned long config);
>     pin_config_get(const char *dev_name, const char *name, unsigned
> long parameter,
>                           unsigned long *config);
>     And the config should be "value >> shift".
> 
> What's your opinion? I prefer the second method since it's easy to
> understand and maintain.
> Then I could hide pinctrl_lookup_map() in core.h.

Yes something like that makes sense to me. Except IMHO we should
use some cookie for a pin instead of dev_name + name, and have
some struct for the config. Something like this perhaps:

pin_config_get(struct pin *pin, struct pin_config *config,
		unsigned long parameter);

Regards,

Tony 
