From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 24 May 2015 23:55:22 +0800
Subject: [linux-sunxi] Re: [RFC 7/7] ARM: dts: sun9i: Add secure SRAM node
 used for MCPM SMP hotplug
In-Reply-To: <20150520100831.GE4004@lukather>
References: <1431583811-25780-1-git-send-email-wens@csie.org>
 <1431583811-25780-8-git-send-email-wens@csie.org>
 <20150520100831.GE4004@lukather>
Message-ID: <CAGb2v67+F_cnjHXgGwbewPODG=mLMPGaZCzvvLfXL=A3huceew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 6:08 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Thu, May 14, 2015 at 02:10:11PM +0800, Chen-Yu Tsai wrote:
>> The A80 stores some magic flags in a portion of the secure SRAM. The
>> BROM jumps directly to the software entry point set by the SMP code
>> if the flags are set. This is required for CPU0 hotplugging.
>>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  arch/arm/boot/dts/sun9i-a80.dtsi | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
>> index 1507bd2a88f0..0695215634d4 100644
>> --- a/arch/arm/boot/dts/sun9i-a80.dtsi
>> +++ b/arch/arm/boot/dts/sun9i-a80.dtsi
>> @@ -366,6 +366,26 @@
>>                */
>>               ranges = <0 0 0 0x20000000>;
>>
>> +             sram_b: sram at 00020000 {
>> +                     /* 256 KiB secure SRAM at 0x20000 */
>> +                     compatible = "mmio-sram";
>> +                     reg = <0x00020000 0x40000>;
>> +
>
> We should probably add a property to that SRAM to tell the driver not
> to access it if we're not booted in secure mode.

(CC-ing Heiko...)

That kind of puts architecture (ARM) dependent code into a platform
driver. Furthermore, AFAIK there isn't a safe way to check if we're
in secure mode or not. Checking SCR raises an undefined instruction
exception in non-secure mode. Can the kernel handle that? I really
don't understand this bit well.

> Otherwise, bad things might happen.

The kernel (or rather the bootloader) boots in secure mode by default,
and we don't have any bootloader support to boot into non-secure mode
ATM. Couldn't we have the bootloader mark the SRAM as disabled when
booting into non-secure when we add that support?


ChenYu
