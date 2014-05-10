From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 10 May 2014 21:18:36 +0800
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <20140510111003.GA1593@shlinux1.ap.freescale.net>
References: <20140509130046.GP2794@dragon>
 <20140510111003.GA1593@shlinux1.ap.freescale.net>
Message-ID: <20140510131815.GT2794@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Robin and David,

On Sat, May 10, 2014 at 07:10:05PM +0800, Peter Chen wrote:
> On Fri, May 09, 2014 at 09:00:47PM +0800, Shawn Guo wrote:
> > I'm running next-20140508 kernel on imx6q-sabresd board with USB
> > mouse/keyboard connected to OTG port.  It  works well on 3.15-rc but
> > is broken on recent linux-next kernel with the message like below.
> > 
> > ...
> > usb 1-1: device v413c p2107 is not supported
> > hub 1-0:1.0: unable to enumerate USB device on port 1
> > 
> > With the help from Peter, I found that the issue shows up only when
> > CONFIG_USB_OTG_FSM is enabled.  The option is enabled by commit 8fd2f1f
> > (ARM: imx_v6_v7_defconfig: Enable drivers for i.MX51 USB Host support.)
> > from IMX tree.
> > 
> > I guess this is a sign that chipidea otg_fsm driver is buggy?  I do not
> > think dropping CONFIG_USB_OTG_FSM selection from imx_v6_v7_defconfig is
> > a solution, and we need to fix the issue in usb driver, right?
> > 
> 
> No, Shawn. The solution of this problem is drop CONFIG_USB_OTG_FSM, I
> guess Denis added it wrongly.
> 
> According to Embedded Hosts & OTG spec, OTG devices and Embedded Hosts
> both have Targeted Host functionality, and each Targeted Host has
> its TPL (Targeted Peripheral List), only the devices are at TPL
> are supported by Targeted Host.
> 
> Current Linux TPL only contains limited devices, each Targeted Host
> needs to update its TPL when it makes product, (The comments at
> otg_whitelist.h also mention it), and the devices are not at TPL
> will not be supported, and will report to user as "an unsupported
> device" error, at current Linux configuration, once the CONFIG_USB_OTG_FSM
> and CONFIG_USB_OTG are chosen, the host will be Targeted Host.
> 
> The reason why Shawn met this problem is: the imx_v6_v7_defconfig set 
> CONFIG_USB_OTG_FSM, so the CONFIG_USB_OTG and CONFIG_USB_OTG_WHITELIST
> are set according to dependency, it makes imx6 device as Targeted Host,
> but the devices connected at Shawn's board are not at TPL, so they are
> not be supported.
> 
> In a word the CONFIG_USB_OTG_FSM should not be chosen for
> defauly kernel configuration. The CONFIG_USB_OTG_FSM should only be chosen
> by default when this device goes to make product and the TPL is updated
> accordingly.

Thanks for the explanation, Peter.

So this is what I see from USB Kconfig.

config USB_OTG_FSM
        tristate "USB 2.0 OTG FSM implementation"
        depends on USB
        select USB_OTG
        select USB_PHY

config USB_OTG_WHITELIST
        bool "Rely on OTG Targeted Peripherals List"
        depends on USB_OTG || EXPERT
        default y if USB_OTG

I see that USB_OTG_FSM has a dependency on USB_OTG, and
USB_OTG_WHITELIST depends on USB_OTG, but USB_OTG does *not* depends
on USB_OTG_WHITELIST.

I'm not sure why we have 'default y if USB_OTG' for USB_OTG_WHITELIST,
when this option only makes sense for product producers per your
explanation.  So maybe dropping the 'default y' is the right fix?

diff --git a/drivers/usb/core/Kconfig b/drivers/usb/core/Kconfig
index cb8e991..9081757 100644
--- a/drivers/usb/core/Kconfig
+++ b/drivers/usb/core/Kconfig
@@ -65,7 +65,6 @@ config USB_OTG
 config USB_OTG_WHITELIST
        bool "Rely on OTG Targeted Peripherals List"
        depends on USB_OTG || EXPERT
-       default y if USB_OTG
        help
          If you say Y here, the "otg_whitelist.h" file will be used as a
          product whitelist, so USB peripherals not listed there will be

Shawn
