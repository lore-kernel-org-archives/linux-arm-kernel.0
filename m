From: heiko@sntech.de (Heiko Stuebner)
Date: Thu, 30 Jun 2016 23:57:39 +0200
Subject: [PATCH] arm64: dts: rockchip: add the power domain node for rk3399
In-Reply-To: <CAD=FV=Wg1vuBhcjFRj53t-E0sKoBH577RB7gHZ-rkJV5T7nyZw@mail.gmail.com>
References: <1467251760-14695-1-git-send-email-wxt@rock-chips.com>
 <CAD=FV=Wg1vuBhcjFRj53t-E0sKoBH577RB7gHZ-rkJV5T7nyZw@mail.gmail.com>
Message-ID: <2709691.LCsUme3dJo@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 30. Juni 2016, 14:49:41 schrieb Doug Anderson:
> Caesar,
> 
> On Wed, Jun 29, 2016 at 6:56 PM, Caesar Wang <wxt@rock-chips.com> wrote:
> > From: Elaine Zhang <zhangqing@rock-chips.com>
> > 
> > In order to meet low power requirements, a power management unit (PMU)
> > is
> > designed for controlling power resources in RK3399. The RK3399 PMU is
> > dedicated for managing the power of the whole chip.
> > 
> > 1. add pd node for RK3399 Soc
> > 2. create power domain tree
> > 3. add qos node for domain
> > 
> > From the DT/binds and driver can get more detail information:
> > The driver:
> > drivers/soc/rockchip/pm_domains.c
> > The document:
> > Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> > 
> > ---
> > 
> > Tested on vop and gpu devices added for next kernel.
> > PD:
> > localhost / # cat sys/kernel/debug/pm_genpd/pm_genpd_summary
> 
> Nit: can you put a "/" before "sys" here and elsewhere in your patches?
> 
> > domain                          status          slaves
> > /device                                             runtime status
> > ----------------------------------------------------------------------
> > pd_gpu                          on
> > /devices/platform/ff9a0000.gpu                      active
> > pd_vopl                         off
> > /devices/platform/ff8f0000.vop                      suspended
> > pd_vopb                         off
> > /devices/platform/ff900000.vop                      suspended
> > pd_vo                           off             pd_vopb, pd_vopl
> > pd_hdcp                         off
> > ...
> > pd_iep                          off
> > pd_vcodec                       off
> > pd_vdu                          off
> > 
> > QOS:
> > localhost / # cat sys/kernel/debug/pm_qos/
> > cpu_dma_latency     network_latency
> > memory_bandwidth    network_throughput
> 
> What is this supposed to be showing exactly?  You can't "cat" a
> directory, so maybe you meant "ls"?
> 
> Also, each of these files contains the string "Empty!" and these files
> seem fairly unconnected to your patch.  Those files exist both before
> and after your patch and nothing that I can see in the Rockchip QoS
> stuff hooks up to the generic Linux QoS infrastructure.  The power
> domains just save and restore the QoS--they don't actually allow
> settting it.

personally, I would just drop that debugfs-dump, as I don't see what we gain 
from it :-).

> 
> > Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > ---

[...]

> > +       pmu: power-management at ff310000 {
> > +               compatible = "rockchip,rk3399-pmu", "syscon",
> > "simple-mfd"; +               reg = <0x0 0xff310000 0x0 0x1000>;
> > +
> > +               power: power-controller {
> > +                       status = "okay";
> > +                       compatible = "rockchip,rk3399-power-controller";
> > +                       #power-domain-cells = <1>;
> > +                       #address-cells = <1>;
> > +                       #size-cells = <0>;
> > +
> > +                       pd_vdu {
> > +                               reg = <RK3399_PD_VDU>;
> > +                               clocks = <&cru ACLK_VDU>,
> > +                                        <&cru HCLK_VDU>;
> > +                               pm_qos = <&qos_video_m1_r>,
> > +                                        <&qos_video_m1_w>;
> > +                       };
> > +                       pd_vcodec {
> > +                               reg = <RK3399_PD_VCODEC>;
> > +                               clocks = <&cru ACLK_VCODEC>,
> > +                                        <&cru HCLK_VCODEC>;
> > +                               pm_qos = <&qos_video_m0>;
> > +                       };
> > +                       pd_iep {
> > +                               reg = <RK3399_PD_IEP>;
> > +                               clocks = <&cru ACLK_IEP>,
> > +                                        <&cru HCLK_IEP>;
> > +                               pm_qos = <&qos_iep>;
> > +                       };
> > +                       pd_rga {
> > +                               reg = <RK3399_PD_RGA>;
> > +                               clocks = <&cru ACLK_RGA>,
> > +                                        <&cru HCLK_RGA>;
> > +                               pm_qos = <&qos_rga_r>,
> > +                                        <&qos_rga_w>;
> > +                       };
> > +                       pd_vio {
> > +                               reg = <RK3399_PD_VIO>;
> > +                               #address-cells = <1>;
> > +                               #size-cells = <0>;
> > +
> > +                               pd_isp0 {
> > +                                       reg = <RK3399_PD_ISP0>;
> > +                                       clocks = <&cru ACLK_ISP0>,
> > +                                                <&cru HCLK_ISP0>;
> > +                                       pm_qos = <&qos_isp0_m0>,
> > +                                                <&qos_isp0_m1>;
> > +                               };
> > +                               pd_isp1 {
> > +                                       reg = <RK3399_PD_ISP1>;
> > +                                       clocks = <&cru ACLK_ISP1>,
> > +                                                <&cru HCLK_ISP1>;
> > +                                       pm_qos = <&qos_isp1_m0>,
> > +                                                <&qos_isp1_m1>;
> > +                               };
> > +                               pd_hdcp {
> > +                                       reg = <RK3399_PD_HDCP>;
> > +                                       clocks = <&cru ACLK_HDCP>,
> > +                                                <&cru HCLK_HDCP>,
> > +                                                <&cru PCLK_HDCP>;
> > +                                       pm_qos = <&qos_hdcp>;
> > +                               };
> > +                               pd_vo {
> > +                                       reg = <RK3399_PD_VO>;
> > +                                       #address-cells = <1>;
> > +                                       #size-cells = <0>;
> > +
> > +                                       pd_vopb {
> > +                                               reg = <RK3399_PD_VOPB>;
> > +                                               clocks = <&cru
> > ACLK_VOP0>, +                                                       
> > <&cru HCLK_VOP0>; +                                              
> > pm_qos = <&qos_vop_big_r>, +                                           
> >             <&qos_vop_big_w>; +                                      
> > };
> > +                                       pd_vopl {
> > +                                               reg = <RK3399_PD_VOPL>;
> > +                                               clocks = <&cru
> > ACLK_VOP1>, +                                                       
> > <&cru HCLK_VOP1>; +                                              
> > pm_qos = <&qos_vop_little>; +                                       };
> > +                               };
> > +                       };
> > +                       pd_gpu {
> > +                               reg = <RK3399_PD_GPU>;
> > +                               clocks = <&cru ACLK_GPU>;
> > +                               pm_qos = <&qos_gpu>;
> > +                       };
> 
> Again a nitty sort order question.  Is there a reason not to make
> things alphabetical?  AKA: pd_gpu, pd_iep, pd_rga, ...
> 
> ...and inside pd_vio should be alphabetical too?
> 
> In the TRM it looks like some of the power domains are grouped
> together (like all the domains under LOGIC or CENTERLOGIC).  If
> keeping that grouping makes sense here then you should add a comment
> at the start of each group and sort the groups sanely (and sort within
> each group).
> 
> It looks like there are also more power domains that you haven't
> listed here (like PD_GMAC, for instance, or PD_CORE_L).  Are you
> planning to add those in a followon patch?

that reminds me, nodes with a reg property should have the base address in 
the node name as well. Using the constant works nicely, as can be seen on 
the rk3288 where we have for example:

	pd_vio at RK3288_PD_VIO


Heiko
