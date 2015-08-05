From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 18:53:03 +0100
Subject: [PATCH 3/4] arm64: Juno: Add HDLCD support to the Juno boards.
In-Reply-To: <1438784892-27888-4-git-send-email-Liviu.Dudau@arm.com>
References: <1438784892-27888-1-git-send-email-Liviu.Dudau@arm.com>
 <1438784892-27888-4-git-send-email-Liviu.Dudau@arm.com>
Message-ID: <20150805175303.GB7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 03:28:11PM +0100, Liviu Dudau wrote:
> +		hdmi-transmitter at 71 {
>  			compatible = "nxp,tda998x";
>  			reg = <0x71>;
> +			port {
> +				tda998x_1_input: endpoint at 0 {
> +					remote-endpoint = <&hdlcd1_output>;
> +				};
> +
> +				tda998x_1_output: endpoint at 1 {
> +					remote-endpoint = <&hdmi1_connector_output>;
> +				};
> +			};

This isn't compliant with the TDA998x binding, and is very likely to
screw Jean's work on adding audio support.  See emails on lakml and
Documentation/devicetree/bindings/drm/i2c/tda998x.txt (which looks
like it needs updating to include the ports stuff.)

Also, the whole question of representing connectors in a DRM model is
yet to be established.  Yes, DT should describe the hardware, but we
don't yet know _how_ to describe physical connectors with stuff
implemented on top of DRM yet, and we have nothing that makes use of
this.

Also note that ePAPR requires a reg= property if you specify a
unit-address (the bit after the @ sign) so the above is non-compliant
with ePAPR as well.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
