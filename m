From: neko@bakuhatsu.net (Matt Sealey)
Date: Tue, 20 Aug 2013 08:53:42 -0500
Subject: [PATCH] dma: imx-sdma: Add ROM script addresses to driver
In-Reply-To: <20130820070039.GH31036@pengutronix.de>
References: <1376914563-10912-1-git-send-email-s.hauer@pengutronix.de>
 <CAHCPf3t1_5zhSOrfVFHgeVPa25sT+ewv1=OZA8X4_YZXb9cSeA@mail.gmail.com>
 <20130820070039.GH31036@pengutronix.de>
Message-ID: <CAHCPf3sJDRXUkrkRtku06OvBav2idFvJwThsxsrHngXg3mEXJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

You know what, I am really confused by this in the first place. Since
when did the SDMA driver actually support ROM addresses in device tree
anyway (referring your comments in the patch series) and when did it
get removed? Why is platform data somehow now required in a driver and
not being put in it's correct place in the device tree?

Why require a firmware file for anything here, bugs notwithstanding?
As far as I recall there were one or two in older tape-out i.MX6 (uart
dma I think) and a few more in i.MX51 and i.MX53 early tapeouts. I was
sure I saw some BSP commits that update the firmware to fix some bugs
in production tape-outs (oddly they're seemingly not in the errata for
any tape-out?). The ROM addresses should be in DT, and for those
devices that now have platform_data glue hardcoding the vaues, they'll
work. DT platforms won't.

I don't understand here how it's not possible to specify the ROM
addresses in the DT for instance using the way regulators are handled
(but I'd want to see reg used to specify the address and name instead
of a custom properties in this case).

What I'd really like to see is the "waiting on a firmware that doesn't
exist when there is a working ROM version of those scripts in the SoC"
bug fixed properly, by using ROM addresses in DT - specifying the
"wrong" addresses is a device tree bug for that board with that
tape-out or users using the wrong device-tree. Then fudging
platform_data for non-DT platforms makes sense in that they have no
DTs. And when they are converted they will follow suit anyway -
there's a path to take to get there that is really clear.

In this case it is just hardcoding one or two SoC and then leaving the
rest tha tare actually device-tree compliant to use that abominable,
OS-specific firmware path name property.. keeping the hangs. I'm
really trying to figure out the intent and design process here,
because from a perspective of getting more device tree support this
really is stepping backwards via a hack to get a couple boards to
work.

-- Matt
