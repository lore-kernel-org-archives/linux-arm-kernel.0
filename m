From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Jan 2017 13:04:44 +0100
Subject: [PATCH v5 3/8] ARM: dts: rockchip: add timer entries to rk3188 SoC
In-Reply-To: <A5940770-B960-4409-8DA4-BE39EF9A6325@gmail.com>
References: <1485260203-14216-1-git-send-email-al.kochet@gmail.com>
 <1485260203-14216-4-git-send-email-al.kochet@gmail.com>
 <20170130110428.GC2206@mai>
 <A5940770-B960-4409-8DA4-BE39EF9A6325@gmail.com>
Message-ID: <20170130120444.GE2206@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2017 at 02:20:13PM +0300, Alexander Kochetkov wrote:
> 
> > 30 ???. 2017 ?., ? 14:04, Daniel Lezcano <daniel.lezcano@linaro.org> ???????(?):
> > 
> > t is up to the RTC to wake up the system from suspend and there is no
> > idle state stopping the local timers on these SoCs. So, the rockchip timers
> > won't be ever used on the rk3188, right ?
> 
> No rockchip timers where used on rk3188 before.
> 
> Actually, I don?t know how to test backup timer functionality. rk3228 backup timer is from alive
> subsystem. It is unclear from TRM what this mean, 

It means it is on an always-on power domain, so it will be always powered even
in suspend mode.

There are different clockevents on the SoC, the local timers (smp_twd) and the
rockchip timer. They are not used together, the local timers will be used as
default because they are per cpu. So the rockchip timer is not used in this case.

Then there is the situation when the cpu is powered down, the local timers,
which belongs to the same power domain, will be powered down also. If there is a
timer set for this CPU, an alternate, backup timer must be used, and that is the
rockchip timer. However this situation happens:

 - when a CPU is offlined. But the timers are moved to another CPU.
 - when the CPU enters a deep idle state. But such state does not exist on rk3188
 - when the system goes to suspend. But the timers are stopped in any case and
   CPU0 is always on.

There is no case when the rockchip timer is used for the clockevent.

If I'm not wrong, you can check /proc/interrupts and see there is no interrupt
on the rockchip timer.

So the board is typically a case where we want to use a clocksource from one IP
and the clockevents from another IP (just looping back with the clkevt macro
patch I answered a few minutes ago).

That does not call in question this patch as it describes the hardware.

> I assume that somehow related to CLK
> during suspend. So I pick the timer from alive subsystem on rk3188 also.
> DT timer configuration where tested: interrupts and IO works.
> 
> > This patch should go after the rockchip timer patches
> 
> 
> Ok, let me know, when I should send v6. Or may be you change the order of the patches
> during merge.

I have to review the last 3 patches of the series. I will let you know for a V6.

Thanks.

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
