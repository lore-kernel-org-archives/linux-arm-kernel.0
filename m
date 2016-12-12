From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 12 Dec 2016 12:41:21 +0800
Subject: [linux-sunxi] sunxi-ng clocks: leaving certain clocks alone?
In-Reply-To: <d70f2809-102c-a3de-c77c-43af27bbcbbc@arm.com>
References: <d70f2809-102c-a3de-c77c-43af27bbcbbc@arm.com>
Message-ID: <CAGb2v67kCAr6Ty5=Gg8vOGNC6xhuRM66Wa=H+C3AD=_d_H+N8w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2016 at 7:54 AM, Andr? Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> I was observing that the new sunxi-ng clock code apparently explicitly
> turns off _all_ clocks that are not used or needed. I find this rather
> unfortunate, as I wanted to use the THS temperature sensor from ARM
> Trusted Firmware to implement emergency shutdown or DVFS throttling.
> That works until the clock framework finds the clock (as enumerated in
> ccu-sun50i-a64.c) and obviously explicitly clears bit 31 in the THS mod
> clock register and bit 8 in the respective clock gate register.
> Turning them manually back on via /dev/mem or removing the THS clock
> from the sunxi-ng driver fixes this for me.
>
> This was not happening with the old Allwinner clocks, since the kernel
> wouldn't even know about it if there was no driver and the clock wasn't
> mentioned in the DT.
>
> Now with sunxi-ng even though the THS clock is not actually referenced
> or used in the DT, the kernel turns it off. I would expect that upon
> entering the kernel all unneeded clocks are turned off anyway, so there
> is no need to mess with clocks that have no user, but are enumerated in
> the ccu driver.

I can't say that's absolutely true (wink).

>
> I wonder if this kills simplefb as well, for instance, since I believe
> that U-Boot needs to turn on certain clocks and relies on them staying up.

The simplefb bindings takes clocks and regulators expressly for the
purpose of keeping them enabled.

>
> So my questions:
> 1) Is this expected behaviour?

Yes.

> 2) If yes, should it really be?
> 3) If yes, shouldn't there be way to explicitly tell Linux to leave that
> clock alone, preferably via DT? Although the sunxi-ng clocks take
> control over the whole CCU unit, I wonder if it should really mess with
> clocks there are not referenced in the DT.

As it owns the whole CCU unit, why not? And how would it know if some
clock is referenced or not, unless going through the whole device tree?

Furthermore, nothing prevents another device driver from referencing
said clock and turning it off when it's not in use. Think THS driver
with runtime PM.

Are you also mapping the THS to secure only? Otherwise nothing would
prevent Linux from also claiming it.

>
> Maybe there is some way to reference those clocks via some dummy driver
> or DT node to avoid this behaviour? Is there any prior art in this respect?

If you want a clock to not be disabled by anyone, adding CLK_IS_CRITICAL
to its flags is the proper option. This is done in the clk driver though.

If you just don't want the clk subsystem to disable unused clks at boot
time, you can add "clk_ignore_unused" to the kernel boot parameters.
I think this is more of a hack and debugging tool though.

About dummy drivers, simplefb comes to mind again. But simplefb disables
them when it gets kicked out by the drm driver. Maybe there are other
examples.

Regards
ChenYu

> I think this issue will affect more future users (thinking of EFI RTC,
> EFI graphics, etc.), so I wanted to start a discussion on this.
>
> Any input welcome.
>
> Cheers,
> Andre.
>
> P.S. For reference my use case: ARM Trusted Firmware (ATF) enables the
> temperature sensor (THS) and programs a shutdown value. It programs the
> respective interrupt as secure and registers an IRQ handler in ATF to
> shutdown the system or take other appropriate matters to avoid
> overheating. Additionally the sensor is exported via the generic SCPI
> interface, so the existing scpi-hwmon driver picks it up and reports it
> to whoever is interested in Linux land via the normal interfaces.
>
> --
> You received this message because you are subscribed to the Google Groups "linux-sunxi" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
