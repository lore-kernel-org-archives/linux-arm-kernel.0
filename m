From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 17 May 2012 10:24:13 +0800
Subject: [PATCH RFC 1/1] pinctrl: improve gpio support for dt
In-Reply-To: <20120517021614.GG3764@S2100-06.ap.freescale.net>
References: <1337090839-21224-1-git-send-email-b29396@freescale.com>
 <20120517021614.GG3764@S2100-06.ap.freescale.net>
Message-ID: <20120517022412.GH10347@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 10:16:15AM +0800, Guo Shawn-R65073 wrote:
> On Tue, May 15, 2012 at 10:07:19PM +0800, Dong Aisheng wrote:
> > From: Dong Aisheng <dong.aisheng@linaro.org>
> > 
> > For dt, the gpio base may be dynamically allocated, thus the original
> > implementation of gpio support based on static gpio number and pin id
> > map may not be easy to use for dt.
> > 
> > One solution is a) use alias id for gpio node and refer to it in gpio
> > range, then we can get the fixed the gpio devices for this range and
> > b) get gpio chip from node which is specified in gpio range structure,
> > then get the dynamically allocated gpio chip base and c) using the chip
> > gpio base and offset to map to a physical pin id for dt.
> > 
> > To implement that, we need add two members in pinctrl_gpio_range structure,
> > 'np' the gpio node for this range and 'off' the offset in this gpio range
> > of the gpio chip.
> > 
> > For devicetree, user can use this two member instead of range->base
> > to create the map, the core will dynamically set the correct range->base
> > based on the gpio base plus gpio offset.
> > 
> > For example:
> > static struct pinctrl_gpio_range imx28_gpio_ranges[] = {
> > 	{ .name = "gpio", .id = 0, .pin_base = 0,   .npins = 8,	 .np = np_gpio0	.off = 0,},
> > 	{ .name = "gpio", .id = 0, .pin_base = 16,  .npins = 13, .np = np_gpio0 .off = 16,},
> > 	{ .name = "gpio", .id = 1, .pin_base = 32,  .npins = 32, .np = np_gpio1 .off = 16},
> 
> How do you have .np statically assigned?
> 
The drivers are responsible for set .np, usually dynamically get it from whether
the driver wants.

Regards
Dong Aisheng
