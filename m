From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 11 Oct 2017 18:54:04 +0300
Subject: [PATCH 5/7] ARM: dts: Add nodes for missing omap4 interconnect
 target modules
In-Reply-To: <20170929223411.9691-6-tony@atomide.com>
References: <20170929223411.9691-1-tony@atomide.com>
 <20170929223411.9691-6-tony@atomide.com>
Message-ID: <f5c57f0b-1423-c362-0fda-4069b77a2e38@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

On 09/30/2017 01:34 AM, Tony Lindgren wrote:
> On omap4 we are missing dts nodes for several interconnect target
> modules that we are idling on init. This currently works with the
> legacy platform data still around.
> 
> To fix this, let's add the interconnect target modules so we can
> idle the unused interconnect target module on init.
> 
> Also note that adding the interconnect target module node does not
> necessarily mean that there is a driver available for the child IP
> block, or that the child IP block is even functional.
> 
> In the SGX case, the PowerVR driver is closed source. And McASP on
> omap4 has at least the TX path disabled and is not supported by the
> davinci-mcasp driver.

RX path is disabled, TX is supposed to work.

...

> +		target-module at 40128000 {
> +			compatible = "ti,sysc-mcasp";
> +			ti,hwmods = "mcasp";
> +			reg = <0x40128004 0x4>;
> +			reg-names = "sysc";
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			ranges = <0x00000000 0x40128000 0x1000>, /* MPU */
> +				 <0x49028000 0x49028000 0x1000>; /* L3 */
> +
> +			/*
> +			 * Child device unsupported by davinci-mcasp. At least
> +			 * TX path is disabled for omap4, and only DIT mode

s/TX/RX

> +			 * works with no I2S. See also old Android kernel
> +			 * omap-mcasp driver for more information.

I'll look at the schema of PandaBoard to see if I can route out the McASP
lines to somewhere then I can add support for this revision to davinci-mcasp
driver.

-- 
P?ter
