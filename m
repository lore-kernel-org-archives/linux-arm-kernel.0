From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 18 Feb 2013 21:14:05 +0900
Subject: [PATCH 3/4] ARM: mach-shmobile: r8a7779: Minimal setup using DT
In-Reply-To: <20130218113752.GA20299@verge.net.au>
References: <1359597051-32700-1-git-send-email-horms+renesas@verge.net.au>
 <1359597051-32700-4-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoRgA_U2onxnOJ7N2wec1C-V4ZE25UEDC5Dm8KstLPuhEg@mail.gmail.com>
 <20130218113752.GA20299@verge.net.au>
Message-ID: <CANqRtoQtCG87UrpJTPUWts5svG5r8GXa2Q=GBddHRveX8sba7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 8:37 PM, Simon Horman <horms@verge.net.au> wrote:
> On Mon, Feb 18, 2013 at 06:36:12PM +0900, Magnus Damm wrote:
>> Hi Simon,
>>
>> Here's some feedback on your r8a7779 DT code.
>>
>> On Thu, Jan 31, 2013 at 10:50 AM, Simon Horman
>> <horms+renesas@verge.net.au> wrote:
>> > Allow a minimal setup of the r8a7779 SoC using a flattened device tree.
>> > In particular, configure the i2c and ethernet controllers using a
>> > flattened device tree.
>> >
>> > SCI serial controller and TMU clock source, whose drivers do not yet
>> > support configuration using a flattened device tree, are still configured
>> > using C code in order to allow booting of a board with this SoC.
>> >
>> > The ethernet controller also requires a regulator which is a board property.
>> > A sample snippet DT for the marzen board is as follows:
>> >
>> > /dts-v1/;
>> > /include/ "r8a7779.dtsi"
>> >
>> > / {
>> >         fixedregulator3v3: fixedregulator at 0 {
>> >                 compatible = "regulator-fixed";
>> >                 regulator-name = "fixed-3.3V";
>> >                 regulator-min-microvolt = <3300000>;
>> >                 regulator-max-microvolt = <3300000>;
>> >                 regulator-boot-on;
>> >                 regulator-always-on;
>> >         };
>> > };
>> >
>> > &lan0 {
>> >         vddvario-supply = <&fixedregulator3v3>;
>> >         vdd33a-supply = <&fixedregulator3v3>;
>> > };
>> >
>> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
>> > ---
>>
>> > --- a/arch/arm/mach-shmobile/setup-r8a7779.c
>> > +++ b/arch/arm/mach-shmobile/setup-r8a7779.c
>> > @@ -321,7 +321,7 @@ static struct platform_device i2c3_device = {
>> >         .num_resources  = ARRAY_SIZE(rcar_i2c3_res),
>> >  };
>> >
>> > -static struct platform_device *r8a7779_early_devices[] __initdata = {
>> > +static struct platform_device *r8a7779_early_devices_dt[] __initdata = {
>> >         &scif0_device,
>> >         &scif1_device,
>> >         &scif2_device,
>> > @@ -330,15 +330,15 @@ static struct platform_device *r8a7779_early_devices[] __initdata = {
>> >         &scif5_device,
>> >         &tmu00_device,
>> >         &tmu01_device,
>> > +};
>> > +
>> > +static struct platform_device *r8a7779_early_devices[] __initdata = {
>> >         &i2c0_device,
>> >         &i2c1_device,
>> >         &i2c2_device,
>> >         &i2c3_device,
>> >  };
>> >
>> > -static struct platform_device *r8a7779_late_devices[] __initdata = {
>> > -};
>> > -
>>
>> Thanks for your work on this. Two things with early/late devices on r8a7779:
>>
>> 1)  Same thing as sh73a0 applies here, please refrain from using early
>> devices with DT.
>
> I guess you are referring to tmu.
> If so, yes, I can move them to r8a7779_early_devices.

As we talked about last Friday, please try to avoid using early
devices in general. It is enough to add SCIF and TMU as late devices.
This goes for both sh73a0 and r8a7779. The only thing you need to do
early is to setup the delay. Please look at the emev2 implementation
for what is needed.

>> 2) The i2c devices as early devices look incorrect. Can you make them
>> late devices?
>
> r8a7779_early_devices is only used for the non-DT case.
> For the non-DT case i2c was set up as early devices before this patch-set.
> Would you like me to change them to late devices for non-DT,
> a change that is orthogonal to this patch-set?

Yes. I realize it is not really related to this DT feature, but it
certainly looks incorrect.

Thanks,

/ magnus
