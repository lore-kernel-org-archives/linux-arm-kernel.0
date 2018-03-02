From: heikki.krogerus@linux.intel.com (Heikki Krogerus)
Date: Fri, 2 Mar 2018 15:13:15 +0200
Subject: [PATCH v5 1/6] dt-bindings: add bindings for USB physical
 connector
In-Reply-To: <20180227071134.28063-2-a.hajda@samsung.com>
References: <20180227071134.28063-1-a.hajda@samsung.com>
 <CGME20180227071138eucas1p17e1e16f13f6d3e3b15a57dc93eb8cf3f@eucas1p1.samsung.com>
 <20180227071134.28063-2-a.hajda@samsung.com>
Message-ID: <20180302131315.GA10598@kuha.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Feb 27, 2018 at 08:11:29AM +0100, Andrzej Hajda wrote:
> +2. USB-C connector attached to CC controller (s2mm005), HS lines routed
> +to companion PMIC (max77865), SS lines to USB3 PHY and SBU to DisplayPort.
> +DisplayPort video lines are routed to the connector via SS mux in USB3 PHY.
> +
> +ccic: s2mm005 at 33 {
> +	...
> +	usb_con: connector {
> +		compatible = "usb-c-connector";
> +		label = "USB-C";

Is this child node really necessary? There will never be more then
one connector per CC line.

We should prefer device_graph* functions over of_graph* and
acpi_graph* functions in the drivers so we don't have to handle the
same thing multiple times with separate APIs. Is it still possible if
there is that connector child node?

> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				usb_con_hs: endpoint {
> +					remote-endpoint = <&max77865_usbc_hs>;
> +				};
> +			};
> +			port at 1 {
> +				reg = <1>;
> +				usb_con_ss: endpoint {
> +					remote-endpoint = <&usbdrd_phy_ss>;
> +				};
> +			};
> +			port at 2 {
> +				reg = <2>;
> +				usb_con_sbu: endpoint {
> +					remote-endpoint = <&dp_aux>;
> +				};
> +			};
> +		};
> +	};
> +};


Thanks,

-- 
heikki
