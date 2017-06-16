From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Jun 2017 12:01:05 +0530
Subject: [PATCH 5/5] phy: bcm-ns-usb3: add MDIO driver using proper bus
 layer
In-Reply-To: <CACna6rwgUpkO+dQjXT-zgxcFgUUQ-0wY7V6RTkWJGtpgOBFmkQ@mail.gmail.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
 <20170511132925.14564-6-zajec5@gmail.com>
 <a5062fcb-a051-e0a9-9e19-954d4e611780@gmail.com>
 <50c92818-5f96-0b9a-b631-898cc09c7349@ti.com>
 <CACna6rwgUpkO+dQjXT-zgxcFgUUQ-0wY7V6RTkWJGtpgOBFmkQ@mail.gmail.com>
Message-ID: <ac107cb7-8551-7a2c-e1e9-983fdb5241aa@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafal,

On Friday 16 June 2017 11:41 AM, Rafa? Mi?ecki wrote:
> On 16 June 2017 at 08:04, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>> On Thursday 11 May 2017 09:59 PM, Florian Fainelli wrote:
>>> On 05/11/2017 06:29 AM, Rafa? Mi?ecki wrote:
>>>> @@ -297,6 +371,28 @@ static struct platform_driver bcm_ns_usb3_driver = {
>>>>              .of_match_table = bcm_ns_usb3_id_table,
>>>>      },
>>>>  };
>>>> -module_platform_driver(bcm_ns_usb3_driver);
>>>> +
>>>> +static int __init bcm_ns_usb3_module_init(void)
>>>> +{
>>>> +    int err;
>>>> +
>>>> +    err = mdio_driver_register(&bcm_ns_usb3_mdio_driver);
>>>> +    if (err)
>>>> +            return err;
>>>> +
>>>> +    err = platform_driver_register(&bcm_ns_usb3_driver);
>>>> +    if (err)
>>>> +            mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
>>>> +
>>>> +    return err;
>>>> +}
>>>> +module_init(bcm_ns_usb3_module_init);
>>>> +
>>>> +static void __exit bcm_ns_usb3_module_exit(void)
>>>> +{
>>>> +    platform_driver_unregister(&bcm_ns_usb3_driver);
>>>> +    mdio_driver_unregister(&bcm_ns_usb3_mdio_driver);
>>>> +}
>>>> +module_exit(bcm_ns_usb3_module_exit)
>>>
>>> Do we need to keep both platform device and mdio device registration
>>> here? Do you have a depreciation time line for when we can entirely
>>> switch to mdio device (assuming this is for backwards compatibility)?
>>
>> I too have the same question.
> 
> My plan is to:
> 1) Get this patch accepted
> 2) Switch DTS files to use the new binding
> 3) Maybe wait for LTS release if we care that much
> 4) Drop old binding support

old dt's are generally not allowed to break. So I'm not sure if we shoud ever
drop old binding support. Rest sounds good.

Thanks
Kishon
