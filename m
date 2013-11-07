From: syin@broadcom.com (Sherman Yin)
Date: Thu, 7 Nov 2013 14:01:26 -0800
Subject: [PATCH 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <527A75A6.5010904@wwwdotorg.org>
References: <1380846199-12829-1-git-send-email-syin@broadcom.com>
 <051069C10411E24D9749790C498526FA1BE0B7D7@SJEXCHMB12.corp.ad.broadcom.com>
 <CACRpkdYSLxp2M4HghcUdjEYGh-UQ+DaiCGp6yee+Qds6DR9poA@mail.gmail.com>
 <201311050026.56321.heiko@sntech.de> <527835FE.2030102@wwwdotorg.org>
 <5279A319.5060701@broadcom.com> <527A75A6.5010904@wwwdotorg.org>
Message-ID: <527C0DB6.5060303@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-11-06 09:00 AM, Stephen Warren wrote:
> You probably don't want to reference the individual xxx1/2/3 nodes in
> the client pinctrl properties, but instead wrap them in a higher-level
> node that represents the whole pinctrl state. Then, the client pinctrl
> properties can reference just that single parent node, instead of many
> small nodes. In other words:
>
> pinctrl at ... {
> 	...
> 	sx: state_xxx {
> 		xxx1 { ... };
> 		xxx2 { ... };
> 		xxx3 { ... };
> 	};
> 	sy: state_yyy {
> 		yyy1 { ... };
> 		yyy2 { ... };
> 	};
> }
>
> some_client at ... {
> 	...
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&sx>;
> };
>
> other_client at ... {
> 	...
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&sy>;
> };
>
> rather than:
>
> pinctrl at ... {
> 	...
> 	sx1: xxx1 { ... };
> 	sx2: xxx2 { ... };
> 	sx3: xxx3 { ... };
> 	sy1: yyy1 { ... };
> 	sy2: yyy2 { ... };
> }
>
> some_client at ... {
> 	...
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&sx1 &sx2 &sx3>;
> };
>
> other_client at ... {
> 	...
> 	pinctrl-names = "default";
> 	pinctrl-0 = <&sy1 &sy2>;
> };
>
> This is exactly how the Tegra pinctrl bindings work for example.

Ok, right, I mistakenly thought the "xxx1" nodes are pin config nodes. 
Actually that's the way my original driver works as well, other than the 
fact that I don't have as many "xxx1" type nodes as decribed in the 
"xxx" node below.

>> This works fine.  However, I'm just thinking that
>> it would have been easier if we could specify just one node:
>>
>> xxx {
>>      pins = <PINA>, <PINB>, <PINC>;
>>      function = <...>;
>>      pull-up = <1 1 0>;
>> }
>>
>> This "feature" seems a bit more concise to me and is what I did for my
>> original pinctrl driver.  The only downside is that with this method,
>> one cannot specify "don't touch this option for this pin" if the same
>> property must provide values for other pins.
>
> The other downside is that if the lists get even slightly long, it get
> really hard to match up the entries in the t properties.

Agree that it would start to get difficult to read if a subnode has too 
many pins.  I guess the solution would be to somehow split up the pins 
to more subnodes with fewer pins each.

Regards,
Sherman
