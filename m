From: zonque@gmail.com (Daniel Mack)
Date: Mon, 13 Aug 2012 11:43:01 +0200
Subject: [PATCH 6/6] ARM: dts: add pinctrl in PXA DT files
In-Reply-To: <CACRpkda0443PF-SwNaiJCO9RmdCFqw1+OtLgTBoTfZzwnFjJ4w@mail.gmail.com>
References: <1343458722-17127-1-git-send-email-haojian.zhuang@gmail.com>
 <1343458722-17127-7-git-send-email-haojian.zhuang@gmail.com>
 <201208060844.29333.arnd@arndb.de>
 <CACRpkdayqp0ptdURHtYWC6G5pk1rNaAiWZkc7bdhv2osY1MaHA@mail.gmail.com>
 <5023C923.3080808@gmail.com>
 <CACRpkda0443PF-SwNaiJCO9RmdCFqw1+OtLgTBoTfZzwnFjJ4w@mail.gmail.com>
Message-ID: <5028CC25.5040707@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10.08.2012 12:56, Linus Walleij wrote:
> On Thu, Aug 9, 2012 at 4:28 PM, Daniel Mack <zonque@gmail.com> wrote:
> 
>> I am looking at the generic pinctrl code right now
> 
> Sweet!
> 
>> and I wonder if the following approach would be ok:
>>
>> - each driver that calls pinctrl_register() has its own dt_match_table
>> entry, so the 'compatible' part of the bindings is specific to a pin
>> controller chip.
> 
> Yep.
> 
>> - introduce a pinctrl_parse_of(struct of_node *) and call that after the
>> driver has added all its pins. That function walks all the children of
>> the given node and uses the callbacks provided by the driver to do the
>> actual work.
> 
> Isn't that already how it works? Maybe I misunderstand, do you mean
> that you want to pass the DT node to pinctrl_register()?

To parse the generic bits, yes. But I realized only now that we already
have dt_to_map_one_config()

> Are you talking about using pinctrl hogs to set up the default
> configuration and muxing? That can already be done today,
> and has nothing to do with whether you use generic pin config
> or not.
> 
> This uses the .dt_node_to_map() and .dt_free_map() callbacks
> in the pinctrl_ops vtable to generate a map from the device tree,
> in any way you want.

Yes, I see. And this is where duplication emerges, or, where
consolidation would need to be done. If we want to standardize the way
pins are set up in terms of bias, pullup/pulldown and all that, we would
just need to map generic DT entries to PIN_CONFIG_* and call the pin
controllers specific functions.

> So the infrastructure I think already exists, but whereas all
> current driver have their own config and mux (etc) parsing
> code, pinconf-generic could provide something that would
> be common for all driver using generic pin config.

Exactly. And then the question is whether we want implicit behaviour.
IOW - let dt_to_map_one_config() parse the generic bits and then call
the driver specific augmentation code, if any.


Daniel
