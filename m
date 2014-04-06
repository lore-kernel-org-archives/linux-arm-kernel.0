From: inki.dae@samsung.com (Inki Dae)
Date: Sun, 6 Apr 2014 12:15:51 +0900
Subject: [PATCH v2 1/7] drm/exynos: add super device support
In-Reply-To: <53403E42.1010403@gmail.com>
References: <1396355882-17010-1-git-send-email-inki.dae@samsung.com>
 <1396355882-17010-2-git-send-email-inki.dae@samsung.com>
 <533EB9C6.80302@samsung.com>
 <CAAQKjZPbzb+qvJA5y+Kco9BRv4j3iVatM_0bd+ugyuVZUbfFFg@mail.gmail.com>
 <53403E42.1010403@gmail.com>
Message-ID: <CAAQKjZP+RbkO0yVNEKgWWAkogx+p36HKwVyJ+4EjPHrSOarBwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'd be really happy if you gave me such opinions before pull request.

Anyway, below is my comments.

2014-04-06 2:32 GMT+09:00 Tomasz Figa <tomasz.figa@gmail.com>:
> [adding more people and MLs on Cc for further discussion]
>
>
> On 04.04.2014 17:44, Inki Dae wrote:
>>
>> 2014-04-04 22:55 GMT+09:00 Tomasz Figa <t.figa@samsung.com>:
>>>
>>> Hi Inki,
>>>
>>>
>>> On 01.04.2014 14:37, Inki Dae wrote:
>>>>
>>>>
>>>> This patch adds super device support to bind sub drivers
>>>> using device tree.
>>>>
>>>> For this, you should add a super device node to each machine dt files
>>>> like belows,
>>>>
>>>> In case of using MIPI-DSI,
>>>>          display-subsystem {
>>>>                  compatible = "samsung,exynos-display-subsystem";
>>>>                  ports = <&fimd>, <&dsi>;
>>>>          };
>>>>
>>>> In case of using DisplayPort,
>>>>          display-subsystem {
>>>>                  compatible = "samsung,exynos-display-subsystem";
>>>>                  ports = <&fimd>, <&dp>;
>>>>          };
>>>>
>>>> In case of using Parallel panel,
>>>>          display-subsystem {
>>>>                  compatible = "samsung,exynos-display-subsystem";
>>>>                  ports = <&fimd>;
>>>>          };
>>>>
>>>> And if you don't add connector device node to ports property,
>>>> default parallel panel driver, exynos_drm_dpi module, will be used.
>>>>
>>>> ports property can have the following device nodes,
>>>>          fimd, mixer, Image Enhancer, MIPI-DSI, eDP, LVDS Bridge, or
>>>> HDMI
>>>>
>>>> With this patch, we can resolve the probing order issue without
>>>> some global lists. So this patch also removes the unnecessary lists and
>>>> stuff related to these lists.
>>>
>>>
>>>
>>> I can see several problems with this approach:
>>>
>>> 1) It breaks compatibility with existing DT. After this patch it is no
>>> longer possible to use old device trees and get a working DRM. However,
>>> in
>>> my opinion, this requirement can be relaxed if we make sure that any
>>> users
>>> are properly converted.
>>>
>>> 2) What happens if in Kconfig you disable a driver for a component that
>>> is
>>
>>
>> I'm not sure what you meant but there wouldn't be no way that users
>> *cannot disable* the driver for a component. The driver would be
>> exynos_drm_drv, not separated module, and would always be built as
>> long as users want to use *exynos drm driver*.
>
>
> I think you don't understand what I mean. Let me show you an example:
>
> You have a board with a DSI panel and also a HDMI output. So you have a
> supernode pointing to FIMD, DSI and HDMI.
>
> Now, an user finds that he doesn't need HDMI in his system, so he turns off
> CONFIG_DRM_EXYNOS_HDMI. The supernode still points at hdmi node and Exynos
> DRM core will register it as a component, but HDMI driver is not available
> and will never probe, leading the whole Exynos DRM to never initialize. Is
> this a desired behavior?
>

Ok, now I understood. Your comment was not enough to me.

First of all, if I see component codes correctly then it seems your
misunderstanding. See the below comments,

>
>>
>>> listed in supernode? If I'm reading the code correctly, Exynos DRM will
>>> not
>>
>>
>> And the only case a component isn't added to the list is when users
>> disabled sub driver.
>
>
> See above.
>
> The code creating the list of components to wait for
> (exynos_drm_add_components()) doesn't seem to consider which sub-drivers are
> actually enabled in kernel config.
>

Are you sure?

exynos_drm_add_components() will try to attach components *added to
component_lists. And these components will be added by only
corresponding sub drivers to the component_lists and
master->components.

So in this case, if users disabled HDMI support then a commponent
object for HDMI sub driver doesn't exists in the component_lists and
master->components. This means that a component object for HDMI sub
driver *cannot be attached to master object*.

As a result, component_bind_add() will ignor component_bind call for
HDMI sub driver so HDMI driver will not be bounded. The only
components added by sub drivers will be bound, component->ops->bind().

For more understanding, it seems like you need to look into below codes,

static int exynos_drm_add_components(...)
{
        ...
        for (i == 0;; i++) {
                ...
                node = of_parse_phandle(np, "ports", i);
                ...
                ret = component_master_add_child(m, compare_of, node);
                ...
        }
}


And below codes,

int component_master_add_child(...)
{
        list_for_each_entry(c, &component_list, node) {
                if (c->master)
                        continue;

                if (compare(...)) {
                         component_attach_master(master, c);
                         ...
                }
        }
}

And below codes,

static void component_attach_master(master, c)
{
        c->master = master;
        list_add_tail(&c->master_node, &master->comonents);
}


As you can see above, the only components added to component_list can
be attached to master. And the important thing is that components can
be added by sub drivers to the component_list.

And below codes that actually tries to bind each sub drivers,

int component_bind_add(...)
{
        ....
        list_for_each_entry(c, &master->components, master_node) {
                   ret = component_bind(c, master, data);
                   ...
        }
        ...
}

The hdmi driver users disabled doesn't exist to master->components list.
How Exynos DRM cannot be initialized?

Of course, there may be my missing point, but I think I see them
correctly. Anyway I will test them tomorrow.

Thanks,
Inki Dae

>
>>> register, which is completely wrong. Users should be able to select which
>>> drivers should be compiled into their kernels.
>>
>>
>> So users are be able to select drivers they want to use, and will be
>> compiled correctly. So no, the only thing users can disable is each
>> sub driver, not core module.
>>
>>>
>>> 3) Such approach leads to complete integration of all Exynos DRM drivers,
>>> without possibility of loading some sub-drivers as modules. I know that
>>> current driver design doesn't support it either, but if this series is
>>
>>
>> No, current drm driver *must also be built* as one integrated single
>> drm driver without super device approach.
>
>
> As I wrote, I know that current design before this patch isn't modular
> either, but this is not my concern here. See below.
>
>
>> So the super device approach
>> *has no any effect on existing design*,  and what the super device
>> approch tries to do is to resolve the probe order issue to sub drivers
>> *without some codes specific to Exynos drm*.
>
>
> My concern is that the supernode design is actually carving such broken
> non-modular design in stone. Remember that we are currently heading towards
> a fully multi-platform kernel where it is critical for such subsystems to be
> modular, because the same zImage is going to be running on completely
> different machines.
>
>
>>
>>> claimed to improve things, it should really do so.
>>>
>>> 4) Exactly the same can be achieved without changing the DT bindings at
>>> all.
>>> In fact even without adding any new single property or node to DT. We
>>> discussed this with Andrzej and Marek today and came to a solution in
>>> which
>>> just by adding a little bit of code to Exynos DRM subdrivers, you could
>>> guarantee correct registration of Exynos DRM platform and also get rid of
>>> #ifdeffery in exynos_drm_drv.c. Andrzej will send an RFC after the
>>> weekend.
>>
>>
>> I'm not sure but I had implemented below prototype codes for that, see
>> the below link,
>>
>> https://git.kernel.org/cgit/linux/kernel/git/daeinki/drm-exynos.git/commit/?h=exynos-bridge-test&id=2860ad02d736e300034ddeabce3da92614922b4e
>>
>> I guess what you said would be similler approach.
>
>
> Not exactly. The approach we found does mostly the same as componentized
> subsystem framework but without _any_ extra data in Device Tree. Just based
> on the list of subsystem sub-drivers that is already available to the master
> driver.
>
>
>>
>> And I still think the use of the component framework would be the best
>> solution and *Linux generic way* for resolving the probe order issue
>> without any specific codes. So I'm not advocating the compoent
>> framework but I tend not to want to use specific codes.
>>
>
> I understand your concern. I also believe that generic frameworks should be
> reused wherever possible. However the componentized subsystem framework is a
> bit of overkill for this simple problem. Moreover, Device Tree is not a
> trash can where any data that can be thought of can be thrown as you go, but
> rather a hardware description that is supposed to be a stable ABI and needs
> to be well-thought. So, if something can be done in a way that doesn't
> require additional data, it's better to do it that way.
>
>
>>>
>>> 5) This series seems to break DPI display support with runtime PM
>>> enabled.
>>> Universal C210 just hangs on second FIMD probe, after first one fails
>>> with
>>> probe deferral. This needs more investigation, though.
>>
>>
>> For -next, I never expect that pm operations would be operated
>> perfactly. They are really not for product. Just adding new feature
>> and drivers to -next, and then fixing them while in RC. And RC process
>> would also be for it. Actually, I see pm interfaces of exynos_drm_dsi
>> driver leads to break a single driver model because pm operations
>> should be done at top level of exynos drm, and some codes Sean didn't
>> fix. So such things are in my fix-todo-list. I tend to accept new
>> features and drivers for -next as long as they have no big problem,
>> And that is my style I maintain.
>
>
> Unless it breaks so much that the system is unable to boot at all, which is
> the case. As I said, the system just hangs, like something would access
> hardware that is not properly initialized, e.g. without power domain or
> clocks enabled.
>
> Anyway, I don't agree that regressions are allowed in linux-next, especially
> if found before applying a patch. Linux-next is a tree in which patches that
> are supposed to be ready to be pulled by Linus should be pushed. Of course
> nobody can spot all the regressions before the patches hitting -next and
> that's fine, as -next is an integration _testing_ tree. However even if
> already in -next, regressions should be fixed ASAP to minimize the number of
> fix patches needed during -rc period.
>
>
> Best regards,
> Tomasz
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
