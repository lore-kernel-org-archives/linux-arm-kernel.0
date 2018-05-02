From: robh@kernel.org (Rob Herring)
Date: Wed, 2 May 2018 09:48:52 -0500
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
References: <20180501213114.20183-1-robh@kernel.org>
 <f808a652-2454-941c-2fd1-60776fb353f6@arm.com>
Message-ID: <CAL_JsqJvMyrKS4LsRC6fDus24Yg8U+VcrbNNvxtOXmKbrc8RAA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2018 at 6:40 AM, Robin Murphy <robin.murphy@arm.com> wrote:
> On 01/05/18 22:31, Rob Herring wrote:
>>
>> Deferred probe will currently wait forever on dependent devices to probe,
>> but sometimes a driver will never exist. It's also not always critical for
>> a driver to exist. Platforms can rely on default configuration from the
>> bootloader or reset defaults for things such as pinctrl and power domains.
>> This is often the case with initial platform support until various drivers
>> get enabled. There's at least 2 scenarios where deferred probe can render
>> a platform broken. Both involve using a DT which has more devices and
>> dependencies than the kernel supports. The 1st case is a driver may be
>> disabled in the kernel config. The 2nd case is the kernel version may
>> simply not have the dependent driver. This can happen if using a newer DT
>> (provided by firmware perhaps) with a stable kernel version.
>>
>> Unfortunately, this change breaks with modules as we have no way of
>> knowing when modules are done loading. One possibility is to make this
>> opt in or out based on compatible strings rather than at a subsystem
>> level.
>> Ideally this information could be extracted automatically somehow. OTOH,
>> maybe the lists are pretty small. There's only a handful of subsystems
>> that can be optional, and then only so many drivers in those that can be
>> modules (at least for pinctrl, many drivers are built-in only).
>
>
> Ooh, this is exactly what I wanted for of_iommu_xlate(), and would be much
> nicer than the current bodge using system_state that I ended up with. The
> context there is very similar - if the device has a parent IOMMU then we
> want to wait for that to probe first if possible, but with a deadline such
> that if it doesn't show up then we can go ahead and make progress without it
> (on the assumption that DMA ops can fall back to CMA). The modules problem
> doesn't currently apply to IOMMU drivers either, although we do use a
> special of_device_id table for detecting built-in drivers via
> OF_IOMMU_DECLARE() to avoid deferring at all when we know it would be
> pointless - a more generic solution for that could certainly be useful too.

Ah, so you kept the IOMMU_OF_DECLARE() but it does nothing but define
a table. We already have the driver match table which should pretty
much be the same data, so it would be better if we could use that if
possible. If we used MODULE_DEVICE_TABLE somehow, we could avoid
modifying lots of drivers. Though many built-in only drivers omit
that. The other problem is it would become a large set of tables to
search thru because it is global. That would probably end up slower
than just deferring. So we need something like
<subsystem>_DEVICE_TABLE() to have per subsystem tables. Then this
function in this patch would need to be told which table to use.
However, this is all really just an optimization to avoid deferring at
all and could be addressed later. Is there any data on how much time
you save avoiding deferring? This has come up in the past and I don't
think it is much.

I've also been thinking about if we could use MODULE_DEVICE_TABLE to
provide a list compatible strings from modules as a whitelist of
devices to keep deferring probe on. That would require building
modules to build the kernel which I don't think would work. I think my
conclusion is that the cases we care about may be short enough to just
manually maintain such a list.

>
> I agree with Greg that the naming here is a bit tricky - FWIW my initial
> thought would be something like driver_defer_until_init(), which is still
> clunky but at least imperative.

Yeah, I didn't give it much thought as I expected more comments on the
general idea... Maybe my poor naming is a good diversion. :)

Rob
