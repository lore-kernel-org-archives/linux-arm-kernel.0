From: rafael@kernel.org (Rafael J. Wysocki)
Date: Fri, 17 Jun 2016 14:54:56 +0200
Subject: [PATCH v2 02/10] driver core: Functional dependencies tracking
 support
In-Reply-To: <20160617103620.GA1626@wunner.de>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <1466144820-6286-3-git-send-email-m.szyprowski@samsung.com>
 <20160617103620.GA1626@wunner.de>
Message-ID: <CAJZ5v0h71xxvzex2D6s9W8Qvq3+BqOQnTJRKy32gMu=tuQLxDA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas@wunner.de> wrote:
> Hi Marek,
>
> On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
>> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
>>
>> Currently, there is a problem with handling cases where functional
>> dependencies between devices are involved.
>>
>> What I mean by a "functional dependency" is when the driver of device
>> B needs both device A and its driver to be present and functional to
>> be able to work.  This implies that the driver of A needs to be
>> working for B to be probed successfully and it cannot be unbound from
>> the device before the B's driver.  This also has certain consequences
>> for power management of these devices (suspend/resume and runtime PM
>> ordering).
>>
>> Add support for representing those functional dependencies between
>> devices to allow the driver core to track them and act on them in
>> certain cases where they matter.
>
> Rafael has indicated that he intends to respin this series:
> https://lkml.org/lkml/2016/6/8/1061

That's OK.

> We also have such a functional dependency for Thunderbolt on Macs:
> On resume from system sleep, the PCIe hotplug ports may not resume
> before the thunderbolt driver has reestablished the PCI tunnels.
> Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> in drivers/pci/quirks.c. It would be good if we could represent
> this dependency using something like Rafael's approach instead of
> open coding it, however one detail in Rafael's patches is problematic:
>
>> New links are added by calling device_link_add() which may happen
>> either before the consumer device is probed or when probing it, in
>> which case the caller needs to ensure that the driver of the
>> supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
>> flag should be passed to device_link_add() to reflect that.
>
> The thunderbolt driver cannot call device_link_add() before the
> PCIe hotplug ports are bound to a driver unless we amend portdrv
> to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> if the thunderbolt driver isn't loaded.
>
> It would therefore be beneficial if device_link_add() can be
> called even *after* the consumer is bound.

I don't quite follow.

Who's the provider and who's the consumer here?

Thanks,
Rafael
