From: robh@kernel.org (Rob Herring)
Date: Mon, 7 May 2018 14:55:31 -0500
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <20180507183106.GF2259@tuxbook-pro>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
Message-ID: <CAL_Jsq+PRUR5rCeV820XZuQmQH3gD-X=6a5fNuF-9qVbq5dqFg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2018 at 1:31 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Tue 01 May 14:31 PDT 2018, Rob Herring wrote:
>
>> Deferred probe will currently wait forever on dependent devices to probe,
>> but sometimes a driver will never exist. It's also not always critical for
>> a driver to exist. Platforms can rely on default configuration from the
>> bootloader or reset defaults for things such as pinctrl and power domains.
>
> But how do you know if this is the case?

Because the platform worked before adding the dependency in the dts.

>> This is often the case with initial platform support until various drivers
>> get enabled.
>
> Can you please name platform that has enough support for Alexander to
> care about backwards and forwards compatibility but lacks a pinctrl
> driver.

Alex will have to answer that. I do agree pinctrl drivers shouldn't be
that hard because it is all just translating a bunch of pin data into
one-time (mostly) register writes, so it shouldn't take that long to
implement support. OTOH, maybe a pinctrl driver is low priority
because nothing needs it yet. Either a given board works with the
defaults and only some new board needs to change things or you don't
need pinctrl until low power modes are implemented. However, power
domains have the same problem and it can take years for those to get
proper support.

Alex proposed declaring dts files stable and then enforcing
compatibility after that point. If anyone believes that will work,
then please send a patch marking all the platforms in the kernel tree
that are stable.

>> There's at least 2 scenarios where deferred probe can render
>> a platform broken. Both involve using a DT which has more devices and
>> dependencies than the kernel supports. The 1st case is a driver may be
>> disabled in the kernel config.
>
> I agree that there is a chance that you _might_ get some parts of the
> system working by relying on the boot loader configuration, but
> misconfiguration issues applies to any other fundamental providers, such
> as clocks, regulators, power domains and gpios as well.

If it is only a chance, then perhaps we shouldn't allow things
upstream without proper drivers for all these things. That will only
give users the wrong impression.

>> The 2nd case is the kernel version may
>> simply not have the dependent driver. This can happen if using a newer DT
>> (provided by firmware perhaps) with a stable kernel version.
>>
>
> As above, this is in no way limited to pinctrl drivers.

Yes, I wasn't trying to imply that with this patch. I was just
starting with 1 example. IOMMUs (which essentially is already doing
what this patch does) and power domains are the main other 2. Clocks
is an obvious one too, but from the discussion I referenced that
problem is a bit different as platforms change from dummy fixed-clocks
to a real clock controller driver. That will need a different
solution.

>> Unfortunately, this change breaks with modules as we have no way of
>> knowing when modules are done loading. One possibility is to make this
>> opt in or out based on compatible strings rather than at a subsystem level.
>> Ideally this information could be extracted automatically somehow. OTOH,
>> maybe the lists are pretty small. There's only a handful of subsystems
>> that can be optional, and then only so many drivers in those that can be
>> modules (at least for pinctrl, many drivers are built-in only).
>>
>
> On the Qualcomm platform most drivers are tristate and on most platforms
> there are size restrictions in the proprietary boot loader preventing us
> from boot the kernel after switching all these frameworks from tristate
> to bool (which feels like a more appropriate solution than your hack).

BTW, QCom platforms are almost the only ones with pinctrl drivers as
modules. They are also happen to be PIA to configure correctly for a
board.

However, I would like a solution that works with modules. It would be
nice to know when userspace finished processing all the coldplug
uevents. That would be sufficient to support modules. I researched
that a bit and it doesn't seem the kernel can tell when that has
happened.

>
>> Cc: Alexander Graf <agraf@suse.de>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>> This patch came out of a discussion on the ARM boot-architecture
>> list[1] about DT forwards and backwards compatibility issues. There are
>> issues with newer DTs breaking on older, stable kernels. Some of these
>> are difficult to solve, but cases of optional devices not having
>> kernel support should be solvable.
>>
>
> There are two cases here:
> 1) DT contains compatibles that isn't supported by the kernel. In this
> case the associated device will remain in the probe deferral list and
> user space won't know about the device.
>
> 2) DT contains compatibles known to the kernel but has new optional
> properties that makes things functional or works around hardware bugs.
>
>> I tested this on a RPi3 B with the pinctrl driver forced off. With this
>> change, the MMC/SD and UART drivers can function without the pinctrl
>> driver.
>>
>
> Cool, so what about graphics, audio, networking, usb and all the other
> things that people actually expect when they _use_ a distro?

I often care about none of those things. When I do, I'd rather boot to
a working console with those broken than have to debug why the kernel
panicked.

>> [1] https://lists.linaro.org/pipermail/boot-architecture/2018-April/000466.html
>>
>>  drivers/base/dd.c            | 16 ++++++++++++++++
>>  drivers/pinctrl/devicetree.c |  2 +-
>>  include/linux/device.h       |  2 ++
>>  3 files changed, 19 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
>> index c9f54089429b..5848808b9d7a 100644
>> --- a/drivers/base/dd.c
>> +++ b/drivers/base/dd.c
>> @@ -226,6 +226,15 @@ void device_unblock_probing(void)
>>       driver_deferred_probe_trigger();
>>  }
>>
>> +
>> +int driver_deferred_probe_optional(void)
>> +{
>> +     if (initcalls_done)
>> +             return -ENODEV;
>
> You forgot the humongous printout here that tells the users that we do
> not want any bug reports related hardware not working as expected after
> this point.

I assume you were joking, but I would happily add a WARN here. Spewing
new warnings while still booting is a better UX than just panicking.
Ideally, it would be once per missing dependency.

Rob
