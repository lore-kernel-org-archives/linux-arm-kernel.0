From: b-liu@ti.com (Bin Liu)
Date: Mon, 9 Oct 2017 21:14:39 -0500
Subject: [PATCH] usb: musb: sunxi: Explicitly release USB PHY on exit
In-Reply-To: <CANwerB2kbxnhrgWAnmWB9Uzp+M1MjC7MwWuwLXw==dpdCRLCAA@mail.gmail.com>
References: <20170926113923.18181-1-net147@gmail.com>
 <20171009142302.GB32614@uda0271908>
 <CANwerB2kbxnhrgWAnmWB9Uzp+M1MjC7MwWuwLXw==dpdCRLCAA@mail.gmail.com>
Message-ID: <20171010021439.GH12182@LTA0271908.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 10, 2017 at 08:17:34AM +1100, Jonathan Liu wrote:
> Hi,
> 
> On 10 October 2017 at 01:23, Bin Liu <b-liu@ti.com> wrote:
> > Hi,
> >
> > On Tue, Sep 26, 2017 at 09:39:23PM +1000, Jonathan Liu wrote:
> >> This fixes a kernel oops when unloading the driver due to usb_put_phy
> >> being called after usb_phy_generic_unregister when the device is
> >> detached. Calling usb_phy_generic_unregister causes x->dev->driver to
> >> be NULL in usb_put_phy and results in a NULL pointer dereference.
> >>
> >> As we are now explicitly managing the lifetime of usb_phy,
> >> devm_usb_get_phy is changed to usb_get_phy and we call usb_put_phy in
> >> the probe error path.
> >>
> >> Cc: stable at vger.kernel.org # v4.3+
> >> Signed-off-by: Jonathan Liu <net147@gmail.com>
> >> ---
> >>  drivers/usb/musb/sunxi.c | 8 ++++++--
> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/usb/musb/sunxi.c b/drivers/usb/musb/sunxi.c
> >> index c9a09b5bb6e5..8eed61042103 100644
> >> --- a/drivers/usb/musb/sunxi.c
> >> +++ b/drivers/usb/musb/sunxi.c
> >> @@ -297,6 +297,8 @@ static int sunxi_musb_exit(struct musb *musb)
> >>       if (test_bit(SUNXI_MUSB_FL_HAS_SRAM, &glue->flags))
> >>               sunxi_sram_release(musb->controller->parent);
> >>
> >> +     usb_put_phy(glue->xceiv);
> >
> > Will devm_usb_put_phy() solve the issue too? Then you don't need the
> > changes in sunxi_musb_probe() below.
> >
> 
> devm_usb_put_phy does solve the issue without changes in
> sunxi_musb_probe but I think it is clearer that the lifetime is
> explicitly managed if we don't mix implicit and explicit freeing of
> resources.

Then what is the purpose of the devm_* API?

The original bug was that devm_usb_get_phy() is called in _probe, but
devm_usb_put_phy() was never called, which caused the device ref count
unbalanced. It is not related to implicit/explicit resource management.

devm_* is recommended whenever applicable.

Regards,
-Bin.
