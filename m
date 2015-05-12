From: bintian.wang@huawei.com (Bintian)
Date: Tue, 12 May 2015 13:06:38 +0800
Subject: [PATCH v5 0/6] arm64,hi6220: Enable Hisilicon Hi6220 SoC
In-Reply-To: <20150512030542.GA5889@leoy-linaro>
References: <1431007225-8513-1-git-send-email-bintian.wang@huawei.com>
 <7ha8xgi10e.fsf@linaro.org>
 <CAAS=xmjR9a-M961-7+9LF2G18qiXYhT+1sb5TEbbrQcW1fnRtw@mail.gmail.com>
 <CAGa+x85QDAzP_8_rPF3H0KpXO9rR2OhzYnMnAFydmBMicDzmEw@mail.gmail.com>
 <20150512030542.GA5889@leoy-linaro>
Message-ID: <55518A5E.7090608@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Kevin,

On 2015/5/12 11:05, Leo Yan wrote:
> hi Kevin,
>
> On Mon, May 11, 2015 at 05:20:54PM -0700, Kevin Hilman wrote:
>> On Thu, May 7, 2015 at 4:11 PM, Brent Wang <wangbintian@gmail.com> wrote:
>>> Hello Kevin,
>>>
>>> 2015-05-08 4:30 GMT+08:00 Kevin Hilman <khilman@linaro.org>:
>>>> Bintian Wang <bintian.wang@huawei.com> writes:
>>>>
>>>>> Hi6220 is one mobile solution of Hisilicon, this patchset contains
>>>>> initial support for Hi6220 SoC and HiKey development board, which
>>>>> supports octal ARM Cortex A53 cores. Initial support is minimal and
>>>>> includes just the arch configuration, clock driver, device tree
>>>>> configuration.
>>>>>
>>>>> PSCI is enabled in device tree and there is no problem to boot all the
>>>>> octal cores, and the CPU hotplug is also working now, you can download
>>>>> and compile the latest firmware based on the following link to run this
>>>>> patch set:
>>>>> https://github.com/96boards/documentation/wiki/UEFI
>>>>
>>>> Do you have any tips for booting this using the HiSi bootloader?  It
>>>> seems that I need to add the magic hisi,boardid property for dtbTool to
>>>> work.  Could you share what that magic value is?
>>> Yes, you need it.
>>> Hisilicon has many different development boards and those boards have some
>>> different hardware configuration, so we need different device tree
>>> files for them.
>>> the original hisi,boardid is used to distinguish different boards and
>>> used by the
>>> bootloader to judge which device tree to use at boot-up.
>>>
>>>> and maybe add it to the wiki someplace?
>>> Maybe add to section "Known Issues" in
>>> "https://github.com/96boards/documentation/wiki/UEFI"
>>> is a good choice, I will update this section later.
>>
>> You updated the wiki, but you didn't specify what the value should be
>> for this to work with the old bootloader.
>>
>> Can you please give the value of that property?
hisi,boardid = <0 0 4 3>
It is needed by the old hisilicon bootloader.

I also updated the wiki page.
>>
>> Also, have you tested this series with the old bootloader as well?
>
> Below are my testing result w/t Bintian's patches and Hisilicon old
> bootloader:
> - Need add property "hisi,boardid" into dts;
> - Need change cpu enable-method from "psci" to "spin-table";
> - The bootloader has not initialized register *cntfrq_el0* so will
>    introduce the failure during init arch timer.
>
> For init cntfrq_el0, we need fix this issue in Hisilicon's old
> bootloader, rather than directly add "clock-frequency" for arch
> timer's node in DTS. i will try to commit one patch for fix this
> issue for Hisilicon's old bootloader.
>
> So i think upper issues mainly are introduced by Hisilicon's old
> bootloader but not come from Bintian's patches. How about u think for
> this?
>
> Below is my local diff which is used to compatible w/t Hisilicon's
> old bootloader; Just for your reference.
>
> Thanks,
> Leo Yan
>
> ---8<---
>
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> index e36a539..fd1f89e 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
> @@ -14,6 +14,7 @@
>
>   / {
>   	model = "HiKey Development Board";
> +	hisi,boardid = <0 0 4 3>;
>   	compatible = "hisilicon,hi6220-hikey", "hisilicon,hi6220";
>
>   	aliases {
> diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> index 229937f..8ade3d9 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
> @@ -13,11 +13,6 @@
>   	#address-cells = <2>;
>   	#size-cells = <2>;
>
> -	psci {
> -		compatible = "arm,psci-0.2";
> -		method = "smc";
> -	};
> -
>   	cpus {
>   		#address-cells = <2>;
>   		#size-cells = <0>;
> @@ -57,56 +52,64 @@
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x0>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>
>   		cpu1: cpu at 1 {
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x1>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>
>   		cpu2: cpu at 2 {
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x2>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>
>   		cpu3: cpu at 3 {
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x3>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>
>   		cpu4: cpu at 100 {
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x100>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>
>   		cpu5: cpu at 101 {
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x101>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>
>   		cpu6: cpu at 102 {
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x102>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>
>   		cpu7: cpu at 103 {
>   			compatible = "arm,cortex-a53", "arm,armv8";
>   			device_type = "cpu";
>   			reg = <0x0 0x103>;
> -			enable-method = "psci";
> +			enable-method = "spin-table";
> +			cpu-release-addr = <0x0 0x740fff8>;
>   		};
>   	};
>
> @@ -129,6 +132,7 @@
>   			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>   			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>,
>   			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
> +		clock-frequency = <1200000>;
>   	};
>
>   	soc {
Thanks for Leo's replies, Leo is responsible for bootloader
development, you can contact him if you have any problem about
bootloader.

Thanks,

Bintian
>
> .
>
