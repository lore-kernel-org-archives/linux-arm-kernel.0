From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Feb 2015 15:03:49 +0000
Subject: [PATCH 0/8] Fix struct clk pointer comparing
In-Reply-To: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
References: <1424876018-17852-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20150225150349.GB8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:53:30PM +0800, Shawn Guo wrote:
> On the first day back from Chinese new year holiday, I got a regression
> report from rmk, saying Ethernet stops working on HimmingBoard with
> v4.0-rc1.
> 
> I read through the thread [1] and found a couple of i.MX audio drivers
> are also affected per Stephen's Coccinelle report.  That's why I came up
> with this series based on Quentin's structclk.cocci, Stephen's result
> and Mike's input (thanks all).

Not all places need to be fixed in this way.

There are two broad cases:

1. Where we are trying to determine if two clocks obtained from clk_get()
   are the same clock.  IOW:

	probe()
	{
		clk1 = clk_get(dev, ...);
		clk2 = clk_get(dev, ...);

		if (clk1 == clk2)
			do_something();
	}

2. Where we are trying to determine if a clock selected from a set of
   previously obtained clk_get()'d clocks is the same as a one of those
   clocks.  IOW:

	probe()
	{
		clk1 = clk_get(dev, ...);
		clk2 = clk_get(dev, ...);
	}
...
	some_fn()
	{
		clk = select_best_clock(clk1, clk2);
		if (clk == previously_selected_clk) {
			previously_selected_clk = clk;
			do_something();
		}
	}

Case 1 applies in places like the Kirkwood I2S driver, and the iMX6
ethernet code, and it's these cases which need to be fixed.

Case 2 applies in the Armada DRM driver, and these cases need not be
"fixed".

To put it a different way: case 1 is when you're testing to see whether
two clocks refer to the same clock.  case 2 is when you're testing
whether the cached clk cookie is the same.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
