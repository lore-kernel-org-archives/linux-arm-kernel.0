From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 7 Dec 2016 12:02:05 +0000
Subject: [PATCH 15/16] drivers/fsi: Add documentation for GPIO bindings
In-Reply-To: <1481069677-53660-16-git-send-email-christopher.lee.bostic@gmail.com>
References: <1481069677-53660-1-git-send-email-christopher.lee.bostic@gmail.com>
 <1481069677-53660-16-git-send-email-christopher.lee.bostic@gmail.com>
Message-ID: <20161207120204.GC7054@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 06:14:36PM -0600, Chris Bostic wrote:
> From: Chris Bostic <cbostic@us.ibm.com>
> 
> Add fsi master gpio device tree binding documentation

Please see Documentation/devicetree/bindings/submitting-patches.txt.

Specifically:

* Please put binding documents earlier in the series than code
  implementing the binding.

* Please document _all_ compatible strings used in the
  series.

Please also write the binding documents in terms of the hardware, rather
then the driver (e.g. introduce what the hardware is in the document,
don't mention the driver). The bindings are there to describe the former
to the latter, and the latter may change arbitrarily.

> Signed-off-by: Chris Bostic <cbostic@us.ibm.com>
> ---
>  .../devicetree/bindings/fsi/fsi-master-gpio.txt     | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
> 
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt

AFAICT, this is the first use of this directory. We should have a
general FSI binding document in there, covering what FSI is, the
"ibm,fsi-master" binding, etc.

> new file mode 100644
> index 0000000..ff3a62e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-gpio.txt
> @@ -0,0 +1,21 @@
> +Device-tree bindings for gpio-based FSI master driver

There's very little information here, so I'm not sure what to make of
this. Can you please elaborate on the above to make it clear what this
means?

IIUC, this is an FSI controller/master that we only communicate with via
GPIOs, right?

Or is this a *virtual* master? i.e. the GPIOs themselves form the master
and are directly connected to slaves?

> +-----------------------------------------------------
> +
> +Required properties:
> +	- compatible = "ibm,fsi-master-gpio";
> +	- clk-gpios;
> +	- data-gpios;

Please give a description of what each of these are used for, how many
are required, and what order elements must come in.

> +Optional properties:
> +	- enable-gpios;
> +	- trans-gpios;
> +	- mux-gpios;

Likewise.

> +
> +fsi-master {
> +	compatible = "ibm,fsi-master", "ibm,fsi-master-gpio";

This is backwards. The most specific string must come first.

> +	clk-gpios = <&gpio 0 &gpio 6>;
> +	data-gpios = <&gpio 1 &gpio 7>;
> +	enable-gpios = <&gpio 2 &gpio 8>;	/* Enable FSI data in/out */
> +	trans-gpios = <&gpio 3 &gpio 9>;	/* Volts translator direction */
> +	mux-gpios = <&gpio 4> &gpio 10>;	/* Multiplexer for FSI pins */

If this were described above, we don't need the comment here.

I note that in the patch, the mux-gpios property has an unmatched '>'
and won't compile.

As a general nit, please bracket elements of a list individually, e.g.

	trans-gpios = <&gpio 3>, <&gpio 9>;
	mux-gpios = <&gpio 4>, <&gpio 10>;

Thanks,
Mark.
