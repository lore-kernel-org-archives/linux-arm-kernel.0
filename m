From: peter.chen@freescale.com (Peter Chen)
Date: Fri, 12 Jul 2013 11:12:01 +0800
Subject: [PATCH v12 00/13] Add tested id switch and vbus connect detect
 support for Chipidea
In-Reply-To: <201307111957.19537.marex@denx.de>
References: <1373524041-10482-1-git-send-email-peter.chen@freescale.com>
 <201307111957.19537.marex@denx.de>
Message-ID: <20130712031200.GB14793@nchen-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 07:57:19PM +0200, Marek Vasut wrote:
> Hi Peter,
> 
> > This patchset adds tested otg id switch function and
> > vbus connect and disconnect detection for chipidea driver.
> > And fix kinds of bugs found at chipidea drivers after enabling
> > id and vbus detection.
> > 
> > This patch is fully tested at imx6 sabresd platform.
> > My chipidea repo: https://github.com/hzpeterchen/linux-usb.git
> > 
> > Changes for v12:
> > - Rebased greg's usb-next tree (3.10.0-rc7+)
> > - Split more small patches for single function and fix.
> 
> I tested the patchset. Here are the results:
> 
> - VBUS switching
> 
> I'm no longer getting any ID interrupts at all when I apply the patch below. The 
> board stays in HOST mode all the time. If I configure it as peripheral, it works 
> as peripheral. Note with [1], I was able to switch from Peripheral->Host , not 
> the other way around.

Thanks for your testing. But first, can you have me check
if your ID wakeup is enabled?

I can have a test at mx28evk.
Is it current upstream kernel can boot mx28evk run?
I have a RevC board, I would like to know if
any patches needed.
> 
> --- a/arch/arm/boot/dts/imx28-m28evk.dts
> +++ b/arch/arm/boot/dts/imx28-m28evk.dts
> @@ -240,6 +240,8 @@
>  
>         ahb at 80080000 {
>                 usb0: usb at 80080000 {
> +                       dr_mode = "otg";
> +                       phy_mode = "utmi";
>                         vbus-supply = <&reg_usb0_vbus>;
>                         pinctrl-names = "default";
>                         pinctrl-0 = <&usbphy0_pins_a>;
> 
> ---------------------------
> 
> - MX23 UDC issue
> 
> I found a workaround. Now running 'dmesg' via telnet through USB CDC link no 
> longer hangs the USB driver, but works as expected. I applied this small patch 
> that enables the streaming mode. Works on MX23EVK. It's surprising this issue 
> doesn't manifest on MX28, maybe MX28 contains a new revision of the controller. 
> I remember there was some discussion about the streaming mode on MXS some time 
> ago.

It seems not reasonable, the same question for mx23evk,
it can run well with current kernel? I have no board on hand,
let me see if I can find one.
  

-- 

Best Regards,
Peter Chen
