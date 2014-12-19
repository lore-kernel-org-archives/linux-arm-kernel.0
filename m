From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 19 Dec 2014 08:59:53 +0100
Subject: Enable runtime PM automatically?
In-Reply-To: <7hppbg63zo.fsf@deeprootsystems.com>
References: <CAMuHMdWY_ne+S3zKrEYqVyU8=S-at=+rGuEkYNauF4s2KaKNdw@mail.gmail.com>
 <7hppbg63zo.fsf@deeprootsystems.com>
Message-ID: <CAMuHMdWmy82=cnoSVD3gdEu=5Ttr1j-PJv6EXKYwbR3o_FEDiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

Thanks for your comments!

On Thu, Dec 18, 2014 at 10:29 PM, Kevin Hilman <khilman@kernel.org> wrote:
>> However, if PM domains are active, drivers must be runtime PM-aware for the
>> gpd_dev_ops.start() method to be called in the first place (perhaps this is just
>> one bug that's easy to fix --- the device is "assumed suspended", but can be
>> used). They must
>>   1. call pm_runtime_enable() to enable runtime PM for the device,
>>   2. call pm_runtime_get_sync() to prevent the device from being put in a
>>     low-power state at any time. This second call has the
>> "side-effect" of calling
>>     gpd_dev_ops.start().
>>
>> Hence, if PM domains are enabled, wouldn't it make sense to
>>   1. enable runtime PM by default, for all devices (bound and unbound),
>>   2. call pm_runtime_get_sync(), for all devices bound to a driver.
>> Of course we have to keep track if drivers call any of the pm_runtime_*()
>> methods theirselves, as that would have to move them from automatic to
>> manual mode.
>>
>> Would this be feasible?
>
> We have to be careful about where the PM core's _get_sync() call goes.
>
> Because you're talking about "bound" devices, I guess you mean after the
> driver probes?  Otherwise, it gets tricky if the _get_sync() is before
> the driver probes, because the device driver may have work it wants to
> do in its runtime PM callbacks, which are not initialized/available
> before the driver probes.  Doing this before probe also makes it rather
> difficult to know for sure the actual physical state of the device, and
> make sure it matches the runtime PM state of the device.  Rafael
> mentioned this also, and I'm not sure how we can be sure of the physical
> state.

Yes, it's complicated by the fact that there are multiple sets of callbacks
(PM domain, device type, class type, bus type, driver).
However, the PM domain one has the highest priority, and is always
(also for devices not bound to a driver) available.

> Some thoughts: devices without drivers would be runtime resumed by the
> core, but will never be suspended, so the PM domain will never shut
> down.  I guess the core will have to keep track of the devices it
> automatically runtime resumed and decide to runtime suspend them too?
> Hmm, where would that go?

No, devices without a driver just need to become runtime PM enabled.
They will only be resumed when a dependent device (e.g. a child) is resumed,
and are suspended again after all dependents are suspended. That's how
simple-pm-bus behaves.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
