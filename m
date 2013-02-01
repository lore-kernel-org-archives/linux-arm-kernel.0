From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 1 Feb 2013 12:35:30 +0530
Subject: [PATCH V2 1/6] pinctrl: pinctrl-single: use arch_initcall and
 module_exit
In-Reply-To: <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
References: <1359445134-13323-1-git-send-email-manishv.b@ti.com>
 <1359445134-13323-2-git-send-email-manishv.b@ti.com>
 <CACRpkdbf7TwrjfT2rhqQFGc3yh_Nt117RtzQO2y6g5Ddx5Ay_w@mail.gmail.com>
Message-ID: <510B693A.70807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/2013 4:29 PM, Linus Walleij wrote:
> On Tue, Jan 29, 2013 at 8:38 AM, Vishwanathrao Badarkhe, Manish
> <manishv.b@ti.com> wrote:
> 
>> Currently, I2C driver gets probed before pinctrl driver.
>> To achieve I2C pin muxing via pinctrl driver before I2C
>> probe get called, register pinctrl driver in arch_initcall.
>> Also, add module_exit to unregister pinctrl driver.
>>
>> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>
> 
> So your I2C driver is not returning -EPROBE_DEFER
> if it cannot find its pins?
> 
> Hm, well I can live with this, if Tony ACKs it.

FWIW, most of the other pinctrl drivers seem to be using arch_initcall() 
already.

$ grep -r arch_initcall drivers/pinctrl/*
drivers/pinctrl/pinctrl-at91.c:arch_initcall(at91_pinctrl_init);
drivers/pinctrl/pinctrl-coh901.c:arch_initcall(u300_gpio_init);
drivers/pinctrl/pinctrl-imx35.c:arch_initcall(imx35_pinctrl_init);
drivers/pinctrl/pinctrl-imx51.c:arch_initcall(imx51_pinctrl_init);
drivers/pinctrl/pinctrl-imx53.c:arch_initcall(imx53_pinctrl_init);
drivers/pinctrl/pinctrl-imx6q.c:arch_initcall(imx6q_pinctrl_init);
drivers/pinctrl/pinctrl-sirf.c:arch_initcall(sirfsoc_pinmux_init);
drivers/pinctrl/pinctrl-tegra20.c:arch_initcall(tegra20_pinctrl_init);
drivers/pinctrl/pinctrl-tegra30.c:arch_initcall(tegra30_pinctrl_init);
drivers/pinctrl/pinctrl-u300.c:arch_initcall(u300_pmx_init);
drivers/pinctrl/spear/pinctrl-spear300.c:arch_initcall(spear300_pinctrl_init);
drivers/pinctrl/spear/pinctrl-spear320.c:arch_initcall(spear320_pinctrl_init);
drivers/pinctrl/spear/pinctrl-spear310.c:arch_initcall(spear310_pinctrl_init);
drivers/pinctrl/spear/pinctrl-spear1340.c:arch_initcall(spear1340_pinctrl_init);
drivers/pinctrl/spear/pinctrl-spear1310.c:arch_initcall(spear1310_pinctrl_init);

Thanks,
Sekhar
