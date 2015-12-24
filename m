From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 24 Dec 2015 13:27:08 +0100
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <20151224105206.GB8644@n2100.arm.linux.org.uk>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
 <20151223103906.2aae53595345240d57d57b41@free.fr>
 <20151223100534.GW960@e106497-lin.cambridge.arm.com>
 <20151223182033.a52356408b9a81e9497464e7@free.fr>
 <20151223185948.GT8644@n2100.arm.linux.org.uk>
 <20151224091528.4f68d0f5838735a1a38c02c6@free.fr>
 <20151224105206.GB8644@n2100.arm.linux.org.uk>
Message-ID: <20151224132708.10a35feafb44a5bb8e65ba6d@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Dec 2015 10:52:07 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Dec 24, 2015 at 09:15:28AM +0100, Jean-Francois Moine wrote:
> > Well, two topics:
> > 
> > - adding a second 'of_compare' function complexifies the code
> >   and people may wonder why such a function is needed and what
> >   they have to put inside.
> > 
> > - usually, the component drivers just do a component_add() of the device
> >   at probe time.
> 
> ... which is exactly what does happen throughout imx-drm.
> 
> >   Now, as the bind() function of the components of the first level
> >   returns the port in 'data', some work has to be done for retrieving
> >   the device.
> >   This can (should?) be done in the bind() function.
> 
> Sorry, this still makes zero sense to me.  "retrieving the device"
> is all done by the core component code and has nothing to do with
> the drivers themselves.

Right, sorry, I wrote 'data' while thinking 'dev'.

> >   In drm/imx/ipuv3-crtc.c, this is done by a hack, changing the device
> >   node reference before calling component_add()!
> 
> What hack?
	[snip]
> There's no hack there.  I see nothing changing dev->of_node there.

Right again, I was looking in 4.4-rc1.

> > I looked at the imx-drm and the associated DTs, and I think that,
> > without the v2 patch and keeping the port parent as the component
> > (previous mail), the code could be simplified adding an intermediate
> > device node in the DT.
> 
> Not going to happen, because that's going to break compatibility with
> existing DTs.

OK, I cannot discuss against that!

> Let me explain instead what's going on, and why imx-drm is different.

Already understood.

	[snip]
> However, when we come to the Linux implementation, things get sticky
> because we need to select the correct platform device corresponding
> with the IPU's port.  This can only be done using the 'port' node
> and not port->parent.
> 
> port->parent would be the IPU device node itself.  If we were to
> introduce the additional ports {} node, that doesn't help, because
> now port->parent points at the ports {} node instead, not the actual
> port - and we need the port itself to identify which of the IPU's
> own created platform devices to select.
> 
> So, modifying DT doesn't help in any way, even if you ignore the fact
> that we need to maintain backwards compatibility.

The ports {} node is just a container, and so is the (unique) port {}
node which is inside:

	ipu1: ipu at 02400000 {
		...
		ports at 2 {			/* di0 device */
			ipu1_di0: port {
				...
				ipu1_di0_hdmi: endpoint at 1 {
					remote-endpoint = <&hdmi_mux_0>;
				};
				ipu1_di0_mipi: endpoint at 2 {
					remote-endpoint = <&mipi_mux_0>;
				};
				...
			};
		};
		ports at 3 {			/* di1 device */
			ipu1_di1: port {
				...
				ipu1_di1_hdmi: endpoint at 1 {  
					remote-endpoint = <&hdmi_mux_1>;
				};
				ipu1_di1_mipi: endpoint at 2 {
					remote-endpoint = <&mipi_mux_1>;
				};
				...
			};
		};
	};

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
