From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Dec 2015 12:36:10 +0000
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <20151224132708.10a35feafb44a5bb8e65ba6d@free.fr>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
 <20151223103906.2aae53595345240d57d57b41@free.fr>
 <20151223100534.GW960@e106497-lin.cambridge.arm.com>
 <20151223182033.a52356408b9a81e9497464e7@free.fr>
 <20151223185948.GT8644@n2100.arm.linux.org.uk>
 <20151224091528.4f68d0f5838735a1a38c02c6@free.fr>
 <20151224105206.GB8644@n2100.arm.linux.org.uk>
 <20151224132708.10a35feafb44a5bb8e65ba6d@free.fr>
Message-ID: <20151224123610.GE8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 01:27:08PM +0100, Jean-Francois Moine wrote:
> On Thu, 24 Dec 2015 10:52:07 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> > However, when we come to the Linux implementation, things get sticky
> > because we need to select the correct platform device corresponding
> > with the IPU's port.  This can only be done using the 'port' node
> > and not port->parent.
> > 
> > port->parent would be the IPU device node itself.  If we were to
> > introduce the additional ports {} node, that doesn't help, because
> > now port->parent points at the ports {} node instead, not the actual
> > port - and we need the port itself to identify which of the IPU's
> > own created platform devices to select.
> > 
> > So, modifying DT doesn't help in any way, even if you ignore the fact
> > that we need to maintain backwards compatibility.
> 
> The ports {} node is just a container, and so is the (unique) port {}
> node which is inside:
> 
> 	ipu1: ipu at 02400000 {
> 		...
> 		ports at 2 {			/* di0 device */
> 			ipu1_di0: port {
> 				...
> 				ipu1_di0_hdmi: endpoint at 1 {
> 					remote-endpoint = <&hdmi_mux_0>;
> 				};
> 				ipu1_di0_mipi: endpoint at 2 {
> 					remote-endpoint = <&mipi_mux_0>;
> 				};
> 				...
> 			};
> 		};
> 		ports at 3 {			/* di1 device */
> 			ipu1_di1: port {
> 				...
> 				ipu1_di1_hdmi: endpoint at 1 {  
> 					remote-endpoint = <&hdmi_mux_1>;
> 				};
> 				ipu1_di1_mipi: endpoint at 2 {
> 					remote-endpoint = <&mipi_mux_1>;
> 				};
> 				...
> 			};
> 		};
> 	};

That's against the binding documentation for graphs:

All 'port' nodes can be grouped under an optional 'ports' node, which
allows to specify #address-cells, #size-cells properties for the 'port'
nodes independently from any other child device nodes a device might
have.

It says "All 'port' nodes" not "Some" or similar.  The DT code requires
this.  To change this would mean changing the DT binding and the code
parsing that binding, adding much more complexity there.

You earlier argued against adding (what would be less) complexity to
the DRM OF helper, now you seem to be wanting more complexity elsewhere
to save what would be trivial complexity elsewhere - all the functions
which iterate over the port nodes would need to be updated to find
all the "ports" nodes, and end up needing an additional level of looping
and complexity to jump from one port node in a ports { } block to the
first port node in the next ports { } block.

Also it makes the API more difficult because we end up with the ports at n
nodes needing a reg= property (as per ePAPR requirements) and it becomes
unclear what that would represent at the hardware level.

It seems that you're trying to work around a limitation in Linux by
modifying the hardware representation...

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
