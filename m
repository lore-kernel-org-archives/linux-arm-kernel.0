From: marex@denx.de (Marek Vasut)
Date: Fri, 12 Jul 2013 06:04:43 +0200
Subject: [PATCH v12 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <20130712031200.GB14793@nchen-desktop>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <201307111957.19537.marex@denx.de> <20130712031200.GB14793@nchen-desktop>
Message-ID: <201307120604.43642.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

> On Thu, Jul 11, 2013 at 07:57:19PM +0200, Marek Vasut wrote:
> > Hi Peter,
> > 
> > > This patchset adds tested otg id switch function and
> > > vbus connect and disconnect detection for chipidea driver.
> > > And fix kinds of bugs found at chipidea drivers after enabling
> > > id and vbus detection.
> > > 
> > > This patch is fully tested at imx6 sabresd platform.
> > > My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
> > > 
> > > Changes for v12:
> > > - Rebased greg's usb-next tree (3.10.0-rc7+)
> > > - Split more small patches for single function and fix.
> > 
> > I tested the patchset. Here are the results:
> > 
> > - VBUS switching
> > 
> > I'm no longer getting any ID interrupts at all when I apply the patch
> > below. The board stays in HOST mode all the time. If I configure it as
> > peripheral, it works as peripheral. Note with [1], I was able to switch
> > from Peripheral->Host , not the other way around.
> 
> Thanks for your testing. But first, can you have me check
> if your ID wakeup is enabled?

ID wakeup? How do I check?

> I can have a test at mx28evk.
> Is it current upstream kernel can boot mx28evk run?

Yes, I use next-20130711 and it works fine.

> I have a RevC board, I would like to know if
> any patches needed.

Apply just this patchset and you should be all set.

> > --- a/arch/arm/boot/dts/imx28-m28evk.dts
> > +++ b/arch/arm/boot/dts/imx28-m28evk.dts
> > @@ -240,6 +240,8 @@
> > 
> >         ahb at 80080000 {
> >         
> >                 usb0: usb at 80080000 {
> > 
> > +                       dr_mode = "otg";
> > +                       phy_mode = "utmi";
> > 
> >                         vbus-supply = <&reg_usb0_vbus>;
> >                         pinctrl-names = "default";
> >                         pinctrl-0 = <&usbphy0_pins_a>;
> > 
> > ---------------------------
> > 
> > - MX23 UDC issue
> > 
> > I found a workaround. Now running 'dmesg' via telnet through USB CDC link
> > no longer hangs the USB driver, but works as expected. I applied this
> > small patch that enables the streaming mode. Works on MX23EVK. It's
> > surprising this issue doesn't manifest on MX28, maybe MX28 contains a
> > new revision of the controller. I remember there was some discussion
> > about the streaming mode on MXS some time ago.
> 
> It seems not reasonable

I talked to Fabio and he said he met similar issue on MX6, where disabling the 
streaming mode fixed the problem. Could it possibly be so that the non-streaming 
mode is broken on mx23?

btw. I also tested this on STMP3780-based device, works the same way as MX23 
does, streaming mode has to be enabled.

> the same question for mx23evk,
> it can run well with current kernel? I have no board on hand,
> let me see if I can find one.

Yes, MX23EVK rev. B2 works just fine with next-20130711 . You need to add the DT 
USB sections for MX23EVK, but they can be copied from imx28.dtsi + imx28-evk.dts 
.

Best regards,
Marek Vasut
