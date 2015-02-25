From: michal.simek@xilinx.com (Michal Simek)
Date: Wed, 25 Feb 2015 15:21:33 +0100
Subject: [PATCH] ARM64: Add new Xilinx ZynqMP SoC
In-Reply-To: <20150224183831.GZ9714@leverpostej>
References: <8ac3037c175711dec0adcd0d898be7d9722e0ed0.1424764548.git.michal.simek@xilinx.com>
 <20150224183831.GZ9714@leverpostej>
Message-ID: <BY2FFO11FD04863C0B4C8C0A6C8EBA183E2170@BY2FFO11FD048.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 02/24/2015 07:38 PM, Mark Rutland wrote:
> Hi Michal,
> 
> I have a few minor comments below, but generally this is looking like
> one of the best dts submissions I've seen!

thanks appreciate it.

> 
> [...]
> 
>> +/ {
>> +       model = "ZynqMP EP108";
>> +
>> +       aliases {
>> +               serial0 = &uart0;
>> +       };
>> +
>> +       chosen {
>> +               stdout-path = "serial0:115200n8";
>> +       };
> 
> Thanks for using stdout-path with the full parameters.
> 
> Does your UART have earlycon support?

yes earlycon support is already in the kernel.

btw: I found that only stdout-path has different behavior
compare to console=ttyPS0,115200 passed via bootargs.
But I have to look at details to be accurate.


>> +/ {
>> +       compatible = "xlnx,zynqmp";
>> +       #address-cells = <2>;
>> +       #size-cells = <1>;
> 
> I guess this is fine, though to me it feels more natural to use
> #size-cells = <2> in case we need to describe larger ranges for some bus
> later.

I can fix it when it is needed.

> 
>> +       cpus {
>> +               #address-cells = <1>;
>> +               #size-cells = <0>;
>> +
>> +               cpu at 0 {
>> +                       compatible = "arm,cortex-a53", "arm,armv8";
>> +                       device_type = "cpu";
>> +                       enable-method = "psci";
>> +                       reg = <0x0>;
>> +               };
>> +
>> +               cpu at 1 {
>> +                       compatible = "arm,cortex-a53", "arm,armv8";
>> +                       device_type = "cpu";
>> +                       enable-method = "psci";
>> +                       reg = <0x1>;
>> +               };
>> +
>> +               cpu at 2 {
>> +                       compatible = "arm,cortex-a53", "arm,armv8";
>> +                       device_type = "cpu";
>> +                       enable-method = "psci";
>> +                       reg = <0x2>;
>> +               };
>> +
>> +               cpu at 3 {
>> +                       compatible = "arm,cortex-a53", "arm,armv8";
>> +                       device_type = "cpu";
>> +                       enable-method = "psci";
>> +                       reg = <0x3>;
>> +               };
>> +       };
> 
> These look fine.

good


>> +
>> +       psci {
>> +               compatible = "arm,psci-0.2";
>> +               method = "smc";
>> +       };
> 
> Neat!
> 
> What are you using as your implementation? Are all the mandatory
> PSCIv0.2 features implemented (e.g. MIGRATE_INFO_TYPE)?

ATF.

> 
> I take it this boots at EL2 on all CPUs?

yep.

> 
> Does CPU0 hotplug work?

cpu shutdown is working fine with the current firmware.
I didn't try anything else.

> 
> Do you need to keep a CPU online or do you require MIGRATE? e.g. does
> MIGRATE_INFO_TYPE return something other than 2 ("MP or not present")?

We are not require migrate and we don't need to keep CPU online now.
Migrate should return -1.

> 
> [...]
> 
>> +       amba_apu {
>> +               compatible = "simple-bus";
>> +               #address-cells = <2>;
>> +               #size-cells = <1>;
>> +               ranges;
>> +
>> +               timer {
>> +                       compatible = "arm,armv8-timer";
>> +                       interrupt-parent = <&gic>;
>> +                       interrupts = <1 13 0xff01>,
>> +                                    <1 14 0xff01>,
>> +                                    <1 11 0xff01>,
>> +                                    <1 10 0xff01>;
>> +               };
> 
> The architected timer should just be under the root node, given it's a
> component of the CPU -- it doesn't live on any bus.

Fair enough - will add it there.

> 
> I take it CNTFRQ is configured appropriately on all CPUs?

I believe so. :-)


> [...]
> 
>> +               i2c_clk: i2c_clk {
>> +                       compatible = "fixed-clock";
>> +                       #clock-cells = <0x0>;
>> +                       clock-frequency = <111111111>;
>> +               };
> 
> That clock-frequency looks a little odd. Is that right?

why is it odd? Is value too high?
It is exactly what we need to get to get i2c working.

> 
> I haven't taken an in-depth look at the other nodes. They look sane at a
> high-level, and assuming they are all already documented and supported
> they look fine to me.

I was checking that and hopefully I didn't miss anything.

Thanks,
Michal
