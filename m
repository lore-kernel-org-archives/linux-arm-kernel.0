From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Nov 2013 20:52:25 +0000
Subject: [PATCH 11/31] dma: add channel request API that supports
 deferred probe
In-Reply-To: <20131125202808.GN2760@book.gsilab.sittig.org>
References: <528E4F55.9070204@wwwdotorg.org>
 <CAPcyv4jTUVjhFFXP8RL2jCqFj1MqxSCKQYvfdLHTj+1PRDDL3Q@mail.gmail.com>
 <528F95A9.2050305@wwwdotorg.org>
 <CAPcyv4iXmBmcsHDc7yjxxbH7sO8m1nVoEO6PUibuDeb1Wtge+g@mail.gmail.com>
 <528F9DF9.6080706@wwwdotorg.org>
 <20131123003442.GH16735@n2100.arm.linux.org.uk>
 <5293883A.8050808@wwwdotorg.org>
 <20131125175330.GQ16735@n2100.arm.linux.org.uk>
 <52938F75.7020108@wwwdotorg.org>
 <20131125202808.GN2760@book.gsilab.sittig.org>
Message-ID: <20131125205224.GT16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 09:28:08PM +0100, Gerhard Sittig wrote:
> See 2771399a "fs_enet: cleanup clock API use" or b3bfce2bc "i2c:
> mpc: cleanup clock API use" for an example.

And had I seen that change I'd have commented thusly:

+       /* make clock lookup non-fatal (the driver is shared among platforms),
+        * but require enable to succeed when a clock was specified/found,
+        * keep a reference to the clock upon successful acquisition
+        */
+       clk = devm_clk_get(&ofdev->dev, "per");
+       if (!IS_ERR(clk)) {
+               err = clk_prepare_enable(clk);
+               if (err) {
+                       ret = err;
+                       goto out_free_fpi;
+               }
+               fpi->clk_per = clk;
+       }

 out_put:
        of_node_put(fpi->phy_node);
+       if (fpi->clk_per)
+               clk_disable_unprepare(fpi->clk_per);

        of_node_put(fep->fpi->phy_node);
+       if (fep->fpi->clk_per)
+               clk_disable_unprepare(fep->fpi->clk_per);

So, lets consider what happens if clk_get() inside devm_clk_get() returns
NULL.

* devm_clk_get() allocates its tracking structure, and sets the clk pointer
  to be freed to NULL.
* !IS_ERR(NULL) is true, so we call clk_prepare_enable(NULL).  This succeeds.
* We store NULL into fpi->clk_per.
* The error cleanup/teardown paths check for a NULL pointer, and fail to
  call the CLK API in that case.

This is not very nice.  Better solution:

	fpi->clk_per = PTR_ERR(-EINVAL);
	clk = devm_clk_get(&ofdev->dev, "per");
	if (!IS_ERR(clk)) {
		err = clk_prepare_enable(clk);
		if (err) {
			ret = err;
			goto out_free_fpi;
		}
		fpi->clk_per = clk;
	}

...

        of_node_put(fpi->phy_node);
        if (!IS_ERR(fpi->clk_per))
                clk_disable_unprepare(fpi->clk_per);
