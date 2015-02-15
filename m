From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 15 Feb 2015 16:36:47 +0000
Subject: [PATCH 4/8] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
In-Reply-To: <54DF7F93.3040009@gmail.com>
References: <20150214152659.GI8656@n2100.arm.linux.org.uk>
 <E1YMedG-00054d-0d@rmk-PC.arm.linux.org.uk>
 <54DF7F93.3040009@gmail.com>
Message-ID: <20150215163647.GK8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 14, 2015 at 06:02:11PM +0100, Sebastian Hesselbarth wrote:
> Should we be more precise and call it "marvell,dove-pmu" ?

Andrew made the same comment, consider it done.

> Also, can we have an additional "syscon" compatible for that node?

I'll look into it, thanks.

> How about we copy the clk subsystem way of installing early probed
> pm for DT here?
> 
> For example:
> 
> #define PM_OF_DECLARE(name, compat, fn) OF_DECLARE_1(clk, name, compat, fn)
> 
> and
> 
> static int __init dove_pmu_init(struct device_node *np) { ... }
> PM_OF_DECLARE(dove_pmu, "marvell,dove-pmu", dove_init_pmu);

Not sure it's worth the overhead.  Firstly, sticking the PMU into the
clock OF tables doesn't seem like the right thing to do.  Secondly,
it means modifying the asm-generic vmlinux.lds.S, adding another
config symbol for PMUs to enable that table, adding a sentinel entry,
and finally adding some code somewhere to scan this new table which
right now is only going to have at most one entry.

That seems like an awful lot of overhead.

It would have been easier if there was a generic mechanism, like the
initcall mechanism, where it's possible to add these kinds of
compatible matches automatically without having to mess around with
so many different files.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
