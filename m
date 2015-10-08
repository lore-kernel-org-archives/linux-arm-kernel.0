From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2015 17:16:06 +0100
Subject: Regression: USB OTG port breaks after a few hours in host mode
 on iMX6
In-Reply-To: <BN3PR0301MB0849F94B72B10051ABE9CCA581350@BN3PR0301MB0849.namprd03.prod.outlook.com>
References: <20151007082222.GB21513@n2100.arm.linux.org.uk>
 <20151008044412.GA8169@shlinux2>
 <BN3PR0301MB0849F94B72B10051ABE9CCA581350@BN3PR0301MB0849.namprd03.prod.outlook.com>
Message-ID: <20151008161605.GH32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 09:52:52AM +0000, Peter Chen wrote:
> I can't reproduce it for 5 hours, and will change pinmux (do the same
> thing with your platform), and do the overnight test.

There's definitely something weird going on.  Over night last night,
I left the Logitech universal receiver in the port, and this morning
it was indicating in /proc/interrupts:

283:         50          0          0          0       GPC  43 Edge      2184000.usb

I removed it, and now I have:

283:         50          0       1716          0       GPC  43 Edge      2184000.usb

which is increasing at a rate of 90 per minute.

Nothing in the kernel message log indicating why this may be.  It looks
like runtime PM doesn't work on this port:

/sys/bus/platform/devices/2184000.usb/power/runtime_active_time:109850496
/sys/bus/platform/devices/2184000.usb/power/runtime_status:active
/sys/bus/platform/devices/2184000.usb/power/runtime_suspended_time:0

whereas the other port (which has zero interrupts) it does:

/sys/bus/platform/devices/2184200.usb/power/runtime_active_time:16924
/sys/bus/platform/devices/2184200.usb/power/runtime_status:suspended
/sys/bus/platform/devices/2184200.usb/power/runtime_suspended_time:109861760

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
