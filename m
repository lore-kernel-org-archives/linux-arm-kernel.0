From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 07 Apr 2014 16:18:21 +0200
Subject: [PATCH v2 1/7] drm/exynos: add super device support
In-Reply-To: <CAAQKjZP+RbkO0yVNEKgWWAkogx+p36HKwVyJ+4EjPHrSOarBwQ@mail.gmail.com>
References: <1396355882-17010-1-git-send-email-inki.dae@samsung.com>
 <1396355882-17010-2-git-send-email-inki.dae@samsung.com>
 <533EB9C6.80302@samsung.com>
 <CAAQKjZPbzb+qvJA5y+Kco9BRv4j3iVatM_0bd+ugyuVZUbfFFg@mail.gmail.com>
 <53403E42.1010403@gmail.com>
 <CAAQKjZP+RbkO0yVNEKgWWAkogx+p36HKwVyJ+4EjPHrSOarBwQ@mail.gmail.com>
Message-ID: <5342B3AD.1030502@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Inki and Tomasz,

On 04/06/2014 05:15 AM, Inki Dae wrote:

(...)
> The code creating the list of components to wait for
> (exynos_drm_add_components()) doesn't seem to consider which sub-drivers are
> actually enabled in kernel config.
>
> Are you sure?
>
> exynos_drm_add_components() will try to attach components *added to
> component_lists. And these components will be added by only
> corresponding sub drivers to the component_lists and
> master->components.
>
> So in this case, if users disabled HDMI support then a commponent
> object for HDMI sub driver doesn't exists in the component_lists and
> master->components. This means that a component object for HDMI sub
> driver *cannot be attached to master object*.
>
> As a result, component_bind_add() will ignor component_bind call for
> HDMI sub driver so HDMI driver will not be bounded. The only
> components added by sub drivers will be bound, component->ops->bind().
>
> For more understanding, it seems like you need to look into below codes,
>
> static int exynos_drm_add_components(...)
> {
>         ...
>         for (i == 0;; i++) {
>                 ...
>                 node = of_parse_phandle(np, "ports", i);
>                 ...
>                 ret = component_master_add_child(m, compare_of, node);
>                 ...
>         }
> }

Hmm, In case HDMI driver is not present, HDMI device is not probed and
HDMI component is not added, so component_master_add_child returns
an error when it tries to add hdmi component and master is never brought
up, am I correct?

>
>
> And below codes,
>
> int component_master_add_child(...)
> {
>         list_for_each_entry(c, &component_list, node) {
>                 if (c->master)
>                         continue;
>
>                 if (compare(...)) {
>                          component_attach_master(master, c);
>                          ...
>                 }
>         }
> }
>
> And below codes,
>
> static void component_attach_master(master, c)
> {
>         c->master = master;
>         list_add_tail(&c->master_node, &master->comonents);
> }
>
>
> As you can see above, the only components added to component_list can
> be attached to master. And the important thing is that components can
> be added by sub drivers to the component_list.
>
> And below codes that actually tries to bind each sub drivers,
>
> int component_bind_add(...)
> {
>         ....
>         list_for_each_entry(c, &master->components, master_node) {
>                    ret = component_bind(c, master, data);
>                    ...
>         }
>         ...
> }
>
> The hdmi driver users disabled doesn't exist to master->components list.
> How Exynos DRM cannot be initialized?
>
> Of course, there may be my missing point, but I think I see them
> correctly. Anyway I will test them tomorrow.
>
> Thanks,
> Inki Dae
>
>>>> register, which is completely wrong. Users should be able to select which
>>>> drivers should be compiled into their kernels.
>>>
>>> So users are be able to select drivers they want to use, and will be
>>> compiled correctly. So no, the only thing users can disable is each
>>> sub driver, not core module.
>>>
>>>> 3) Such approach leads to complete integration of all Exynos DRM drivers,
>>>> without possibility of loading some sub-drivers as modules. I know that
>>>> current driver design doesn't support it either, but if this series is
>>>
>>> No, current drm driver *must also be built* as one integrated single
>>> drm driver without super device approach.
>>
>> As I wrote, I know that current design before this patch isn't modular
>> either, but this is not my concern here. See below.
>>
>>
>>> So the super device approach
>>> *has no any effect on existing design*,  and what the super device
>>> approch tries to do is to resolve the probe order issue to sub drivers
>>> *without some codes specific to Exynos drm*.
>>
>> My concern is that the supernode design is actually carving such broken
>> non-modular design in stone. Remember that we are currently heading towards
>> a fully multi-platform kernel where it is critical for such subsystems to be
>> modular, because the same zImage is going to be running on completely
>> different machines.
>>
>>
>>>> claimed to improve things, it should really do so.
>>>>
>>>> 4) Exactly the same can be achieved without changing the DT bindings at
>>>> all.
>>>> In fact even without adding any new single property or node to DT. We
>>>> discussed this with Andrzej and Marek today and came to a solution in
>>>> which
>>>> just by adding a little bit of code to Exynos DRM subdrivers, you could
>>>> guarantee correct registration of Exynos DRM platform and also get rid of
>>>> #ifdeffery in exynos_drm_drv.c. Andrzej will send an RFC after the
>>>> weekend.
>>>
>>> I'm not sure but I had implemented below prototype codes for that, see
>>> the below link,
>>>
>>> https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/commit/?h=exynos-bridge-test&id=2860ad02d736e300034ddeabce3da92614922b4e
>>>
>>> I guess what you said would be similler approach.
>>
>> Not exactly. The approach we found does mostly the same as componentized
>> subsystem framework but without _any_ extra data in Device Tree. Just based
>> on the list of subsystem sub-drivers that is already available to the master
>> driver.

I am not so sure which approach is better, anyway I hope to post RFC soon,
as some material for discussion.

>>
>>
>>> And I still think the use of the component framework would be the best
>>> solution and *Linux generic way* for resolving the probe order issue
>>> without any specific codes. So I'm not advocating the compoent
>>> framework but I tend not to want to use specific codes.
>>>
>> I understand your concern. I also believe that generic frameworks should be
>> reused wherever possible. However the componentized subsystem framework is a
>> bit of overkill for this simple problem. Moreover, Device Tree is not a
>> trash can where any data that can be thought of can be thrown as you go, but
>> rather a hardware description that is supposed to be a stable ABI and needs
>> to be well-thought. So, if something can be done in a way that doesn't
>> require additional data, it's better to do it that way.
>>
>>
>>>> 5) This series seems to break DPI display support with runtime PM
>>>> enabled.
>>>> Universal C210 just hangs on second FIMD probe, after first one fails
>>>> with
>>>> probe deferral. This needs more investigation, though.

If we are talking about the same issue, it is a problem of panel
initialization sequence on some
panels. I will post fix for it.


Regards
Andrzej
