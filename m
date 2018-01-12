From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 12 Jan 2018 10:18:59 +0100
Subject: [PATCH] usb: dwc2: Fix endless deferral probe
In-Reply-To: <277384ef-b30c-fb5a-5ffe-1efc15c500bb@i2se.com>
References: <1515526134-2148-1-git-send-email-stefan.wahren@i2se.com>
 <CAK8P3a3eggC=XWLxr-A+pdaXj-0kMZ4aoX3hRyg5tLUknoDeBA@mail.gmail.com>
 <7ef21b99-67c8-b246-cc9a-b7202264a7a0@i2se.com>
 <CAK8P3a3GdHvBBPR3D_qO5+Zjr1CUBMLOAvjTiMQEMO1NtKjb3w@mail.gmail.com>
 <277384ef-b30c-fb5a-5ffe-1efc15c500bb@i2se.com>
Message-ID: <CAK8P3a3yZKnBM9gD-0YiHdMuHXUV=11vxGgFsZvQSkbM=B5Mxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 9:06 AM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
> Am 12.01.2018 um 00:32 schrieb Arnd Bergmann:
>> On Wed, Jan 10, 2018 at 1:15 PM, Stefan Wahren <stefan.wahren@i2se.com>

>> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
>> index b4964b067aec..93b55fb71d54 100644
>> --- a/drivers/phy/phy-core.c
>> +++ b/drivers/phy/phy-core.c
>> @@ -410,6 +410,10 @@ static struct phy *_of_phy_get(struct device_node
>> *np, int index)
>>          if (ret)
>>                  return ERR_PTR(-ENODEV);
>>
>> +       /* This phy type handled by the usb-phy subsystem for now */
>> +       if (of_device_is_compatible(np, "usb-nop-xceiv"))
>> +               return ERR_PTR(-ENODEV);
>> +
>>          mutex_lock(&phy_provider_mutex);
>>          phy_provider = of_phy_provider_lookup(args.np);
>>          if (IS_ERR(phy_provider) || !try_module_get(phy_provider->owner))
>> {
>
>
> I tried this, but it doesn't work. "np" is the node of the USB controller,
> not of the phy?

Correct, that was a really dumb mistake on my end, I'm glad I asked
you to try it first.

I'll fix it up and send the right version with a proper changelog right away.

Thanks for bearing with me,

       Arnd
