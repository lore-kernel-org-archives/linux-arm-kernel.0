From: drake@endlessm.com (Daniel Drake)
Date: Wed, 25 Jun 2014 10:58:53 +0100
Subject: [PATCH 3/6] clk: samsung: exynos4: Remove SRC_MASK_ISP gates
In-Reply-To: <1403618235-19353-4-git-send-email-t.figa@samsung.com>
References: <1403618235-19353-1-git-send-email-t.figa@samsung.com>
 <1403618235-19353-4-git-send-email-t.figa@samsung.com>
Message-ID: <CAD8Lp45a0kQocSFVeXGY99jE+Rx7PVwv6ZZKbE8iFp7G4=X12A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,

On Tue, Jun 24, 2014 at 2:57 PM, Tomasz Figa <t.figa@samsung.com> wrote:
> ISP special clocks have dedicated gating registers and so MUX SRC_MASK
> register should not be used. This patch fixes the problem of
> Exynos4x12-based boards freezing on system suspend, because those
> mux outputs need not to be masked while suspending.

Not sure if you will be interested in this, as your plate must be
pretty full already, and I am probably the first person to try
suspend/resume on ODROID, but:

ODROID-U2 fails to suspend/resume. I am testing with rtcwake, trying
to raise a wakeup alarm on the internal Exynos4412 RTC. For this,
CONFIG_COMMON_CLK_MAX77686 must be disabled (otherwise it disables the
upstream 32KHz clock source for the RTC), I also have
CONFIG_RTC_DRV_MAX77686 disabled so that there is only one RTC to
worry about.

Then:
 rtcwake --utc -m mem -s 10 -v

Before this patch, it would totally hang after calling cpu_suspend()
(checked with S3C_PMDBG) - not sure if it hangs before sleeping, or if
it sleeps but simply fails to wake up.

With this patch, now it seems like the RTC alarm does wake up the
system after the desired time, however it immediately goes back into
uboot rather than resuming into Linux. So this patch does make some
progress at least.

The power light is on at all times during these tests (not sure if
that means anything, but I was wondering if it should go out when the
system suspends).

Thanks
Daniel
