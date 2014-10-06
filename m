From: gautam.vivek@samsung.com (Vivek Gautam)
Date: Mon, 6 Oct 2014 10:32:27 +0530
Subject: 3.17-rc6 on ODROID: ERROR: Bad of_node_put() on
 /ehci@12580000/port@1
In-Reply-To: <CAD8Lp46UxTd04fczjm9c1597SBnvR--PUasjBqZwvWU8MKtj8Q@mail.gmail.com>
References: <CAD8Lp45qyHpHqRnUy4T9Sm8zV4XJBDp=cLYXjtcxmVrS8GSjbg@mail.gmail.com>
 <CAFp+6iGwB3XuzSuYPzO=5MacPO2LGFDnh9oS5rAL3Ne26wb9Dg@mail.gmail.com>
 <CAD8Lp46UxTd04fczjm9c1597SBnvR--PUasjBqZwvWU8MKtj8Q@mail.gmail.com>
Message-ID: <CAFp+6iGy4vDGy6JHsy=KbuVF=52YNzszZ6Pe6MX0sRfMWWiS3w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 1, 2014 at 8:42 PM, Daniel Drake <drake@endlessm.com> wrote:
> On Wed, Oct 1, 2014 at 12:36 AM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
>> One reason i doubt why it could be coming is because we are
>> specifically putting the
>> child after doing everything with it.
>>
>> When we are getting the child node using for_each_available_child_of_node(),
>> which calls for of_get_next_available_child(). So of_get_next_available_child()
>> does a of_node_put() on the "prev" node, in case we have siblings to the child.
>>
>> Can you see if the below change helps ?
>>
>> ------------------------------------------------------------------------------------------------------------
>> diff --git a/drivers/usb/host/ehci-exynos.c b/drivers/usb/host/ehci-exynos.c
>> index 7189f2e..1b726bf 100644
>> --- a/drivers/usb/host/ehci-exynos.c
>> +++ b/drivers/usb/host/ehci-exynos.c
>> @@ -74,7 +74,6 @@ static int exynos_ehci_get_phy(struct device *dev,
>>
>>                 phy = devm_of_phy_get(dev, child, NULL);
>>                 exynos_ehci->phy[phy_number] = phy;
>> -               of_node_put(child);
>>                 if (IS_ERR(phy)) {
>>                         ret = PTR_ERR(phy);
>>                         if (ret == -EPROBE_DEFER) {
>> ------------------------------------------------------------------------------------------------------------
>>
>>
>> This is on top of usb-next.
>> If you are testing on rc6 only, then probably you will have to cherrypick two
>> patches each for ehci-exynos and ohci-exynos:
>> usb: host: ehci-exynos: Remove unnecessary usb-phy support
>> usb: host: ohci-exynos: Remove unnecessary usb-phy support
>
> I made the equivalent change to 3.17-rc7 (right now 3.17 is my main
> interest), i.e. removed all of_node_put calls from
> exynos_ehci_get_phy(). Same change is needed in exynos_ohci_get_phy().
> Now the warnings are gone.
> BTW, I think the warning only appeared when CONFIG_OF_SELFTEST=y
>
> I didn't check the implementation details like you did, but I looked
> at a few other users of for_each_available_child_of_node and it looks
> like indeed you do not need to call of_node_put() on the children in
> the normal case, or at least, nobody else does.

Yes, i saw the same; and the reason i mentioned above looks like the
issue with us.
I will post necessary patches for removing this extra of_node_put()
from ehci/ohci-exynos



-- 
Best Regards
Vivek Gautam
Samsung R&D Institute, Bangalore
India
