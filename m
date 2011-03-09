From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Mar 2011 12:32:00 -0800
Subject: [PATCH] omap2+: mux: Add macro for configuring static with
	omap_hwmod_mux_init (Re: [PATCH] omap2+: mux: Remove the use of IDLE
	flag)
In-Reply-To: <b76e32aff88265d31cc1b7b2fc502a32@mail.gmail.com>
References: <1299472552-22017-1-git-send-email-r.sricharan@ti.com>
	<20110308164033.GC26463@atomide.com>
	<b76e32aff88265d31cc1b7b2fc502a32@mail.gmail.com>
Message-ID: <20110309203200.GP26463@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sricharan R <r.sricharan@ti.com> [110309 03:47]:
> 
> Btw,I have fixed the comments on the below patches that
> I sent for configuring the serial pads.
> 
> 4430sdp:
> http://marc.info/?l=linux-omap&m=129900334420003&w=2
> 
> omap4panda:
> http://marc.info/?l=linux-omap&m=129900338520082&w=2
> 
> 3430sdp:
> http://marc.info/?l=linux-omap&m=129619117726479&w=2
> 
> Can you please check if they are ok?

Look OK to me, but let's make things a bit easier to read
and maintain with the following patch. Can you please
update your patches to use this macro?

Each line then just becomes something like:

OMAP_MUX_STATIC("uart3_tx_irtx.uart3_tx_irtx",
		OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Wed, 9 Mar 2011 12:14:04 -0800
Subject: [PATCH] omap2+: mux: Add macro for configuring static with omap_hwmod_mux_init

Add macro for defining static pins in the board file.

We can now start implementing pin multiplexing in the platform init
code for devices that call omap_hwmod_mux_init. Currently that is
only implemented for serial.c.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -186,6 +186,12 @@ struct omap_device_pad {
 
 struct omap_hwmod_mux_info;
 
+#define OMAP_MUX_STATIC(signal, mode)					\
+{									\
+	.name	= (signal),						\
+	.enable	= (mode),						\
+}
+
 #if defined(CONFIG_OMAP_MUX)
 
 /**
