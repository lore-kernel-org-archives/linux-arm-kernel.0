From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 22 Aug 2014 13:37:49 +0200
Subject: [PATCH v7] ARM: dts: Prepare node labels for exynos5250
In-Reply-To: <080101cfbdf6$c8fd1f30$5af75d90$@samsung.com>
References: <53DCD74B.8090400@gmail.com>
 <1408539764-5835-1-git-send-email-afaerber@suse.de>
 <080101cfbdf6$c8fd1f30$5af75d90$@samsung.com>
Message-ID: <53F72B8D.1080305@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.08.2014 12:49, schrieb Kukjin Kim:
> Andreas F?rber wrote:
>>
>> Allows them to be extended by reference.
>>
>> Reviewed-by: Doug Anderson <dianders@chromium.org>
>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>> ---
>>  v6 -> v7:
>>  * Dropped uart* labels (Tomasz Figa)
>>
>>  v6: Split off from Snow/SMDK cleanups (Doug Anderson)
>>
>>  arch/arm/boot/dts/exynos5250.dtsi | 16 ++++++++--------
>>  1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
>> index 492e1eff37bd..42eafd19cfb2 100644
>> --- a/arch/arm/boot/dts/exynos5250.dtsi
>> +++ b/arch/arm/boot/dts/exynos5250.dtsi
>> @@ -218,7 +218,7 @@
>>  		clock-names = "fimg2d";
>>  	};
>>
>> -	codec at 11000000 {
>> +	mfc: codec at 11000000 {
>>  		compatible = "samsung,mfc-v6";
>>  		reg = <0x11000000 0x10000>;
>>  		interrupts = <0 96 0>;
>> @@ -227,7 +227,7 @@
>>  		clock-names = "mfc";
>>  	};
>>
>> -	rtc at 101E0000 {
>> +	rtc: rtc at 101E0000 {
>>  		clocks = <&clock CLK_RTC>;
>>  		clock-names = "rtc";
>>  		status = "disabled";
>> @@ -261,7 +261,7 @@
>>  		clock-names = "uart", "clk_uart_baud0";
>>  	};
>>
>> -	sata at 122F0000 {
>> +	sata: sata at 122F0000 {
>>  		compatible = "snps,dwc-ahci";
>>  		samsung,sata-freq = <66>;
>>  		reg = <0x122F0000 0x1ff>;
>> @@ -573,7 +573,7 @@
>>  		#phy-cells = <1>;
>>  	};
>>
>> -	usb at 12110000 {
>> +	ehci: usb at 12110000 {
> 
> I'm not sure which one is recommended between above and "ehci: ehci at 12110000 {"
> 
>>  		compatible = "samsung,exynos4210-ehci";
>>  		reg = <0x12110000 0x100>;
>>  		interrupts = <0 71 0>;
>> @@ -588,7 +588,7 @@
>>  		};
>>  	};
>>
>> -	usb at 12120000 {
>> +	ohci: usb at 12120000 {
> 
> Same as above...

A quick git-grep in v3.16.1 shows both ways used in arch/arm/boot/dts/:
 usb@: 232
 xhci@: 0
 ehci@: 41
 ohci@: 60
 uhci@: 7

>>  		compatible = "samsung,exynos4210-ohci";
>>  		reg = <0x12120000 0x100>;
>>  		interrupts = <0 71 0>;
>> @@ -725,7 +725,7 @@
>>  		clock-names = "gscl";
>>  	};
>>
>> -	hdmi {
>> +	hdmi: hdmi {
> 
> Should be
> 
> +	hdmi: hdmi at 14530000 { ?

Actually, without applying this patch and my follow-up cleanups strictly
using these new labels, we can't rename any of the nodes here, since it
would break the derived .dts files. It was specifically requested in v5
to make this patch here separate from subsequent uses of the new labels
for the benefit of cherry-picking.

So since you don't seem to disagree with the label names that I add
here, I consider renaming nodes outside the scope of this patch.

+1 for reflecting the reg address in the unit address of the hdmi node
as a follow-up to the refactorings, if that does not break any driver
assumptions.

Regards,
Andreas

>>  		compatible = "samsung,exynos4212-hdmi";
>>  		reg = <0x14530000 0x70000>;
>>  		interrupts = <0 95 0>;
>> @@ -751,14 +751,14 @@
>>  		#phy-cells = <0>;
>>  	};
>>
>> -	dp-controller at 145B0000 {
>> +	dp: dp-controller at 145B0000 {
>>  		clocks = <&clock CLK_DP>;
>>  		clock-names = "dp";
>>  		phys = <&dp_phy>;
>>  		phy-names = "dp";
>>  	};
>>
>> -	fimd at 14400000 {
>> +	fimd: fimd at 14400000 {
>>  		clocks = <&clock CLK_SCLK_FIMD1>, <&clock CLK_FIMD1>;
>>  		clock-names = "sclk_fimd", "fimd";
>>  	};
>> --
>> 2.0.4

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
