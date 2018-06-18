From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 18 Jun 2018 01:00:41 -0300
Subject: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
In-Reply-To: <20180226134741.neqkpge33zo3pfzt@earth.universe>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
Message-ID: <CAOMZO5Czdpdo3Vt0TjGYGUFoz=ZMuy_6F3C=dq4gp4NEvXBZAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sebastian,

[Adding Martin on Cc who also tried to enable DBGEN bit in a previous patch]

On Mon, Feb 26, 2018 at 10:47 AM, Sebastian Reichel
<sebastian.reichel@collabora.co.uk> wrote:
> Hi Shawn,
>
> On Sat, Feb 24, 2018 at 03:45:44PM +0800, Shawn Guo wrote:
>> On Mon, Feb 12, 2018 at 01:39:44PM +0100, Sebastian Reichel wrote:
>> > On i.MX53 it is necessary to set the DBG_EN bit in the
>> > platform GPC register to enable access to PMU counters
>> > other than the cycle counter.
>> >
>> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>> > ---
>> >  arch/arm/mach-imx/mach-imx53.c | 39 ++++++++++++++++++++++++++++++++++++++-
>> >  1 file changed, 38 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm/mach-imx/mach-imx53.c b/arch/arm/mach-imx/mach-imx53.c
>> > index 07c2e8dca494..658e28604dca 100644
>> > --- a/arch/arm/mach-imx/mach-imx53.c
>> > +++ b/arch/arm/mach-imx/mach-imx53.c
>> > @@ -28,10 +28,47 @@ static void __init imx53_init_early(void)
>> >     mxc_set_cpu_type(MXC_CPU_MX53);
>> >  }
>> >
>> > +#define MXC_CORTEXA8_PLAT_GPC 0x63fa0004
>>
>> The base address should be retrieved from device tree.
>
> DT has no entry for 0x63fa0000-0x63fa3fff. iMX53 TRM lists it as "ARM Platform"
> with 8 platform specific 32 bit registers. Do you think it's worth the trouble
> adding a new binding? Do you have a suggestion for a compatible value?

I also think we should add a compatible string for the "ARM platform" region.

This way both mx51 and mx53 could retrieve the base address from the
device tree.

What about:

--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -672,6 +672,11 @@
                                status = "disabled";
                        };

+                       arm_plat: arm-plat at 63fa0000 {
+                               compatible = "fsl,imx53-arm-plat",
"fsl,imx51-arm-plat";
+                               reg = <0x63fa0000 0x4000>;
+                       };
+
                        owire: owire at 63fa4000 {
                                compatible = "fsl,imx53-owire",
"fsl,imx21-owire";
                                reg = <0x63fa4000 0x4000>;
