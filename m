From: eduardo.valentin@ti.com (Valentin, Eduardo)
Date: Thu, 28 Jun 2012 16:48:54 +0300
Subject: [PATCH v3 0/7] OMAP System Control Module
In-Reply-To: <CAGF5oy925c96QqwjqMEaUYDon+mSVGd2dtgnWrzwnrq0rN14Ng@mail.gmail.com>
References: <4FEB4B30.2040305@dev.rtsoft.ru> <20120628044343.GA2471@besouro>
 <CAGF5oy925c96QqwjqMEaUYDon+mSVGd2dtgnWrzwnrq0rN14Ng@mail.gmail.com>
Message-ID: <CAGF5oy8V+RZ=ewQsT==2wRY-BVsxVndEtONrd8a3NtjoGFu4hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

On Thu, Jun 28, 2012 at 9:29 AM, Valentin, Eduardo
<eduardo.valentin@ti.com> wrote:
> Hello Konstantin,
>
> On Thu, Jun 28, 2012 at 7:43 AM, Eduardo Valentin
> <eduardo.valentin@ti.com> wrote:
>> Hello,
>>
>> On Wed, Jun 27, 2012 at 10:04:32PM +0400, Konstantin Baydarov wrote:
>>> ?Hello.
>>>
>>> This is a next version of series of patches(based on Eduardo Valentin's patch set) adding a basic support for system control module, on OMAP4+ context. It is a working in progress.
>>>
>>> Main changes since previous patch set version:
>>> - Bandgap and usb phy: drivers are now independent from control module driver, they use their own functions to acess scm registers.
>>
>> Well, I believe the idea of having them with their own io resource was to avoid
>> children drivers accessing each other io areas. Is this now working?
>>
>>> - omap-control-core: resources aren't hardcoded, they are specified in dts file.
>>> - omap-control-core: Control module is a built-in driver - added control module select to ARCH_HAS_CONTROL_MODULE and ARCH_OMAP4.
>>> Probably, no configuration option is required!
>>
>> Why is this? I suppose the idea is to have the arch config selecting that flag.
>>
>>> - omap-control-core: Added early init call that ioremaps control module IOMEM window, this allows access of SCM registers very early, for example from omap_type()
>>
>> Is this going to be reserved as well? if yes, how children are going to have
>> their own access functions?
>>
>>> - omap-control-core: Removed device pointer from omap-control-core API arguments, becuase there can be only one instance control
>>> module device.
>>> - omap-control-core: removed omap_control_get, omap_control_readl, omap_control_writel
>>
>> fine, assuming the io split works...
>>
>>> - omap-control-core: added omap_control_status_read that is used early in omap_type
>>> - Bandgap and usb phy: Added private spinlocks for bandgap and usb drivers.
>>> - Bandgap: Check the type of bandgap dynamically in bandgap driver probe function by reading
>>> omap core control module revision register CONTROL_GEN_CORE_REVISION.
>>
>> this has some issue... I will post comment on the patch
>>
>>> - Bandgap and usb phy: Parent SCM platform device IOMEM resources is used to get the base address of SCM window.
>>
>> Ohh.. Then what is the point of having them using their own io access functions,
>> nothing is again protected as you have only 1 io resource which is shared.
>> And now is even worse because you have several io access function..
>> I think this is moving backwards.
>>
>>> - Bandgap masks defines were moved to drivers/thermal/omap-bandgap.c.
>>>
>>> TODO list for bandgap driver:
>>> - Reserve omap-control-core IOMEM window.
>>> - Improve thermal zone definition for OMAP4
>>> - Introduce the thermal zones for OMAP5
>>
>> Based on the review comments on RFC patch series, there are more
>> things to be done.
>>
>> I have the O4 and O5 zone definition ready. But that work depends
>> on generic CPU cooling patches. I have also looked the driver support
>> for 4430. But the probing and io resource split is still based on
>> previous design. I have also a patch which does the remapping in the
>> bandgap driver. But really, for this to work it would require to have
>> several entries in the reg property. And that is going to change from
>> BG version to BG version.
>>
>> I can prepare some patches for this.
>
> You can find the updated patches here:
> git at gitorious.org:thermal-framework/thermal-framework.git
> thermal_work/omap/bandgap_clean
>
> But, as I said they are based on the generic cpu cooling. And the zone
> registration follows the API as in linux-next.

FYI, I just updated the branches on that repo. The branch
thermal_work/omap/pu has all required changes in order to get BG
driver working on 4430/4460/4470 and O5.

It relies on Rui's patch set sent to linux-pm, which reorgs the
thermal fw a bit,  combined with the generic cpu cooling device by
Amit. I also pushed in the 'pu' branch the APIs changes mentioned by
Durga on other thread.

While checking the pu branch you should be able to get a thermal zone
with cpu cooling for OMAP on the mentioned omap versions.

Once there is an agreement about the APIs between SCM core driver and
its children, I can send out the BG driver patches and this initial
omap thermal support using the generic thermal layer.

There are some changes in the core thermal layer in the
thermal_work/eduardo_thermal_upgrade. But there could be probably some
extra changes in the core layer to finalize the omap thermal support.
That's a work in progress :-)

>
>
> --
>
> Eduardo Valentin



-- 

Eduardo Valentin
