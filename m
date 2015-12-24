From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 24 Dec 2015 09:15:28 +0100
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <20151223185948.GT8644@n2100.arm.linux.org.uk>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
 <20151223103906.2aae53595345240d57d57b41@free.fr>
 <20151223100534.GW960@e106497-lin.cambridge.arm.com>
 <20151223182033.a52356408b9a81e9497464e7@free.fr>
 <20151223185948.GT8644@n2100.arm.linux.org.uk>
Message-ID: <20151224091528.4f68d0f5838735a1a38c02c6@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 23 Dec 2015 18:59:48 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > > Have a look at my v2 where I've introduced two compare functions and also
> > > modified the Rockchip compare_port() to use port->parent in the comparison. I
> > > guess that should solve your problem.
> > 
> > Keeping the port instead of the parent asks for more code, but,
> > especially, it also asks for changes in the component drivers because,
> > at bind time, in 'data', they get a port instead of the device.
> 
> Sorry, this doesn't make sense.  You have far too many sub-clauses
> which mean nothing at all.  Please rephrase.

Well, two topics:

- adding a second 'of_compare' function complexifies the code
  and people may wonder why such a function is needed and what
  they have to put inside.

- usually, the component drivers just do a component_add() of the device
  at probe time.
  Now, as the bind() function of the components of the first level
  returns the port in 'data', some work has to be done for retrieving
  the device.
  This can (should?) be done in the bind() function.
  In drm/imx/ipuv3-crtc.c, this is done by a hack, changing the device
  node reference before calling component_add()!

I looked at the imx-drm and the associated DTs, and I think that,
without the v2 patch and keeping the port parent as the component
(previous mail), the code could be simplified adding an intermediate
device node in the DT.

For example, in imx6qdl.dtsi:

	ipu1: ipu at 02400000 {
		...
		ports at 2 {			/* di<x> device */
			ipu1_di0: port {
				...
				ipu1_di0_hdmi: endpoint at 1 {
					remote-endpoint = <&hdmi_mux_0>;
				};
				...
			};
		};
	}

In the code, the ipu driver searches the 'ports' and adds them as components.
After binding, the devices are the 'ports'.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
