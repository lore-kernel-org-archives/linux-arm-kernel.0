From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 3 Jun 2011 10:32:52 +0800
Subject: [RFC 1/2] ARM:Tegra: Device Tree Support: Initialize the audio
	card from the device tree.
In-Reply-To: <20110602214322.GC10532@n2100.arm.linux.org.uk>
References: <20110527205444.21000.90209.stgit@riker>
	<20110527205706.21000.34832.stgit@riker>
	<BANLkTi=NMjBjWVv_o3PocejhgGr8TdG+1Q@mail.gmail.com>
	<BANLkTi=PtEhxxmZo2DqvmySCmnEd3LbezQ@mail.gmail.com>
	<BANLkTikWpiY_o27OF-Jxvq7iPeWzrAYOsQ@mail.gmail.com>
	<20110602160445.GA8373@ponder.secretlab.ca>
	<BANLkTikGp_O-Wd3nMhbV+-RLeXZoWeB6eQ@mail.gmail.com>
	<20110602214322.GC10532@n2100.arm.linux.org.uk>
Message-ID: <BANLkTikiaA3CCRAXkB=x56wtt8nNF9dqxA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/6/3 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Fri, Jun 03, 2011 at 12:21:50AM +0800, Barry Song wrote:
>> Arnd has required me to use device tree in our new SoC for the coming
>> upstream. so i am trying to define a property like clock = "uart" in
>> dts. then in drivers,
>> i get this ?string by:
>> clk = of_get_property(np, "clock", NULL);
>> then request this clock by clk_get().
>
> This is entirely wrong. ?clk_get() takes two things. ?It takes a struct
> device. ?We should know what the struct device is (provided they're named
> in a stable manner.)
>
> The other parameter, the string, is up to the driver. ?It's not a device
> property. ?It's not a SoC-wide clock name. ?It's a connection name for
> the clock on the device. ?This won't change from one instance of the
> device to another instance of the device - it's effectively a constant.
>
i see :-)

but there is really no an unified rule by now, for exmaple, samsung
just required platform device names matched with the string parameter
to get a clock.
it looks like clk_get in plat-samsung depends on the string more than
device and the clock name is in SoC level.

struct clk *clk_get(struct device *dev, const char *id)
{
        struct clk *p;
        struct clk *clk = ERR_PTR(-ENOENT);
        int idno;

        if (dev == NULL || !dev_is_platform_device(dev))
                idno = -1;
        else
                idno = to_platform_device(dev)->id;

        spin_lock(&clocks_lock);

        list_for_each_entry(p, &clocks, list) {
                if (p->id == idno &&
                    strcmp(id, p->name) == 0 &&
                    try_module_get(p->owner)) {
                        clk = p;
                        break;
                }
        }

        /* check for the case where a device was supplied, but the
         * clock that was being searched for is not device specific */

        if (IS_ERR(clk)) {
                list_for_each_entry(p, &clocks, list) {
                        if (p->id == -1 && strcmp(id, p->name) == 0 &&
                            try_module_get(p->owner)) {
                                clk = p;
                                break;
                        }
                }

}

same situation for mach-at91/clock.c:

/* clocks cannot be de-registered no refcounting necessary */
struct clk *clk_get(struct device *dev, const char *id)
{
        struct clk *clk;

        list_for_each_entry(clk, &clocks, node) {
                if (strcmp(id, clk->name) == 0)
                        return clk;
                if (clk->function && (dev == clk->dev) && strcmp(id,
clk->function) == 0)
                        return clk;
        }

        return ERR_PTR(-ENOENT);
}
EXPORT_SYMBOL(clk_get);


msm required device struct matched:
struct clk *clk_get(struct device *dev, const char *id)
{
        struct clk *clk;

        mutex_lock(&clocks_mutex);

        list_for_each_entry(clk, &clocks, list)
                if (!strcmp(id, clk->name) && clk->dev == dev)
                        goto found_it;

        list_for_each_entry(clk, &clocks, list)
                if (!strcmp(id, clk->name) && clk->dev == NULL)
                        goto found_it;

        clk = ERR_PTR(-ENOENT);
found_it:
        mutex_unlock(&clocks_mutex);
        return clk;
}
EXPORT_SYMBOL(clk_get);

> So there's no point in having the DT describe that name - that's out of
> its realm.

yes. i made a mistake. our old codes have an ugly implement of clk
APIs, which is using names with index, for example "uart0", "uart1",
"uart2",  to distinguish clocks for multi-instances of same kind of
devices. so i included this name in dts to bring up and test device
tree functions fast. i believe our clk implementation need clean-up.
but what's the best possible way to bind clocks with dynamic
registerred devices from device tree? people maybe need more
agreement.


>
> One of the problems is that clk_get() hides the mapping of device+connection
> internally, which it has had to as we haven't had a device tree to look
> things up.
>
> In essence, clk_get() is looking up a property (the clock connection name)
> for the struct device. ?When clks get converted to the device tree, the
> DT stuff should hook inside clk_get() to do a property lookup to discover
> which clock the driver wants.
>
> Drivers should definitely not be looking up a property in the device tree
> and using that as a connection name into clk_get().
