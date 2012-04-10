From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 09 Apr 2012 21:44:51 -0600
Subject: [PATCH 1/1] pinctrl: add some error checking for user interfaces
In-Reply-To: <20120410034927.GA674@shlinux2.ap.freescale.net>
References: <1333967409-8168-1-git-send-email-b29396@freescale.com>
 <4F82FA2A.3090604@wwwdotorg.org>
 <20120410034927.GA674@shlinux2.ap.freescale.net>
Message-ID: <4F83ACB3.6010300@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2012 09:49 PM, Dong Aisheng wrote:
> On Mon, Apr 09, 2012 at 11:03:06PM +0800, Stephen Warren wrote:
>> On 04/09/2012 04:30 AM, Dong Aisheng wrote:
>>> From: Dong Aisheng <dong.aisheng@linaro.org>
>>>
>>> This patch can avoid kernel oops in case the mux or config
>>> function is not supported by driver.
...
>>>  static int pinconf_pins_show(struct seq_file *s, void *what)
>>>  {
>>>  	struct pinctrl_dev *pctldev = s->private;
>>> +	const struct pinconf_ops *ops = pctldev->desc->confops;
>>>  	unsigned i, pin;
>>>  
>>> +	if (!ops || !ops->pin_config_get)
>>> +		return 0;
>>
>> I don't think this is necessary; it looks like this function (and those
>> it calls) always checks ops where they're used.
>
> Yes, it's true.
> But it will still dump all pins configs although there's no config value
> which is almost the same as another debug entry 'pins'.
> It looks it does not make too much sense to dump this info if no config support.
> The existing pinconf_group_show did like this way(no output).
> So i changed pinconf_pins_show in the same behavior as pinconf_group_show.
> 
> Do you think it's reasonable?

OK, I guess so.

I was thinking the file wouldn't be compiled without pin config support,
but that's only the core support and doesn't necessarily imply the
individual driver has support.
