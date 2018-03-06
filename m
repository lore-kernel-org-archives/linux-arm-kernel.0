From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 06 Mar 2018 19:49:41 +0100
Subject: [PATCH] arm64: dts: rockchip: Fix rk3399-gru-* s2r (pinctrl hogs,
 wifi reset)
In-Reply-To: <16f41a01-2ac2-c4c0-6989-990612b467d1@arm.com>
References: <20180227204711.29357-1-dianders@chromium.org>
 <CAD=FV=Wr6_U9c1qFRgx3=JhMg8US20_oMEmEfCdpVyGKek_8gQ@mail.gmail.com>
 <16f41a01-2ac2-c4c0-6989-990612b467d1@arm.com>
Message-ID: <13699528.5LUGj0SynH@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 6. M?rz 2018, 19:15:18 CET schrieb Marc Zyngier:
> Hi Doug,
> 
> On 06/03/18 18:00, Doug Anderson wrote:
> > Hi,
> > 
> > On Tue, Mar 6, 2018 at 3:58 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> >> Hi all,
> >> 
> >> On 01/03/18 08:43, Heiko St?bner wrote:
> >>> Am Dienstag, 27. Februar 2018, 21:47:11 CET schrieb Douglas Anderson:
> >>>> Back in the early days when gru devices were still under development
> >>>> we found an issue where the WiFi reset line needed to be configured as
> >>>> early as possible during the boot process to avoid the WiFi module
> >>>> being in a bad state.
> >>>> 
> >>>> We found that the way to get the kernel to do this in the earliest
> >>>> possible place was to configure this line in the pinctrl hogs, so
> >>>> that's what we did.  For some history here you can see
> >>>> <http://crosreview.com/368770>.  After the time that change landed in
> >>>> the kernel, we landed a firmware change to configure this line even
> >>>> earlier.  See <http://crosreview.com/399919>.  However, even after the
> >>>> firmware change landed we kept the kernel change to deal with the fact
> >>>> that some people working on devices might take a little while to
> >>>> update their firmware.
> >>>> 
> >>>> At this there are definitely zero devices out in the wild that have
> >>>> firmware without the fix in it.  Specifically looking in the firmware
> >>>> branch several critically important fixes for memory stability landed
> >>>> after the patch in coreboot and I know we didn't ship without those.
> >>>> Thus, by now, everyone should have the new firmware and it's safe to
> >>>> not have the kernel set this up in a pinctrl hog.
> >>>> 
> >>>> Historically, even though it wasn't needed to have this in a pinctrl
> >>>> hog, we still kept it since it didn't hurt.  Pinctrl would apply the
> >>>> default hog at bootup and then would never touch things again.  That
> >>>> all changed with commit 981ed1bfbc6c ("pinctrl: Really force states
> >>>> during suspend/resume").  After that commit then we'll re-apply the
> >>>> default hog at resume time and that can screw up the reset state of
> >>>> WiFi.  ...and on rk3399 if you touch a device on PCIe in the wrong way
> >>>> then the whole system can go haywire.  That's what was happening.
> >>>> Specifically you'd resume a rk3399-gru-* device and it would mostly
> >>>> resume, then would crash with some crazy weird crash.
> >>>> 
> >>>> One could say, perhaps, that the recent pinctrl change was at fault
> >>>> (and should be fixed) since it changed behavior.  ...but that's not
> >>>> really true.  The device tree for rk3399-gru is really to blame.
> >>>> Specifically since the pinctrl is defined in the hog and not in the
> >>>> "wlan-pd-n" node then the actual user of this pin doesn't have a
> >>>> pinctrl entry for it.  That's bad.
> >>>> 
> >>>> Let's fix our problems by just moving the control of
> >>>> "wlan_module_reset_l pinctrl" out of the hog and put them in the
> >>>> proper place.
> >>>> 
> >>>> NOTE: in theory, I think it should actually be possible to have a pin
> >>>> controlled _both_ by the hog and by an actual device.  Once the device
> >>>> claims the pin I think the hog is supposed to let go.  I'm not 100%
> >>>> sure that this works and in any case this solution would be more
> >>>> complex than is necessary.
> >>>> 
> >>>> Reported-by: Marc Zyngier <marc.zyngier@arm.com>
> >>>> Fixes: 48f4d9796d99 ("arm64: dts: rockchip: add Gru/Kevin DTS")
> >>>> Fixes: 981ed1bfbc6c ("pinctrl: Really force states during
> >>>> suspend/resume")
> >>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >>> 
> >>> applied as fix for 4.16 with the 2 Tested-tags
> >> 
> >> Sorry to rain on everyone's parade, but further testing shows that this
> >> patch may not be enough to restore a reliable s2r. My initial testing
> >> did show that we were resuming without the VOP errors, but there seem to
> >> be further issues (I'm loosing the keyboard and the trackpad after
> >> resume on Kevin).
> >> 
> >> Applying my initial hack makes it work again. I suspect that there are
> >> more hog pins that need tweaking, but I'm a bit out of my depth here.
> > 
> > Are you positive you weren't just wearing your lucky hat when you
> > tested your patch and then took it off when you tested mine?  As far
> 
> So far, I seem to have a 100% success rate in resuming with my silly
> hack, whist your DT patch alone only gives me a 50% rate at best.
> 
> > as I can see the only hogs left on kevin are:
> >   &ap_pwroff      /* AP will auto-assert this when in S3 */
> >   &clk_32k        /* This pin is always 32k on gru boards */
> > 
> > Those map to:
> >   ap_pwroff: ap-pwroff {
> >   
> >      rockchip,pins = <1 5 RK_FUNC_1 &pcfg_pull_none>;
> >   
> >   };
> >   
> >   clk_32k: clk-32k {
> >   
> >     rockchip,pins = <0 0 RK_FUNC_2 &pcfg_pull_none>;
> >   
> >   };
> > 
> > So I added some printouts at suspend/resume time.  Specifically I set
> > a boolean to "true" for the duration rockchip_pinctrl_suspend() and
> > rockchip_pinctrl_resume() and this turned on a printout in
> > rockchip_set_mux().  My printout looked like this (yeah, I know it's a
> > whitespace-damaged patch just to show what I'm doing):
> > 
> > +       regmap_read(regmap, reg, &before);
> > 
> >         data = (mask << (bit + 16));
> >         rmask = data | (data >> 16);
> >         data |= (mux & mask) << bit;
> >         ret = regmap_update_bits(regmap, reg, rmask, data);
> > 
> > +       regmap_read(regmap, reg, &after);
> > +
> > +       if (DOUG) {
> > +               dev_info(info->dev,
> > +                        "setting mux of GPIO%d-%d to %d;
> > %#010x=>%#010x\n", +                        bank->bank_num, pin, mux,
> > reg, before, after); +       }
> > 
> > ...and a similar one in rockchip_set_pull().  That showed this at resume
> > time:
> > 
> > [   62.284427] rockchip-pinctrl pinctrl: setting mux of GPIO1-5 to 1;
> > 0x00009400=>0x00009400
> > [   62.294423] rockchip-pinctrl pinctrl: setting pull of GPIO1-5;
> > 0x000041aa=>0x000041aa
> > [   62.303343] rockchip-pinctrl pinctrl: setting mux of GPIO0-0 to 2;
> > 0x00005002=>0x00005002
> > [   62.313240] rockchip-pinctrl pinctrl: setting pull of GPIO0-0;
> > 0x00000ddc=>0x00000ddc
> > [
> > 
> > Said another way: pinmux and pull isn't actually changing due to the
> > hogs.  We can see if something else could be changing, but I'd really
> > want to be sure you're certain that the hogs are causing you
> > problems...
> 
> I cannot say for sure that the hogs are the issue. But I thought that
> they were the only pins affected by 981ed1bfbc6c... If this patch can
> affect other pins, then I'm probably barking up the wrong tree.

On Kevin I see something like

[   60.764129] cros-ec-spi spi2.0: spi transfer failed: -108
[   60.764132] cros-ec-spi spi2.0: cs-deassert spi transfer failed: -108
[   60.764136] cros-ec-spi spi2.0: Command xfer error (err:-108)
[   60.764365] cros-ec-spi spi2.0: spi transfer failed: -108
[   60.764368] cros-ec-spi spi2.0: cs-deassert spi transfer failed: -108
[   60.764371] cros-ec-spi spi2.0: Command xfer error (err:-108)

on resume with my current for-next. So maybe your hack just
happened to change some timing during resume?

Suspend/Resume also disconnects my usb-ethernet, making me lose my
nfsroot, so I can test this once every boot only.
