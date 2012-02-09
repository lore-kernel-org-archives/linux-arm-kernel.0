From: balbi@ti.com (Felipe Balbi)
Date: Thu, 9 Feb 2012 08:08:37 +0200
Subject: [PATCH] gpio: omap: be more aggressive with pm_runtime
In-Reply-To: <87zkcsx48j.fsf@ti.com>
References: <1328707614-20146-1-git-send-email-balbi@ti.com>
 <20120208135329.GJ16334@legolas.emea.dhcp.ti.com>
 <87zkcsx48j.fsf@ti.com>
Message-ID: <20120209060835.GA1121@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 08, 2012 at 04:03:24PM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > Hi,
> >
> > On Wed, Feb 08, 2012 at 03:26:54PM +0200, Felipe Balbi wrote:
> >> try to keep gpio block suspended as much as possible.
> >> 
> >> Tested with pandaboard and a sysfs exported gpio.
> >> 
> >> Signed-off-by: Felipe Balbi <balbi@ti.com>
> >> ---
> >> 
> >> I couldn't see any issues with this patch. I managed to export
> >> a gpio and change the direction with a while true loop with
> >> no issues whatsoever.
> >
> > btw, I also played with gpios 7 and 8 because they have LEDs on them on
> > pandaboard and everything seems to be fine.
> >
> > I just want to be sure I can still go to OFF mode and wakeup, but on
> > vanilla 3.3-rc2 after echo mem > /sys/power/state the systems freezes on
> > panda, so I can't go any further.
> 
> I don't think it's frozen.  I suspected it's suspended without any
> wakeups enabled.  You probably haven't enabled UART wakeups.  Try
> enabling them like this:
> 
>   echo enabled > /sys/devices/platform/omap/omap_uart.2/tty/ttyO2/power/wakeup
>  
> before going into suspend.

that did the trick. But not having UART with wakeup enabled by default
prevents us from doing suspend/resume tests during bootup, because the
system won't wakeup through console.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120209/b0ab2319/attachment.sig>
