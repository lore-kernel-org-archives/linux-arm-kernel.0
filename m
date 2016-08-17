From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 17 Aug 2016 16:10:09 +0200
Subject: [PATCH 1/2] ARM: dts: rockchip: remove excess sd properties for
 firefly reload
In-Reply-To: <af99cf05-dfc7-1ae6-8d23-f33298b5f683@soulik.info>
References: <522097f6-8b5c-ee6d-c1b1-a63840228a0e@rock-chips.com>
 <35898684.O6p1GdTFI2@phil> <af99cf05-dfc7-1ae6-8d23-f33298b5f683@soulik.info>
Message-ID: <19126716.OZv44ZHtAK@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag, 14. August 2016, 20:38:59 schrieb ayaka:
> On 08/14/2016 08:30 PM, Heiko Stuebner wrote:
> > Am Sonntag, 14. August 2016, 19:27:23 CEST schrieb Randy Li:
> >> Because of a bug in hardware design, the sdcard at firefly
> >> rk3288 reload board can't switch the io voltage level to 1.8v.
> >> 
> >> Signed-off-by: Randy Li <ayaka@soulik.info>
> >> ---
> >> 
> >>   arch/arm/boot/dts/rk3288-firefly-reload.dts | 7 +------
> >>   1 file changed, 1 insertion(+), 6 deletions(-)
> >> 
> >> diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts
> >> b/arch/arm/boot/dts/rk3288-firefly-reload.dts index 43145d1..a2b1f14
> >> 100644
> >> --- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
> >> +++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
> >> @@ -202,18 +202,13 @@
> >> 
> >>   	bus-width = <4>;
> >>   	cap-mmc-highspeed;
> >>   	cap-sd-highspeed;
> >> 
> >> -	sd-uhs-sdr12;
> >> -	sd-uhs-sdr25;
> >> -	sd-uhs-sdr50;
> >> -	sd-uhs-sdr104;
> >> -	sd-uhs-ddr50;
> >> 
> >>   	card-detect-delay = <200>;
> >>   	disable-wp;
> >>   	num-slots = <1>;
> >>   	pinctrl-names = "default";
> >>   	pinctrl-0 = <&sdmmc_clk>, <&sdmmc_cmd>, <&sdmmc_cd>, <&sdmmc_bus4>;
> >>   	vmmc-supply = <&vcc_sd>;
> >> 
> >> -	vqmmc-supply = <&vccio_sd>;
> >> +	vqmmc-supply = <&vcc_sd>;
> > 
> > that looks wrong. vccio_sd is still the vqmmc supply in the schematics
> > even
> > though we don't want to switch to 1.8V . But that regulator should still
> > be
> 
> I think the vccio_sd is just the one connected to the io_domains, but
> the voltage source for the
> pull up register is not vccio_sd but vcc_io.

vqmmc-supply is the so called io-voltage according to the code and also the 
jedec spec (VCCQ). And the sdmmc0_vdd that vccio_sd is connected to is exactly 
that ... according to the rk3288 datasheet the "SDMMC0 Digital IO Power 
Supply", so that connection is not only meaningful for the iodomains, but _is_ 
an actual supply and if you turn off vccio_sd, you probably won't get any 
sdmmc transfers at all ;-) .

So yes, due to the resistor misheap vccio_sd should stay limited to 3.3V, but 
its connection as vqmmc should stay.
