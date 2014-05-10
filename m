From: peter.chen@freescale.com (Peter Chen)
Date: Sat, 10 May 2014 19:10:05 +0800
Subject: i.MX6 USB OTG support is broken on linux-next
In-Reply-To: <20140509130046.GP2794@dragon>
References: <20140509130046.GP2794@dragon>
Message-ID: <20140510111003.GA1593@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 09, 2014 at 09:00:47PM +0800, Shawn Guo wrote:
> I'm running next-20140508 kernel on imx6q-sabresd board with USB
> mouse/keyboard connected to OTG port.  It  works well on 3.15-rc but
> is broken on recent linux-next kernel with the message like below.
> 
> ...
> usb 1-1: device v413c p2107 is not supported
> hub 1-0:1.0: unable to enumerate USB device on port 1
> 
> With the help from Peter, I found that the issue shows up only when
> CONFIG_USB_OTG_FSM is enabled.  The option is enabled by commit 8fd2f1f
> (ARM: imx_v6_v7_defconfig: Enable drivers for i.MX51 USB Host support.)
> from IMX tree.
> 
> I guess this is a sign that chipidea otg_fsm driver is buggy?  I do not
> think dropping CONFIG_USB_OTG_FSM selection from imx_v6_v7_defconfig is
> a solution, and we need to fix the issue in usb driver, right?
> 

No, Shawn. The solution of this problem is drop CONFIG_USB_OTG_FSM, I
guess Denis added it wrongly.

According to Embedded Hosts & OTG spec, OTG devices and Embedded Hosts
both have Targeted Host functionality, and each Targeted Host has
its TPL (Targeted Peripheral List), only the devices are at TPL
are supported by Targeted Host.

Current Linux TPL only contains limited devices, each Targeted Host
needs to update its TPL when it makes product, (The comments at
otg_whitelist.h also mention it), and the devices are not at TPL
will not be supported, and will report to user as "an unsupported
device" error, at current Linux configuration, once the CONFIG_USB_OTG_FSM
and CONFIG_USB_OTG are chosen, the host will be Targeted Host.

The reason why Shawn met this problem is: the imx_v6_v7_defconfig set 
CONFIG_USB_OTG_FSM, so the CONFIG_USB_OTG and CONFIG_USB_OTG_WHITELIST
are set according to dependency, it makes imx6 device as Targeted Host,
but the devices connected at Shawn's board are not at TPL, so they are
not be supported.

In a word the CONFIG_USB_OTG_FSM should not be chosen for
defauly kernel configuration. The CONFIG_USB_OTG_FSM should only be chosen
by default when this device goes to make product and the TPL is updated
accordingly.

Peter
