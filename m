From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 22 Aug 2016 17:50:25 +0200
Subject: [PATCH v2 0/7] musb: sunxi: Add support for run-time changing
 dr-mode through sysfs
In-Reply-To: <20160822140829.GE1853@uda0271908>
References: <1471288892-21702-1-git-send-email-hdegoede@redhat.com>
 <20160819212540.GB1853@uda0271908>
 <f7109331-b1fd-f3f4-31fa-23f49d31ba05@redhat.com>
 <20160822140829.GE1853@uda0271908>
Message-ID: <906e9d73-a35b-78fb-8690-daf3ce50b583@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 22-08-16 16:08, Bin Liu wrote:
> Hi,
>
> On Sun, Aug 21, 2016 at 11:29:02AM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 19-08-16 23:25, Bin Liu wrote:
>>> Hi,
>>>
>>> On Mon, Aug 15, 2016 at 09:21:25PM +0200, Hans de Goede wrote:
>>>> Hi All,
>>>>
>>>> Here is a patch series which implements run-time changing the dr-mode
>>>> of sunxi musb controllers through the (already existing) musb "mode"
>>>> sysfs attribute.
>>>>
>>>> This is useful on boards where there is no id pin, e.g. some tv-boxes
>>>> use the musb controller to get an extra usb A port without needing
>>>> a hub chip. Except for the missing id pin when using a usb A<->A cable
>>>> these ports can do peripheral mode just fine. This series makes it
>>>> possible to do e.g. this by doing echo "peripheral" > mode before
>>>> plugging in the usb A<->A cable.
>>>
>>> Well, this is an illegal usecase. A-A cable is invalid by USB Spec.
>>
>> Yet they exist and there are USB devices (e.g. harddisk enclosures)
>> which use a USB-A connector even though they are a device not
>> a host. I own several such devices myself. I agree that this is
>> wrong but these devices exist, typical case of reality trumping
>> the spec.
>
> I know those products exist, but they are different from yours. Those
> existing devices are usb peripheral-only, which never source vbus so do
> not hurt anything other than violate the USB Spec. But your usecase
> allows the device switching to host mode, which could damage the usb
> host on the other end of the connection due to vbus contention.

Actually the sun4i phy driver avoids this by checking vbus-detect for
external vbus presence before enabling the boards own Vbus.

More importantly, not supporting peripheral mode on musb attached to an
USB-A receptacle will not stop users from trying to use it and insert
an A<->A cable at which point the damage is already done.

I understand why you dislike this, but we cannot stop a user
from trying this. So it is better to actually be prepared for this
(e.g. do the vbus-detect check we're already doing) then it is
to not support this.

For example:

Lets say we do not have vbus-detect and the user plugs in
an A<->A cable causing Vbus being driven from 2 sides.

Not good, now we have current flowing between the 2
power supplies and things are heating up.

Now there are 2 possible follow-up scenarios:

1) We support peripheral mode, the user does
"echo peripheral > mode" in sysfs and we disable
the boards Vbus, no more current, things are cooling
down again before components burn up.

2) We do not support peripheral mode (which is what you're
suggesting), the user does "echo peripheral > mode" in sysfs,
nothing happens. Now we can only happen the user unplugs
the A<->A cable soon, instead of trying a bunch of other things.

Neither is ideal, but do you see how not allowing peripheral
mode is not helping here ? As soon as the user plugs in
an A<->A cable bad things may happen, we cannot avoid that
from the software side.

>>> With type-A receptacle the controller should be in host-only mode,
>>> switching to peripheral mode should not be allowed.
>>
>> Peripheral mode can still be quite useful, e.g. to do ethernet
>> over USB (some of these devices lack wired ethernet).
>
> For such usecase, a micro-AB connector should be used, or use two
> connectors - type-A and type-B which are mux'd to the same usb port.
>
>>
>> Also the manual of these devices typically instructs users to
>> use an A<->A cable for firmware updates, since the bootROM in
>
> (Nobody reads the manual, we all know it...) This does not prevent users
> to connect two hosts together then damage the hardware. So this design
> should not be allowed.

Nothing prevents an user from doing that, as soon as they have
an A<->A cable they can easily do that, one can only hope they
will not do it.

>> the SoC does not care anmd will happily put the device in
>> Allwinner's custom DFU mode using the USB-A connector.
>>
>> Although I agree with this being not ideal, the fact is that
>> an USB-A connector combined with a A<->A cable is electrically
>> 100% identical to a USB-B connector with its id-pin not connected
>> (on the PCB side), which also happens see below.
>
> they are two different cables. A-B cable does not provide a chance to
> connect two hosts together, but A-A cable does.

Right, but an A-B cable with its id-pin wrongly connected to ground
(some so called otg charging hubs do this) will cause the exact same issue.

This is why usb-ports and especially otg ports should have current limiting
on their Vbus and why the sun4i phy driver checks vbus-detect not reporting
an external vbus before enabling Vbus.

>>>> This series has both sun4i-usb-phy driver and sunxi-musb-glue changes,
>>>> both are necessary for the run-time changing to work, but they can be
>>>> merged independently without breaking anything.
>>>>
>>>> Changed in v2:
>>>>
>>>> After sleeping on it a night I realized that always passing port_mode =
>>>> DUAL_ROLE to the musb-core was wrong. There is a distintion between
>>>> the id-pin not working properly which we can work around with software
>>>> mode switching (and we want to register both the host and udc driver
>>>> in this case) vs cases where we really only want to register a host
>>>> (wifi module connected to musb soldered onto the PCB).
>>>>
>>>> So v2 of this series drops the
>>>> "musb: sunxi: Always register both host and udc when build with dual-role support"
>>>> patch.
>>>>
>>>> Instead systems which are dual-role capable, but lack an id-pin should use
>>>> dr_mode = "otg" in the dts file. There is one problem with this, some
>>>> systems are dual-role capable but use a female USB-A connector connected
>>>> to the musb controller. These should come up in host mode by default,
>>>
>>> This is not a problem. With a type-A connector, the dual-role controller
>>> should work in host-only mode.
>>> Role switching should only be allowed if an AB connector is used.
>>
>> Yet people may want to use it in peripheral mode, I strongly believe
>> that we should not be telling people what they can and cannot do
>> with their hardware. That is policy and the kernel does not set
>
> I agree with the policy, but we are responsible to tell people don't do
> something which is not correct.
>
>> such policy, that is up to userspace. OTOH the port should clearly
>> default to host mode hence the new property.
>
> Due to the problem with A-A cable I explained above, A-A cable should
> not be used in role-switching cases (it should be used at the first
> place), so this new property is unnecessary.
>
>>
>>> Using the sysfs entry to switch roles for generic purpose is really a
>>> bad idea, it opens up ton of problems.
>>
>> Yet the sysfs entry exists already, and the problems depend on how
>> you hook it up. I'm merely using the sysfs entry as an id-pin
>> for cases where there is no id pin hooked up. If you look at the
>> patches you will see that all that is changed by writing the
>> sysfs entry is the phy reporting a different id-pin value to
>> the musb ip. Everything else is handled the same as for any normal
>> otg mode port.
>>
>>> For systems which lack of id-pin should use a discrete circuit (for
>>> example GPIO) to detect the id pin in the AB receptacle, then the USB
>>> driver will handle the role switching transparently.
>>
>> You're again talking theory here in reality there is hardware where
>> for whatever reasons the PCB uses a mini or micro usb receptacle,
>> but they did not bother to _physically_ hook up the id pin.
>
> Who are they?

One example of such a device is the quite popular mk802 tv stick
(the original version) with A10s SoC.

 > the manufactures who use musb controller to make products,
> so as Linux or musb drivers, we have control, it is our responsibility
> to tell those manufactures to do things in the right way - design the hw
> correctly at the first place. We can't compromise by using an A-A cable
> to provide a change to damage the usb host.
>
> This is different from the cases, for example, from the xhci controller
> perspective, the xhci driver has to compromise any usb thumb drives
> which do not follow the USB Specs, to make them work on PCs.

That makes no sense, why would the xhci driver have to compromise
but we don't ? Either actually having things working is more important
then following the spec or the spec is more important...

And in reality as your xhci example points out having things
working (and that means offering all possible functionality) is
more important.

>> As said before reality trumps the Spec / theory.
>>
>>>> rather then peripheral mode which is the default for systems which lack an
>>>> id-pin. This patch set introduces:
>>>>
>>>> "phy-sun4i-usb: Add "allwinner,usb0-usb-a-connector" dt property"
>>>>
>>>> Which allows specifying the use of a female USB-A connector for the
>>>> musb controller in the phy dt node, the presence of this dt property
>>>> changes the default to host mode.
>>>
>>> This is unnecessary, if using a type-A connector, dr_mode should be
>>> "host" in DT.
>>
>> Which means we're telling users what they can and cannot do with
>> their hardware, which we should not be doing.
>
> To summary up my opinion from my lengthy comments above,
>
> A-A cable should not be used, especially in role-switching cases, so
> the DT prop is unnecessary;

A<_>A cables exist, users will try to plug them in, those are facts.

So we'd better be prepared to deal with this, denying this scenario
exists is not helpful, not supporting it is equally unhelpful.

Regards,

Hans
