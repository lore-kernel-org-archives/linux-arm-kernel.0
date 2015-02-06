From: stefan@agner.ch (Stefan Agner)
Date: Fri, 06 Feb 2015 20:40:43 +0100
Subject: [PATCH] pinctrl: imx: do not implicitly set pin regs to -1
In-Reply-To: <20150206192121.GD10842@pengutronix.de>
References: <1423240256-27210-1-git-send-email-stefan@agner.ch>
 <20150206192121.GD10842@pengutronix.de>
Message-ID: <93e8f8135f2c459b7694ef1a22636f7b@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-02-06 20:21, Uwe Kleine-K?nig wrote:
> Hallo Stefan,
> 
> On Fri, Feb 06, 2015 at 05:30:56PM +0100, Stefan Agner wrote:
>> -	memset(info->pin_regs, 0xff, sizeof(*info->pin_regs) * info->npins);
>> +
>> +	for (i = 0; i < info->npins; i++) {
>> +		info->pin_regs[i].mux_reg = -1;
>> +		info->pin_regs[i].conf_reg = -1;
>> +	}
> looks definitely better. Just out of interest, did you check if it
> changes the generated code?

Just checked quickly, before it branched to memset. The object file is
24 bytes larger. I guess memset might be a bit faster due to optimized
memory access. But not worth for some error handling relevant
initialization code IMHO...

--
Stefan
