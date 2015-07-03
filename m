From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 3 Jul 2015 16:41:16 +0200
Subject: crypto: marvell/CESA: Issues with non cache-line aligned buffers
In-Reply-To: <20150703131059.GX7557@n2100.arm.linux.org.uk>
References: <20150703114305.15611807@bbrezillon>
 <20150703131059.GX7557@n2100.arm.linux.org.uk>
Message-ID: <20150703144116.GK13481@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> A few other things I notice when looking at this code:
> 
>         /* Not all platforms can gate the clock, so it is not
>            an error if the clock does not exists. */
>         cp->clk = clk_get(&pdev->dev, NULL);
>         if (!IS_ERR(cp->clk))
>                 clk_prepare_enable(cp->clk);
> 
> So, if clk_get() returns PTR_ERR(-EPROBE_DEFER) we treat that clock as
> missing?  Is that really the behaviour you want there?

Hi Russell

I probably added that to the older driver and it got copied into the
newer one.

The clock it is using is added to the system using CLK_OF_DECLARE()
This results in an entry in the __clk_of_table table. That table is
walked in of_clk_init(), which is called by time_init() in
arch/arc/kernel/time.c, early in the boot.

If we get -EPROBE_DEFER, something is seriously wrong.

   Andrew
