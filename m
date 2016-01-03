From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jan 2016 10:53:19 +0000
Subject: [PATCH] clk: fix clk-gpio.c with optional clock= DT property
In-Reply-To: <20160103064749.15239.59588@quark.deferred.io>
References: <E1aFJ0A-00086Z-0I@rmk-PC.arm.linux.org.uk>
 <20160103064749.15239.59588@quark.deferred.io>
Message-ID: <20160103105319.GB5779@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 02, 2016 at 10:47:49PM -0800, Michael Turquette wrote:
> Hi Russell,
> 
> Quoting Russell King (2016-01-02 02:01:34)
> > When the clock DT property is not given, of_clk_get_parent_count()
> > returns -ENOENT, which then tries to allocate -2 x 4 bytes of memory,
> > which of course fails, causing the whole driver to fail to create
> > the clock.
> > 
> > This causes the SolidRun platforms to fail probing the SDHCI1 interface
> > which is connected to the WiFi.
> > 
> > Fix this by detecting errno codes, skipping the allocation, and fixing
> > of_clk_gpio_gate_delayed_register_get() to handle a NULL parent_names
> > array.
> 
> Thanks for the fix. Applied to clk-next manually.

Thanks.

> > This goes all the way back to 80eeb1f0f757 ("clk: add gpio controlled
> > clock multiplexer") introduced in June in v4.3-rc2 - which raises the
> > question why _development_ work in clk is being merged outside of the
> > merge window.
> 
> That patch was merged into the clk tree in June 2015, based on 4.2-rc1.

Interesting... I guess git describe is buggy then:

$ git describe --contains 80eeb1f0f757
v4.3-rc2~4^2~124
$ git log v4.3-rc1..v4.3-rc2 | grep 80eeb1f0f757
$ git log v4.2..v4.3-rc1 | grep 80eeb1f0f757
commit 80eeb1f0f757c790b020d9f425bb0e824973d49c
$ git describe --help
...
       --contains
           Instead of finding the tag that predates the commit, find the tag
           that comes after the commit, and thus contains it. Automatically
           implies --tags.

> Below is the modified version of your patch.

Looks fine, thanks.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
