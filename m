From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 27 Feb 2017 23:34:25 +0800
Subject: [PATCH v1 1/2] coresight: bindings for debug module
In-Reply-To: <CAJ9a7VgBx+4Vgr_2VOY76wJMyjoyO48YD3Pp7Qx0C7hUY8xzKg@mail.gmail.com>
References: <1487815067-27511-1-git-send-email-leo.yan@linaro.org>
 <1487815067-27511-2-git-send-email-leo.yan@linaro.org>
 <CAJ9a7VgBx+4Vgr_2VOY76wJMyjoyO48YD3Pp7Qx0C7hUY8xzKg@mail.gmail.com>
Message-ID: <20170227153425.GA31630@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, Feb 27, 2017 at 12:37:45PM +0000, Mike Leach wrote:
> Hi Leo
> 
> On 23 February 2017 at 01:57, Leo Yan <leo.yan@linaro.org> wrote:
> > According to ARMv8 architecture reference manual (ARM DDI 0487A.k)
> > Chapter 'Part H: External debug', the CPU can integrate debug module
> > and it can support self-hosted debug and external debug. Especially
> > for supporting self-hosted debug, this means the program can access
> > the debug module from mmio region; and usually the mmio region is
> > integrated with coresight.
> >
> > So add document for binding debug component, includes binding to two
> > clocks, one is apb clock for bus and another is debug clock for debug
> > module self; and also need specify the CPU node which the debug module
> > is dedicated to specific CPU.
> >
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> > ---
> >  .../devicetree/bindings/arm/coresight-debug.txt    | 39 ++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/coresight-debug.txt
> >
> > diff --git a/Documentation/devicetree/bindings/arm/coresight-debug.txt b/Documentation/devicetree/bindings/arm/coresight-debug.txt
> > new file mode 100644
> > index 0000000..6e03e9b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/coresight-debug.txt
> > @@ -0,0 +1,39 @@
> > +* CoreSight Debug Component:
> > +
> > +CoreSight debug component are compliant with the ARMv8 architecture reference
> > +manual (ARM DDI 0487A.k) Chapter 'Part H: External debug'. The external debug
> > +module is mainly used for two modes: self-hosted debug and external debug, and
> > +it can be accessed from mmio region from Coresight and eventually the debug
> > +module connects with CPU for debugging. And the debug module provides
> > +sample-based profiling extension, which can be used to sample CPU program
> > +counter, secure state and exception level, etc; usually every CPU has one
> > +dedicated debug module to be connected.
> > +
> > +Required properties:
> > +
> > +- compatible : should be
> > +            * "arm,coresight-debug", "arm,primecell"; supplemented with
> > +              "arm,primecell" as driver is using the AMBA bus interface.
> > +
> > +- reg : physical base address and length of the register set.
> > +
> > +- clocks : the clocks associated to this component.
> > +
> > +- clock-names : the name of the clocks referenced by the code. Since we are
> > +                using the AMBA framework, the name of the clock providing
> > +               the interconnect should be "apb_pclk", and the debug module
> > +               has an additional clock "dbg_clk", which is used to provide
> > +               clock for debug module itself. Both clocks are mandatory.
> > +
> 
> Perhaps I am misunderstanding the nature of the .dts files, but I'm
> puzzled about the dbg_clk. I cannot see anything in the architecture
> or normal A53 implementation that mentions this.
> To access external debug from the core/external debug agent then we do
> need the APB clock, but the interface between the debug logic and the
> processor core is clocked by the internal CPU clocks.

You are right and sorry I may introduce confusion at here.

When I wrote this doc for binding, I assumed every debug logic has
its own clock source. This is because there have one register
ACPU_SC_PDBGUP_MBIST with eight bits, every bit is used to control
every CPU's DBGPWRDUP signal. I wrongly understood this bit is used
for debug logic clock gating.

I read CA53 TRM, the DBGPWRDUP signal actually is used between power
controller and CPU so can ensure CPU can be safely enter and exit low
power states; and "The EDPRSR.PU bit reflects the value of this
DBGPWRDUP signal". So I made mistake here and the bits in
ACPU_SC_PDBGUP_MBIST is no matter with debug logic clocks.

I will remove the "dbg_clk" from binding doc. Please correct me if my
understanding is still wrong or blur.

> > +- cpu : the cpu phandle the debug module is affined to. When omitted
> > +       the source is considered to belong to CPU0.
> > +
> > +Example:
> > +
> > +       debug at f6590000 {
> > +               compatible = "arm,coresight-debug","arm,primecell";
> > +               reg = <0 0xf6590000 0 0x1000>;
> > +               clocks = <&sys_ctrl HI6220_CS_ATB>, <&acpu_ctrl HI6220_ACPU_DBG_CLK0>;
> > +               clock-names = "apb_pclk", "dbg_clk";
> > +               cpu = <&cpu0>;
> > +       };
> > --
> > 2.7.4
> >
> 
> When I was looking at clocks for trace on the HiKey board I noted:
> HI6220_CS_DAPB -- which I assumed was the debug APB clock.
> HI6220_CS_ATB - which I assumed was the ATB (trace bus) clock.

The clock HI6220_CS_DAPB is a mux; and after went through the spec for
register definition, the clock driver misses the dapb gate clock in
its system controller 'sysctrl'; And I checked this bit is luckily
enabled by bootloaders (I have not checked it's enabled by ARM-TF or
UEFI) so the driver can access debug module registers.

diff --git a/drivers/clk/hisilicon/clk-hi6220.c b/drivers/clk/hisilicon/clk-hi6220.c
index 553d083..a4ac75e 100644
--- a/drivers/clk/hisilicon/clk-hi6220.c
+++ b/drivers/clk/hisilicon/clk-hi6220.c
@@ -134,6 +134,7 @@ static struct hisi_gate_clock hi6220_separated_gate_clks_sys[] __initdata = {
        { HI6220_UART4_PCLK,    "uart4_pclk",    "uart4_src",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 8,  0, },
        { HI6220_SPI_CLK,       "spi_clk",       "clk_150m",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 9,  0, },
        { HI6220_TSENSOR_CLK,   "tsensor_clk",   "clk_bus",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 12, 0, },
+       { HI6220_DAPB_CLK,      "dapb_clk",      "cs_dapb",        CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x230, 18, 0, },
        { HI6220_MMU_CLK,       "mmu_clk",       "ddrc_axi1",      CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x240, 11, 0, },
        { HI6220_HIFI_SEL,      "hifi_sel",      "hifi_src",       CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 0,  0, },
        { HI6220_MMC0_SYSPLL,   "mmc0_syspll",   "syspll",         CLK_SET_RATE_PARENT|CLK_IGNORE_UNUSED, 0x270, 1,  0, },

Thanks,
Leo Yan
