From: hkallweit1@gmail.com (Heiner Kallweit)
Date: Tue, 7 Feb 2017 21:43:11 +0100
Subject: [PATCH] ARM64: dts: meson-gxbb: set reset for ethernet
In-Reply-To: <259f7102-591b-f251-5844-a864fa39e137@baylibre.com>
References: <ec31eddc-d286-d0bc-0bdb-ae9d5014d82e@gmail.com>
 <259f7102-591b-f251-5844-a864fa39e137@baylibre.com>
Message-ID: <f2759982-28c6-db7b-2e0a-48f3ed90adf5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 06.02.2017 um 10:29 schrieb Neil Armstrong:
> On 01/29/2017 03:07 PM, Heiner Kallweit wrote:
>> Add reset control for ethernet.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> index 39a774ad..753fddf6 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
>> @@ -113,6 +113,8 @@
>>  		 <&clkc CLKID_FCLK_DIV2>,
>>  		 <&clkc CLKID_MPLL2>;
>>  	clock-names = "stmmaceth", "clkin0", "clkin1";
>> +	resets = <&reset RESET_ETHERNET>;
>> +	reset-names = "stmmaceth";
>>  };
>>  
>>  &aobus {
>>
> 
> Hi,
> 
> Actually this is a no-op since the Amlogic reset controller only supports "pulse" resets and the
> STMMAC driver only supports "level" resets. If you want to use this reset, you must add the
> corresponding support code in the meson8b glue code to call device_reset().
> 
Thanks for the hint! I did some further tests to check the "nature" of the reset register bits.
Setting a reset bit and immediately reading it back always returns 0.
And the chip spec doesn't mention whether writing a reset bit triggers a reset pulse or
whether it asserts the reset line.
Therefore I'm a little clueless whether it's possible to have "level" resets.

> Neil
> 
