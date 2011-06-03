From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Jun 2011 07:20:09 +0100
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <BANLkTikiaA3CCRAXkB=x56wtt8nNF9dqxA@mail.gmail.com>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
	<BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
	<BANLkTi=PtEhxxmZo2DqvmySCmnEd3LbezQ@mail.gmail.com>
	<BANLkTikWpiY_o27OF-Jxvq7iPeWzrAYOsQ@mail.gmail.com>
	<20110602160445.GA8373@ponder.secretlab.ca>
	<BANLkTikGp_O-Wd3nMhbV+-RLeXZoWeB6eQ@mail.gmail.com>
	<20110602214322.GC10532@n2100.arm.linux.org.uk>
	<BANLkTikiaA3CCRAXkB=x56wtt8nNF9dqxA@mail.gmail.com>
Message-ID: <20110603062009.GD10532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 03, 2011 at 10:32:52AM +0800, Barry Song wrote:
> but there is really no an unified rule by now, for exmaple, samsung
> just required platform device names matched with the string parameter
> to get a clock.
> it looks like clk_get in plat-samsung depends on the string more than
> device and the clock name is in SoC level.

Samsung has been broken in respect of this for quite some time, and I've
been nagging Ben about it ever since I provided clkdev.  The problem is
that Ben doesn't have the time to fix Samsung...

> same situation for mach-at91/clock.c:
> 
> /* clocks cannot be de-registered no refcounting necessary */
> struct clk *clk_get(struct device *dev, const char *id)
> {
>         struct clk *clk;
> 
>         list_for_each_entry(clk, &clocks, node) {
>                 if (strcmp(id, clk->name) == 0)
>                         return clk;
>                 if (clk->function && (dev == clk->dev) && strcmp(id,
> clk->function) == 0)
>                         return clk;
>         }
> 
>         return ERR_PTR(-ENOENT);
> }
> EXPORT_SYMBOL(clk_get);

That's broken, and it's incompatible with DT in any case because the
only way to set 'clk->dev' is to have devices statically declared.

OMAP used to be broken until I converted it to clkdev, and when I did
their drivers became more simple because they didn't need to ifdef
clocknames and such like.

> msm required device struct matched:
> struct clk *clk_get(struct device *dev, const char *id)
> {
>         struct clk *clk;
> 
>         mutex_lock(&clocks_mutex);
> 
>         list_for_each_entry(clk, &clocks, list)
>                 if (!strcmp(id, clk->name) && clk->dev == dev)
>                         goto found_it;
> 
>         list_for_each_entry(clk, &clocks, list)
>                 if (!strcmp(id, clk->name) && clk->dev == NULL)
>                         goto found_it;
> 
>         clk = ERR_PTR(-ENOENT);
> found_it:
>         mutex_unlock(&clocks_mutex);
>         return clk;
> }
> EXPORT_SYMBOL(clk_get);

Again, that's incompatible with DT in any case, as we don't know what
'clk->dev' would be if the devices aren't statically declared.  So this
is broken too.

Each need to be converted to clkdev _before_ they even start thinking
about device trees.
