From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Thu, 04 Feb 2016 11:44:50 +0100
Subject: [PATCH v4 1/1] USB: core: let USB device know device node
In-Reply-To: <1453706679-18948-1-git-send-email-peter.chen@freescale.com>
References: <1453706679-18948-1-git-send-email-peter.chen@freescale.com>
Message-ID: <1454582690.3356.18.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

Am Montag, den 25.01.2016, 15:24 +0800 schrieb Peter Chen:
> Although most of USB devices are hot-plug's, there are still some devices
> are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> If these kinds of USB devices are multiple functions, and they can supply
> other interfaces like i2c, gpios for other devices, we may need to
> describe these at device tree.
> 
> In this commit, it uses "reg" in dts as physical port number to match
> the phyiscal port number decided by USB core, if they are the same,
> then the device node is for the device we are creating for USB core.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
> Changes for v4:
> - The range of "reg" should be 1-31, changing device node address
>   style as in lower case hexadecimal with leading zeroes suppressed
>   [binding doc, usb-device.txt]
> - Improve the example at binding doc, it describes node from the top
>   (the controller)
> - Delete the struct of_node * within struct usb_device
> - Using usb_hcd_find_raw_port_number to get raw port number under root
>   hub port
> 
> Changes for v3:
> - typo: s/descirbe/describe/
> 
> Changes for v2:
> - Fix build error reported by kbuild robot, lack of "static" for
>   inline usb_of_get_child_node
> - Fix typo, "devcie_node" -> "device_node"
> - Add kernel-doc for of_node at struct usb_device
> 
> Changes from RFC:
> - Fix the error address for binding doc, and add compatible for binding doc
> - Change get child node API from "usb_of_find_node" to
>   "usb_of_get_child_node"
> - Delete unecessary header files
> - One typo
> 
>  .../devicetree/bindings/usb/usb-device.txt         | 25 ++++++++++++
>  drivers/usb/core/Makefile                          |  2 +-
>  drivers/usb/core/of.c                              | 47 ++++++++++++++++++++++
>  drivers/usb/core/usb.c                             | 14 ++++++-
>  include/linux/usb/of.h                             |  7 ++++
>  5 files changed, 92 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/usb-device.txt
>  create mode 100644 drivers/usb/core/of.c
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-device.txt b/Documentation/devicetree/bindings/usb/usb-device.txt
> new file mode 100644
> index 0000000..c702885
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/usb-device.txt
> @@ -0,0 +1,25 @@
> +Generic USB Device Properties
> +
> +Usually, we only use device tree for hard wired USB device.
> +The reference binding doc is from:
> +http://www.firmware.org/1275/bindings/usb/usb-1_0.ps
> +
> +Required properties:
> +- compatible: usbVID,PID

The reference recommendation states that for single-configuration USB
devices the compatible should contain all of the applicable strings from
the list starting with 2) "usbVID,PID.REV" and ending with 11)
"usb,device". Are we going to ignore this?

The document also states that "the textual representation of VID, PID
[...] shall be in lower case hexadecimal with leading zeroes
suppressed". This should be documented here.

> +- reg: the port number which this device is connecting to, the range
> +  is 1-31.
> +
> +
> +Example:
> +
> +&usb1 {
> +	status = "okay";
> +
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +
> +	hub: genesys at 1 {

There are node names specified for hubs and mass storage devices:
"hub", "storage", "cdrom", "tape", "solid-state", and "device" for
everything else. Should we follow this recommendation?

> +		compatible = "usb05e3,0608";
> +		reg = <0x1>;
> +	};

I'd have written this node as:

	hub: hub at 1 {
		compatible = "usb5e3,608", "usb5e3,class9",
			     "usb,class9", "usb,device";
		reg = <1>;
	};

As another example, I'd like to introduce the USB WLAN Adapter soldered
onto the imx6q-gk802 board to its power enable GPIO via the device tree:

/* Internal USB port (USBH1) */
&usbh1 {
	#address-cells = <1>;
	#size-cells = <0>;
	status = "okay";

	/* RTL8192CU 802.11n WLAN Adapter */
	device at 1 {
		compatible = "usbbda,8176.200", "usbbda,8176",
			     "usb,device";
		reg = <1>;

		enable-gpios = <&gpio2 0 GPIO_ACTIVE_LOW>;
	};
};

regards
Philipp
