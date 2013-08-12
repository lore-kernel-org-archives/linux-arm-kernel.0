From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 12 Aug 2013 09:50:02 -0600
Subject: [PATCH v10] reset: Add driver for gpio-controlled reset pins
In-Reply-To: <1376305484.22237.37.camel@pizza.hi.pengutronix.de>
References: <1374139586-6344-1-git-send-email-p.zabel@pengutronix.de>
 <20130802092823.GA2884@e106331-lin.cambridge.arm.com>
 <1375687936.4000.21.camel@pizza.hi.pengutronix.de>
 <51FFDFB7.6080806@wwwdotorg.org>
 <1375774345.4004.25.camel@pizza.hi.pengutronix.de>
 <52012B70.7050306@wwwdotorg.org>
 <1375954978.4284.29.camel@pizza.hi.pengutronix.de>
 <5203E6B5.1010704@wwwdotorg.org>
 <1376305484.22237.37.camel@pizza.hi.pengutronix.de>
Message-ID: <5209042A.3060104@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 05:04 AM, Philipp Zabel wrote:
> Am Donnerstag, den 08.08.2013, 12:43 -0600 schrieb Stephen Warren:
...
>> Equally, if every binding is either-or, you may as well force drivers
>> passing the binding to just call different APIs based on their binding
>> definition.
>>
>> If (2), then you'd need to pass both the legacy property name and
>> reset-names value separately, since I imagine those values would be
>> different, consider:
>>
>> old:
>>
>> 	nvidia,phy-reset-gpio = <&gpio 1 0>;
>>
>> new:
>>
>> 	reset-gpios = <&gpio 1 0>;
>> 	reset-names = "phy";
> 
> Correct. In this case:
> 
> 	rstc = of_get_named_reset_control(np, "nvidia,phy-reset-gpio", 0);
> 	if (IS_ERR(rstc)) {
> 		ret = PTR_ERR(rstc);
> 		if (ret == -EPROBE_DEFER)
> 			return ret;
> 		rstc = reset_control_get(dev, "phy");
> 		if (IS_ERR(rstc))
> 			return PTR_ERR(rstc);
> 	}
> 
> Maybe encapsulate this in a convenience wrapper:
> 
> 	rstc = reset_control_get_legacy(dev, "phy", "nvidia,phy-reset-gpio");

Yes, that's exactly what I envisaged. Thanks.
