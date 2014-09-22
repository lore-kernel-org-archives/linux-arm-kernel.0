From: info@lategoodbye.de (Stefan Wahren)
Date: Mon, 22 Sep 2014 23:25:20 +0200
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <CAOMZO5A7-66LJtv4O2TghN3gVzme4N6JFMYd8TV7zXhUhsXedQ@mail.gmail.com>
References: <53F9B4BF.2050802@lategoodbye.de>	<20140825080123.GA12289@dragon>	<53FB1041.5010208@lategoodbye.de>	<CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>	<CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>	<540412A9.4090806@lategoodbye.de>
 <CAOMZO5A7-66LJtv4O2TghN3gVzme4N6JFMYd8TV7zXhUhsXedQ@mail.gmail.com>
Message-ID: <542093C0.1040004@lategoodbye.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am 01.09.2014 15:33, schrieb Fabio Estevam:
> Hi Stefan,
>
> On Mon, Sep 1, 2014 at 3:31 AM, Stefan Wahren <info@lategoodbye.de> wrote:
>
>> thanks. Okay, that leads to more questions:
>>
>> How can i test a ported mxs-regulator driver, that it's really working? Is
>> there any userspace interface?
>
> After you ported the mxs regulator you can check whether it probed
> correctly and if the reported voltages in the kernel log match the
> register settings. You can also check if the voltages are really in
> the correct reported value with a scope.
>
> On mx6q we have the following:
>
> [    0.070554] vdd1p1: 800 <--> 1375 mV at 1100 mV
> [    0.071521] vdd3p0: 2800 <--> 3150 mV at 3000 mV
> [    0.072397] vdd2p5: 2000 <--> 2750 mV at 2400 mV
> [    0.073369] vddarm: 725 <--> 1450 mV at 1150 mV
> [    0.074282] vddpu: 725 <--> 1450 mV at 1150 mV
> [    0.075247] vddsoc: 725 <--> 1450 mV at 1200 mV
>
> and you should get something like that in your kernel log after you
> ported the mxs regulator driver.
>
>

i've ported the mxs-regulator driver and now i'm getting an probing 
output like above with Linux 3.17-rc4.

Now i want to test the mxs-regulator driver with the cpufreq-cpu0 as 
consumer. So i defined cpu at 0 according to cpufreq-cpu0 binding in 
imx28.dtsi and enabled cpufreq-cpu0 driver and userspace gov in Kernel 
config.

But if i modprobe cpufreq-cpu0 i don't get any output and the entry 
/sys/devices/system/cpu/cpu0/cpufreq is also missing.

Any ideas, what's wrong or missing?

Best regards
Stefan

PS: Here the relevant config:

# .config
#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
# CONFIG_CPU_FREQ_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
CONFIG_CPU_FREQ_GOV_USERSPACE=y
# CONFIG_CPU_FREQ_GOV_ONDEMAND is not set
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
CONFIG_GENERIC_CPUFREQ_CPU0=m

# imx28.dtsi

[...]

cpus {
	#address-cells = <1>;
	#size-cells = <0>;

	cpu: cpu at 0 {
		compatible = "arm,arm926ej-s";
		device_type = "cpu";
		operating-points = <
			/* kHz	uV */
			454736	1550000
			392727	1475000
			360000	1375000
			261818	1275000
			64000	1050000
		>;
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
