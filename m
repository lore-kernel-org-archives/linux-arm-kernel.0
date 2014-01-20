From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 20 Jan 2014 10:17:24 +0100
Subject: [RFC v3 08/13] ahci-platform: Allow specifying platform_data
 through of_device_id
In-Reply-To: <20140120090950.GI16215@pengutronix.de>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-9-git-send-email-hdegoede@redhat.com>
 <20140120082438.GH16215@pengutronix.de> <52DCDFBA.2070903@redhat.com>
 <20140120090950.GI16215@pengutronix.de>
Message-ID: <52DCE9A4.50901@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/20/2014 10:09 AM, Sascha Hauer wrote:
> On Mon, Jan 20, 2014 at 09:35:06AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 01/20/2014 09:24 AM, Sascha Hauer wrote:
>>>> +
>>>> +static const struct ahci_platform_data *ahci_get_pdata(struct device *dev)
>>>> +{
>>>> +	struct ahci_platform_data *pdata;
>>>> +	const struct of_device_id *of_id;
>>>> +
>>>> +	pdata = dev_get_platdata(dev);
>>>> +	if (pdata)
>>>> +		return pdata;
>>>> +
>>>> +	of_id = of_match_device(ahci_of_match, dev);
>>>> +	if (of_id)
>>>> +		return of_id->data;
>>>
>>> I don't think it's a good idea to force of_id->data to be of type struct
>>> struct ahci_platform_data *. With this we don't have a place to store
>>> SoC specific data anymore.
>>
>> ?? ahci_platform_data *is* soc specific data, it allows various soc
>> specific overrides.
>
> I know, but it might not be enough for encding the slight differences
> between i.MX53 and i.MX6. So you say then we would need to different
> instances of struct ahci_platform_data, one for i.MX53 and one for
> i.MX6. Ok, that works.
>
> Overall I must say that I'm not really happy with giving up control over
> the probe function and putting ahci_platform as a midlayer between the
> SoC and the ahci lib. Just my 2 cents, if I'm the only one feel free to
> ignore me, but maybe there are others that have the same feeling.

I'm currently working on a slightly different implementation of a more
generic ahci_platform.c where ahci_platform.c exports some standard platform
related functionality as library functions.

Drivers which need to override some of ahci_platform.c's behavior because of
non standard hw, will then export their own struct platform_driver and can
call into the exported functions for standard stuff to avoid code duplication
where appropriate, while still having 100% freedom to do things in a custom
way where necessary.

I hope to post a PATCH RFC v4 with these changes later today, which you will
hopefully like better. Input on v4, even just a "yep better" remark would be
much appreciated.

Regards,

Hans
