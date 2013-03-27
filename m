From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 27 Mar 2013 10:59:49 +0100
Subject: [PATCH v4] clk: allow reentrant calls into the clk framework
In-Reply-To: <alpine.LFD.2.02.1303270941320.22263@ionos>
References: <1364368183-24420-1-git-send-email-mturquette@linaro.org>
 <alpine.LFD.2.02.1303270941320.22263@ionos>
Message-ID: <7889001.WUy2IIhd2C@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Wednesday 27 March 2013 10:40:28 Thomas Gleixner wrote:
> On Wed, 27 Mar 2013, Mike Turquette wrote:
> > Reentrancy into the clock framework from the clk.h api is necessary
> > for clocks that are prepared and unprepared via i2c_transfer (which
> > includes many PMICs and discrete audio chips) as well as for several
> > other use cases.
> 
> That explanation sucks.
> 
> Why does an i2c clock need reentrancy? Just because it's i2c or what?

That's just an example, other clocks need reentrancy as well.

> What exactly are the "several other use cases"?

Please see below.

> Why do you need the spinlock side reentrant? If a clock is handled by
> i2c it hardly can hold the spinlock over a i2c transfer.
> 
> A few pointers to code which needs this would be nice as well.

See for instance 
http://git.linuxtv.org/pinchartl/media.git/commitdiff/c4abb868a4cb6ad33fde76a6383543f3bd6699b0

That commit exposes the XCLKA and XCLKB clock outputs of the OMAP3 ISP (camera 
interface) as clock framework objects. The issue here is that the ISP has 
several inputs clocks. One of them is a parent of XCLK[AB], and another one 
controls access to the ISP registers (L4 bus clock). The ISP driver thus needs 
to enable/disable and prepare/unprepare the L4 clock in the XCLK[AB] 
enable/disable and prepare/unprepare operation handlers.

> I'm refraining from reviewing the horrible implementation until I get
> proper answers to the above questions.

-- 
Regards,

Laurent Pinchart
