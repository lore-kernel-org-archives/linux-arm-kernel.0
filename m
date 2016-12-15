From: briannorris@chromium.org (Brian Norris)
Date: Wed, 14 Dec 2016 16:47:38 -0800
Subject: [PATCH 3/3] arm64: dts: rockchip: add clk-480m for ehci and ohci
 of rk3399
In-Reply-To: <CAD=FV=UU4JdRjRgEvc_wxprvi6bo46+jd=x2m2QzOe4uJmuRPA@mail.gmail.com>
References: <1481710301-1454-1-git-send-email-zhengxing@rock-chips.com>
 <1481710301-1454-4-git-send-email-zhengxing@rock-chips.com>
 <CAD=FV=UU4JdRjRgEvc_wxprvi6bo46+jd=x2m2QzOe4uJmuRPA@mail.gmail.com>
Message-ID: <20161215004737.GA32652@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I think Doug is probably right on most accounts, and I haven't
thoroughly investigated all the claims. But a few thoughts:

On Wed, Dec 14, 2016 at 04:10:38PM -0800, Doug Anderson wrote:
> On Wed, Dec 14, 2016 at 2:11 AM, Xing Zheng <zhengxing@rock-chips.com> wrote:
> > From: William wu <wulf@rock-chips.com>
> >
> > We found that the suspend process was blocked when it run into
> > ehci/ohci module due to clk-480m of usb2-phy was disabled.
> >
> > The root cause is that usb2-phy suspended earlier than ehci/ohci
> > (usb2-phy will be auto suspended if no devices plug-in).

When you say "suspend" do you mean USB runtime suspend (i.e., auto
suspend) or do you mean system suspend (i.e., driver .suspend()
callbacks)? The latter are empty intentionally for PHY drivers, since
PHY state is managed by the consumer driver (i.e., the controller
driver). And the former doesn't actually disable any clocks AFAIK, so
that's a red herring IIUC.

> This is really weird, but I can confirm it is true on my system too
> (kernel-4.4 based).  At least I see:
> 
> [  208.012065] calling  usb1+ @ 4984, parent: fe380000.usb, cb: usb_dev_suspend
> [  208.569112] calling  ff770000.syscon:usb2-phy at e450+ @ 4983, parent:
> ff770000.syscon, cb: platform_pm_suspend
> [  208.569113] call ff770000.syscon:usb2-phy at e450+ returned 0 after 0 usecs
> [  208.569439] calling  fe380000.usb+ @ 4983, parent: platform, cb:
> platform_pm_suspend
> [  208.569444] call fe380000.usb+ returned 0 after 4 usecs
> 
> 
> In general I thought that suspend order was supposed to be related to
> probe order.  So if your probe order is A, B, C then your suspend
> order would be C, B, A.  ...and we know for sure that the USB PHY
> needs to probe _before_ the main USB controller.  If it didn't then
> you'd get an EPROBE_DEFER in the USB controller, right?  So that means
> that the USB controller should be suspending before its PHY.
> 
> Any chance this is somehow related to async probe?  I'm not a huge
> expert on async probe but I guess I could imagine things getting
> confused if you had a sequence like this:
> 
> 1. Start USB probe (async)
> 2. Start PHY probe
> 3. Finish PHY probe
> 4. In USB probe, ask for PHY--no problems since PHY probe finished
> 5. Finish USB probe
> 
> The probe order would be USB before PHY even though the USB probe
> _depended_ on the PHY probe being finished...  :-/  Anyway, probably
> I'm just misunderstanding something and someone can tell me how dumb I
> am...

That may well be true. There isn't a single defined probe order as soon
as you involve async probe, right? So things get a little fuzzier. Also,
I know if you're talking about async suspend/resume, the driver core
only (until quite recently? [1]) respects parent/child relationships.
But I'm not sure of all the async details right now, and async suspend
isn't typically used for the controllers AFAIK -- just for the
hubs/devices.

Anyway, I don't think that's relevant at all because:

> I also notice that the ehci_platform_power_off() function we're
> actually making PHY commands right before the same commands that turn
> off our clocks.  Presumably those commands aren't really so good to do
> if the PHY has already been suspended?
> 
> Actually, does the PHY suspend from platform_pm_suspend() actually
> even do anything?  It doesn't look like it.  It looks as if all the
> PHY cares about is init/exit and on/off...  ...and it looks as if the
> PHY should be turned off by the EHCI controller at about the same time
> it turns off its clocks...

Right, PHY drivers don't do anything at suspend/resume, since I guess
they presume the consuming driver (the controller) will handle state
transitions (power off, exit).

> I haven't fully dug, but is there any chance that things are getting
> confused between the OTG PHY and the Host PHY?  Maybe when we turn off
> the OTG PHY it turns off something that the host PHY needs?

Random thing I noticed: there seems to be a race in
phy-rockchip-inno-usb2.c, if we're worried about the 480M clock getting
disabled too early. See:

static int rockchip_usb2phy_power_off(struct phy *phy)
{
...
        clk_disable_unprepare(rphy->clk480m);
...
}

static int rockchip_usb2phy_exit(struct phy *phy)
{
        struct rockchip_usb2phy_port *rport = phy_get_drvdata(phy);

        if (rport->port_id == USB2PHY_PORT_OTG &&
            rport->mode != USB_DR_MODE_HOST) {
                cancel_delayed_work_sync(&rport->otg_sm_work);
                cancel_delayed_work_sync(&rport->chg_work);
        } else if (rport->port_id == USB2PHY_PORT_HOST)
                cancel_delayed_work_sync(&rport->sm_work);

        return 0;
}

I believe that means any of those work handlers can still be running while
after power_off() -- and therefore can be running after we've disabled the
clock. Might this be your problem?

If so, you're papering that bug by keeping a clock reference in the
controller, which implicitly defers the *actual*
clock_disable_unprepare() until much later.

Brian

[1] commit 9ed9895370ae ("driver core: Functional dependencies tracking
support")
