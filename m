From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 11 Aug 2016 09:32:20 +0100
Subject: [PATCH] drm/bridge: dw-hdmi: fix hdmi display lost
In-Reply-To: <1470902043-23384-1-git-send-email-mark.yao@rock-chips.com>
References: <1470902043-23384-1-git-send-email-mark.yao@rock-chips.com>
Message-ID: <20160811083220.GS1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 11, 2016 at 03:54:03PM +0800, Mark Yao wrote:
> hdmi->disabled maybe not match to the real hardware status.
> 
> ->dw_hdmi_bridge_enable()
>   hdmi->disabled = false;
> -->dw_hdmi_update_power()
>    if (hdmi->rxsense)
>        force = DRM_FORCE_ON;
>    else
>        force = DRM_FORCE_OFF;
> 
> hdmi->rxsense maybe false on bridge enable path, then hdmi->disabled
> is false, but actually hardware is power off, they are not match.

... which is correct.  If rxsense is false, it means there is nothing
plugged in, so we don't power the hardware up until something _is_
plugged in.

When something is plugged in, we get the HPD and RXSENSE events, which
will cause dw_hdmi_update_power() to be called.

hdmi->disabled is merely a bit mask of things that would cause us to
want to avoid powering the hardware up when rxsense becomes true.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
