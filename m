From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 27 Nov 2015 11:41:17 +0100
Subject: [linux-sunxi] Re: [PATCH v3 1/2] phy-sun4i-usb: Use of_match_node
 to get model specific config data
In-Reply-To: <56583260.1080106@redhat.com>
References: <1448470202-3628-1-git-send-email-hdegoede@redhat.com>
 <CAGb2v64XL=bptxoCwiVkf8u-EfckpuASS3Foo=Q3i4a_6CaJYA@mail.gmail.com>
 <5656F6F4.1040801@redhat.com> <20151127085332.GU32142@lukather>
 <56583260.1080106@redhat.com>
Message-ID: <5658334D.30804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 27-11-15 11:37, Hans de Goede wrote:
> Hi,
>
> On 27-11-15 09:53, Maxime Ripard wrote:
>> On Thu, Nov 26, 2015 at 01:11:32PM +0100, Hans de Goede wrote:
>>>>> +enum sun4i_usb_phy_type {
>>>>> +       sun4i_a10_phy,
>>>>> +       sun8i_a33_phy,
>>>>> +};
>>>>> +
>>>>> +struct sun4i_usb_phy_cfg {
>>>>> +       int num_phys;
>>>>> +       u32 disc_thresh;
>>>>> +       enum sun4i_usb_phy_type type;
>>>>> +       bool dedicated_clocks;
>>>>> +};
>>>>> +
>>>>>   struct sun4i_usb_phy_data {
>>>>>          void __iomem *base;
>>>>> +       const struct sun4i_usb_phy_cfg *cfg;
>>>>>          struct mutex mutex;
>>>>> -       int num_phys;
>>>>> -       u32 disc_thresh;
>>>>> -       bool has_a33_phyctl;
>>>>>          struct sun4i_usb_phy {
>>>>>                  struct phy *phy;
>>>>>                  void __iomem *pmu;
>>>>> @@ -164,12 +174,15 @@ static void sun4i_usb_phy_write(struct sun4i_usb_phy *phy, u32 addr, u32 data,
>>>>>
>>>>>          mutex_lock(&phy_data->mutex);
>>>>>
>>>>> -       if (phy_data->has_a33_phyctl) {
>>>>> +       switch (phy_data->cfg->type) {
>>>>> +       case sun4i_a10_phy:
>>>>> +               phyctl = phy_data->base + REG_PHYCTL_A10;
>>>>
>>>> Any reason why this offset isn't incorporated into phy_data?
>>>
>>> You mean in phy_data->cfg I assume, the difference needed for
>>> the "sun4i_usb_phy_write" functionality are not just the phyctl
>>> register offset...
>>>
>>>>
>>>>> +               break;
>>>>> +       case sun8i_a33_phy:
>>>>>                  phyctl = phy_data->base + REG_PHYCTL_A33;
>>>>>                  /* A33 needs us to set phyctl to 0 explicitly */
>>>>>                  writel(0, phyctl);
>>>
>>> e.g. the A33 needs this extra write, and on the H3 we need to do
>>> similar bitbanging, but slightly different, see:
>>>
>>> https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/usb/host/sunxi_hci.c#L899
>>>
>>> Notice how it uses different addr and write register addresses
>>> their through the usb_phy_csr_add and usb_phy_csr_write helper
>>> functions as well as directly poking offset 0x20.
>>
>> Then it easy to support: one u8 for each register that changes, one
>> bool to tell if you need to clear the phyctl register or not, And you
>> don't have to duplicate the switch everywhere, and basically just
>> reimplement of_device_is_compatible without an actual compatible to
>> workaround the review ;)
>
> You clearly have not looked at the actual code I've linked to, the
> entire "algorithm" for sun4i_usb_phy_write is different on the H3.
>
> Moreover, this has nothing to do with this patch, the code coding the
> difference behavior for the a10 style phy and the a33 style phy is already
> there before this patch-set, and this is not something Kishon asked
> me to change.

And on top of that phy_data->cfg->type is also used in different places,
where the behavior for h3 is again completely different then for the other
phy-s. There are just some differences which cannot be encoded in the form
of register offsets or bools between the old a10 usb phys and the newer ones.

And yes I've considered to just do a whole new phy driver, but there is enough
overlap to make doing this in one driver more sensible. This may change when
we add otg support for the H3. But we can always do a new driver then, and
remove the limited (see the 2nd patch in this series) amount of changes needed
for the H3 from phy-sun4i-usb.c again.

Regards,

Hans
