From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Dec 2014 16:16:20 +0000
Subject: [RFC 00/15] Resource tracking/allocation framework
In-Reply-To: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
References: <1418226513-14105-1-git-send-email-a.hajda@samsung.com>
Message-ID: <20141210161620.GM11285@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 04:48:18PM +0100, Andrzej Hajda wrote:
> 3. There are drivers which can work without specific resource, but if
>   the resource becomes available/unavailable it can do some additional stuff.
>   An example of such driver is DRM driver (more precisely drm_connector) -
>   it can start without attached drm_panel, but if the panel becomes available it
>   can react by generating HPD event and start using it.

Bad example, and actually incorrect.  DRM connectors are referenced in
userspace by an IDR number, which can be re-used in the case of a
connector appearing, disappearing, and then a different connector
re-appearing.

DRM really is *not* safe to hotplug like this: DRM is more a card-level
thing, which is why we have the component helpers - which allow us to
merge several devices into one logical card-like device in a generic
manner.

DRM needs a stable picture of the CRTCs, encoders and connectors, which
should _never_ change during the lifetime of the DRM device.  Devices
attached to connectors can be hotplugged, but that's about the limit of
hot-plugging in DRM.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
