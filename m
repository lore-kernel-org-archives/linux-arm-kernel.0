From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Fri, 10 Oct 2014 13:09:25 +0200
Subject: [PATCH v9 0/2] Adds PMU and S2R support for exynos5420
In-Reply-To: <7hh9zcluhg.fsf@deeprootsystems.com>
References: <1412673723-15551-1-git-send-email-vikas.sajjan@samsung.com>
 <7hiojuno9e.fsf@deeprootsystems.com>
 <CAM4voanoOV44EQveAeikp1P0bXCU8HHdX2XDi3jwLkfQOP0CNQ@mail.gmail.com>
 <CABxcv==V0vR2XXq5cKzbaqkCbtkqKgrhJotdPSM5K0uyNW968w@mail.gmail.com>
 <7hbnpknc98.fsf@deeprootsystems.com>
 <7hh9zcluhg.fsf@deeprootsystems.com>
Message-ID: <CABxcv=kRNgdzqsMFBQ5O7naQP6nOEdEo+QUTEnVqwLP2TC2NrQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On Fri, Oct 10, 2014 at 12:59 AM, Kevin Hilman <khilman@kernel.org> wrote:
> Kevin Hilman <khilman@kernel.org> writes:
>
> [...]
>
>> Trying $SUBJECT series on top of kukjin's for-next is working fine, but
>> I'm still not able to make it work on linux-next, with or without the
>> CLK_IGNORE_UNUSED patch.
>
> Nevermind, turns out I didn't apply the CLK_IGNORE_UNUSED PATCH.  If I
> actually apply it, I have it working on top of linux-next.  However, it
> seems to have some issues with the nonboot CPUs resuming:
>

Did you have this issue both on top of kukjin's for-next and
linux-next or only on the later?
Could you please share your tree so I can give a try on my each Pit?

> [   11.319833] Enabling non-boot CPUs ...
> [   12.319134] CPU1: failed to come online
> [   12.319235] Error taking CPU1 up: -5
> [   13.319137] CPU2: failed to come online
> [   13.319209] Error taking CPU2 up: -5
> [   14.319133] CPU3: failed to come online
> [   14.319224] Error taking CPU3 up: -5
>
> Are you guys seeing all the non-boot CPUs coming up?  They fail to come
> online, but the /sys/devices/.../cpu?/online reports that they are
> online, which means the next attempt to hotplug them will probably BUG().
>

Maybe a silly question but are you using the last version (v9) [0] of
Abhilash's "ARM: EXYNOS: Use MCPM call-backs to support S2R on
Exynos5420" patch?

I had the same issue than you when testing with his v8 version because
there was a mistake on rebasing where the CPU power down logic was in
exynos_cpu_power_up() instead of exynos_cpu_power_down().

> Also, If I turn off the switcher (enabled by default exynos_defconfig),
> resume still has problems bringing all the nonboot CPUs online, and then
> has a bunch of I2C errors[1].
>
> And one more..., if I try enabling CPUidle[1] with exynos_defconfig, S2R
> causes a reboot (seems to be on resume.)
>

I didn't try CPUidle and I don't remember seeing the I2C errors but
maybe I just didn't notice. I'll re-test and see if it behaves the
same on my Exynos5420 machine.

> Kevin
>
>
> [1]
> [   47.644273] cros-ec-spi spi2.0: EC failed to respond in time
> [   47.648535] cros-ec-spi spi2.0: spi transfer failed: -110
> [   47.653866] tps65090-charger tps65090-charger: tps65090_charger_isr(): Error in reading reg 0xa
>
> [2]
> CONFIG_CPU_IDLE=y
> CONFIG_ARM_BIG_LITTLE_CPUIDLE=y
> CONFIG_ARM_EXYNOS_CPUIDLE=n
>

Best regards,
Javier

[0]: http://www.spinics.net/lists/linux-samsung-soc/msg37647.html
