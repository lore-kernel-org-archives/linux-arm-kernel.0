From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Mon, 19 Aug 2013 13:01:11 +0530
Subject: Kexec: BE kernel on ARM VE TC2
In-Reply-To: <alpine.LFD.2.03.1308141026210.14472@syhkavp.arg>
References: <CALicx6ueLxCFCeun1grdtcC21HSkCDfenLWOSfuoSJnhx9GZ6w@mail.gmail.com>
 <20130808215034.GE19383@mudshark.cambridge.arm.com>
 <alpine.LFD.2.03.1308131851300.14472@syhkavp.arg>
 <CALicx6uKhd0z=81G68VvTjBpPy=vwK3tgK8zk11dpu34N=YyYA@mail.gmail.com>
 <alpine.LFD.2.03.1308141026210.14472@syhkavp.arg>
Message-ID: <CALicx6sgS6J4aU2mf3fBoWA7oREDrbkit4FW-ptj49EmLuH_HA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 14, 2013 at 8:49 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 14 Aug 2013, Vijay Kilari wrote:
>
>> On Wed, Aug 14, 2013 at 4:22 AM, Nicolas Pitre <nico@fluxnic.net> wrote:
>> > On Thu, 8 Aug 2013, Will Deacon wrote:
>> >
>> >> On Mon, Aug 05, 2013 at 01:12:17PM +0100, Vijay Kilari wrote:
>> >> > Hi Will,
>> >> >
>> >> > I am trying to make kexec work on BE kernel on ARM VE TC2.
>> >> >
>> >> > First, to make KEXEC work with SMP on ARM VE TC2 board,
>> >> > I set nr_cpus=2 (i.e boot only A15's) this works with LE kernel.
>> >>
>> >> Interesting, is this with a mainline kernel? I don't see how SMP kexec can
>> >> work on TC2 without additional patches to park the secondary cores safely.
>> >
>> > BTW those patches are available in linux-next at the moment.
>>
>> Thanks for this info.
>> I see that MCPM, TC2_PM & SPC configuration needs to be enabled to have
>> TC2 power management. However MCPM also depends on CCI configuration
>> to register smps ops.
>> In my config, I dont have CCI config enabled
>
> You do need CCI support in addition to all the above.  Managing CPUs on
> TC2 is serious business !
>
>> Can you please suggest right configuration to be enabled and also dts
>> configuration for SPC, CCI to enable TC2 power mgmt.
>
> You need the following pieces of firmware:
>
> mbb_v311.ebf or later in MB/HBI0190D/ and proper reference to it in
> MB/HBI0190D/board.txt.
>
> dbb_v110.ebf or later in SITE1/HBI0249A/. The file
> SITE1/HBI0249A/board.txt must have a proper reference to that file,
> as well as the following values in the "[SCC REGISTERS]" section:
>
> SCC: 0x700 0x0032F003
>
> Most important here is to have bits 12 through 15 set to 1.
>
> Those firmware files should be available on ARM's web site.
>
> You also need to have the following sections in your device tree source
> file:
>
> - SPC/SCC
>
>   Depending on the flavor of the patch you have, this is either
>   spc at 7fff0000 or scc at 7fff0000.  You should look for either
>   vexpress-spc.txt or vexpress-scc.txt in
>   Documentation/devicetree/bindings/arm/ and use the example therein.
>
> - CCI
>
>   You need a CCI section as examplified in
>   Documentation/devicetree/bindings/arm/cci.txt.
>
>> Also I am using u-boot. Do I need to use UEFI/firmware to enable TC2 power mgmt?
>
> No.  I'm using U-Boot as well.
>
>> I remember, some time back, I have tried linaro tracking git and
>> failed to boot my board
>
> This is most likely because of the above firmware settings and device
> tree requirements.
>
>

Thanks for this info. I have taken your linaro branch and tested it

git clone git://git.linaro.org/people/nico/linux.git and checkout TC2 branch

I have selected MCPM, TC2_PM config and made following changes to dts file

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index d2803be..46ba764 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -9,6 +9,8 @@

 /dts-v1/;

+/memreserve/ 0xff000000 0x01000000;
+
 / {
        model = "V2P-CA15_CA7";
        arm,hbi = <0x249>;
@@ -29,6 +31,47 @@
                i2c1 = &v2m_i2c_pcie;
        };

+       clusters {
+               #address-cells = <1>;
+               #size-cells = <0>;
+               cluster0: cluster at 0 {
+                       reg = <0>;
+                       cores {
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+
+                               core0: core at 0 {
+                                       reg = <0>;
+                               };
+
+                               core1: core at 1 {
+                                       reg = <1>;
+                               };
+
+                       };
+               };
+
+               cluster1: cluster at 1 {
+                       reg = <1>;
+                       cores {
+                               #address-cells = <1>;
+                               #size-cells = <0>;
+
+                               core2: core at 0 {
+                                       reg = <0>;
+                               };
+
+                               core3: core at 1 {
+                                       reg = <1>;
+                               };
+
+                               core4: core at 2 {
+                                       reg = <2>;
+                               };
+                       };
+               };
+       };
+
        cpus {
                #address-cells = <1>;
                #size-cells = <0>;
@@ -37,36 +80,56 @@
                        device_type = "cpu";
                        compatible = "arm,cortex-a15";
                        reg = <0>;
+                       cluster = <&cluster0>;
+                       core = <&core0>;
+                       clock-frequency = <1000000000>;
+                       cci-control-port = <&cci_control1>;
                };

                cpu1: cpu at 1 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a15";
                        reg = <1>;
+                       cluster = <&cluster0>;
+                       core = <&core1>;
+                       clock-frequency = <1000000000>;
+                       cci-control-port = <&cci_control1>;
                };

                cpu2: cpu at 2 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a7";
                        reg = <0x100>;
+                       cluster = <&cluster1>;
+                       core = <&core2>;
+                       clock-frequency = <800000000>;
+                       cci-control-port = <&cci_control2>;
                };

                cpu3: cpu at 3 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a7";
                        reg = <0x101>;
+                       cluster = <&cluster1>;
+                       core = <&core3>;
+                       clock-frequency = <800000000>;
+                       cci-control-port = <&cci_control2>;
                };

                cpu4: cpu at 4 {
                        device_type = "cpu";
                        compatible = "arm,cortex-a7";
                        reg = <0x102>;
+                       cluster = <&cluster1>;
+                       core = <&core4>;
+                       clock-frequency = <800000000>;
+                       cci-control-port = <&cci_control2>;
                };
        };

        memory at 80000000 {
                device_type = "memory";
-               reg = <0 0x80000000 0 0x40000000>;
+               reg = <0 0x80000000 0 0x80000000>;
        };

        wdt at 2a490000 {
@@ -81,6 +144,8 @@
                compatible = "arm,hdlcd";
                reg = <0 0x2b000000 0 0x1000>;
                interrupts = <0 85 4>;
+               mode = "1024x768-16 at 60";
+               framebuffer = <0 0xff000000 0 0x01000000>;
                clocks = <&oscclk5>;
                clock-names = "pxlclk";
        };
@@ -104,6 +169,36 @@
                interrupts = <1 9 0xf04>;
        };

+       cci at 2c090000 {
+               compatible = "arm,cci-400";
+               #address-cells = <1>;
+               #size-cells = <1>;
+               reg = <0 0x2c090000 0 0x1000>;
+               ranges = <0x0 0x0 0x2c090000 0x10000>;
+
+               cci_control1: slave-if at 4000 {
+                       compatible = "arm,cci-400-ctrl-if";
+                       interface-type = "ace";
+                       reg = <0x4000 0x1000>;
+               };
+
+               cci_control2: slave-if at 5000 {
+                       compatible = "arm,cci-400-ctrl-if";
+                       interface-type = "ace";
+                       reg = <0x5000 0x1000>;
+               };
+       };
+
+       cci-pmu at 2c099000 {
+               compatible = "arm,cci-400-pmu";
+               reg = <0 0x2c099000 0 0x6000>;
+               interrupts = <0 101 4>,
+                            <0 102 4>,
+                            <0 103 4>,
+                            <0 104 4>,
+                            <0 105 4>;
+       };
+
        memory-controller at 7ffd0000 {
                compatible = "arm,pl354", "arm,primecell";
                reg = <0 0x7ffd0000 0 0x1000>;
@@ -125,6 +220,12 @@
                clock-names = "apb_pclk";
        };

+       spc at 7fff0000 {
+               compatible = "arm,vexpress-spc,v2p-ca15_a7","arm,vexpress-spc";
+               reg = <0 0x7fff0000 0 0x1000>;
+               interrupts = <0 95 4>;
+       };
+
        timer {
                compatible = "arm,armv7-timer";
                interrupts = <1 13 0xf08>,

With this I see that secondary CPU's are not booted. Please see log below

PERCPU: Embedded 7 pages/cpu @80d12000 s7296 r8192 d13184 u32768
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260096
Kernel command line: console=ttyAMA0,38400n8 root=/dev/nfs rw ip=dhcp
nfsroot=10.167.100.215:/mnt/be_rfs
PID hash table entries: 4096 (order: 2, 16384 bytes)
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 1034252K/1048576K available (3579K kernel code, 166K rwdata,
1020K rodata, 203K init, 139K bss, 14324K reserved)
Virtual kernel memory layout:
    vector  : 0xffff0000 - 0xffff1000   (   4 kB)
    fixmap  : 0xfff00000 - 0xfffe0000   ( 896 kB)
    vmalloc : 0xc0800000 - 0xff000000   (1000 MB)
    lowmem  : 0x80000000 - 0xc0000000   (1024 MB)
    modules : 0x7f000000 - 0x80000000   (  16 MB)
      .text : 0x80008000 - 0x804862ac   (4601 kB)
      .init : 0x80487000 - 0x804b9c80   ( 204 kB)
      .data : 0x804ba000 - 0x804e39e0   ( 167 kB)
       .bss : 0x804e39e0 - 0x805068d0   ( 140 kB)
SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
Hierarchical RCU implementation.
NR_IRQS:16 nr_irqs:16 16
sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps every 4294967ms
sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 178956ms
Console: colour dummy device 80x30
Calibrating delay loop... 1987.37 BogoMIPS (lpj=9936896)
pid_max: default: 32768 minimum: 301
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
CPU0: update cpu_power 1441
CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
Setting up static identity map for 0x80365b78 - 0x80365bd0
vexpress-spc loaded at c0808000
ARM CCI driver probed
TC2 power management initialized
CPU1: failed to come online
CPU2: failed to come online
CPU3: failed to come online
Brought up 1 CPUs
SMP: Total of 1 processors activated (1987.37 BogoMIPS).
CPU: All CPU(s) started in SVC mode.

I am using following firware versions

MB: mbb_v312.ebf
DBB: dbb_v110.ebf

and board.txt in DBB is as follows

SCC: 0x700 0x0032F003           ;CFGRW48 - Cluster configuration
register (Default 0x0032F003)
                                ;          [   28] Boot Cluster (default CA15)
                                ;          [25:24] Boot CPU (default 0)
                                ;          [   15] A7 Event stream
generation (default: enabled)
                                ;          [   14] A15 Event stream
generation (default: enabled)
                                ;          [   13] Power down the
non-boot cluster (default: enabled)
                                ;          [   12] Use per-cpu
mailboxes for power management (default: enabled)
                                ;          [   11] A15 executes WFEs
as nops (default: disabled)

SCC: 0x400 0x33330C00           ;CFGRW41 - A15 configuration register
0 (Default 0x33330C00)
                                ;          [29:28] SPNIDEN
                                ;          [25:24] SPIDEN
                                ;          [21:20] NIDEN
                                ;          [17:16] DBGEN
                                ;          [13:12] CFGTE
                                ;          [ 9: 8] VINITHI_CORE
                                ;          [    7] IMINLN
                                ;          [ 3: 0] CLUSTER_ID

..
                                ;Power management interface
SCC: 0xC00 0x00000007           ;Control: [0]PMI_EN [1]DBG_EN
[2]SPC_SYSCFG (disable DBG_EN for power measurements)

In fact, I have updated complete firmware to v5.2 version, with this
Boot monitor version is v5.2.1
and as I mentioned, I am using u-boot for booting

Please let me know what is going wrong here?

> Nicolas
