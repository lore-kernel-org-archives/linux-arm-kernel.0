From: caesar.upstream@gmail.com (Caesar Wang)
Date: Mon, 21 Nov 2016 10:55:25 +0800
Subject: [PATCH v2 3/9] arm64: dts: rockchip: add VOP and VOP iommu node
 for rk3399
In-Reply-To: <10151352.zSDKCnp23A@phil>
References: <1478697721-2323-1-git-send-email-wxt@rock-chips.com>
 <1478697721-2323-4-git-send-email-wxt@rock-chips.com>
 <10151352.zSDKCnp23A@phil>
Message-ID: <558a2302-39ec-35cb-c375-ae7f5a16006a@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2016?11?15? 00:05, Heiko Stuebner ??:
> Am Mittwoch, 9. November 2016, 21:21:55 CET schrieb Caesar Wang:
>> From: Mark Yao <mark.yao@rock-chips.com>
>>
>> Add the core display-subsystem node and the two display controllers
>> available on the rk3399.
>>
>> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
>> Signed-off-by: Yakir Yang <ykk@rock-chips.com>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> ---
>>
>> Changes in v2: None
>>
>>   arch/arm64/boot/dts/rockchip/rk3399.dtsi | 58
>> ++++++++++++++++++++++++++++++++ 1 file changed, 58 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> b/arch/arm64/boot/dts/rockchip/rk3399.dtsi index e5b5b3d..f1d289a 100644
>> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
>> @@ -1290,6 +1290,64 @@
>>   		status = "disabled";
>>   	};
>>
>> +	vopl: vop at ff8f0000 {
>> +		compatible = "rockchip,rk3399-vop-lit";
>> +		reg = <0x0 0xff8f0000 0x0 0x3efc>;
>> +		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
> we're usig 4 irq elements nowadays to accomodate the pmus for separate
> clusters, see
>
> https://git.kernel.org/cgit/linux/kernel/git/mmind/linux-rockchip.git/commit/?id=210bbd38bb88989ce19208f98e530ff0468f38bd
>
> Same for the edp node.

Ah!  Sorry.

>
> Also, sadly the rockchip drm seems to need some tweaks still, as I wasn't
> able to get any display output yet.
>
> To make the vop at least compile I needed to forward-port
> https://github.com/mmind/linux-rockchip/commit/05ad856e54fc1aa1939ad1057897036cedc7fb0b
> https://github.com/mmind/linux-rockchip/commit/0edb1f7e1ac77437a17d7966121ee6e10ab5db67
>
> [full branch is https://github.com/mmind/linux-rockchip/commits/tmp/testing_20161109 ]

Pls allow me to have a look at it and bring up with ChromeOs, the 
upstream maybe miss some patches for upstream. (DRM or IOMMU or ....)
I will resend the other patches if  I bring up and show display with 
upstream  on 
https://github.com/Caesar-github/rockchip/commits/rk3399/tmp-test

-Caesar
> but I'm not sure if I did that correctly yet and am also still seeing
> nothing on the display and get iommu errors when starting X11
>
>
> Heiko
>
>> +		clocks = <&cru ACLK_VOP1>, <&cru DCLK_VOP1>, <&cru HCLK_VOP1>;
>> +		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
>> +		resets = <&cru SRST_A_VOP1>, <&cru SRST_H_VOP1>, <&cru SRST_D_VOP1>;
>> +		reset-names = "axi", "ahb", "dclk";
>> +		iommus = <&vopl_mmu>;
>> +		status = "disabled";
>> +
>> +		vopl_out: port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +	};
>> +
>> +	vopl_mmu: iommu at ff8f3f00 {
>> +		compatible = "rockchip,iommu";
>> +		reg = <0x0 0xff8f3f00 0x0 0x100>;
>> +		interrupts = <GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "vopl_mmu";
>> +		#iommu-cells = <0>;
>> +		status = "disabled";
>> +	};
>> +
>> +	vopb: vop at ff900000 {
>> +		compatible = "rockchip,rk3399-vop-big";
>> +		reg = <0x0 0xff900000 0x0 0x3efc>;
>> +		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru ACLK_VOP0>, <&cru DCLK_VOP0>, <&cru HCLK_VOP0>;
>> +		clock-names = "aclk_vop", "dclk_vop", "hclk_vop";
>> +		resets = <&cru SRST_A_VOP0>, <&cru SRST_H_VOP0>, <&cru SRST_D_VOP0>;
>> +		reset-names = "axi", "ahb", "dclk";
>> +		iommus = <&vopb_mmu>;
>> +		status = "disabled";
>> +
>> +		vopb_out: port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +		};
>> +	};
>> +
>> +	vopb_mmu: iommu at ff903f00 {
>> +		compatible = "rockchip,iommu";
>> +		reg = <0x0 0xff903f00 0x0 0x100>;
>> +		interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-names = "vopb_mmu";
>> +		#iommu-cells = <0>;
>> +		status = "disabled";
>> +	};
>> +
>> +	display_subsystem: display-subsystem {
>> +		compatible = "rockchip,display-subsystem";
>> +		ports = <&vopl_out>, <&vopb_out>;
>> +		status = "disabled";
>> +	};
>> +
>>   	pinctrl: pinctrl {
>>   		compatible = "rockchip,rk3399-pinctrl";
>>   		rockchip,grf = <&grf>;
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
