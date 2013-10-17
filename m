From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 17 Oct 2013 09:45:13 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
Message-ID: <20131017084513.GN25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay, next problem...

As I described via the Cubox-i community last night on google+...

I'm now at the point where certain resolutions and refreshes work fine
(eg, 720p @ 50 or 60Hz, 1366x768, 1024x768).

Others either don't display (1080p, 800x600, 848x480, 640x480), or have
speckles, a line of corruption that flashes up, and blanks (576p @50 Hz,
480p @60Hz), possibly a result of loss of signal.

I've been looking at the DMFC, suspecting a fifo problem, but that to me
looks fine - we seem to always allocate 4 slots, with each slot having a
bandwidth of 99Mpixels each.  This in theory should give a maximum of
396Mpixels, which is more than plenty.  The bandwidth calculation is
probably wrong though - the peak bandwidth is actually the pixel clock
since this is the rate at which pixels have to be supplied during a line,
not the refresh * hdisplayed * vdisplayed - that's the average bandwidth
over a full frame.

However, if it was a DMFC problem, and as this only carries pixel data,
I'd expect that not to cause loss of signal.

I've checked the phy MPLL settings back to the manual for certain problem
clock rates, and they also seem fine.  I've polled the status register to
see whether it's unstable, and it appears to remain locked.

I think I should probe the HDMI signals, particularly the clock signal to
see if that provides any useful clues.
