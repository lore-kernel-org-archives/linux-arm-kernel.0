From: swarren@wwwdotorg.org (Stephen Warren)
Date: Sun, 01 Dec 2013 12:15:07 -0700
Subject: [PATCH 04/31] ARM: tegra: update DT files to add reset properties
In-Reply-To: <20131129130031.GQ22771@ulmo.nvidia.com>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-5-git-send-email-swarren@wwwdotorg.org>
 <20131129130031.GQ22771@ulmo.nvidia.com>
Message-ID: <529B8ABB.5040109@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2013 06:00 AM, Thierry Reding wrote:
> On Fri, Nov 15, 2013 at 01:53:59PM -0700, Stephen Warren wrote: 
> [...]
>> @@ -135,8 +140,10 @@ reg-shift = <2>; interrupts = <GIC_SPI 37
>> IRQ_TYPE_LEVEL_HIGH>; nvidia,dma-request-selector = <&apbdma 9>; 
>> -		status = "disabled"; clocks = <&tegra_car
>> TEGRA114_CLK_UARTB>; +		resets = <&tegra_car 7>;
> 
> This is confusing. For some reason that escapes me the
> tegra114-car.h file defines TEGRA114_CLK_UARTB as 192. Other reset
> entries match the numerical value of the TEGRA114_CLK_* define,
> which makes it easy to double-check this.
> 
> But UARTB is indeed at bit 7, so this looks good.
> 
> Oh, I think perhaps it's caused by bit 7 being shared by both the
> UARTB and the VFIR controllers for reset, but not for the clocks.

Yes, there's a single reset bit that affects 2 HW modules, yet each HW
module has its own clock. So the reset and clock IDs don't exactly
align. That's the main reason I wanted to switch the drivers to the
reset framework rather than piggy-backing on the clock framework to do
resets, so the difference in name-spaces is explicit.

>> reg = <0x70080300 0x100>; nvidia,ahub-cif-ids = <4 4>; clocks =
>> <&tegra_car TEGRA114_CLK_I2S0>;
> 
> The clocks for these i2s devices are already listed in the ahub
> node. Is that on purpose?

Yes.

The AHUB driver needs to remove reset from the HW modules, so that the
configlink bus works. Reset removal used to require a custom Tegra API
that took a clock as a parameter. Hence, the AHUB node needed the
clock reference. After this series, the AHUB only needs a reset handle
to use the standard reset API. However, the clock references are left
in the AHUB node until after the AHUB driver is converted, so the
series is bisectable. After the series, only the I2S driver needs to
clock references.

>> @@ -110,6 +118,8 @@ reg = <0x54080000 0x00040000>; interrupts =
>> <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>; clocks = <&tegra_car
>> TEGRA30_CLK_VI>; +			resets = <&tegra_car 164>;
> 
> I think this needs to be 20.

OK, I'll check that when I get back...

>> +			 <&tegra_car 30>,  /* i2s0 */ +			 <&tegra_car 11>,  /* i2s1
>> */ +			 <&tegra_car 18>,  /* i2s2 */ +			 <&tegra_car 101>, /*
>> i2s3 */ +			 <&tegra_car 102>, /* i2s4 */
> 
> Some comment for these as for Tegra20.

I'm not sure which other comment was "for Tegra20", since none of the
filenames were quoted, but I'll try to check when I get back.
