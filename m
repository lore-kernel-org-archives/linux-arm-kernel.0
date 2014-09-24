From: info@lategoodbye.de (Stefan Wahren)
Date: Wed, 24 Sep 2014 22:46:20 +0200
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <CAOMZO5A0of3_arOx2z0_t7xN37jQjJ5uU4gwcsgCuSdpBJJVzw@mail.gmail.com>
References: <53F9B4BF.2050802@lategoodbye.de>	<20140825080123.GA12289@dragon>	<53FB1041.5010208@lategoodbye.de>	<CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>	<CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>	<540412A9.4090806@lategoodbye.de>	<CAOMZO5A7-66LJtv4O2TghN3gVzme4N6JFMYd8TV7zXhUhsXedQ@mail.gmail.com>	<542093C0.1040004@lategoodbye.de>
 <CAOMZO5A0of3_arOx2z0_t7xN37jQjJ5uU4gwcsgCuSdpBJJVzw@mail.gmail.com>
Message-ID: <54232D9C.5070404@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 23.09.2014 00:18, schrieb Fabio Estevam:
> Hi Stefan,
>
>> Now i want to test the mxs-regulator driver with the cpufreq-cpu0 as
>> consumer. So i defined cpu at 0 according to cpufreq-cpu0 binding in imx28.dtsi
>> and enabled cpufreq-cpu0 driver and userspace gov in Kernel config.
>>
>> But if i modprobe cpufreq-cpu0 i don't get any output and the entry
>> /sys/devices/system/cpu/cpu0/cpufreq is also missing.
>>
>> Any ideas, what's wrong or missing?
>
> Have you registered cpufreq-cpu0 inside arch/arm/mach-mxs/mach-mxs.c?
>
> Take a look at this patch for an example:
> http://www.spinics.net/lists/arm-kernel/msg363761.html
>

thanks, registering cpufreq-cpu0 and adding missing properties reg & 
clocks did the trick.

Now the sys interface of cpufreq is available and the mxs-regulator 
seems to handle frequency change. But the frequency selection do not 
work as expected. If i set cpu frequency to 454736, 392727 or 261818 
kHz, the cpufreq driver change it silently to 240000 kHz.

Why? Is it the wrong clock ( 21 should be cpu )?

Thanks in advance
Stefan

PS: Here my DT and the debug output

####################### imx28.dtsi

[...]

cpus {
	#address-cells = <1>;
	#size-cells = <0>;

	cpu at 0 {
		compatible = "arm,arm926ej-s";
		device_type = "cpu";
		reg = <0x0>;
		operating-points = <
			/* kHz	uV */
			454736	1550000
			392727	1475000
			360000	1375000
			261818	1275000
			64000	1050000
		>;
		clocks = <&clks 21>;
		clock-latency = <61036>; /* two CLK32 periods */
		cpu0-supply = <&reg_vddd>;
	};
};

[...]

power: power at 80044000 {
	compatible = "simple-bus";
	#address-cells = <1>;
	#size-cells = <1>;
	reg = <0x80044000 0x2000>;
	ranges;

	reg_vddd: regulator at 80044040 {
		reg = <0x80044040 0x10>;
		compatible = "fsl,mxs-regulator";
		regulator-name = "vddd";
		regulator-min-microvolt = <800000>;
		regulator-max-microvolt = <1575000>;
		regulator-boot-on;
		vddd-supply = <&reg_vdda>;
	};

	reg_vdda: regulator at 80044050 {
		reg = <0x80044050 0x10>;
		compatible = "fsl,mxs-regulator";
		regulator-name = "vdda";
		regulator-min-microvolt = <1500000>;
		regulator-max-microvolt = <2275000>;
		regulator-boot-on;
		vdda-supply = <&reg_vddio>;
	};

	reg_vddio: regulator at 80044060 {
		reg = <0x80044060 0x10>;
		compatible = "fsl,mxs-regulator";
		regulator-name = "vddio";
		regulator-min-microvolt = <2800000>;
		regulator-max-microvolt = <3600000>;
		regulator-microvolt-offset = <80000>;
		regulator-boot-on;
	};

	power_sts: power_sts at 800440c0 {
		reg = <0x800440c0 0x10>;
		status = "disabled";
	};
};

####################### dmesg

[ 3845.602210] cpu cpu0: Looking up cpu0-supply from device tree
[ 3845.604389] freq_table: table entry 0: 64000 kHz
[ 3845.604448] freq_table: table entry 1: 261818 kHz
[ 3845.604482] freq_table: table entry 2: 360000 kHz
[ 3845.604512] freq_table: table entry 3: 392727 kHz
[ 3845.604541] freq_table: table entry 4: 454736 kHz
[ 3845.608402] freq_table: request for verificatiorequest for 
verification of policy (64000 - 454736 kHz) for cpu 0
[ 3845.608571] freq_table: verification lead to (64000 - 454736 kHz) for 
cpu 0
[ 4049.590886] freq_table: request for target 392727 kHz (relation: 0) 
for cpu 0
[ 4049.590957] freq_table: target index is 3, freq is:392727 kHz
[ 4049.597120] mxs_get_voltage: vddd register val 28
[ 4049.597202] cpufreq_cpu0: 454 MHz, 1500 mV --> 240 MHz, 1275 mV
[ 4049.597686] mxs_is_enabled: vddd register val 0
[ 4049.597783] mxs_get_voltage: vddd register val 28
[ 4049.597864] mxs_set_voltage: min_uV 1275000, max_uV 1275000, min 
800000, max 1575000
[ 4049.597928] mxs_set_voltage: vddd calculated val 19
[ 4049.598384] mxs_get_voltage: vddd register val 19
[ 4464.831192] freq_table: request for target 360000 kHz (relation: 0) 
for cpu 0
[ 4464.831609] freq_table: target index is 2, freq is:360000 kHz
[ 4464.831871] mxs_get_voltage: vddd register val 19
[ 4464.831965] cpufreq_cpu0: 240 MHz, 1275 mV --> 360 MHz, 1375 mV
[ 4464.832063] mxs_is_enabled: vddd register val 0
[ 4464.832137] mxs_get_voltage: vddd register val 19
[ 4464.832213] mxs_set_voltage: min_uV 1375000, max_uV 1375000, min 
800000, max 1575000
[ 4464.832274] mxs_set_voltage: vddd calculated val 23
[ 4464.832488] mxs_get_voltage: vddd register val 23
[ 4603.949470] freq_table: request for target 261818 kHz (relation: 0) 
for cpu 0
[ 4603.949548] freq_table: target index is 1, freq is:261818 kHz
[ 4603.949747] mxs_get_voltage: vddd register val 23
[ 4603.949815] cpufreq_cpu0: 360 MHz, 1375 mV --> 240 MHz, 1275 mV
[ 4603.950088] mxs_is_enabled: vddd register val 0
[ 4603.950165] mxs_get_voltage: vddd register val 23
[ 4603.950244] mxs_set_voltage: min_uV 1275000, max_uV 1275000, min 
800000, max 1575000
[ 4603.950306] mxs_set_voltage: vddd calculated val 19
[ 4603.950473] mxs_get_voltage: vddd register val 19
[ 4757.663161] freq_table: request for target 454736 kHz (relation: 0) 
for cpu 0
[ 4757.663267] freq_table: target index is 4, freq is:454736 kHz
[ 4757.663518] mxs_get_voltage: vddd register val 19
[ 4757.663614] cpufreq_cpu0: 240 MHz, 1275 mV --> 240 MHz, 1275 mV
