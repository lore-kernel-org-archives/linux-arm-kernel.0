From: khilman@ti.com (Kevin Hilman)
Date: Fri, 02 Sep 2011 09:20:05 -0700
Subject: [RFC PATCH 1/3] OMAP: omap_device: Add omap_device_[alloc|delete]
	for DT integration
In-Reply-To: <4E60F4C6.2050802@ti.com> (Benoit Cousson's message of "Fri, 2
	Sep 2011 17:22:46 +0200")
References: <1314037343-19783-1-git-send-email-b-cousson@ti.com>
	<1314037343-19783-2-git-send-email-b-cousson@ti.com>
	<87liu8dsjj.fsf@ti.com> <4E60F4C6.2050802@ti.com>
Message-ID: <87vcta9aru.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Cousson, Benoit" <b-cousson@ti.com> writes:

[...]

>>> @@ -471,72 +572,31 @@ struct platform_device *omap_device_build_ss(const char *pdev_name, int pdev_id,
>>>   		goto odbs_exit;
>>>   	}
>>>
>>> -	pr_debug("omap_device: %s: building with %d hwmods\n", pdev_name,
>>> -		 oh_cnt);
>>> +	/* Set the dev_name early to allow dev_xxx in omap_device_alloc */
>>> +	if (pdev->id != -1)
>>> +		dev_set_name(&pdev->dev, "%s.%d", pdev->name,  pdev->id);
>>> +	else
>>> +		dev_set_name(&pdev->dev, "%s", pdev->name);
>> 
>> Minor: I think setting dev->init_name is more appropriate here, and
>> should have the same effect.
>
> The slight difference is that if I do that:
> pdev->dev.init_name = kasprintf(GFP_KERNEL, "%s.%d", pdev->name, pdev->id);
>
> I will have to free it myself, because device_add is doing only that:
>
>         if (dev->init_name) {
>                 dev_set_name(dev, "%s", dev->init_name);
>                 dev->init_name = NULL;
>         }
>
> Whereas dev_set_name is doing it for me.
>
> So it will add one more line later. Does it worth it?

OK, keeping dev_set_name() is fine with me then.

Kevin
