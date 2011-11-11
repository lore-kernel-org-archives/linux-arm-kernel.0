From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Fri, 11 Nov 2011 16:33:41 +0900
Subject: [PATCH 1/4] ARM: exynos4: Add support for AFTR mode cpuidle state
In-Reply-To: <1320426228-21746-2-git-send-email-amit.kachhap@linaro.org>
References: <1320426228-21746-1-git-send-email-amit.kachhap@linaro.org>
 <1320426228-21746-2-git-send-email-amit.kachhap@linaro.org>
Message-ID: <CAJ0PZbTzFDvom3PoPXEvhC8JE_mV3wfYMspnQdRLO=-oz5wGkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 5, 2011 at 2:03 AM,  <amit.kachhap@linaro.org> wrote:
> From: Amit Daniel Kachhap <amit.kachhap@linaro.org>
>
> This patch adds support for AFTR(ARM OFF TOP RUNNING) mode in
> cpuidle driver for EXYNOS4210. L2 cache keeps their data in this mode.
> This patch ports the code to the latest interfaces to
> save/restore CPU state inclusive of CPU PM notifiers, l2
> resume and cpu_suspend/resume.
>
> Signed-off-by: Jaecheol Lee <jc.lee@samsung.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Signed-off-by: Amit Daniel Kachhap <amit.kachhap@linaro.org>
> ---
[]
> +#define REG_DIRECTGO_ADDR      (samsung_rev() == EXYNOS4210_REV_1_1 ? \
> +                               S5P_INFORM7 : (S5P_VA_SYSRAM + 0x24))
> +#define REG_DIRECTGO_FLAG      (samsung_rev() == EXYNOS4210_REV_1_1 ? \
> +                               S5P_INFORM6 : (S5P_VA_SYSRAM + 0x20))
>
[]
> +
> +       __raw_writel(BSYM(virt_to_phys(s3c_cpu_resume)),
> +                                                REG_DIRECTGO_ADDR);
> +       __raw_writel(0xfcba0d10, REG_DIRECTGO_FLAG);
> +
>        return 0;

Hello,


Why are you using INFORM6 and 7 registers in order to save resume
address and power-mode flags?

INFORM0 and 1 have been used in pm.c for the exactly same purpose.
Please use the same registers in cpuidle.c as well.

The same part in bootloader (IPL) can handle whether it's
suspend-to-RAM or AFTR and the both modes are mutually exclusive and
you only need one value for resume PC.

Therefore, you can keep the value at the same location, which is the
method we have been using.

Besides, the Exynos4210 chipmaker (S.LSI) has told that INFORM6 and 7
registers are used by in-chip code (iROM or iRAM).


Cheers!
MyungJoo



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
