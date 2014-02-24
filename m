From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Feb 2014 17:06:53 +0000
Subject: [RFC PATCH v3 1/9] staging: imx-drm-core: don't request probe
 deferral in imx_drm_encoder_parse_of
In-Reply-To: <1393260998.3091.63.camel@pizza.hi.pengutronix.de>
References: <1392723370-4772-1-git-send-email-p.zabel@pengutronix.de>
 <1392723370-4772-2-git-send-email-p.zabel@pengutronix.de>
 <20140224154919.GL21483@n2100.arm.linux.org.uk>
 <1393260998.3091.63.camel@pizza.hi.pengutronix.de>
Message-ID: <20140224170653.GO21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 05:56:38PM +0100, Philipp Zabel wrote:
> Am Montag, den 24.02.2014, 15:49 +0000 schrieb Russell King - ARM Linux:
> One issue was that the DT parsing code would try to add the imx-ldb
> component right after the first crtc, and then its bind would fail
> in imx_drm_encoder_parse_of because the three remaining crtcs were
> not yet registered. This is already fixed by adding the crtc
> components first.

That's what happens anyway - we add /all/ the CRTCs first before we
start adding the connectors.

That means the CRTCs will be bound before the connectors (ldb).

What you're probably missing is that with what's in my branch, if you
want both CRTCs or the second CRTC in the IPU pair, you must specify
both in the "crtcs" property - iow "crtcs = <&ipuX 0>, <&ipuX 1>".
The reason is there's no way to differentiate the individual platform
devices there without delving into the platform data.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
