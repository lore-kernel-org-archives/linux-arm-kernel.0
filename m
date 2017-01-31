From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Tue, 31 Jan 2017 10:49:20 +0100
Subject: [PATCH v3 21/24] media: imx: Add MIPI CSI-2 Receiver subdev driver
In-Reply-To: <20170131000125.GO27312@n2100.armlinux.org.uk>
References: <1483755102-24785-1-git-send-email-steve_longerbeam@mentor.com>
 <1483755102-24785-22-git-send-email-steve_longerbeam@mentor.com>
 <20170131000125.GO27312@n2100.armlinux.org.uk>
Message-ID: <1485856160.2932.10.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-01-31 at 00:01 +0000, Russell King - ARM Linux wrote:
[...]
> The iMX6 manuals call for a very specific seven sequence of initialisation
> for CSI2, which begins with:
> 
> 1. reset the D-PHY.
> 2. place MIPI sensor in LP-11 state
> 3. perform D-PHY initialisation
> 4. configure CSI2 lanes and de-assert resets and shutdown signals
> 
> Since you reset the CSI2 at power up and then release it, how do you
> guarantee that the published sequence is followed?
> 
> With Philipp's driver, this is easy, because there is a prepare_stream
> callback which gives the sensor an opportunity to get everything
> correctly configured according to the negotiated parameters, and place
> the sensor in LP-11 state.
> 
> Some sensors do not power up in LP-11 state, but need to be programmed
> fully before being asked to momentarily stream.  Only at that point is
> the sensor guaranteed to be in the required LP-11 state.

Do you expect that 1. and 2. could depend on the negotiated parameters
in any way on some hardware? I had removed the prepare_stream callback
from my driver in v2 because for my use case at least the above sequence
could be realized by

1. in imx-mipi-csi2 s_power(1)
2. in MIPI sensor s_power(1)
3./4. in imx-mipi-csi2 s_stream(1)
4. in MIPI sensor s_stream(1)

as long as the sensor is correctly put back into LP-11 in s_stream(0).

regards
Philipp
