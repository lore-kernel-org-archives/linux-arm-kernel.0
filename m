From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Mar 2017 09:46:13 +0000
Subject: [PATCH] drm: dw_hdmi: Gate audio sampler clock from the
 enablement functions
In-Reply-To: <20170310093509.19044-1-romain.perier@collabora.com>
References: <20170310093509.19044-1-romain.perier@collabora.com>
Message-ID: <20170310094613.GQ21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 10, 2017 at 10:35:09AM +0100, Romain Perier wrote:
> Currently, the audio sampler clock is enabled from dw_hdmi_setup() at
> step E. and is kept enabled for later use. This clock should be enabled
> and disabled along with the actual audio stream and not always on (that
> is bad for PM). Futhermore, this might cause sound glitches with some
> HDMI devices, as the CTS+N is forced to zero when the stream is disabled
> while the audio clock is still running.
> 
> This commit adds a parameter to hdmi_audio_enable_clk() that controls
> when the audio sample clock must be enabled or disabled. Then, it moves
> the call to this function into dw_hdmi_audio_enable() and
> dw_hdmi_audio_disable().

How does this interact with the workaround given in my commit introducing
these functions?  (Commit b90120a96608).

Setting N=0 is a work-around for iMX6, and we need the audio FIFO to be
loaded with data prior to setting N non-zero.  If disabling the audio
clock prevents the audio FIFO being loaded, your patch will break iMX6.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
