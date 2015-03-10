From: fkan@apm.com (Feng Kan)
Date: Tue, 10 Mar 2015 10:23:28 -0700
Subject: [PATCH] arm64: dts: add APM Merlin Board device tree
In-Reply-To: <20150310172036.GG31849@leverpostej>
References: <1426007454-11848-1-git-send-email-fkan@apm.com>
 <20150310172036.GG31849@leverpostej>
Message-ID: <CAL85gmBDWHd8zsY13DAxxADz3p5NK6sLHrarffkR0XdMaN+saA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 10, 2015 at 10:20 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Tue, Mar 10, 2015 at 05:10:54PM +0000, Feng Kan wrote:
>> This patch adds the support for APM Merlin board. The Merlin board
>> is based on the APM X-Gene Shadowcat SoC. This DTS enables PMU,
>> SATA and Serial.
>>
>> Signed-off-by: Feng Kan <fkan@apm.com>
>> ---
>>  arch/arm64/boot/dts/apm/apm-merlin.dts     |  39 ++++++++
>>  arch/arm64/boot/dts/apm/apm-shadowcat.dtsi | 154 +++++++++++++++++++++++++++++
>>  2 files changed, 193 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/apm/apm-merlin.dts
>>  create mode 100644 arch/arm64/boot/dts/apm/apm-shadowcat.dtsi
>
> [...]
>
>> +     memory {
>> +             device_type = "memory";
>> +             reg = < 0x1 0x00000000 0x0 0x80000000 >;
>> +     };
>
> [...]
>
>> +             cpu at 000 {
>> +                     device_type = "cpu";
>> +                     compatible = "apm,strega", "arm,armv8";
>> +                     reg = <0x0 0x000>;
>> +                     enable-method = "spin-table";
>
> I take it that as with Potenza there won't be PSCI?
Yes.
>
>> +                     cpu-release-addr = <0x1 0x0000fff8>;
>> +             };
>
> The range covered by the cpu-release-addr exists in the memory node and
> there's no /memreserve/, so this is broken.
I will fix this and the rest.
>
> Please fix this so the release address and the code the secondaries are
> executing to poll it can't be accidentally clobbered.
>
> [...]
>
>> +     gic: interrupt-controller at 78090000 {
>> +             compatible = "arm,cortex-a15-gic";
>> +             #interrupt-cells = <3>;
>> +             #address-cells = <2>;
>> +             #size-cells = <2>;
>> +             interrupt-controller;
>> +             interrupts = <1 9 0xf04>;       /* GIC Maintenence IRQ */
>> +             ranges = <0 0 0 0x79000000 0x0 0x800000>; /* MSI Range */
>
> Nothing in this patch seems to require this ranges entry. Remove it
> until it's necessary.
>
>> +             reg = <0x0 0x78090000 0x0 0x10000>,     /* GIC Dist */
>> +                   <0x0 0x780A0000 0x0 0x20000>,     /* GIC CPU */
>> +                   <0x0 0x780C0000 0x0 0x10000>,     /* GIC VCPU Control */
>> +                   <0x0 0x780E0000 0x0 0x20000>;     /* GIC VCPU */
>> +     };
>> +
>> +     pmu {
>> +             compatible = "arm,armv8-pmuv3";
>> +             interrupts = <1 12 0xff04>;
>> +     };
>> +
>> +     timer {
>> +             compatible = "arm,armv8-timer";
>> +             interrupts = <1 0 0xff04>,      /* Secure Phys IRQ */
>> +                          <1 13 0xff04>,     /* Non-secure Phys IRQ */
>> +                          <1 14 0xff04>,     /* Virt IRQ */
>> +                          <1 15 0xff04>;     /* Hyp IRQ */
>> +             clock-frequency = <50000000>;
>
> CNTFRQ should be programmed (on all CPUs) by the FW/bootloader prior to
> entering the kernel.
>
> If it isn't configured, virtualization is broken.
>
> If it is configured, this is unnecessary and can be dropped from the
> dts.
>
> [...]
>
>> +             serial0: serial at 10600000 {
>> +                     device_type = "serial";
>> +                     compatible = "ns16550";
>> +                     reg = <0 0x10600000 0x0 0x1000>;
>> +                     reg-shift = <2>;
>> +                     clock-frequency = <10000000>;
>> +                     interrupt-parent = <&gic>;
>> +                     interrupts = <0x0 0x4c 0x4>;
>> +             };
>
> It would be good if /chosen/stdout-path were set up appropriately for
> this.
>
> Thanks,
> Mark.
