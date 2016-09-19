From: robh@kernel.org (Rob Herring)
Date: Mon, 19 Sep 2016 16:14:00 -0500
Subject: [PATCH v2 1/2] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <20160901025328.376-2-d-gerlach@ti.com>
References: <20160901025328.376-1-d-gerlach@ti.com>
 <20160901025328.376-2-d-gerlach@ti.com>
Message-ID: <20160919211400.GA4276@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 09:53:27PM -0500, Dave Gerlach wrote:
> Add the device tree bindings document for the TI CPUFreq/OPP driver
> on AM33xx, AM43xx, DRA7, and AM57 SoCs. The operating-points-v2 binding
> allows us to provide an opp-supported-hw property for each OPP to define
> when it is available. This driver is responsible for reading and parsing
> registers to determine which OPPs can be selectively enabled based
> on the specific SoC in use by matching against the opp-supported-hw
> data.

Sorry, for the delay. Missed this somehow.

> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v1->v2:
> 	- Dropped all driver/linux specific documentation
> 	- Fixed some typos
> 	- Add new compatibles for each SoC family to match against
> 	- Switched to use am335x example to better demonstrate field one of
> 	  opp-supported-hw.
> 
>  .../devicetree/bindings/cpufreq/ti-cpufreq.txt     | 130 +++++++++++++++++++++
>  1 file changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
> 
> diff --git a/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
> new file mode 100644
> index 000000000000..6276ae494121
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt
> @@ -0,0 +1,130 @@
> +TI CPUFreq and OPP bindings
> +================================
> +
> +Certain TI SoCs, like those in the am335x, am437x, am57xx, and dra7xx
> +families support different OPPs depending on the silicon variant in use.
> +The ti_cpufreq driver can use revision and an efuse value from the SoC to
> +provide the OPP framework with supported hardware information. This is
> +used to determine which OPPs from the operating-points-v2 table get enabled
> +when it is parsed by the OPP framework.
> +
> +Required properties:
> +--------------------
> +In 'cpus' nodes:
> +- operating-points-v2: Phandle to the operating-points-v2 table to use.
> +- ti,syscon-efuse: Syscon phandle, offset to efuse register, efuse register
> +		   mask, and efuse register shift to get the relevant bits
> +		   that describe OPP availability.
> +- ti,syscon-rev: Syscon and offset used to look up revision value on SoC.

These have nothing to do with a cpu, so they don't belong here. Maybe 
the first is a property of an OPP table, but the second certainly is 
not.

> +
> +In 'operating-points-v2' table:
> +- compatible: Should be
> +	- 'operating-points-v2-ti-am3352-cpu' for am335x SoCs
> +	- 'operating-points-v2-ti-am4372-cpu' for am43xx SoCs
> +	- 'operating-points-v2-ti-dra7-cpu' for dra7xx/am57xx SoCs
> +
> +- opp-supported-hw: Two bitfields indicating:
> +	1. Which revision of the SoC the OPP is supported by
> +	2. Which eFuse bits indicate this OPP is available

I tend to think you should handle this with kernel code (bootloader 
really) fixing up the OPP table as necessary rather than putting in DT.

Rob
