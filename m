From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 6 Jun 2017 15:08:19 -0700
Subject: [PATCH] clk: sunxi-ng: Move all clock types to a library
In-Reply-To: <CAK8P3a1Qvt4nvM5HeK-n87tsi2D5GBOmZo0rZv_Lp==CC=34Uw@mail.gmail.com>
References: <20170602223006.1653-1-sboyd@codeaurora.org>
 <201706031243.qNvuUbQX%fengguang.wu@intel.com>
 <20170605144546.b6oh5sygrza22hbe@flea.lan>
 <CAK8P3a1Qvt4nvM5HeK-n87tsi2D5GBOmZo0rZv_Lp==CC=34Uw@mail.gmail.com>
Message-ID: <20170606220819.GK20170@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06, Arnd Bergmann wrote:
> On Mon, Jun 5, 2017 at 4:45 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Sat, Jun 03, 2017 at 12:22:32PM +0800, kbuild test robot wrote:
> >> Hi Stephen,
> >>
> >> [auto build test ERROR on sunxi/sunxi/for-next]
> >> [also build test ERROR on next-20170602]
> >> [cannot apply to clk/clk-next v4.12-rc3]
> >> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >>
> >>    sunxi_sid.c:(.data+0x1da8c): undefined reference to `ccu_gate_ops'
> >>    sunxi_sid.c:(.data+0x1dac8): undefined reference to `ccu_gate_ops'
> >>    sunxi_sid.c:(.data+0x1db20): undefined reference to `ccu_mux_ops'
> >>    sunxi_sid.c:(.data+0x1db74): undefined reference to `ccu_mux_ops'
> >>    sunxi_sid.c:(.data+0x1dbec): undefined reference to `ccu_mp_ops'
> >>    sunxi_sid.c:(.data+0x1dc64): undefined reference to `ccu_mp_ops'
> >
> > It seems like even though the lib.a file is compiled properly, it is
> > never linked in. It looks like we would be supposed to add
> > drivers/clk/sunxi-ng/ to libs-y, but that doesn't seem to work for
> > Makefiles in drivers/*
> 
> Ah, too bad. I see that only one directory under drivers/ uses something
> with lib.a, in drivers/firmware/efi/libstub/Makefile, but that seems to
> rely on being special-cased as well.
> 
> However, this patch seems to fix it:
> 
> diff --git a/drivers/clk/sunxi-ng/Makefile b/drivers/clk/sunxi-ng/Makefile
> index cbc8cb4f70e3..321d3da7cc6a 100644
> --- a/drivers/clk/sunxi-ng/Makefile
> +++ b/drivers/clk/sunxi-ng/Makefile
> @@ -18,16 +18,16 @@ lib-$(CONFIG_SUNXI_CCU) += ccu_nm.o
>  lib-$(CONFIG_SUNXI_CCU) += ccu_mp.o
> 
>  # SoC support
> -obj-$(CONFIG_SUN50I_A64_CCU) += ccu-sun50i-a64.o
> -obj-$(CONFIG_SUN5I_CCU) += ccu-sun5i.o
> -obj-$(CONFIG_SUN6I_A31_CCU) += ccu-sun6i-a31.o
> -obj-$(CONFIG_SUN8I_A23_CCU) += ccu-sun8i-a23.o
> -obj-$(CONFIG_SUN8I_A33_CCU) += ccu-sun8i-a33.o
> -obj-$(CONFIG_SUN8I_A83T_CCU) += ccu-sun8i-a83t.o
> -obj-$(CONFIG_SUN8I_H3_CCU) += ccu-sun8i-h3.o
> -obj-$(CONFIG_SUN8I_V3S_CCU) += ccu-sun8i-v3s.o
> -obj-$(CONFIG_SUN8I_DE2_CCU) += ccu-sun8i-de2.o
> -obj-$(CONFIG_SUN8I_R_CCU) += ccu-sun8i-r.o
> -obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80.o
> -obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80-de.o
> -obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80-usb.o
> +obj-$(CONFIG_SUN50I_A64_CCU) += ccu-sun50i-a64.o lib.a
> +obj-$(CONFIG_SUN5I_CCU) += ccu-sun5i.o lib.a
> +obj-$(CONFIG_SUN6I_A31_CCU) += ccu-sun6i-a31.o lib.a
> +obj-$(CONFIG_SUN8I_A23_CCU) += ccu-sun8i-a23.o lib.a
> +obj-$(CONFIG_SUN8I_A33_CCU) += ccu-sun8i-a33.o lib.a
> +obj-$(CONFIG_SUN8I_A83T_CCU) += ccu-sun8i-a83t.o lib.a
> +obj-$(CONFIG_SUN8I_H3_CCU) += ccu-sun8i-h3.o lib.a
> +obj-$(CONFIG_SUN8I_V3S_CCU) += ccu-sun8i-v3s.o lib.a
> +obj-$(CONFIG_SUN8I_DE2_CCU) += ccu-sun8i-de2.o lib.a
> +obj-$(CONFIG_SUN8I_R_CCU) += ccu-sun8i-r.o lib.a
> +obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80.o lib.a
> +obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80-de.o lib.a
> +obj-$(CONFIG_SUN9I_A80_CCU) += ccu-sun9i-a80-usb.o lib.a
> 
> It's not documented behavior, but I think it's still good enough,
> and improves the current version, unless there is another bug
> after we add this to your patch.

We should add a comment above this so we know what the lib.a is
all about. As you say, it's not documented.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
