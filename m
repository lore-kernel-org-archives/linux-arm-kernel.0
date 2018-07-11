From: liviu.dudau@arm.com (Liviu Dudau)
Date: Wed, 11 Jul 2018 10:21:27 +0100
Subject: [PATCH 1/3 v4] ARM: dts: Modernize the Vexpress PL111 integration
In-Reply-To: <b00c3b85-1368-f62b-efda-d23ce27e6f9c@arm.com>
References: <20180709075232.30678-1-linus.walleij@linaro.org>
 <b00c3b85-1368-f62b-efda-d23ce27e6f9c@arm.com>
Message-ID: <20180711092127.GM15340@e110455-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 10, 2018 at 10:46:03AM +0100, Sudeep Holla wrote:
> 
> 
> On 09/07/18 08:52, Linus Walleij wrote:
> > The Versatile Express was submitted with the actual display
> > bridges unconnected (but defined in the device tree) and
> > mock "panels" encoded in the device tree node of the PL111
> > controller.
> > 
> > This doesn't even remotely describe the actual Versatile
> > Express hardware. Exploit the SiI9022 bridge by connecting
> > the PL111 pads to it, making it use EDID or fallback values
> > to drive the monitor.
> > 
> > The  also has to use the reserved memory through the
> > CMA pool rather than by open coding a memory region and
> > remapping it explicitly in the driver. To achieve this,
> > a reserved-memory node must exist in the root of the
> > device tree, so we need to pull that out of the
> > motherboard .dtsi include files, and push it into each
> > top-level device tree instead.
> > 
> > We do the same manouver for all the Versatile Express
> > boards, taking into account the different location of the
> > video RAM depending on which chip select is used on
> > each platform.
> > 
> > This plays nicely with the new PL111 DRM driver and
> > follows the standard ways of assigning bridges and
> > memory pools for graphics.
> > 
> > Cc: Sudeep Holla <sudeep.holla@arm.com>
> > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > Cc: Mali DP Maintainers <malidp@foss.arm.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> > ChangeLog v3->v4:
> > - Fix the ARM and ARM64 shared vexpress-v2m-rc1.dtsi
> >   file address-cells etc so that the ports do not give
> >   DTC warnings anymore.
> 
> Still get below warnings, not sure if I need to upgrade my DTC ?
> 
> vexpress-v2f-1xv7-ca53x2.dtb: Warning (graph_child_address):
> /smb at 8000000/motherboard/iofpga at 3,00000000/i2c at 160000/dvi-transmitter at 39/ports:
> graph node has single child node 'port at 0', #address-cells/#size-cells
> are not necessary
> rtsm_ve-aemv8a.dtb: Warning (graph_child_address):
> /smb at 8000000/motherboard/iofpga at 3,00000000/i2c at 160000/dvi-transmitter at 39/ports:
> graph node has single child node 'port at 0', #address-cells/#size-cells
> are not necessary
> 
> > - Fixed up the CA53 DTS: use the right chip select base
> >   at 0x18000000.
> 
> I really hate this as it make maintenance difficult, but I don't have
> good alternative, so I am fine as it is for now :)
> 
> > - Fixed up the Real-Time Systems Models Virtual Executive
> >   RTSMv8 AEM VE:
> >   - Added the I2C interface (whether implemented in the
> >     emulator or not)
> 
> It doesn't work. This change is breaking the working CLCD on the models.
> I just tested and CLCD driver returns
> 
> >   - Fixed the chip select of the memory node to the right
> >     memory base 0x18000000.
> 
> See, this keeps happening.
> 
> Anyways I think you can drop RTSM changes if models don't support I2C
> and DVI.
> 
> Liviu,

Hi Sudeep,

> 
> As you deal with DRM drivers and I have no knowledge in that domain,
> I want to hear your feedback or Ack/Review ?

I was testing last week the previous version of the patchset but run
into the issue with my toolchain having the new binutils that generates
invalid code for THUMB2 kernels, so it took me a while to find that one
out.

For a VExpress that has a TC2 CoreTile, the HDLCD driver fails to load
because the DT doesn't have the right "port" node, which is something I
need to fix, but then we need to make sure we can switch outputs to the
CoreTile and that is where I got to until now, due to some other
commitments.

Otherwise, provided Linus has a fix for the issues you've raised, I have
nothing against these patches being merged, so if you need them:

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> -- 
> -- 
> Regards,
> Sudeep

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
