From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 25 Dec 2015 10:38:17 +0100
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <20151224123610.GE8644@n2100.arm.linux.org.uk>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
 <20151223103906.2aae53595345240d57d57b41@free.fr>
 <20151223100534.GW960@e106497-lin.cambridge.arm.com>
 <20151223182033.a52356408b9a81e9497464e7@free.fr>
 <20151223185948.GT8644@n2100.arm.linux.org.uk>
 <20151224091528.4f68d0f5838735a1a38c02c6@free.fr>
 <20151224105206.GB8644@n2100.arm.linux.org.uk>
 <20151224132708.10a35feafb44a5bb8e65ba6d@free.fr>
 <20151224123610.GE8644@n2100.arm.linux.org.uk>
Message-ID: <20151225103817.3aa1d89433607ee7fbf5181f@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Dec 2015 12:36:10 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> It seems that you're trying to work around a limitation in Linux by
> modifying the hardware representation...

Sorry to come back to this topic, but I think you are wrong.

Looking at the imx6 DTs, the problem comes from the display-subsystem
node which is a pure Linux specific software entity.

If you want to describe only the hardware in the DT, everything is
simple.

A IPU is a image controller with its sub-devices. Seen from the system, it
is like a 'board' with its devices (LCDs, camera...).

When 2 IPUs, there are 2 independant boards.

Here is what could be a pure hardware DT:

/* no display-subsystem */

	ipu1: ipu at 02400000 {		/* image controller / board 1 */
		compatible = "fsl,imx6q-ipu";
		...
		ports = <&ipu1_di0>, <&ipu1_di1>;
	};
	ipu1_di0: di at 0 {		/* display interface / crtc 1 */
		compatible = "fsl,imx6q-di";
		...
		ipu1_di0_hdmi: endpoint at 1 {
			remote-endpoint = <&hdmi_mux_0>;
		};
		ipu1_di0_mipi: endpoint at 2 {
			remote-endpoint = <&mipi_mux_0>;
		}
		...
	};
	ipu1_di1: di at 1 {		/* display interface / crtc 2 */
		compatible = "fsl,imx6q-di";
		...
		ipu1_di1_hdmi: endpoint at 1 {
			remote-endpoint = <&hdmi_mux_1>;
		};
		ipu1_di1_mipi: endpoint at 2 {
			remote-endpoint = <&mipi_mux_1>;
		}
		...
	};

	ipu2: ipu at 02800000 {		/* image controller / board 2 */
		compatible = "fsl,imx6q-ipu";
		...
		ports = <&ipu2_di0>, <&ipu2_di1>;
	};
	ipu2_di0: di at 0 {		/* display interface / crtc 1 */
		compatible = "fsl,imx6q-di";
		...
		ipu2_di0_hdmi: endpoint at 1 {
			remote-endpoint = <&hdmi_mux_2>;
		};
		ipu2_di0_mipi: endpoint at 2 {
			remote-endpoint = <&mipi_mux_2>;
		}
		...
	};
	ipu2_di1: di at 1 {		/* display interface / crtc 2 */
		compatible = "fsl,imx6q-di";
		...
		ipu2_di1_hdmi: endpoint at 1 {
			remote-endpoint = <&hdmi_mux_3>;
		};
		ipu2_di1_mipi: endpoint at 2 {
			remote-endpoint = <&mipi_mux_3>;
		}
		...
	};

Then, a standard component binding (port->parent) works fine...

(you may note that the same problem exists with audio: the
'simple-card' is also a pure Linux specific software entity)

-- 
Merry Christmas	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
