From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 1 Jul 2014 14:10:26 +0100
Subject: [PATCH 4/4] ARM: mvebu: add armada drm init to Dove board setup
In-Reply-To: <1404219871-18419-5-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1404219871-18419-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1404219871-18419-5-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20140701131026.GO32514@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 01, 2014 at 03:04:31PM +0200, Sebastian Hesselbarth wrote:
> +	pdev = platform_device_register_full(&armada_drm_dev_info);
> +	/* assign last found lcd node to drm device for clk lookup */
> +	pdev->dev.of_node = clknp;

NAK.  This really isn't a good way to deal with this, even in a
temporary basis.  While assigning a DT node to a manually created
platform device does solve that problem, it also introduces the
problem that this platform device will now match any platform driver
which recognises the "marvell,dove-lcd" compatible type, which may
occur _before_ we find the driver to match using the legacy strings.

There really isn't an easy solution to this other than doing the thing
properly.

The other problem in this series is that while you introduce some
bindings which may work today, they're not going to work tomorrow, and
that's a problem.  Don't do DT piecemeal like this and end up having to
break the bindings (which we will have to do to add the endpoints.)

If you want to do this then you need to add the endpoints from the start
even though the driver doesn't yet make use of them - or don't add the
DT bits at all.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
