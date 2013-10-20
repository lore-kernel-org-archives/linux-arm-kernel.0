From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 20 Oct 2013 10:32:34 +0100
Subject: [PATCH v2 1/3] imx-drm: Add mx6 hdmi transmitter support
In-Reply-To: <20131016183107.GC18050@kroah.com>
References: <1380826287-30253-1-git-send-email-fabio.estevam@freescale.com>
 <20131003202751.GZ6192@mwanda>
 <20131015131038.GB25034@n2100.arm.linux.org.uk>
 <CAOMZO5BDEFAKue9b94+wCQSk+1V04P9Oz_yrqG5XLZ532L+VUg@mail.gmail.com>
 <20131016170341.GH25034@n2100.arm.linux.org.uk>
 <20131016180735.GI25034@n2100.arm.linux.org.uk>
 <20131016183107.GC18050@kroah.com>
Message-ID: <20131020093233.GM25034@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Another problem.

After performing several modesets, the IPU seems to lock up and produce
no syncs or output data.

I've seen this many times over the last week while testing out various
aspects of imx-drm, and had put it down to problems with the clocking
arrangement getting its settings wrong.  Now that I've sorted all that
though, and I still have the problem, there's something else going on.

What I see is:
- the HDMI clock is running correctly (right frequency and unmodulated)
- the TMDS data lines show signs of there being some data (probably
  control, guard bands and data islands from the frame composer in the
  HDMI interface).  The data lines are definitely lacking image data though.
- reading the various status registers indicates that all FIFOs within
  the IPU are empty.
- the attached TV says that there is no HDMI signal.

One of my tests has been to cycle through all display resolutions from the
smallest width to the largest, leaving each one set for 30 seconds.  This
will occasionally provoke the problem, but obviously is rather slow to do
so.

I tried this with a less demanding test last night as far as a change in
the settings: switching between 720p at 50 and 60Hz.  The clocks for these
two modes are the same at 74.25MHz, and the vertical timing parameters are
identical.  The only timing difference is with the horizontal parameters:

  1280x720 (0x41)   74.2MHz +HSync +VSync +preferred
        h: width  1280 start 1390 end 1430 total 1650 skew    0 clock   45.0KHz
        v: height  720 start  725 end  730 total  750           clock   60.0Hz
  1280x720 (0x4f)   74.2MHz +HSync +VSync
        h: width  1280 start 1720 end 1760 total 1980 skew    0 clock   37.5KHz
        v: height  720 start  725 end  730 total  750           clock   50.0Hz

This dies within a couple of minutes.  I haven't gathered enough
information to tell whether it always dies when switching from 50 -> 60Hz
or whether it's any switch.

My test for this is basically:

while :; do
  xrandr -s 1280x720 -r 50
  sleep 5
  xrandr -s 1280x720 -r 60
  sleep 5
done
