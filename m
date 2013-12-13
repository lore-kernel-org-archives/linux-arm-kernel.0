From: balbi@ti.com (Felipe Balbi)
Date: Fri, 13 Dec 2013 14:09:24 -0600
Subject: [PATCH v6 08/15] usb: phy-mxs: Add implementation of
 nofity_suspend and notify_resume
In-Reply-To: <CAL411-rEJN_AkmJEooVB+45qDE8n8CGNq-ODUKMhfPyuQ5fPwA@mail.gmail.com>
References: <1386897825-6130-1-git-send-email-peter.chen@freescale.com>
 <1386897825-6130-9-git-send-email-peter.chen@freescale.com>
 <20131213043236.GH867@saruman.home>
 <CAL411-rEJN_AkmJEooVB+45qDE8n8CGNq-ODUKMhfPyuQ5fPwA@mail.gmail.com>
Message-ID: <20131213200924.GI5292@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 13, 2013 at 02:31:42PM +0800, Peter Chen wrote:
> On Fri, Dec 13, 2013 at 12:32 PM, Felipe Balbi <balbi@ti.com> wrote:
> > On Fri, Dec 13, 2013 at 09:23:38AM +0800, Peter Chen wrote:
> >> Implementation of notify_suspend and notify_resume will be different
> >> according to mxs_phy_data->flags.
> >>
> >> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> >> ---
> >>  drivers/usb/phy/phy-mxs-usb.c |   55 ++++++++++++++++++++++++++++++++++++++---
> >>  1 files changed, 51 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/usb/phy/phy-mxs-usb.c b/drivers/usb/phy/phy-mxs-usb.c
> >> index 0ef930a..e3df53f 100644
> >> --- a/drivers/usb/phy/phy-mxs-usb.c
> >> +++ b/drivers/usb/phy/phy-mxs-usb.c
> >> @@ -166,8 +166,8 @@ static int mxs_phy_suspend(struct usb_phy *x, int suspend)
> >>  static int mxs_phy_on_connect(struct usb_phy *phy,
> >>               enum usb_device_speed speed)
> >>  {
> >> -     dev_dbg(phy->dev, "%s speed device has connected\n",
> >> -             (speed == USB_SPEED_HIGH) ? "high" : "non-high");
> >> +     dev_dbg(phy->dev, "%s device has connected\n",
> >> +             (speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
> >
> > unrelated.
> >
> >> @@ -179,8 +179,8 @@ static int mxs_phy_on_connect(struct usb_phy *phy,
> >>  static int mxs_phy_on_disconnect(struct usb_phy *phy,
> >>               enum usb_device_speed speed)
> >>  {
> >> -     dev_dbg(phy->dev, "%s speed device has disconnected\n",
> >> -             (speed == USB_SPEED_HIGH) ? "high" : "non-high");
> >> +     dev_dbg(phy->dev, "%s device has disconnected\n",
> >> +             (speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
> >
> > unrelated.
> >
> 
> Marek suggested using that string, I will added it at another patch.
> 
> >> @@ -189,6 +189,48 @@ static int mxs_phy_on_disconnect(struct usb_phy *phy,
> >>       return 0;
> >>  }
> >>
> >> +static int mxs_phy_on_suspend(struct usb_phy *phy,
> >> +             enum usb_device_speed speed)
> >> +{
> >> +     struct mxs_phy *mxs_phy = to_mxs_phy(phy);
> >> +
> >> +     dev_dbg(phy->dev, "%s device has suspended\n",
> >> +             (speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
> >> +
> >> +     /* delay 4ms to wait bus entering idle */
> >> +     usleep_range(4000, 5000);
> >> +
> >> +     if (mxs_phy->data->flags & MXS_PHY_ABNORMAL_IN_SUSPEND) {
> >> +             writel_relaxed(0xffffffff, phy->io_priv + HW_USBPHY_PWD);
> >> +             writel_relaxed(0, phy->io_priv + HW_USBPHY_PWD);
> >> +     }
> >> +
> >> +     if (speed == USB_SPEED_HIGH)
> >> +             writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> >> +                             phy->io_priv + HW_USBPHY_CTRL_CLR);
> >
> > why only on HS ? So if !HS and !ABNORMAL, this is no-op.
> >
> >> +static int mxs_phy_on_resume(struct usb_phy *phy,
> >> +             enum usb_device_speed speed)
> >> +{
> >> +     dev_dbg(phy->dev, "%s device has resumed\n",
> >> +             (speed == USB_SPEED_HIGH) ? "HS" : "FS/LS");
> >> +
> >> +     if (speed == USB_SPEED_HIGH) {
> >> +             /* Make sure the device has switched to High-Speed mode */
> >> +             udelay(500);
> >> +             writel_relaxed(BM_USBPHY_CTRL_ENHOSTDISCONDETECT,
> >> +                             phy->io_priv + HW_USBPHY_CTRL_SET);
> >> +     }
> >
> > likewise, if !HS it's a no-op.
> >
> 
> Correct,  this operation is only needed for HS.
> 
> >> @@ -235,6 +277,11 @@ static int mxs_phy_probe(struct platform_device *pdev)
> >>
> >>       platform_set_drvdata(pdev, mxs_phy);
> >>
> >> +     if (mxs_phy->data->flags & MXS_PHY_SENDING_SOF_TOO_FAST) {
> >> +             mxs_phy->phy.notify_suspend = mxs_phy_on_suspend;
> >> +             mxs_phy->phy.notify_resume = mxs_phy_on_resume;
> >> +     }
> >
> > hmm, and seems like you only need notify_* on a buggy device. Sorry
> > Peter but you don't have enough arguments to make me agree with this
> > (and previous) patch.
> >
> > You gotta find a better way to handle this using normal phy
> > suspend/resume calls.
> >
> 
> Like I explained at previous patch, it needs to be notified during
> ehci suspend/resume.
> I admit it is a SoC bug, but all SoCs have bugs, hmm.
> Software needs the solution to workaround it which breaks the standard USB spec.

Then I think what you need is a real notification mechanism. usbcore
already notifies about buses and devices being added and removed,
perhaps you can convince Greg to accept suspend/resume notifications.

With that, you can (conditionally) make this driver listen to usbcore
notifications. That'll be more work, but I guess it's best in the long
run as we won't need to keep on adding callbacks to the USB PHY
structure just because another buggy device showed up on the market.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131213/2aea1aa5/attachment.sig>
