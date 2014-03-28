From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Fri, 28 Mar 2014 13:51:27 +0100
Subject: *READ THIS IF YOUR SOC HAS A L2 CACHE* PL310 auxctrl settings
In-Reply-To: <20140318112221.GV21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140316152953.GX21483@n2100.arm.linux.org.uk>
 <CAL_JsqLDun2VkCFK9Fec6n38bNz2w9mscPdXcGYeLiZtiXkVDg@mail.gmail.com>
 <20140318112221.GV21483@n2100.arm.linux.org.uk>
Message-ID: <5335704F.4090502@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/18/2014 12:22 PM, Russell King - ARM Linux wrote:
> On Mon, Mar 17, 2014 at 09:00:03AM -0500, Rob Herring wrote:
>> On Sun, Mar 16, 2014 at 10:29 AM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>>> static struct l2x0_aux prima2_l2x0_aux __initconst = {
>>>          .val = 2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT,
>>>          .mask = 0,
>>> };
>>>
>>> static struct l2x0_aux marco_l2x0_aux __initconst = {
>>>          .val = (2 << L2X0_AUX_CTRL_WAY_SIZE_SHIFT) |
>>>                  (1 << L2X0_AUX_CTRL_ASSOCIATIVITY_SHIFT),
>>>          .mask = L2X0_AUX_CTRL_MASK,
>>
>> What I like about this is all the bits they are clearing and failing
>> to set. Shared override, prefetch, etc.
>
> It gets more fun when you see the full picture.  Here's a table of the
> auxctrl settings that everyone uses.  The "good" ones which leave the
> auxctrl register value alone are listed at the top.
>
>                                                          DT val      mask
> arch/arm/mach-bcm/board_bcm281xx.c:                     Y  00000000 ffffffff
> arch/arm/mach-highbank/highbank.c:                      Y  00000000 ffffffff
> arch/arm/mach-imx/mach-vf610.c:                         Y  00000000 ffffffff
> arch/arm/mach-imx/system.c:                             Y  00000000 ffffffff
> arch/arm/mach-mvebu/armada-370-xp.c:                    Y  00000000 ffffffff
> arch/arm/mach-rockchip/rockchip.c:                      Y  00000000 ffffffff
> arch/arm/mach-socfpga/socfpga.c:                        Y  00000000 ffffffff
> arch/arm/mach-berlin/berlin.c:                          Y  70c00000 feffffff
> arch/arm/mach-cns3xxx/core.c:                           N  00540000 fe000fff
> arch/arm/mach-exynos/common.c:                          Y  7c470001 c200ffff
> arch/arm/mach-imx/mm-imx3.c:                            N  00030024 00000000
> arch/arm/mach-nomadik/cpu-8815.c:                       Y  00730249 fe000fff
> arch/arm/mach-omap2/omap4-common.c:                     Y  aux_ctrl aux_mask
> arch/arm/mach-omap2/omap4-common.c:                     N  aux_ctrl aux_mask
> arch/arm/mach-prima2/l2x0.c:                            Y  aux->val aux->mask
> arch/arm/mach-realview/realview_pbx.c:                  N  02520000 c0000fff
> arch/arm/mach-realview/realview_pb1176.c:               N  00730000 fe000fff
> arch/arm/mach-realview/realview_eb.c:                   N  00790000 fe000fff
> arch/arm/mach-realview/realview_pb11mp.c:               N  00790000 fe000fff
> arch/arm/mach-shmobile/setup-r8a7779.c:                 N  40470000 82000fff
> arch/arm/mach-shmobile/board-kzm9g.c:                   N  40460000 82000fff
> arch/arm/mach-shmobile/board-kzm9g-reference.c:         N  40460000 82000fff
> arch/arm/mach-shmobile/board-armadillo800eva.c:         N  40440000 82000fff
> arch/arm/mach-shmobile/board-armadillo800eva-reference.c:N 40440000 82000fff
> arch/arm/mach-shmobile/setup-r8a7778.c:                 N  40470000 82000fff
> arch/arm/mach-spear/spear13xx.c:                        N  70a60001 fe00ffff
> arch/arm/mach-sti/board-dt.c:                           Y  30480000 c0000fff

For STiH416 SoC, the reset value of the AUX_CTRL register is 0x02000000.
So bits 19:17 = 0, whereas the expected value is bits 19:17 = 4.

IIRC, for the other STi SoCs, the reset value is the good one.

Note that on STi platforms, the kernel runs in Secure mode, so it can 
write this register directly, without having to issue SMC call.

Regards,
Maxime
