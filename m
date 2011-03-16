From: balbi@ti.com (Felipe Balbi)
Date: Wed, 16 Mar 2011 14:47:33 +0200
Subject: [PATCH] DM644x EVM: register MUSB device earlier
In-Reply-To: <4D80A228.7000602@mvista.com>
References: <201103132306.59986.sshtylyov@ru.mvista.com>
	<20110314085248.GA2285@legolas.emea.dhcp.ti.com>
	<4D7E640A.9090908@mvista.com>
	<20110315093332.GA3602@legolas.emea.dhcp.ti.com>
	<4D80A228.7000602@mvista.com>
Message-ID: <20110316124731.GH2325@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 16, 2011 at 02:42:32PM +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 15-03-2011 12:33, Felipe Balbi wrote:
> 
> >>>I wonder how noone has noticed that from -rc1 until now.
> 
> >>    I don't think many people run the most current DaVinci kernel.
> >>Most people probably use the Arago project kernels or even older
> >>MV-based TI's stuff...
> 
> >that's nasty :-p All those hacks on a 2.6.18 kernel...
> 
>    If not 2.6.10... :-)
> 
> >Oh well, thanks for noticing and sending a patch :-)
> 
>    I have noticed that back when testing your patch series, if you
> remember. And I really should have fixed it earlier, so that it could
> get into 2.6.38 (damn my illness that caused a week delay). BTW, you
> haven't done anything about the broken MUSB modules, have you?

You mean building musb as module ? Patch is coming:

diff --git a/drivers/Makefile b/drivers/Makefile
index b423bb1..15df745 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -66,7 +66,7 @@ obj-$(CONFIG_TC)              += tc/
 obj-$(CONFIG_UWB)              += uwb/
 obj-$(CONFIG_USB_OTG_UTILS)    += usb/otg/
 obj-$(CONFIG_USB)              += usb/
-obj-$(CONFIG_USB_MUSB_HDRC)    += usb/musb/
+obj-$(CONFIG_USB_MUSB)         += usb/musb/
 obj-$(CONFIG_PCI)              += usb/
 obj-$(CONFIG_USB_GADGET)       += usb/gadget/
 obj-$(CONFIG_SERIO)            += input/serio/
diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
index 4cbb7e4..32136c4 100644
--- a/drivers/usb/musb/Kconfig
+++ b/drivers/usb/musb/Kconfig
@@ -6,10 +6,14 @@
 comment "Enable Host or Gadget support to see Inventra options"
        depends on !USB && USB_GADGET=n
 
+config USB_MUSB
+       bool
+
 # (M)HDRC = (Multipoint) Highspeed Dual-Role Controller
 config USB_MUSB_HDRC
        depends on (USB || USB_GADGET)
        depends on (ARM || (BF54x && !BF544) || (BF52x && !BF522 && !BF523))
+       select USB_MUSB
        select NOP_USB_XCEIV if (ARCH_DAVINCI || MACH_OMAP3EVM || BLACKFIN)
        select TWL4030_USB if MACH_OMAP_3430SDP
        select TWL6030_USB if MACH_OMAP_4430SDP || MACH_OMAP4_PANDA

compiling and testing a jiffy.

-- 
balbi
