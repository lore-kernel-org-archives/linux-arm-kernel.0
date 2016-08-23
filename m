From: robh@kernel.org (Rob Herring)
Date: Tue, 23 Aug 2016 18:06:26 -0500
Subject: [PATCH v2 03/22] usb: ulpi: Support device discovery via device
 properties
In-Reply-To: <CAJOFmgwTPDwdL_cc7f5N09enZNhKwSkWAxdpF39vOBQLfEdVSg@mail.gmail.com>
References: <20160707222114.1673-1-stephen.boyd@linaro.org>
 <20160707222114.1673-4-stephen.boyd@linaro.org>
 <20160718022355.GA8568@rob-hp-laptop>
 <147043320014.26915.7483025835695600714@sboyd-linaro>
 <CAJOFmgwTPDwdL_cc7f5N09enZNhKwSkWAxdpF39vOBQLfEdVSg@mail.gmail.com>
Message-ID: <CAL_JsqKPgVEr8zuaO7f8NczuxdCqa9ceg+PnVpOBxiT=Lr79eA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2016 at 3:00 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> On Fri, Aug 5, 2016 at 2:40 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
>> Quoting Rob Herring (2016-07-17 19:23:55)
>>> On Thu, Jul 07, 2016 at 03:20:54PM -0700, Stephen Boyd wrote:
>>> > +-------
>>> > +
>>> > +usb {
>>> > +     compatible = "vendor,usb-controller";
>>> > +
>>> > +     ulpi {
>>> > +             phy {
>>> > +                     compatible = "vendor,phy";
>>> > +                     ulpi-vendor = /bits/ 16 <0x1d6b>;
>>> > +                     ulpi-product = /bits/ 16 <0x0002>;
>>> > +             };
>>> > +     };
>>>
>>> I'm still having concerns about describing both phys and devices. If I
>>> have a controller with 2 ports and 2 devices attached, I'd have
>>> something like this under the USB controller:
>>>
>>> ulpi {
>>>         phy at 1 {
>>>         };
>>>         phy at 2 {
>>>         };
>>> };
>>
>> My understanding is there would only be one status="ok" node on the ULPI
>> bus for the single phy that a usb controller would have. At the least,
>> the kernel's ULPI layer only seems to support one ULPI phy for a
>> controller right now. So even if there are two ports, it doesn't mean
>> there are two phys.
>>
>>>
>>> dev at 1 {
>>> ...
>>> };
>>>
>>> dev at 2 {
>>> ...
>>> };
>>>
>>>
>>> That doesn't seem the best, but I don't have a better suggestion. Maybe
>>> the device nodes need to go under the phy nodes?
>>>
>>
>> What if we moved the dev at 1 and dev at 2 to another sub node like "ports" or
>> "usb-devices"? Legacy code can support having those devices directly
>> underneath the usb controller, but future users would always need to put
>> them in a different sub-node so that we can easily differentiate the
>> different busses that a usb controller node may support?
>>
>> I'm not sure I see any need to relate the phy to the ports that are on
>> the controller, but if that is needed then perhaps you're right and we
>> should move the ports underneath the phy. USB core could be modified to
>> go through the legacy path or through the phy, if it even exists, to
>> find ports.
>>
>> Do we typically do this for other phy designs like sata or pci? The phy
>> always seemed like a parallel thing to the logical bus that the phy is
>> used for.
>
> Rob does this sound ok to you?

Well, if there's only ever 1 phy under the controller, then as you had
it is fine.

Rob
