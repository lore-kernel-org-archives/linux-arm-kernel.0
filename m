From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 14 Feb 2017 17:59:10 +0100
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <04a4d130-0259-cbba-7815-e41c1c80c3c7@gmail.com>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
 <1486036237.2289.37.camel@pengutronix.de>
 <ca0a2eb3-21b6-d312-c8e0-61da48c4c700@gmail.com>
 <20170208234235.GA27312@n2100.armlinux.org.uk>
 <d6dba77e-902c-7a4c-cc70-fe3a5c9649bb@gmail.com>
 <e9076980-ce84-f9ee-096d-865243b82a9e@gmail.com>
 <1486977617.2873.29.camel@pengutronix.de>
 <04a4d130-0259-cbba-7815-e41c1c80c3c7@gmail.com>
Message-ID: <1487091550.2305.32.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Mon, 2017-02-13 at 15:20 -0800, Steve Longerbeam wrote:
[...]
> > It seems the OV5640 driver never puts its the CSI-2 lanes into stop
> > state while not streaming.
> 
> Yes I found that as well.
> 
> But good news, I finally managed to coax the OV5640's clock lane
> into LP-11 state! It was accomplished by setting bit 5 in OV5640 register
> 0x4800. The datasheet describes this bit as "Gate clock lane when no
> packet to transmit". But I may have also got this to work with the 
> additional
> write 1 to bits 4-6 in register 0x3019 ("MIPI CLK/data lane state in sleep
> mode" - setting 1 to these bits selects LP-11 for sleep mode).
> 
> So I am now finally able to call csi2_dphy_wait_stopstate() in
> csi2_s_stream(ON).

That's good news.

> So for the TC35874, you shouldn't see a timeout in csi2_s_stream(ON)
> any longer.
> 
> I have updated both ov5640.c and imx6-mipi-csi2.c in the wip branch.
> Can you try again? I have not applied your patch below, because I
> don't think that is needed anymore.

Thanks, I'll test tomorrow.

> And speaking of the TC35874, I received this module for the SabreLite
> from Boundary Devices (thanks BD!). So I can finally help you with
> debug/test. Are there any patches you need to send to me (against
> wip branch) for this support, or can I use what exists now in media
> tree? Also any scripts or help with running.

That's even better news. I have pushed my my wip branch, which contains
some colorspace work and experiments to pass through query/g_/s_std
subdev calls so bypassing the pipeline can be avoided. Also, there's the
Nitrogen6X device tree that I've been using to test:

    https://git.pengutronix.de/git/pza/linux imx-media-staging-md-wip

> >   With the recent s_stream reordering,
> > streaming from TC358743 does not work anymore, since imx6-mipi-csi2
> > s_stream is called before tc358743 s_stream, while all lanes are still
> > in stop state. Then it waits for the clock lane to become active and
> > fails. I have applied the following patch to revert the reordering
> > locally to get it to work again.
> >
> > The initialization order, as Russell pointed out, should be:
> >
> > 1. reset the D-PHY.
> > 2. place MIPI sensor in LP-11 state
> > 3. perform D-PHY initialisation
> > 4. configure CSI2 lanes and de-assert resets and shutdown signals
> >
> > So csi2_s_stream should wait for stop state on all lanes (the result of
> > 2.) before dphy_init (3.), not wait for active clock afterwards. That
> > should happen only after sensor_s_stream was called. So unless we are
> > allowed to reorder steps 1. and 2., we might need the prepare_stream
> > callback after all.
> 
> Agreed!
> 
> See my new FIXME comment in imx6-mipi-csi2.c.

Looks good. I wonder if enabling the phy clock isn't part of step 3.
though.

> I agree we might need a new subdev op .prepare_stream(). This
> op would be implemented by imx6-mipi-csi2.c, and would carry
> out steps 3, 4, 5 (instead of currently by csi2_s_stream()). Then
> step 6 would finally become available as csi2_s_stream().
> 
> And then we must re-order stream on to start sensor first, then
> csi2, as in your patch below.

regards
Philipp
