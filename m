From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 26 Jan 2013 14:46:01 +0100
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <20130126134012.GE29973@lunn.ch>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126123827.GA5786@lunn.ch> <5103D103.5040409@gmail.com>
 <20130126134012.GE29973@lunn.ch>
Message-ID: <5103DE19.6080300@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/26/2013 02:40 PM, Andrew Lunn wrote:
> On Sat, Jan 26, 2013 at 01:50:11PM +0100, Sebastian Hesselbarth wrote:
>> have a look at dove_legacy_clk_init() in arch/arm/mach-dove/common.c.
>> This is how I handled non-DT clock aliases from DT provided clocks.
>> Maybe you can also use it for kirkwood.
>
> The code here is based on dove_legacy_clk_init(). However the change
> made by Jason is in order to make a DT device work, not an non-DT
> device.

Yeah, I know. The second after I sent that email, I knew it was just
totally wrong. Sorry for that.

> The problem is the way the driver is getting the clock.
>
> 	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
>
> clk_get() then calls
>
>                  clk = of_clk_get_by_name(dev->of_node, con_id);
>
>   * of_clk_get_by_name() - Parse and lookup a clock referenced by a device node
>   * @np: pointer to clock consumer node
>   * @name: name of consumer's clock input, or NULL for the first clock reference
>
> So it is looking for a clock called "0" or "1" in the node. This does
> not exist, and so it falls. Jason's change then comes into affect and
> it finds the clkdev entries added above.
>
> I will change the driver to use of_clk_get() when passed an np.

This is way better.

Sebastian
