From: paul@pwsan.com (Paul Walmsley)
Date: Fri, 3 Dec 2010 18:10:49 -0700 (MST)
Subject: OMAP2+: PM/serial: hold console semaphore while OMAP UARTs are
	disabled
In-Reply-To: <AANLkTi=hiwspQ4hM0Ok+MHjn5iHme4XRTKZPGa0Z2=Xy@mail.gmail.com>
References: <alpine.DEB.2.00.1011241646310.20215@utopia.booyaka.com>
	<AANLkTina+O1GgMgS0qDKix=d4HOtT1fFrCotTuCCxACv@mail.gmail.com>
	<alpine.DEB.2.00.1011251017390.20215@utopia.booyaka.com>
	<AANLkTik5cRQPodAYtacTD5EdQYnDbvGgOoNfNfHuW+fq@mail.gmail.com>
	<alpine.DEB.2.00.1012020022390.2515@utopia.booyaka.com>
	<AANLkTi=hiwspQ4hM0Ok+MHjn5iHme4XRTKZPGa0Z2=Xy@mail.gmail.com>
Message-ID: <alpine.DEB.2.00.1012031807440.17078@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Salut Jean

On Thu, 2 Dec 2010, Jean Pihet wrote:

> On Thu, Dec 2, 2010 at 8:23 AM, Paul Walmsley <paul@pwsan.com> wrote:
> > On Thu, 25 Nov 2010, Jean Pihet wrote:
> >> On Thu, Nov 25, 2010 at 6:35 PM, Paul Walmsley <paul@pwsan.com> wrote:
> >> > On Thu, 25 Nov 2010, Jean Pihet wrote:
> >> >> On Thu, Nov 25, 2010 at 12:49 AM, Paul Walmsley <paul@pwsan.com> wrote:
> >> >> >
> >> >> > The console semaphore must be held while the OMAP UART devices are
> >> >> > disabled, lest a console write cause an ARM abort (and a kernel crash)
> >> >> > when the underlying console device is inaccessible. ?These crashes
> >> >> > only occur when the console is on one of the OMAP internal serial
> >> >> > ports.
> >> >> This does not fix the issue for me on Beagle (console on ttyO2).
> >> >>
> >> >> Doing:
> >> >> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.0/sleep_timeout
> >> >> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.1/sleep_timeout
> >> >> ? / # echo 5 > /sys/devices/platform/omap/omap-hsuart.2/sleep_timeout
> >> >> and waiting 5 seconds hangs the console.
> >> >
> >> > By the way, you write that the above situation "hangs the console." ?Is it
> >> > just the case that the console dies and the rest of the system is still
> >> > alive, or does the whole system crash?
> >> The console hangs, the rest of the system still runs.
> >
> > Just out of curiosity, if you send a few breaks to the OMAP over serial,
> > does that cause the console to pay attention again? ?CTRL-A F in minicom.
> Yes it helps. In most cases sending 2-3 breaks resumes the UART console.

Could you try enabling DSS in your .config?  I applied the following to my 
omap2plus_defconfig after make oldnoconfig, and the console is now working 
again for me.

Hopefully adding DSS hwmod stuff will fix this...


- Paul

--- .config	2010-12-03 18:05:31.661889255 -0700
+++ .config.sleep.working	2010-12-03 18:03:57.733918058 -0700
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux/arm 2.6.37-rc4 Kernel Configuration
-# Fri Dec  3 18:05:31 2010
+# Fri Dec  3 18:00:21 2010
 #
 CONFIG_ARM=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
@@ -1465,9 +1465,28 @@
 # CONFIG_FB_METRONOME is not set
 # CONFIG_FB_MB862XX is not set
 # CONFIG_FB_BROADSHEET is not set
-# CONFIG_FB_OMAP is not set
 CONFIG_FB_OMAP_LCD_VGA=y
-# CONFIG_OMAP2_DSS is not set
+CONFIG_OMAP2_DSS=y
+CONFIG_OMAP2_VRAM_SIZE=0
+CONFIG_OMAP2_DSS_DEBUG_SUPPORT=y
+# CONFIG_OMAP2_DSS_COLLECT_IRQ_STATS is not set
+CONFIG_OMAP2_DSS_DPI=y
+# CONFIG_OMAP2_DSS_RFBI is not set
+CONFIG_OMAP2_DSS_VENC=y
+# CONFIG_OMAP2_DSS_SDI is not set
+# CONFIG_OMAP2_DSS_DSI is not set
+# CONFIG_OMAP2_DSS_FAKE_VSYNC is not set
+CONFIG_OMAP2_DSS_MIN_FCK_PER_PCK=0
+# CONFIG_FB_OMAP2 is not set
+
+#
+# OMAP2/3 Display Device Drivers
+#
+# CONFIG_PANEL_GENERIC is not set
+# CONFIG_PANEL_SHARP_LS037V7DW01 is not set
+# CONFIG_PANEL_SHARP_LQ043T1DG01 is not set
+# CONFIG_PANEL_TOPPOLY_TDO35S is not set
+# CONFIG_PANEL_TPO_TD043MTEA1 is not set
 CONFIG_BACKLIGHT_LCD_SUPPORT=y
 CONFIG_LCD_CLASS_DEVICE=y
 # CONFIG_LCD_L4F00242T03 is not set
