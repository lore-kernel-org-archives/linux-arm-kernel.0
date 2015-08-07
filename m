From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 7 Aug 2015 08:55:45 +0200
Subject: [PATCH v3 0/18] On-demand device probing
In-Reply-To: <CAL_JsqKq_-TLb_3VRMN_MhjsGnRfpRN1uuEgHE9DAyP3Y3ovhQ@mail.gmail.com>
References: <1438870315-18689-1-git-send-email-tomeu.vizoso@collabora.com>
 <CAL_JsqKq_-TLb_3VRMN_MhjsGnRfpRN1uuEgHE9DAyP3Y3ovhQ@mail.gmail.com>
Message-ID: <CAAObsKDAMgsVbzvgofbktKAbdgO+iwdXZwSo8AauTVJdaN3TsA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 August 2015 at 22:14, Rob Herring <robherring2@gmail.com> wrote:
> On Thu, Aug 6, 2015 at 9:11 AM, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> Hello,
>>
>> I have a problem with the panel on my Tegra Chromebook taking longer
>> than expected to be ready during boot (St?phane Marchesin reported what
>> is basically the same issue in [0]), and have looked into ordered
>> probing as a better way of solving this than moving nodes around in the
>> DT or playing with initcall levels and linking order.
>>
>> While reading the thread [1] that Alexander Holler started with his
>> series to make probing order deterministic, it occurred to me that it
>> should be possible to achieve the same by probing devices as they are
>> referenced by other devices.
>>
>> This basically reuses the information that is already implicit in the
>> probe() implementations, saving us from refactoring existing drivers or
>> adding information to DTBs.
>>
>> During review of v1 of this series Linus Walleij suggested that it
>> should be the device driver core to make sure that dependencies are
>> ready before probing a device. I gave this idea a try [2] but Mark Brown
>> pointed out to the logic duplication between the resource acquisition
>> and dependency discovery code paths (though I think it's fairly minor).
>>
>> To address that code duplication I experimented with Arnd's devm_probe
>> [3] concept of having drivers declare their dependencies instead of
>> acquiring them during probe, and while it worked [4], I don't think we
>> end up winning anything when compared to just probing devices on-demand
>> from resource getters.
>>
>> One remaining objection is to the "sprinkling" of calls to
>> fwnode_ensure_device() in the resource getters of each subsystem, but I
>> think it's the right thing to do given that the storage of resources is
>> currently subsystem-specific.
>>
>> We could avoid the above by moving resource storage into the core, but I
>> don't think there's a compelling case for that.
>>
>> I have tested this on boards with Tegra, iMX.6, Exynos and OMAP SoCs,
>> and these patches were enough to eliminate all the deferred probes
>> (except one in PandaBoard because omap_dma_system doesn't have a
>> firmware node as of yet).
>>
>> Have submitted a branch [5] with these patches to kernelci.org and I'm
>> currently trying to fix all regressions, usually due to code assuming
>> that devices will be probed in a specific order. Current results [6] are
>> 348 passes, 30 fails and 42 unknowns (linux-next [7] is currently
>> 387/3/23).
>
> This is a bit worrying. If this causes a high number of boot failures,
> fixing the errors you can find is not the path forward as we can't
> test a lot of platforms (and many people don't look at -next). We may
> want to put this behind a kconfig option so that we can easily restore
> old behavior it needed. Otherwise, we could have to revert the series.

A Kconfig sounds fine to me. Altogether, I don't think it's that bad
because only these boards are known to have broken because of this
series:

at91-sama5d3_xplained
sama5d35ek

ste-snowball

vexpress-v2p-ca15
vexpress-v2p-ca15
vexpress-v2p-ca15_a7
vexpress-v2p-ca15-tc1
vexpress-v2p-ca9

I assume there's only 3 different bugs to fix there, plus a race in
imx boards that I have only papered over with a delay so far.

The failure rate seems to be so high because each boot is a
combination of board+defconfig and there are duplicated boards in
several labs and many were just offline at that moment.

But I agree that there's no way I can test it on all supported hw, so
a Kconfig that people can quickly switch on to disable the feature
sounds good to me.

> Are all the commits before this series fixing boot failures? You can't
> do dts updates as the fix or backwards compatibility will be broken.

The gpio-ranges fix for Tegra has a commit that safeguards backwards
compatibility, and the typo in regulator names for ux500 doesn't
really break anything that I can see, I just stumped into it when
trying to blindly fix the boot for ste-snowball (I don't have access
to that hw).

>> With this series I get the kernel to output to the panel in 0.5s,
>> instead of 2.8s.
>>
>> Regards,
>>
>> Tomeu
>>
>> [0] http://lists.freedesktop.org/archives/dri-devel/2014-August/066527.html
>>
>> [1] https://lkml.org/lkml/2014/5/12/452
>>
>> [2] https://lkml.org/lkml/2015/6/17/305
>>
>> [3] http://article.gmane.org/gmane.linux.ports.arm.kernel/277689
>>
>> [4] https://lkml.org/lkml/2015/7/21/441a
>>
>> [5] https://git.collabora.com/cgit/user/tomeu/linux.git/log/?h=on-demand-probes-v5
>>
>> [6] http://kernelci.org/boot/all/job/collabora/kernel/v4.2-rc5-6548-g632b98c83840/
>>
>> [7] http://kernelci.org/boot/all/job/next/kernel/next-20150806/
>>
>> Changes in v3:
>> - Only delay platform devices with OF nodes
>> - Set and use device_node.platform_dev instead of reversing the logic to
>>   find the platform device that encloses a device node.
>
> I still want this to be a struct device and not a struct
> platform_device and am not convinced it can't be. It can simply be an
> optimization of the existing function:

Now I realize what you meant, that makes sense to me.

Thanks,

Tomeu

> struct platform_device *of_find_device_by_node(struct device_node *np)
> {
>   if (node->device && node->device->bus == &platform_bus_type)
>     return to_platform_device(node->device);
>   return NULL;
> }
>
> Rob
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
