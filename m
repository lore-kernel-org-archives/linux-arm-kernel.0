From: linux@mniewoehner.de (Michael =?ISO-8859-1?Q?Niew=F6hner?=)
Date: Tue, 18 Oct 2016 14:20:27 +0200
Subject: PROBLEM: DWC3 USB 3.0 not working on Odroid-XU4 with Exynos 5422
In-Reply-To: <a4d744ae-d043-b652-3073-f29ebe76f865@codeaurora.org>
References: <1472414695.3845.3.camel@mniewoehner.de>
 <87lgzgdof3.fsf@linux.intel.com> <57C41582.1030604@linux.intel.com>
 <1472468730.4925.3.camel@mniewoehner.de>
 <CANAwSgQMsK8YPxR==UXtR49kiJzYhkzvSCNwn8mDJfj-3wpa2w@mail.gmail.com>
 <CAFp+6iGrS0DTP=KUKDvk3NwWB32+1uj-irKT6fn5XTcfk572Hg@mail.gmail.com>
 <1475578687.1912.28.camel@mniewoehner.de>
 <CAFp+6iGx-jf+xrdHF=0J3FK9dDBg54zESYNVo8bz2Qz6G4gEZg@mail.gmail.com>
 <1475771380.22019.5.camel@mniewoehner.de> <87y420wqoy.fsf@linux.intel.com>
 <1475871962.1697.12.camel@mniewoehner.de>
 <1476627597.1752.3.camel@mniewoehner.de> <874m4btn2m.fsf@linux.intel.com>
 <a4d744ae-d043-b652-3073-f29ebe76f865@codeaurora.org>
Message-ID: <1476793227.1786.2.camel@mniewoehner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
On Mon, 2016-10-17 at 15:21 +0530, Vivek Gautam wrote:
> 
> On 10/17/2016 01:38 PM, Felipe Balbi wrote:
> > Hi,
> > 
> > Michael Niew?hner <linux@mniewoehner.de> writes:
> > > Hi Felipe,
> > > On Fri, 2016-10-07 at 22:26 +0200, Michael Niew?hner wrote:
> > > > Hi Felipe,
> > > > 
> > > > On Fr, 2016-10-07 at 10:42 +0300, Felipe Balbi wrote:
> > > > > Hi,
> > > > > 
> > > > > Michael Niew?hner <linux@mniewoehner.de> writes:
> > > > > > > The clocks are same across working/non-working.
> > > > > > > Is it possible to bisect the commit that's causing hang for 4.8x ?
> > > > > > 
> > > > > > [c499ff71ff2a281366c6ec7a904c547d806cbcd1] usb: dwc3: core: re-factor init and exit paths
> > > > > > This patch causes both the hang on reboot and the lsusb hang.
> > > > > 
> > > > > How to reproduce? Why don't we see this on x86 and TI boards? I'm
> > > > > guessing this is failed bisection, as I can't see anything in that
> > > > > commit that would cause reboot hang. Also, that code path is *NOT*
> > > > > executed when you run lsusb.
> > > > > 
> > > > 
> > > > I've tested this procedure multiple times to be sure:
> > > > 
> > > > - checkout c499ff71, compile, boot the odroid
> > > > - run lsusb -v => lsusb hangs, can't terminate with ctrl-c
> > > > - hard reset, after boot run poweroff or reboot => board does not completely power off / reboot (see log below)
> > > > - revert c499ff71, mrproper, compile, boot the odroid
> > > > - run lsusb -v => shows full output, not hanging
> > > > - run reboot or poweroff => board powers off / reboots just fine
> > > > 
> > > > 
> > > > dmesg poweroff not working:
> > > > ...
> > > > [??120.733519] systemd-journald[144]: systemd-journald stopped as pid 144
> > > > [??120.742663] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
> > > > [??120.769212] systemd-shutdown[1]: Unmounting file systems.
> > > > [??120.773713] systemd-shutdown[1]: Unmounting /sys/kernel/debug.
> > > > [??120.827211] systemd-shutdown[1]: Unmounting /dev/mqueue.
> > > > [??121.081672] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
> > > > [??121.091687] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
> > > > [??121.095608] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
> > > > [??121.101014] systemd-shutdown[1]: All filesystems unmounted.
> > > > [??121.106523] systemd-shutdown[1]: Deactivating swaps.
> > > > [??121.111585] systemd-shutdown[1]: All swaps deactivated.
> > > > [??121.116661] systemd-shutdown[1]: Detaching loop devices.
> > > > [??121.126395] systemd-shutdown[1]: All loop devices detached.
> > > > [??121.130525] systemd-shutdown[1]: Detaching DM devices.
> > > > [??121.135824] systemd-shutdown[1]: All DM devices detached.
> > > > [??121.166327] systemd-shutdown[1]: /lib/systemd/system-shutdown succeeded.
> > > > [??121.171739] systemd-shutdown[1]: Powering off.
> > > > 
> > > > => at this point removing the sd card would show a message
> > > > "removed mmc0" (not sure what the real message was...) so the board is not completely off.
> > > > 
> > > > 
> > > > dmesg poweroff working:
> > > > ...
> > > > [??120.733519] systemd-journald[144]: systemd-journald stopped as pid 144
> > > > [??120.742663] systemd-shutdown[1]: Sending SIGKILL to remaining processes...
> > > > [??120.769212] systemd-shutdown[1]: Unmounting file systems.
> > > > [??120.773713] systemd-shutdown[1]: Unmounting /sys/kernel/debug.
> > > > [??120.827211] systemd-shutdown[1]: Unmounting /dev/mqueue.
> > > > [??121.081672] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
> > > > [??121.091687] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
> > > > [??121.095608] EXT4-fs (mmcblk1p2): re-mounted. Opts: (null)
> > > > [??121.101014] systemd-shutdown[1]: All filesystems unmounted.
> > > > [??121.106523] systemd-shutdown[1]: Deactivating swaps.
> > > > [??121.111585] systemd-shutdown[1]: All swaps deactivated.
> > > > [??121.116661] systemd-shutdown[1]: Detaching loop devices.
> > > > [??121.126395] systemd-shutdown[1]: All loop devices detached.
> > > > [??121.130525] systemd-shutdown[1]: Detaching DM devices.
> > > > [??121.135824] systemd-shutdown[1]: All DM devices detached.
> > > > [??121.166327] systemd-shutdown[1]: /lib/systemd/system-shutdown succeeded.
> > > > [??121.171739] systemd-shutdown[1]: Powering off.
> > > > [??121.182331] rebo?
> > > > 
> > > > 
> > > > 
> > > > Best regards
> > > > Michael Niew?hner
> > > 
> > > I did some more tests with next-20161016. Reverting / commenting out
> > > one part of your patch "solves" the lsusb hang, the reboot problem
> > > and also the "debounce failed" message. [1]
> > > Another "solution" is to call phy_power_off before phy_power_on. [2]
> > > 
> > > Disclaimer: I have no idea what I was doing ;-) These were just some
> > > simple trial-and-error attempts that maybe help to find the real
> > > cause of the problems.
> > > 
> > > [1]
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 7287a76..5ef589d 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -724,6 +724,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
> > > ??	/* Adjust Frame Length */
> > > ??	dwc3_frame_length_adjustment(dwc);
> > > ??
> > > +/*
> > > ??	usb_phy_set_suspend(dwc->usb2_phy, 0);
> > > ??	usb_phy_set_suspend(dwc->usb3_phy, 0);
> > > ??	ret = phy_power_on(dwc->usb2_generic_phy);
> > > @@ -733,6 +734,7 @@ static int dwc3_core_init(struct dwc3 *dwc)
> > > ??	ret = phy_power_on(dwc->usb3_generic_phy);
> > > ??	if (ret < 0)
> > > ??		goto err3;
> > > +*/
> > > ??
> > > ??	ret = dwc3_event_buffers_setup(dwc);
> > > ??	if (ret) {
> > > 
> > > [2]
> > > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > > index 7287a76..f6c8e13 100644
> > > --- a/drivers/usb/dwc3/core.c
> > > +++ b/drivers/usb/dwc3/core.c
> > > @@ -726,6 +726,8 @@ static int dwc3_core_init(struct dwc3 *dwc)
> > > ??
> > > ?????????usb_phy_set_suspend(dwc->usb2_phy, 0);
> > > ?????????usb_phy_set_suspend(dwc->usb3_phy, 0);
> > > +???????phy_power_off(dwc->usb2_generic_phy);
> > > +???????phy_power_off(dwc->usb3_generic_phy);
> > 
> > This looks like a PHY driver bug to me. Which PHY driver are you using?
> > 
> 
> The exynos5-usbdrd phy driver is used for exynos platforms.
> Looks like something is not right with the phy driver even
> after applying the phy_calibrate patches.
> 
> Michael, are you using the last set of patches for phy calibration [1]?
> [1] https://lkml.org/lkml/2015/2/2/257.

yes, I'm using the original LOS level patch.
The phy patch doesn't apply to next, so I use this adapted patch:
https://github.com/c0d3z3r0/linux/commit/8b7a0b2a19e235c308b9082a14ffe73477e2c9ed

> 
> 
> Thanks
> Vivek
> 


Michael
