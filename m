From: robh@kernel.org (Rob Herring)
Date: Tue, 12 Jun 2018 14:48:02 -0600
Subject: [RFC PATCH 6/8] dts: coresight: Clean up the device tree graph
 bindings
In-Reply-To: <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
References: <1527858967-16047-1-git-send-email-suzuki.poulose@arm.com>
 <1527858967-16047-7-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180612204802.GA15817@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 01, 2018 at 02:16:05PM +0100, Suzuki K Poulose wrote:
> The coresight drivers relied on default bindings for graph
> in DT, while reusing the "reg" field of the "ports" to indicate
> the actual hardware port number for the connections. However,
> with the rules getting stricter w.r.t to the address mismatch
> with the label, it is no longer possible to use the port address
> field for the hardware port number. Hence, we add an explicit
> property to denote the hardware port number, "coresight,hwid"
> which must be specified for each "endpoint".
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 26 +++++++++---
>  drivers/hwtracing/coresight/of_coresight.c         | 46 ++++++++++++++++------
>  2 files changed, 54 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index bd36e40..385581a 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -104,7 +104,11 @@ properties to uniquely identify the connection details.
>  	"slave-mode"
>  
>   * Hardware Port number at the component:
> -     -  The hardware port number is assumed to be the address of the "port" component.
> +   - (Obsolete) The hardware port number is assumed to be the address of the "port" component.
> +   - Each "endpoint" must define the hardware port of the local end of the
> +     connection using the following property:
> +	"coresight,hwid" - 32bit integer, hardware port number at the local end.

"coresight" is not a vendor and properties are in the form 
[<vendor>,]<prop-name>.

> +
>  
>  
>  Example:
> @@ -120,6 +124,7 @@ Example:
>  			etb_in_port: endpoint at 0 {

There shouldn't be a unit address here because there is no reg property.

>  				slave-mode;
>  				remote-endpoint = <&replicator_out_port0>;
> +				coresight,hwid = <0>;

It doesn't make sense for these to be in the endpoint. If you had 
multiple endpoints, then you would have to duplicate it. "ports" are 
a single data stream. "endpoints" are connections to that stream. So if 
you have a muxed (input) or fanout/1-to-many (output) connection, then 
you have multiple endpoints. 

The same applied to the slave-mode property, but that ship has sailed. 
No reason to continue that though.

>  			};
>  		};
>  	};
> @@ -134,6 +139,7 @@ Example:
>  			tpiu_in_port: endpoint at 0 {
>  				slave-mode;
>  				remote-endpoint = <&replicator_out_port1>;
> +				coresight,hwid = <0>;
>  			};
>  		};
>  	};
> @@ -154,6 +160,7 @@ Example:
>  				reg = <0>;
>  				replicator_out_port0: endpoint {
>  					remote-endpoint = <&etb_in_port>;
> +					coresight,hwid = <0>;
>  				};
>  			};
>  
> @@ -161,15 +168,17 @@ Example:
>  				reg = <1>;
>  				replicator_out_port1: endpoint {
>  					remote-endpoint = <&tpiu_in_port>;
> +					coresight,hwid = <1>;
>  				};
>  			};
>  
>  			/* replicator input port */
>  			port at 2 {
> -				reg = <0>;
> +				reg = <1>;

This will still get flagged as an error. reg must be 2 here.

Rob
