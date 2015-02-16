From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Feb 2015 11:27:24 +0000
Subject: [PATCH RFC v9 01/20] clk: divider: Correct parent clk round rate
 if no bestdiv is normally found
In-Reply-To: <20150213185713.GA12209@pengutronix.de>
References: <1423720903-24806-1-git-send-email-Ying.Liu@freescale.com>
 <1423720903-24806-2-git-send-email-Ying.Liu@freescale.com>
 <20150212093356.GR12209@pengutronix.de>
 <20150212103944.GA1290@victor>
 <20150212122405.GW12209@pengutronix.de>
 <20150212125646.GT8656@n2100.arm.linux.org.uk>
 <20150212134131.GX12209@pengutronix.de> <54DE0BB8.7070004@ti.com>
 <20150213185713.GA12209@pengutronix.de>
Message-ID: <20150216112724.GN8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 13, 2015 at 07:57:13PM +0100, Sascha Hauer wrote:
> I agree that it's a bit odd, but I think it has to be like this.
> Consider that you request a rate of 100Hz, but the clock can only
> produce 99.5Hz, so due to rounding clk_round_rate() returns 99Hz.
> Now when you request 99Hz from clk_set_rate() the 99.5Hz value
> can't be used because it's too high.

Math rounding rules normally state that anything of .5 and greater
should be rounded up, not rounded down.  So, for 99.5Hz, you really
ought to be returning 100Hz, not 99Hz.

However, you do have a point for 99.4Hz, which would be returned as
99Hz, and when set, it would result in something which isn't 99.4Hz.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
