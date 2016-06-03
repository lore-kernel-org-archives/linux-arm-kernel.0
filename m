From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 3 Jun 2016 15:15:28 +0200
Subject: [PATCH 1/4] USB: Fix of_usb_get_dr_mode_by_phy with a shared phy
 block
In-Reply-To: <20160603131213.GB3778@uda0271908>
References: <1464888666-17728-1-git-send-email-hdegoede@redhat.com>
 <575167EC.8000504@ti.com> <e8b770aa-5642-93c3-60c8-0717e87e732e@redhat.com>
 <20160603131213.GB3778@uda0271908>
Message-ID: <69b477f9-df92-437d-e79d-6418a5657c37@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03-06-16 15:12, Bin Liu wrote:
> Hi,
>
> On Fri, Jun 03, 2016 at 01:39:26PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 03-06-16 13:20, Kishon Vijay Abraham I wrote:
>>> Hi,
>>>
>>> On Thursday 02 June 2016 11:01 PM, Hans de Goede wrote:
>>>> Some SoCs have a single phy-hw-block with multiple phys, this is
>>>> modelled by a single phy dts node, so we end up with multiple
>>>> controller nodes with a phys property pointing to the phy-node
>>>> of the otg-phy.
>>>
>>> Maybe we should try to model each phy with a separate dt node?
>>
>> That seems like making things unnecessarily complicated. If we want
>> to be 100% sure that of_usb_get_dr_mode_by_phy finds the right
>
> I believe we have to.

We do not have to, things work fine as is, and the problem we're
discussing can be solved much simpler by passing the otg-phy index
to of_usb_get_dr_mode_by_phy

Also doing this breaks the dt bindings and that simply is not allowed
so not only do we not have to do this, we cannot do this!

>> controller, we could add an "int index" parameter to of_usb_get_dr_mode_by_phy
>> and make it check that first argument specified to the phandle
>> used in the controller node matches the passed in index.
>
> Why we need the 'index'? Once the dt has seperate nodes for the phys,
> 'phy_np' passed in is the uniqe id of the phy node.

Because we cannot use separate nodes for the phys as that would break
the devicetree bindings.

Anyways please wait for v2 of my patch, I believe that will solve this
properly without needing to break devicetree bindings.

Regards,

Hans
