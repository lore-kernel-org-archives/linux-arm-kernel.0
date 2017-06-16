From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Fri, 16 Jun 2017 08:11:26 +0200
Subject: [PATCH 5/5] phy: bcm-ns-usb3: add MDIO driver using proper bus
 layer
In-Reply-To: <50c92818-5f96-0b9a-b631-898cc09c7349@ti.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
 <20170511132925.14564-6-zajec5@gmail.com>
 <a5062fcb-a051-e0a9-9e19-954d4e611780@gmail.com>
 <50c92818-5f96-0b9a-b631-898cc09c7349@ti.com>
Message-ID: <CACna6rwgUpkO+dQjXT-zgxcFgUUQ-0wY7V6RTkWJGtpgOBFmkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 June 2017 at 08:04, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> On Thursday 11 May 2017 09:59 PM, Florian Fainelli wrote:
>> On 05/11/2017 06:29 AM, Rafa? Mi?ecki wrote:
>>> @@ -297,6 +371,28 @@ static struct platform_driver bcm_ns_usb3_driver = {
>>>              .of_match_table = bcm_ns_usb3_id_table,
>>>      },
>>>  };
>>> -module_platform_driver(bcm_ns_usb3_driver);
>>> +
>>> +static int __init bcm_ns_usb3_module_init(void)
>>> +{
>>> +    int err;
>>> +
>>> +    err = mdio_driver_register(&bcm_ns_usb3_mdio_driver);
>>> +    if (err)
>>> +            return err;
>>> +
>>> +    err = platform_driver_register(&bcm_ns_usb3_driver);
>>> +    if (err)
>>> +            mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
>>> +
>>> +    return err;
>>> +}
>>> +module_init(bcm_ns_usb3_module_init);
>>> +
>>> +static void __exit bcm_ns_usb3_module_exit(void)
>>> +{
>>> +    platform_driver_unregister(&bcm_ns_usb3_driver);
>>> +    mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
>>> +}
>>> +module_exit(bcm_ns_usb3_module_exit)
>>
>> Do we need to keep both platform device and mdio device registration
>> here? Do you have a depreciation time line for when we can entirely
>> switch to mdio device (assuming this is for backwards compatibility)?
>
> I too have the same question.

My plan is to:
1) Get this patch accepted
2) Switch DTS files to use the new binding
3) Maybe wait for LTS release if we care that much
4) Drop old binding support

Not sure if it was noticed, but I added following text to the commit
message after receiving Florian's question:
> For now keep platform device support in place. We may consider dropping
> it once MDIO bindings gets used "everywhere".

-- 
Rafa?
