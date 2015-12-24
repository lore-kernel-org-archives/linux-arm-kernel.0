From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 24 Dec 2015 10:52:07 +0000
Subject: [PATCH v2 0/2] Improve drm_of_component_probe() and move
 rockchip to use it
In-Reply-To: <20151224091528.4f68d0f5838735a1a38c02c6@free.fr>
References: <1448029325-14602-1-git-send-email-Liviu.Dudau@arm.com>
 <20151222173800.GU960@e106497-lin.cambridge.arm.com>
 <20151223103906.2aae53595345240d57d57b41@free.fr>
 <20151223100534.GW960@e106497-lin.cambridge.arm.com>
 <20151223182033.a52356408b9a81e9497464e7@free.fr>
 <20151223185948.GT8644@n2100.arm.linux.org.uk>
 <20151224091528.4f68d0f5838735a1a38c02c6@free.fr>
Message-ID: <20151224105206.GB8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 24, 2015 at 09:15:28AM +0100, Jean-Francois Moine wrote:
> On Wed, 23 Dec 2015 18:59:48 +0000
> Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> 
> > > > Have a look at my v2 where I've introduced two compare functions and also
> > > > modified the Rockchip compare_port() to use port->parent in the comparison. I
> > > > guess that should solve your problem.
> > > 
> > > Keeping the port instead of the parent asks for more code, but,
> > > especially, it also asks for changes in the component drivers because,
> > > at bind time, in 'data', they get a port instead of the device.
> > 
> > Sorry, this doesn't make sense.  You have far too many sub-clauses
> > which mean nothing at all.  Please rephrase.
> 
> Well, two topics:
> 
> - adding a second 'of_compare' function complexifies the code
>   and people may wonder why such a function is needed and what
>   they have to put inside.
> 
> - usually, the component drivers just do a component_add() of the device
>   at probe time.

... which is exactly what does happen throughout imx-drm.

>   Now, as the bind() function of the components of the first level
>   returns the port in 'data', some work has to be done for retrieving
>   the device.
>   This can (should?) be done in the bind() function.

Sorry, this still makes zero sense to me.  "retrieving the device"
is all done by the core component code and has nothing to do with
the drivers themselves.

>   In drm/imx/ipuv3-crtc.c, this is done by a hack, changing the device
>   node reference before calling component_add()!

What hack?

static int ipu_drm_probe(struct platform_device *pdev)
{
        struct device *dev = &pdev->dev;
        int ret;

        if (!dev->platform_data)
                return -EINVAL;

        ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
        if (ret)
                return ret;

        return component_add(dev, &ipu_crtc_ops);
}

There's no hack there.  I see nothing changing dev->of_node there.

> I looked at the imx-drm and the associated DTs, and I think that,
> without the v2 patch and keeping the port parent as the component
> (previous mail), the code could be simplified adding an intermediate
> device node in the DT.

Not going to happen, because that's going to break compatibility with
existing DTs.

Let me explain instead what's going on, and why imx-drm is different.

The iMX DT files describe the hardware, which is a very complex block.
The IPU as a whole in DT, with its external interfaces.  The IPU driver
lives in drivers/gpu/ipu-v3/.

The hardware is a single controller (aka IPU - image processing unit)
which consists of many sub-blocks of hardware.  Two of these blocks
are display controllers with associated display interfaces.  These
_can_ be programmed to behave as a CRTC, but they're essentially just
waveform generators.  There's other blocks, including camera interfaces.

We _choose_ in Linux to have the IPU driver create several different
platform devices, one for each of its ports, whether it's a camera
interface or a display interface.  These platform devices are bound
to the IPU's port DT nodes.

Some iMX chips have two IPUs.  This means there can be a total of four
display outputs.

On the display bridge side, display bridges can be configured via
muxes to be connected to any of these display outputs.  Several
display bridges can even be connected to a single display output,
though this is not done in practise.

DT fully describes these links between the display outputs and
display bridges using the OF graph support.  From the DT point of
view, this is all very elegant and correct to the hardware structure.

However, when we come to the Linux implementation, things get sticky
because we need to select the correct platform device corresponding
with the IPU's port.  This can only be done using the 'port' node
and not port->parent.

port->parent would be the IPU device node itself.  If we were to
introduce the additional ports {} node, that doesn't help, because
now port->parent points at the ports {} node instead, not the actual
port - and we need the port itself to identify which of the IPU's
own created platform devices to select.

So, modifying DT doesn't help in any way, even if you ignore the fact
that we need to maintain backwards compatibility.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
