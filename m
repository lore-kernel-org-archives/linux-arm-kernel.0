From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 6 Jan 2017 09:04:17 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS
In-Reply-To: <9f508097-f605-ebd8-20af-c3e798c6fdcc@poczta.onet.pl>
References: <1483628549-29486-1-git-send-email-narmstrong@baylibre.com>
 <9f508097-f605-ebd8-20af-c3e798c6fdcc@poczta.onet.pl>
Message-ID: <cd6bbd24-f014-7342-34e6-ead7eec429f4@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/05/2017 08:04 PM, Micha? Zegan wrote:
> Hello.
> 
> The patch causes cpufreq module (scpi-cpufreq) not to detect cpufreq, so
> it actually works, but...
> Loading the module causes few errors because of not found frequencies or
> something, then it is all okay. However after loading scpi-cpufreq you
> cannot actually power the cpu off and on. You will power it off
> successfully, but when trying to power it on, the cpufreq driver will
> error out, and then after it happens, the cpu that was trying to go
> online will be offline again, and that is a little... unfortunate. The
> question is, and I cannot really test that: will the module actually
> autoload after this change?

Hi Michal,

You are right, it breaks cpufreq and the cpu hotplug feature, I will send a v2 completely disabling cpufreq instead.

For the module autoloading, the arm_scpi.ko must be loaded before the other scpi modules.

Please ask Sudeep Holla <sudeep.holla@arm.com> if module autoloading for scpi is meant to work.

Neil


> 
> W dniu 05.01.2017 o 16:02, Neil Armstrong pisze:
>> The current hardware is not able to run with all cores enabled at a
>> cluster frequency superior at 1536MHz.
>> But the currently shipped u-boot for the platform still reports an OPP
>> table with possible DVFS frequency up to 2GHz, and will not change since
>> the off-tree linux tree supports limiting the OPPs with a kernel parameter.
>> A recent u-boot change reports the boot-time DVFS around 100MHz and
>> the default performance cpufreq governor sets the maximum frequency.
>> Previous version of u-boot reported to be already at the max OPP and
>> left the OPP as is.
>> Nevertheless, other governors like ondemand could setup the max frequency
>> and make the system crash.
>>
>> This patch disables the DVFS clock and disables cpufreq.
>>
>> Fixes: 70db166a2baa ("ARM64: dts: meson-gxbb: Add SCPI with cpufreq & sensors Nodes")
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> index 238fbea..5e63e3b 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> @@ -137,6 +137,10 @@
>>  	};
>>  };
>>  
>> +&scpi_dvfs {
>> +	status = "disabled";
>> +};
>> +
>>  &uart_AO {
>>  	status = "okay";
>>  	pinctrl-0 = <&uart_ao_a_pins>;
>>
> 


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170106/f360c5ac/attachment-0001.sig>
