From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Sat, 15 Feb 2014 12:18:00 -0300
Subject: [PATCH 1/2] clk: fixed-rate: use full DT node name
In-Reply-To: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
References: <1392358613-19962-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <52FF8528.2020404@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Stephen,

El 14/02/14 03:16, Stephen Warren escribi?:
> clk-fixed-rate currently names clocks according to a node's name without
> the unit address. When faced with the legal and technically correct DT
> structure below, this causes rgistration attempts for 3 clocks with the
> same name, 2 of which fail.
>
> 	clocks {
> 		compatible = "simple-bus";
> 		#address-cells = <1>;
> 		#size-cells = <0>;
>
> 		clk_mmc: clock at 0 {
> 			compatible = "fixed-clock";
> 			reg = <0>;
> ...
> 		clk_i2c: clock at 1 {
> 			compatible = "fixed-clock";
> 			reg = <1>;
> ...
> 		clk_spi: clock at 2 {
> 			compatible = "fixed-clock";
> 			reg = <2>;
> ...
>
> Solve this by naming the clocks after the full node name rather than the
> short version (e.g. /clocks/clock at 0).

An alternative that doesn't require any change in the driver would be to 
use the optional but recommended clock-output-names property from the 
common clock binding.

Your DT would then look something like the following

 > ...
 > 		clk_mmc: clk at 0 {
 > 			compatible = "fixed-clock";
 > 			clock-output-names = "mmc";
 > ...
 > 		clk_i2c: clk at 1 {
 > 			compatible = "fixed-clock";
 > 			clock-output-names = "i2c";
 > ...
 > 		clk_spi: clk at 2 {
 > 			compatible = "fixed-clock";
 > 			clock-output-names = "spi";
 > ...

Cheers,

Emilio
