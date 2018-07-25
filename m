From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 25 Jul 2018 13:25:09 -0600
Subject: [PATCH v2 09/10] coresight: Cleanup coresight DT bindings
In-Reply-To: <1531997715-6767-10-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
 <1531997715-6767-10-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20180725192509.GA21975@xps15>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, Jul 19, 2018 at 11:55:13AM +0100, Suzuki K Poulose wrote:
> The coresight drivers relied on default bindings for graph
> in DT, while reusing the "reg" field of the "ports" to indicate
> the actual hardware port number for the connections. This can
> cause duplicate ports with same addresses, but different
> direction. However, with the rules getting stricter w.r.t to the

It's only a matter of time before someone calls you out on the "w.r.t".  Better
to simply spell it out.

> address mismatch with the label, it is no longer possible to use
> the port address field for the hardware port number.
> 
> This patch introduces new DT binding rules for coresight
> components, based on the same generic DT graph bindings, but
> avoiding the address duplication.
> 
> - All output ports must be specified under a child node with
>   name "out-ports".
> - All input ports must be specified under a childe node with
>   name "in-ports".
> - Port address should match the hardware port number.
> 
> The support for legacy bindings is retained, with a warning.
> 
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> ---
>  .../devicetree/bindings/arm/coresight.txt          | 91 ++++++++++----------
>  drivers/hwtracing/coresight/of_coresight.c         | 97 +++++++++++++++++++---
>  2 files changed, 129 insertions(+), 59 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
> index 8e21512..f39d2c6 100644
> --- a/Documentation/devicetree/bindings/arm/coresight.txt
> +++ b/Documentation/devicetree/bindings/arm/coresight.txt
> @@ -104,19 +104,9 @@ The connections must be described via generic DT graph bindings as described
>  by the "bindings/graph.txt", where each "port" along with an "endpoint"
>  component represents a hardware port and the connection.
>  
> -Since it is possible to have multiple connections for any coresight component
> -with a specific direction of data flow, each connection must define the
> -following properties to uniquely identify the connection details.
> -
> - * Direction of the data flow w.r.t the component :

Same here.

With those changes:

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -   Each input port must have the following property defined at the "endpoint"
> -   for the port.
> -	"slave-mode"
> -
> - * Hardware Port number at the component:
> -     -  The hardware port number is assumed to be the address of the "port"
> -         component.
> -
> + * All output ports must be listed inside a child node named "out-ports"
> + * All input ports must be listed inside a child node named "in-ports".
> + * Port address must match the hardware port number.
>  
>  Example:
>  
> @@ -127,10 +117,11 @@ Example:
>  
>  		clocks = <&oscclk6a>;
>  		clock-names = "apb_pclk";
> -		port {
> -			etb_in_port: endpoint at 0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator_out_port0>;
> +		in-ports {
> +			port {
> +				etb_in_port: endpoint at 0 {
> +					remote-endpoint = <&replicator_out_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -141,10 +132,11 @@ Example:
>  
>  		clocks = <&oscclk6a>;
>  		clock-names = "apb_pclk";
> -		port {
> -			tpiu_in_port: endpoint at 0 {
> -				slave-mode;
> -				remote-endpoint = <&replicator_out_port1>;
> +		out-ports {
> +			port {
> +				tpiu_in_port: endpoint at 0 {
> +					remote-endpoint = <&replicator_out_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -185,7 +177,7 @@ Example:
>  		 */
>  		compatible = "arm,coresight-replicator";
>  
> -		ports {
> +		out-ports {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
>  
> @@ -203,12 +195,11 @@ Example:
>  					remote-endpoint = <&tpiu_in_port>;
>  				};
>  			};
> +		};
>  
> -			/* replicator input port */
> -			port at 2 {
> -				reg = <0>;
> +		in-ports {
> +			port {
>  				replicator_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&funnel_out_port0>;
>  				};
>  			};
> @@ -221,40 +212,36 @@ Example:
>  
>  		clocks = <&oscclk6a>;
>  		clock-names = "apb_pclk";
> -		ports {
> -			#address-cells = <1>;
> -			#size-cells = <0>;
> -
> -			/* funnel output port */
> -			port at 0 {
> -				reg = <0>;
> +		out-ports {
> +			port {
>  				funnel_out_port0: endpoint {
>  					remote-endpoint =
>  							<&replicator_in_port0>;
>  				};
>  			};
> +		};
>  
> -			/* funnel input ports */
> -			port at 1 {
> +		in-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
>  				reg = <0>;
>  				funnel_in_port0: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm0_out_port>;
>  				};
>  			};
>  
> -			port at 2 {
> +			port at 1 {
>  				reg = <1>;
>  				funnel_in_port1: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&ptm1_out_port>;
>  				};
>  			};
>  
> -			port at 3 {
> +			port at 2 {
>  				reg = <2>;
>  				funnel_in_port2: endpoint {
> -					slave-mode;
>  					remote-endpoint = <&etm0_out_port>;
>  				};
>  			};
> @@ -270,9 +257,11 @@ Example:
>  		cpu = <&cpu0>;
>  		clocks = <&oscclk6a>;
>  		clock-names = "apb_pclk";
> -		port {
> -			ptm0_out_port: endpoint {
> -				remote-endpoint = <&funnel_in_port0>;
> +		out-ports {
> +			port {
> +				ptm0_out_port: endpoint {
> +					remote-endpoint = <&funnel_in_port0>;
> +				};
>  			};
>  		};
>  	};
> @@ -284,9 +273,11 @@ Example:
>  		cpu = <&cpu1>;
>  		clocks = <&oscclk6a>;
>  		clock-names = "apb_pclk";
> -		port {
> -			ptm1_out_port: endpoint {
> -				remote-endpoint = <&funnel_in_port1>;
> +		out-ports {
> +			port {
> +				ptm1_out_port: endpoint {
> +					remote-endpoint = <&funnel_in_port1>;
> +				};
>  			};
>  		};
>  	};
> @@ -300,9 +291,11 @@ Example:
>  
>  		clocks = <&soc_smc50mhz>;
>  		clock-names = "apb_pclk";
> -		port {
> -			stm_out_port: endpoint {
> -				remote-endpoint = <&main_funnel_in_port2>;
> +		out-ports {
> +			port {
> +				stm_out_port: endpoint {
> +					remote-endpoint = <&main_funnel_in_port2>;
> +				};
>  			};
>  		};
>  	};
> diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
> index f9e2169..2178734 100644
> --- a/drivers/hwtracing/coresight/of_coresight.c
> +++ b/drivers/hwtracing/coresight/of_coresight.c
> @@ -45,13 +45,13 @@ of_coresight_get_endpoint_device(struct device_node *endpoint)
>  			       endpoint, of_dev_node_match);
>  }
>  
> -static inline bool of_coresight_ep_is_input(struct device_node *ep)
> +static inline bool of_coresight_legacy_ep_is_input(struct device_node *ep)
>  {
>  	return of_property_read_bool(ep, "slave-mode");
>  }
>  
> -static void of_coresight_get_ports(const struct device_node *node,
> -				   int *nr_inport, int *nr_outport)
> +static void of_coresight_get_ports_legacy(const struct device_node *node,
> +					  int *nr_inport, int *nr_outport)
>  {
>  	struct device_node *ep = NULL;
>  	int in = 0, out = 0;
> @@ -61,7 +61,7 @@ static void of_coresight_get_ports(const struct device_node *node,
>  		if (!ep)
>  			break;
>  
> -		if (of_coresight_ep_is_input(ep))
> +		if (of_coresight_legacy_ep_is_input(ep))
>  			in++;
>  		else
>  			out++;
> @@ -72,6 +72,67 @@ static void of_coresight_get_ports(const struct device_node *node,
>  	*nr_outport = out;
>  }
>  
> +static struct device_node *of_coresight_get_port_parent(struct device_node *ep)
> +{
> +	struct device_node *parent = of_graph_get_port_parent(ep);
> +
> +	/*
> +	 * Skip one-level up to the real device node, if we
> +	 * are using the new bindings.
> +	 */
> +	if (!of_node_cmp(parent->name, "in-ports") ||
> +	    !of_node_cmp(parent->name, "out-ports"))
> +		parent = of_get_next_parent(parent);
> +
> +	return parent;
> +}
> +
> +static inline struct device_node *
> +of_coresight_get_input_ports_node(const struct device_node *node)
> +{
> +	return of_get_child_by_name(node, "in-ports");
> +}
> +
> +static inline struct device_node *
> +of_coresight_get_output_ports_node(const struct device_node *node)
> +{
> +	return of_get_child_by_name(node, "out-ports");
> +}
> +
> +static inline int
> +of_coresight_count_ports(struct device_node *port_parent)
> +{
> +	int i = 0;
> +	struct device_node *ep = NULL;
> +
> +	while ((ep = of_graph_get_next_endpoint(port_parent, ep)))
> +		i++;
> +	return i;
> +}
> +
> +static void of_coresight_get_ports(const struct device_node *node,
> +				   int *nr_inport, int *nr_outport)
> +{
> +	struct device_node *input_ports = NULL, *output_ports = NULL;
> +
> +	input_ports = of_coresight_get_input_ports_node(node);
> +	output_ports = of_coresight_get_output_ports_node(node);
> +
> +	if (input_ports || output_ports) {
> +		if (input_ports) {
> +			*nr_inport = of_coresight_count_ports(input_ports);
> +			of_node_put(input_ports);
> +		}
> +		if (output_ports) {
> +			*nr_outport = of_coresight_count_ports(output_ports);
> +			of_node_put(output_ports);
> +		}
> +	} else {
> +		/* Fall back to legacy DT bindings parsing */
> +		of_coresight_get_ports_legacy(node, nr_inport, nr_outport);
> +	}
> +}
> +
>  static int of_coresight_alloc_memory(struct device *dev,
>  			struct coresight_platform_data *pdata)
>  {
> @@ -136,7 +197,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
>  		rep = of_graph_get_remote_endpoint(ep);
>  		if (!rep)
>  			break;
> -		rparent = of_graph_get_port_parent(rep);
> +		rparent = of_coresight_get_port_parent(rep);
>  		if (!rparent)
>  			break;
>  		if (of_graph_parse_endpoint(rep, &rendpoint))
> @@ -176,6 +237,8 @@ of_get_coresight_platform_data(struct device *dev,
>  	struct coresight_platform_data *pdata;
>  	struct coresight_connection *conn;
>  	struct device_node *ep = NULL;
> +	const struct device_node *parent = NULL;
> +	bool legacy_binding = false;
>  
>  	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
>  	if (!pdata)
> @@ -196,14 +259,28 @@ of_get_coresight_platform_data(struct device *dev,
>  	if (ret)
>  		return ERR_PTR(ret);
>  
> +	parent = of_coresight_get_output_ports_node(node);
> +	/*
> +	 * If the DT uses obsoleted bindings, the ports are listed
> +	 * under the device and we need to filter out the input
> +	 * ports.
> +	 */
> +	if (!parent) {
> +		legacy_binding = true;
> +		parent = node;
> +		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
> +	}
> +
>  	conn = pdata->conns;
> -	/* Iterate through each port to discover topology */
> -	while ((ep = of_graph_get_next_endpoint(node, ep))) {
> +
> +	/* Iterate through each output port to discover topology */
> +	while ((ep = of_graph_get_next_endpoint(parent, ep))) {
>  		/*
> -		 * No need to deal with input ports, processing for as
> -		 * processing for output ports will deal with them.
> +		 * Legacy binding mixes input/output ports under the
> +		 * same parent. So, skip the input ports if we are dealing
> +		 * with legacy binding.
>  		 */
> -		if (of_coresight_ep_is_input(ep))
> +		if (legacy_binding && of_coresight_legacy_ep_is_input(ep))
>  			continue;
>  
>  		ret = of_coresight_parse_endpoint(dev, ep, &conn);
> -- 
> 2.7.4
> 
