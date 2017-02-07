From: robh@kernel.org (Rob Herring)
Date: Tue, 7 Feb 2017 11:27:47 -0600
Subject: [PATCH v3 16/18] drivers/fsi: Add documentation for GPIO based
 FSI master
In-Reply-To: <20170201165358.45415-17-cbostic@linux.vnet.ibm.com>
References: <20170201165358.45415-1-cbostic@linux.vnet.ibm.com>
 <20170201165358.45415-17-cbostic@linux.vnet.ibm.com>
Message-ID: <20170207172747.koe5lb2skyxxjzzy@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 10:53:56AM -0600, Christopher Bostic wrote:
> From: Chris Bostic <cbostic@us.ibm.com>
> 
> Define the device tree bindings for the GPIO master type.
> 
> Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
> ---
>  .../devicetree/bindings/fsi/fsi-master-gpio.txt    | 71 ++++++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
> new file mode 100644
> index 0000000..5d589bf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
> @@ -0,0 +1,71 @@
> +Device-tree bindings for FSI master implemented with GPIO
> +---------------------------------------------------------
> +
> +Typically a FSI master is defined in hardware with output control
> +lines designated for Enable, Data, Clock, etc..  In the case of
> +a 'GPIO FSI master', however, it may be the case that there is no
> +such master defined in hardware and must be implemented in standard
> +GPIO to interact with its slaves.  In this 'virtual' FSI master
> +case the GPIO pins representing clk and data are directly
> +connected to the slaves.
> +
> +The GPIO FSI master node
> +-------------------------
> +This node describes a FSI master implmented with GPIO.
> +Required property:
> +	compatible = "ibm,fsi-master-gpio"
> +
> +The standard FSI master node
> +----------------------------
> +This node describes a FSI master implmemented fully in hardware
> +with dedicated input/output pins required for its function (i.e.
> +not using generic GPIO pins).
> +Required property:
> +	compatible = "ibm,fsi-master"

This section still needs to be a separate doc. And ibm,fsi-master is too 
generic.

> +
> +
> +GPIO FSI master property/pin descriptions
> +------------------------------------------
> +clk -	The master controlled clock line that indicates to the
> +	slave when to read in or send out new data - required.

Just put the definitions with the properties (i.e. clk-gpios).

> +data -	The serial data line containing information to be sent or
> +	received by the master.  This line is bi-directional.  During
> +	command phase the master controls the line and when a response
> +	is required the slave takes control - required.
> +enable - Controls power state of data line - optional.
> +trans - Voltage translator control. In some applications the data line
> +	must have its signal levels altered by a translator. If this is
> +	necessary then control of signal direction is managed via this
> +	line - optional.
> +mux -	Multiplexor control.  This activates/deactivates the data line
> +	in cases where it is one of many possible selections via mux -
> +	optional.
> +
> +Required properties:
> +	- compatible = "ibm,fsi-master-gpio";
> +	- clk-gpios;
> +	- data-gpios;
> +
> +Optional properties:
> +	- enable-gpios;
> +	- trans-gpios;
> +	- mux-gpios;
> +
> +Order of property activation:
> +1. clk
> +2. data
> +3. trans
> +4. enable
> +5. mux
> +
> +
> +Example:
> +
> +fsi-master {
> +	compatible = "ibm,fsi-master-gpio", "ibm,fsi-master";

Aren't these 2 mutually exclusive?

> +	clk-gpios = <&gpio 0>, <&gpio 6>;
> +	data-gpios = <&gpio 1>, <&gpio 7>;
> +	enable-gpios = <&gpio 2>, <&gpio 8>;
> +	trans-gpios = <&gpio 3>, <&gpio 9>;
> +	mux-gpios = <&gpio 4>, <&gpio 10>;
> +}
> -- 
> 1.8.2.2
> 
