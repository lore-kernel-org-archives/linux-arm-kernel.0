From: robh@kernel.org (Rob Herring)
Date: Sun, 20 Sep 2015 21:01:58 -0500
Subject: [PATCH 2/2] irqchip/gicv3-its: Handle OF device tree "msi-map"
 properties.
In-Reply-To: <55FC4FBA.1010306@caviumnetworks.com>
References: <1442512859-31633-1-git-send-email-ddaney.cavm@gmail.com>
 <1442512859-31633-3-git-send-email-ddaney.cavm@gmail.com>
 <20150918095109.144c22ed@arm.com>
 <55FC4FBA.1010306@caviumnetworks.com>
Message-ID: <CAL_JsqJy78FqkRihQhFytLx8Q+-NJCUaG18cQ59pHB1EJ5Ndsg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 18, 2015 at 12:54 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 09/18/2015 01:51 AM, Marc Zyngier wrote:
>>
>> On Thu, 17 Sep 2015 11:00:59 -0700
>> David Daney <ddaney.cavm@gmail.com> wrote:
>>
>> Hi David,
>>
>>> From: David Daney <david.daney@cavium.com>
>>>
>>> Search up the device hierarchy to find devices with a "msi-map"
>>> property, if found apply the mapping to the GIC device id.

[...]

>>> +               masked_devid = msi_mask & dev_alias.dev_id;
>>> +               matched = false;
>>> +               while (msi_map_len >= 4 * sizeof(__be32)) {
>>> +                       rid_base = be32_to_cpup(msi_map + 0);
>>> +                       phandle = be32_to_cpup(msi_map + 1);
>>> +                       msi_base = be32_to_cpup(msi_map + 2);
>>> +                       rid_len = be32_to_cpup(msi_map + 3);
>>
>>
>> Ouch. I wonder if that kind of thing should deserve a generic helper.
>> of_property_read_u32_array_from_index()? Rob, what do you think?
>
>
> I think it is possible to add too many wrapper functions.  IMO, this is not
> too unreadable.

Given you are not reading into an array, I don't think a new helper
would help. You could just use of_property_read_u32_index though.

Rob
