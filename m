From: matt@genesi-usa.com (Matt Sealey)
Date: Wed, 11 Jan 2012 10:30:15 -0600
Subject: Clock API and "maximum rate"
Message-ID: <CAKGA1bmZGxxSfwGkpdyt7c-UYUTj+mV2AZhmhCUSEKTd12Q+4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Just a curious question, is there any safe way in the current API or
even by peeking a little behind the scenes to find out what the
maximum clock rate would be for a given named clock or struct clk?

I have a specific issue with the MX5 IPU whereby the IPU clock defines
the upper limit of the pixel clock. On MX51 it's around 133MHz, thus
limiting displays to 133MHz - this means not 1080p60 but 1080p24 would
and does work). On MX53 it's 150MHz which encompasses the CEA 1080p60
(148.25MHz) modes but probably not anything higher like 1600x1200. Of
course this mostly depends on the monitor used (I have one that has
1600x1200 at 50 at 125MHz or so), but in the end the IPU driver should
refuse to accept such a mode (as invalid) and any DRM connector or
subdriver for HDMI, DVI, VGA or whatever should certainly parse these
modes out from standard available mode lists too. This behavior relies
on the idea that we know where we're deriving the pixel clock from and
where we need to do the refusal to set mode or parsing of the mode
lists, so I am not sure if there is even a single place to do so, but
knowing the maximum clock seems like a better idea than perhaps just
checking for a particular running cpu_is_imx51() or so and giving a
hardcoded value (especially since the PLL the IPU clock is derived
from could possibly limit possible clock rates below the maximum).

So, is there a solution for this, or at least a nice way to report
such information without making a guess of the system state?

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
