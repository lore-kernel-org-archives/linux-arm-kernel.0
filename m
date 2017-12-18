From: baruch@tkos.co.il (Baruch Siach)
Date: Mon, 18 Dec 2017 22:33:24 +0200
Subject: [PATCH v4 01/12] dt-bindings: thermal: Describe Armada AP806 and
 CP110
In-Reply-To: <20171218143643.7714-2-miquel.raynal@free-electrons.com>
References: <20171218143643.7714-1-miquel.raynal@free-electrons.com>
 <20171218143643.7714-2-miquel.raynal@free-electrons.com>
Message-ID: <20171218203324.ftyqrgjawkujvhmn@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Miqu?l,

On Mon, Dec 18, 2017 at 03:36:32PM +0100, Miquel Raynal wrote:
> From: Baruch Siach <baruch@tkos.co.il>
> 
> Add compatible strings for AP806 and CP110 that are part of the Armada
> 8k/7k line of SoCs.
> 
> Add a note on the differences in the size of the control area in
> different bindings. This is an existing difference between the Armada
> 375 binding and the other boards already supported. The new AP806 and
> CP110 bindings are similar to the existing Armada 375 in this regard.
> 
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> [<miquel.raynal@free-electrons.com>: reword, additional details]
> Signed-off-by: Miquel Raynal <miquel.raynal@free-electrons.com>
> ---
>  .../devicetree/bindings/thermal/armada-thermal.txt | 24 +++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> index 24aacf8948c5..9b7b2c03cc6f 100644
> --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> @@ -7,17 +7,31 @@ Required properties:
>  		marvell,armada375-thermal
>  		marvell,armada380-thermal
>  		marvell,armadaxp-thermal
> +		marvell,armada-ap806-thermal
> +		marvell,armada-cp110-thermal
>  
>  - reg:		Device's register space.
>  		Two entries are expected, see the examples below.
> -		The first one is required for the sensor register;
> -		the second one is required for the control register
> -		to be used for sensor initialization (a.k.a. calibration).
> +		The first one points to the status register (4B).
> +		The second one points to the control registers (8B).
> +		Note: with legacy bindings, the second entry pointed
> +		only to the so called "control MSB" ("control 1"), was
> +		4B wide and did not let the possibility to reach the
> +		"control LSB" ("control 0") register. This is only
> +		allowed for compatibility reasons in Armada
> +		370/375/38x/XP DT nodes.

"allowed" is not the right term, IMO. Legacy compatibles MUST point to the MSB 
control register to preserve compatibility with existing DTs.

The original patch had a list of legacy and non-legacy compatibles. I think we 
need to keep them.

baruch

> -Example:
> +Examples:
>  
> +	/* Legacy bindings */
>  	thermal at d0018300 {
>  		compatible = "marvell,armada370-thermal";
> -                reg = <0xd0018300 0x4
> +		reg = <0xd0018300 0x4
>  		       0xd0018304 0x4>;
>  	};
> +
> +	ap_thermal: thermal at 6f8084 {
> +		compatible = "marvell,armada-ap806-thermal";
> +		reg = <0x6f808C 0x4>,
> +		      <0x6f8084 0x8>;
> +	};

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
