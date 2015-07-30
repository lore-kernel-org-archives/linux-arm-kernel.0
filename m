From: robherring2@gmail.com (Rob Herring)
Date: Wed, 29 Jul 2015 22:06:02 -0500
Subject: [PATCH v2 0/22] On-demand device probing
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <CAL_Jsq+2q=c6JbER8EMOGFtR=a6gvHermb8DRo9dKyj6fvdnXg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 8:19 AM, Tomeu Vizoso
<tomeu.vizoso@collabora.com> wrote:
> Hello,
>
> I have a problem with the panel on my Tegra Chromebook taking longer
> than expected to be ready during boot (St?phane Marchesin reported what
> is basically the same issue in [0]), and have looked into ordered
> probing as a better way of solving this than moving nodes around in the
> DT or playing with initcall levels and linking order.
>
> While reading the thread [1] that Alexander Holler started with his
> series to make probing order deterministic, it occurred to me that it
> should be possible to achieve the same by probing devices as they are
> referenced by other devices.
>
> This basically reuses the information that is already implicit in the
> probe() implementations, saving us from refactoring existing drivers or
> adding information to DTBs.
>
> During review of v1 of this series Linus Walleij suggested that it
> should be the device driver core to make sure that dependencies are
> ready before probing a device. I gave this idea a try [2] but Mark Brown
> pointed out to the logic duplication between the resource acquisition
> and dependency discovery code paths (though I think it's fairly minor).
>
> To address that code duplication I experimented with Arnd's devm_probe
> [3] concept of having drivers declare their dependencies instead of
> acquiring them during probe, and while it worked [4], I don't think we
> end up winning anything when compared to just probing devices on-demand
> from resource getters.
>
> One remaining objection is to the "sprinkling" of calls to
> fwnode_ensure_device() in the resource getters of each subsystem, but I
> think it's the right thing to do given that the storage of resources is
> currently subsystem-specific.

Seems like a minor change to me.

> We could avoid the above by moving resource storage into the core, but I
> don't think there's a compelling case for that.
>
> I have tested this on boards with Tegra, iMX.6, Exynos and OMAP SoCs,
> and these patches were enough to eliminate all the deferred probes
> (except one in PandaBoard because omap_dma_system doesn't have a
> firmware node as of yet).
>
> With this series I get the kernel to output to the panel in 0.5s,
> instead of 2.8s.

Generally, I think this looks pretty good. It is simple and the error
path is simply falling back to deferred probe.

One overall comment is I'm not so sure if fwnode_ensure_device
shouldn't just be of_ensure_device. At least currently, it looks like
all the calling locations are DT specific functions anyway. There's
very little logic within the function to really benefit sharing with
ACPI. It is basically just a call to of_platform_device_find and then
bus_probe_device. I expect the get functions will always call into
DT/ACPI specific functions which can then call the firmware specific
device find function.

Rob
