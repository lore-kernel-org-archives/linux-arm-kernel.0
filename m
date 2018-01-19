From: robh@kernel.org (Rob Herring)
Date: Fri, 19 Jan 2018 17:11:28 -0600
Subject: [PATCHv<8> 1/3] ARM:dt-bindings:display Intel FPGA Video and
 Image Processing Suite
In-Reply-To: <1516011701-2748-2-git-send-email-hean.loong.ong@intel.com>
References: <1516011701-2748-1-git-send-email-hean.loong.ong@intel.com>
 <1516011701-2748-2-git-send-email-hean.loong.ong@intel.com>
Message-ID: <20180119231128.vm4t3lkkjxw3zihj@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 15, 2018 at 06:21:39PM +0800, Hean-Loong, Ong wrote:
> From: Ong, Hean Loong <hean.loong.ong@intel.com>

"dt-bindings: display: ..."

> 
> Device tree binding for Intel FPGA Video and Image Processing Suite. The binding involved would be generated from the Altera (Intel) Qsys system. The bindings would set the max width, max height, buts per pixel and memory port width. The device tree binding only supports the Intel
> Arria10 devkit and its variants. Vendor name retained as altr.
> 
> V8:

Version history goes below the '---' so it is not in the commit message.

> *Add port to Display port decoder
> 
> V7:
> *Fix OF graph for better description
> *Add description for encoder
> 
> V6:
> *Description have not describe DT device in general
> 
> V5:
> *remove bindings for bits per symbol as it has only one value which is 8
> 
> V4:
> *fix properties that does not describe the values
> 
> V3:
> *OF graph not in accordance to graph.txt
> 
> V2:
> *Remove Linux driver description
> 
> V1:
> *Missing vendor prefix
> 
> Signed-off-by: Ong, Hean Loong <hean.loong.ong@intel.com>
> ---
>  .../devicetree/bindings/display/altr,vip-fb2.txt   |   99 ++++++++++++++++++++
>  1 files changed, 99 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/altr,vip-fb2.txt b/Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> new file mode 100644
> index 0000000..4092804
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/altr,vip-fb2.txt
> @@ -0,0 +1,99 @@
> +Intel Video and Image Processing(VIP) Frame Buffer II bindings
> +
> +Supported hardware: Intel FPGA SoC Arria10 and above with display port IP
> +
> +The Video Frame Buffer II in Video Image Processing (VIP) suite is an IP core
> +that interfaces between system memory and Avalon-ST video ports. The IP core
> +can be configured to support the memory reader (from memory to Avalon-ST)
> +and/or memory writer (from Avalon-ST to memory) interfaces.
> +
> +More information the FPGA video IP component can be acquired from
> +https://www.altera.com/content/dam/altera-www/global/en_US/pdfs\
> +/literature/ug/ug_vip.pdf
> +
> +DT-Bindings:
> +=============
> +Required properties:
> +----------------------------
> +- compatible: "altr,vip-frame-buffer-2.0"
> +- reg: Physical base address and length of the framebuffer controller's
> +	registers.
> +- altr,max-width: The maximum width of the framebuffer in pixels.
> +- altr,max-height: The maximum height of the framebuffer in pixels.
> +- altr,mem-port-width = the bus width of the avalon master port
> +	on the frame reader
> +
> +Optional sub-nodes:
> +- ports: The connection to the encoder
> +
> +Optional properties
> +----------------------------
> +- compatible: "altr, display-port"

spurious space         ^

> +- reg: Physical base address and length of the display port controller's
> +	registers
> +- clocks: required clock handles for specified pairs in clock name
> +- clock-names: required clock names. Contains:
> +	- aux_clk: auxiliary clock,
> +	- clk: 100 MHz output clock
> +	- xcvr_mgmt_clk: transceiver management clock
> +
> +Optional sub-nodes:
> +- ports: The connection to the controller
> +
> +Connections between the Frame Buffer II and other video IP cores in the system
> +are modelled using the OF graph DT bindings. The Frame Buffer II node has up
> +to two OF graph ports. When the memory writer interface is enabled, port 0
> +maps to the Avalon-ST Input (din) port. When the memory reader interface is
> +enabled, port 1 maps to the Avalon-ST Output (dout) port.
> +
> +The encoder is built into the FPGA HW design and therefore would not
> +be accessible from the DDR.
> +
> +		Port 0				Port1
> +---------------------------------------------------------
> +ARRIA10 AVALON_ST (DIN)		AVALON_ST (DOUT)
> +
> +Required Properties Example:
> +----------------------------
> +
> +framebuffer at 100000280 {
> +		compatible = "altr,vip-frame-buffer-2.0";
> +		reg = <0x00000001 0x00000280 0x00000040>;
> +		altr,max-width = <1280>;
> +		altr,max-height = <720>;
> +		altr,mem-port-width = <128>;
> +
> +		ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;

Formatting is wrong here. Each level should be 1 tab.

> +
> +			port at 1 {
> +				reg = <1>;
> +					fb_output: endpoint {
> +						remote-endpoint = <&dp_encoder_input>;
> +					};
> +			};
> +		};
> +};
> +
> +Optional Properties Example:
> +This is not required unless there are needs to customize
> +Display Port controller settings.
> +
> +displayport at 100002000 {
> +		compatible = "altr, display-port";
> +		reg = <0x00000001 0x00002000 0x00000800>;
> +		clocks = <&dp_0_clk_16 &dp_0_clk_100 &dp_0_clk_100>;
> +		clock-names = "aux_clk", "clk", "xcvr_mgmt_clk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <1>;
> +					dp_input: endpoint {
> +						remote-endpoint = <&dp_controller_input>;
> +					};
> +			};
> +};
> -- 
> 1.7.1
> 
