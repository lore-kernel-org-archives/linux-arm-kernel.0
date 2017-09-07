From: liwei213@huawei.com (liwei (CM))
Date: Thu, 7 Sep 2017 06:34:19 +0000
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjMgMS81XSBzY3NpOiB1ZnM6IGFkZCBIaXNpbGlj?=
 =?utf-8?Q?on_ufs_driver_code?=
In-Reply-To: <CAK8P3a0vV94g=iNLfHXXgR-XFHaaK-mHoQQ45FDYG+FVQhix6Q@mail.gmail.com>
References: <20170829084116.106695-1-liwei213@huawei.com>
 <20170829084116.106695-2-liwei213@huawei.com>
 <CAK8P3a0vV94g=iNLfHXXgR-XFHaaK-mHoQQ45FDYG+FVQhix6Q@mail.gmail.com>
Message-ID: <1699CE87DE933F49876AD744B5DC140FA18C49@DGGEMM506-MBX.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Arnd

Thanks for your suggestions, I hope you'll reply again:


-----????-----
???: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] ?? Arnd Bergmann
????: 2017?9?7? 6:47
???: liwei (CM)
??: Rob Herring; Mark Rutland; xuwei (O); Catalin Marinas; Will Deacon; Vinayak Holikatti; James E.J. Bottomley; Martin K. Petersen; Kevin Hilman; Gregory CLEMENT; Thomas Petazzoni; Masahiro Yamada; Riku Voipio; Thierry Reding; Krzysztof Kozlowski; Eric Anholt; devicetree at vger.kernel.org; Linux Kernel Mailing List; Linux ARM; linux-scsi; Guodong Xu; Fengbaopeng (kevin, Kirin Solution Dept)
??: Re: [PATCH v3 1/5] scsi: ufs: add Hisilicon ufs driver code

On Tue, Aug 29, 2017 at 10:41 AM, Li Wei <liwei213@huawei.com> wrote:
itel(host, UFS_ARESET, PERRSTDIS3_OFFSET);
> +
> +       /* disable lp_reset_n */
> +       ufs_sys_ctrl_set_bits(host, BIT_SYSCTRL_LP_RESET_N, RESET_CTRL_EN);
> +       mdelay(1);
> +
> +       if (gpio_is_valid(host->reset_gpio))
> +               gpio_direction_output(host->reset_gpio, 1);
> +
> +       ufs_sys_ctrl_writel(host, MASK_UFS_DEVICE_RESET | BIT_UFS_DEVICE_RESET,
> +               UFS_DEVICE_RESET_CTRL);
> +
> +       mdelay(20);

Could those mdelay() be turned into msleep() functions?

I will fix it in patch v4.

> +static int ufs_hisi_get_resource(struct ufs_hisi_host *host) {
> +       struct resource *mem_res;
> +       struct device_node *np = NULL;
> +       struct device *dev = host->hba->dev;
> +       struct platform_device *pdev = to_platform_device(dev);
> +
> +       /* get resource of ufs sys ctrl */
> +       mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> +       host->ufs_sys_ctrl = devm_ioremap_resource(dev, mem_res);
> +       if (IS_ERR(host->ufs_sys_ctrl))
> +               return PTR_ERR(host->ufs_sys_ctrl);
> +
> +       np = of_find_compatible_node(NULL, NULL, 
> + "hisilicon,hi3660-crgctrl");

It's generally not a good idea to look up one device by its "compatible"
string. What is the "crgctrl"? Does it have a proper DT binding?
Maybe there should be a driver for it, or you could make it a "syscon"
device and look it up by phandle instead.

ok, crgctrl is our common register, if look up device by its "compatible" is not appropriate,
I will add a properties in ufs node, like this:
ufs: ufs at ff3b0000 {
			compatible = "jedec,ufs-1.1", "hisilicon,hi3660-ufs";
			/* 0: HCI standard */
			/* 1: UFS SYS CTRL */
			reg = <0x0 0xff3b0000 0x0 0x1000>,
				<0x0 0xff3b1000 0x0 0x1000>;
			interrupt-parent = <&gic>;
			interrupts = <GIC_SPI 278 IRQ_TYPE_LEVEL_HIGH>;
			clocks = <&crg_ctrl HI3660_CLK_GATE_UFSIO_REF>,
				<&crg_ctrl HI3660_CLK_GATE_UFSPHY_CFG>;
			clock-names = "clk_ref", "clk_phy";
			freq-table-hz = <0 0>, <0 0>;
+			/* offset: 0x84; bit: 12 */
+			/* offset: 0x84; bit: 7  */
+			resets = <&crg_rst 0x84 12>,
+				<&crg_rst 0x84 7>;
+			reset-names = "rst", "assert";
}
And find that by, is it OK?
+	host->rst = devm_reset_control_get(dev, "rst");
+	host->assert = devm_reset_control_get(dev, "assert");

> diff --git a/drivers/scsi/ufs/ufs-hisi.h b/drivers/scsi/ufs/ufs-hisi.h 
> new file mode 100644 index 000000000000..52430a2aca90
> --- /dev/null
> +++ b/drivers/scsi/ufs/ufs-hisi.h


If the header is only used in one file, you don't need it, just move
the definitions
into the other file.

Currently only one file use ufs-hisi.h, but I think so many definitions are defined in a .h file is more clearer, like ufs-qcom.h.
If you think it isn't necessary, I will move it into ufs-hisi.c?


      Arnd
