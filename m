From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Jun 2012 20:41:57 +0800
Subject: [PATCH 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <20120629121437.GQ5844@shlinux2.ap.freescale.net>
References: <1340941925-14591-1-git-send-email-shijie8@gmail.com>
 <1340941925-14591-3-git-send-email-shijie8@gmail.com>
 <20120629020650.GB28932@S2101-09.ap.freescale.net>
 <20120629063329.GE5844@shlinux2.ap.freescale.net>
 <20461.30070.771087.830745@ipc1.ka-ro>
 <20120629093437.GK5844@shlinux2.ap.freescale.net>
 <20461.30991.63507.369439@ipc1.ka-ro>
 <20120629095433.GO5844@shlinux2.ap.freescale.net>
 <20120629111334.GB29197@S2101-09.ap.freescale.net>
 <20120629121437.GQ5844@shlinux2.ap.freescale.net>
Message-ID: <20120629124154.GG29197@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 29, 2012 at 08:14:38PM +0800, Dong Aisheng wrote:
> > I'm with Lothar on this.  At least for imx28 case, we do not even need
> > dummy clock, because NULL con_id in clkdev lookup will have all those
> > clocks match the only one gpmi-nand clock on imx28, as I already said.
> > 
> I'm not quite understand. Can you clarify a bit more?
> For extra clocks need by mx6q like "gpmi_bch", they're indeed have con_id.
> Getting them will not fail on imx28 without dummy clock?
> 
You need to look at how imx28 registers clkdev for gpmi-nand.

static struct clk_lookup gpmi_lookups[] __initdata = {
        { .dev_id = "imx28-gpmi-nand", },
        { .dev_id = "8000c000.gpmi", },
};

clk_register_clkdevs(clks[gpmi], gpmi_lookups, ARRAY_SIZE(gpmi_lookups));

As you can see, con_id is NULL for imx28 case.  As NULL is actually
a wildcard for looking up, all the gpmi-nand clocks match it.

-- 
Regards,
Shawn
