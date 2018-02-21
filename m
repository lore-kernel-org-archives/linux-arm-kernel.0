From: a.hajda@samsung.com (Andrzej Hajda)
Date: Wed, 21 Feb 2018 16:54:42 +0100
Subject: [PATCH v4 5/6] extcon: add possibility to get extcon device by
 OF node
In-Reply-To: <CAHp75VdxGDCGQBN05bL3_h8P62-v6+5oGW3M7CA+701o15ZXnQ@mail.gmail.com>
References: <CGME20180221085608eucas1p162d2e579a1cc887672b722458edb98fe@eucas1p1.samsung.com>
 <20180221085541.14556-1-a.hajda@samsung.com>
 <20180221085541.14556-6-a.hajda@samsung.com>
 <CAHp75VdxGDCGQBN05bL3_h8P62-v6+5oGW3M7CA+701o15ZXnQ@mail.gmail.com>
Message-ID: <6da27f54-76d0-2ac8-666e-e3ebfc71b2c1@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21.02.2018 15:27, Andy Shevchenko wrote:
> On Wed, Feb 21, 2018 at 10:55 AM, Andrzej Hajda <a.hajda@samsung.com> wrote:
>> Since extcon property is not allowed in DT, extcon subsystem requires
>> another way to get extcon device. Lets try the simplest approach - get
>> edev by of_node.
>> +/*
>> + * extcon_get_edev_by_of_node - Get the extcon device from devicetree.
>> + * @node       : OF node identyfying edev
>> + *
>> + * Return the pointer of extcon device if success or ERR_PTR(err) if fail.
>> + */
>> +struct extcon_dev *extcon_get_edev_by_of_node(struct device_node *node)
> First of all, the all other similar cases use "_by_node" in the name.

OK, looks better.

> Second, it's not _get_, it's _find_.

The patch splits exisiting extcon_get_edev_by_phandle function into two
functions, nothing more.
Thus it followed naming convention present in extcon framework. I can
switch it of course to _find_.

>
>> +{
>> +       struct extcon_dev *edev;
>> +
>> +       mutex_lock(&extcon_dev_list_lock);
>> +       list_for_each_entry(edev, &extcon_dev_list, entry)
>> +               if (edev->dev.parent && edev->dev.parent->of_node == node)
>> +                       goto out;
>> +       edev = ERR_PTR(-EPROBE_DEFER);
>> +out:
>> +       mutex_unlock(&extcon_dev_list_lock);
>> +
>> +       return edev;
> Can't it be done using bus_find_device()?

There is no special extcon bus, so I am not sure. Anyway if it can, it
should be done probably in another patch.

Regards
Andrzej
