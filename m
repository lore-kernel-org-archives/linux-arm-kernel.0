From: govindraj.ti@gmail.com (Govindraj)
Date: Tue, 8 Mar 2011 17:14:29 +0530
Subject: [PATCH 2/7] OMAP2+: mux: Enable wakeup for wakeup enable
	requested pads
In-Reply-To: <87tyfi49cs.fsf@ti.com>
References: <1299064343-28534-1-git-send-email-govindraj.raja@ti.com>
	<87lj0u8mrf.fsf@ti.com> <87tyfi49cs.fsf@ti.com>
Message-ID: <AANLkTiknEQrqUt1-sY6-aDw4R5ZMP2uErSjRNB5Yex_v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Sat, Mar 5, 2011 at 7:27 AM, Kevin Hilman <khilman@ti.com> wrote:
> Kevin Hilman <khilman@ti.com> writes:
>
>> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
> [...]
>
>>> ?/* Assumes the calling function takes care of locking */
>>> ?void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>>> ?{
>>> @@ -342,6 +365,9 @@ void omap_hwmod_mux(struct omap_hwmod_mux_info *hmux, u8 state)
>>> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?break;
>>> ? ? ? ? ? ? ? ? ? ? ?flags &= ~OMAP_DEVICE_PAD_ENABLED;
>>> ? ? ? ? ? ? ? ? ? ? ?val = pad->idle;
>>> + ? ? ? ? ? ? ? ? ? ?if (flags & OMAP_DEVICE_PAD_WAKEUP)
>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ?val |= OMAP_WAKEUP_EN;
>>> +
>>
>> Is this needed on every idle transition?
>>
>> You're currently setting it on every idle transition, but never clearing
>> it. ?If it is to be a one-time thing, then move it to the early init of
>> the mux.
>
> Just to clarify...
>
> So as soon as the hwmod is first idled, IO-ring wakeups are enabled for
> any pads that have OMAP_DEVICE_PAD_WAKEUP.
>
> The problem here (compared with behavior of existing code) is that there
> is no provision for disabling IO-ring wakeups.
>
> For example, with current code, you can disable wakeups from userspace
> using the sysfs control file /sys/devices/.../power/wakeup, whose value
> can be checked using device_may_wakeup(), like current
> mach-omap2/serial.c code does.
>
> With this patch, IO-ring wakeups are always enabled, and never disabled.

I am reworking on this patch with new patch this will not have below two snip
changes and will be removed.

+                       if (flags & OMAP_DEVICE_PAD_WAKEUP)
+                               val |= OMAP_WAKEUP_EN;
+

and

+                       val |= omap_mux_read(pad->partition,
+                                               pad->mux->reg_offset);

some more changes I have added for default rx serial pad as below
[this will be done in patch 6/7]

+       {
+               .name   = "uart1_rx.uart1_rx",
+               .flags  = OMAP_DEVICE_PAD_REMUX | OMAP_DEVICE_PAD_WAKEUP,
+               .enable = OMAP_PIN_INPUT_PULLUP | OMAP_MUX_MODE0,
+               .idle   = OMAP_WAKEUP_EN,
+       },
+};


So with this change it will enable io-pad wakeup once we disable
clocks based on
.idle values and remux back to .enable values once we enable clocks back.
so io-pad wakeup for rx will be enabled only when I do put_sync.
[I verified this with lauterbach also]

I am not sure whether now we can control read/writes to pad_mux from any driver
interface and I think we have to go through mux framework for any
read/writes to mux.
with this I cant control pad wake up capabilities with sysfs as done
earlier in serial.c
now control to read/write to pad is outside scope of the driver
interface as omap_hwmod_mux
is the one that takes decision for driver with mux values provided
during omap_hwmod_mux_init.

--
Thanks,
Govindraj.R


>
> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-serial" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
