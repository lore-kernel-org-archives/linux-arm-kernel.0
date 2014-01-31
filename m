From: balbi@ti.com (Felipe Balbi)
Date: Fri, 31 Jan 2014 16:11:19 -0600
Subject: [PATCH] usb: dwc3: keystone: switch to use runtime pm
In-Reply-To: <Pine.LNX.4.44L0.1401311608590.12368-100000@netrider.rowland.org>
References: <20140131164534.GL20736@saruman.home>
 <Pine.LNX.4.44L0.1401311608590.12368-100000@netrider.rowland.org>
Message-ID: <20140131221118.GE2502@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 31, 2014 at 04:13:19PM -0500, Alan Stern wrote:
> On Fri, 31 Jan 2014, Felipe Balbi wrote:
> 
> > probe()
> > {
> > 	...
> > 
> > 	clk_get(dev, "fck");
> > 	clk_prepare(clk);
> > 	clk_enable(clk);
> > 	pm_runtime_set_active(dev);
> > 	pm_runtime_enable(dev);
> > 	pm_runtime_get_sync(dev);
> > 	...
> > }
> 
> > note that because of pm_runtime_set_active() that first
> > pm_runtime_get_sync() in probe() will simply increase the reference
> > counter without calling my ->runtime_resume() callback, which is exactly
> > what we want, as that would completely avoid situations of bad context
> > being restored because of that initial pm_runtime_get_sync().
> 
> Very minor note...  A slightly better way to do the same thing is:
> 
> 	pm_runtime_set_active(dev);
> 	pm_runtime_get_noresume(dev);
> 	pm_runtime_enable(dev);
> 
> The get_noresume says that you want to increment the usage counter
> without performing any callbacks, and doing it before the
> pm_runtime_enable avoids any window during which a runtime suspend
> might somehow occur.

aha, that's perfect :-) Thanks Alan.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140131/f29ba556/attachment.sig>
