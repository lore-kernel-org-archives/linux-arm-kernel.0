From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 17 May 2013 20:57:17 +0200
Subject: [RFC 0/8] rmk's Dove DRM/TDA19988 Cubox driver
In-Reply-To: <20130517180028.GK18614@n2100.arm.linux.org.uk>
References: <20130516192510.GV18614@n2100.arm.linux.org.uk>
 <20130517133345.7c1368f5@armhf>
 <20130517120115.GF18614@n2100.arm.linux.org.uk>
 <20130517194023.0c385ea0@armhf>
 <20130517180028.GK18614@n2100.arm.linux.org.uk>
Message-ID: <20130517205717.4d7e5ef9@armhf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 17 May 2013 19:00:29 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> > Maybe I did not explain correctly: the colored cursor maybe RGB888 +
> > transparency (64x64) or full ARGB (64x32 or 32x64). I coded the first
> > case. And, yes, I better like a hardware cursor: it asks for less
> > computation, and I get it immediately at graphic starting time!  
> 
> Interesting.  Where did you find the documentation for the transparency?
> The FS lists HWC32_TRANS_CNTL but omits to specify where that gets used.

Simply in the ? 11.3.2.1. The HWC32_TRANS_CNTL SRAM is loaded like the
HWC 2bpp, but with 00 transparent / 01 RGB.

> > The first step is "DT or not DT"? For me, the DT is more flexible
> > (one or two LCDs, smart panel definition, display controller or not..)
> > and permits easy inclusion of out of tree drivers as the private VPU
> > and GPU ones.  
> 
> I'd argue supporting both. :)

Not easy!

If you have not yet looked at our driver, here is how it starts:

- in '/', the DT contains

	video {
		compatible = "marvell,dove-video";
	};

  which loads the dove-drm module.

- its module init function registers the lcd driver, the dcon driver
  and the drm driver.

- the lcd probe function tries to get all the resources for the
  specific LCD from the DT, including the clocks and the HDMI
  transmitter.
  If some resource is lacking, it deferes.
  When all resources are there, it says "present" to the drm driver (see
  below).

  The resources of a LCD are declared in the DT by something like:

  &lcd0 {					/* the iomem and irq are declared
						 * in the Dove global DT */
	status = "okay";			/* this LCD is present and usable */
	clocks = <&core_clk 3>, <0>, <&lcdclk>, <&si5351 0>;
							/* 3 usable clocks */
	marvell,port-type = <11>;			/* HDMIA */
	marvell,external-encoder = <&tda998x>;		/* HDMI slave encoder */
  };

- the dcon probe function gets its resources and says "present" to the
  drm driver.
  Its DT declaration is just:

  &dcon { status = "okay"; };			/* iomem and irq in the Dove DT */

- the drm probe function scans all the DT, counting its usuable devices,
  (i.e. the LCDs and the dcon), and decrement the "present" variable
  accordingly.

- when the "present" variable is null, the active devices have all
  their resources, and, then, the drm driver is activated by a call to
  drm_platform_init().

I don't see clearly how to do that with a static initialization, and I
don't want to write a "cubox-setup.c". A kernel CONFIG_CUBOX ?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
