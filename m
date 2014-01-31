From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 31 Jan 2014 16:13:19 -0500 (EST)
Subject: [PATCH] usb: dwc3: keystone: switch to use runtime pm
In-Reply-To: <20140131164534.GL20736@saruman.home>
Message-ID: <Pine.LNX.4.44L0.1401311608590.12368-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 31 Jan 2014, Felipe Balbi wrote:

> probe()
> {
> 	...
> 
> 	clk_get(dev, "fck");
> 	clk_prepare(clk);
> 	clk_enable(clk);
> 	pm_runtime_set_active(dev);
> 	pm_runtime_enable(dev);
> 	pm_runtime_get_sync(dev);
> 	...
> }

> note that because of pm_runtime_set_active() that first
> pm_runtime_get_sync() in probe() will simply increase the reference
> counter without calling my ->runtime_resume() callback, which is exactly
> what we want, as that would completely avoid situations of bad context
> being restored because of that initial pm_runtime_get_sync().

Very minor note...  A slightly better way to do the same thing is:

	pm_runtime_set_active(dev);
	pm_runtime_get_noresume(dev);
	pm_runtime_enable(dev);

The get_noresume says that you want to increment the usage counter
without performing any callbacks, and doing it before the
pm_runtime_enable avoids any window during which a runtime suspend
might somehow occur.

Alan Stern
