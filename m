From: fengguang.wu@intel.com (Fengguang Wu)
Date: Thu, 7 Jun 2012 08:03:40 +0900
Subject: Fwd: + clk-add-non-config_have_clk-routines.patch added to -mm
 tree
In-Reply-To: <20120606224958.GA20538@n2100.arm.linux.org.uk>
References: <20120606214621.GA8892@localhost>
 <20120606145113.f0c8ddcf.akpm@linux-foundation.org>
 <20120606215951.GA9123@localhost>
 <20120606150619.8567afb4.akpm@linux-foundation.org>
 <20120606224225.GA9435@localhost>
 <20120606224958.GA20538@n2100.arm.linux.org.uk>
Message-ID: <20120606230340.GA9990@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 06, 2012 at 11:49:58PM +0100, Russell King - ARM Linux wrote:
> On Thu, Jun 07, 2012 at 07:42:25AM +0900, Fengguang Wu wrote:
> > > I didn't merge this patchset because it still has the build error
> > > reported by Paul, below.
> > 
> > I see. The arm's redefinitions are mostly empty function stubs that
> > are identical to the ones provided by Viresh's patch. Except for this
> > one, trying to act smarter:
> > 
> > arch/arm/mach-netx/fb.c:
> > 
> >         struct clk *clk_get(struct device *dev, const char *id)
> >         {       
> >                 return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
> >         }
> > 
> > The return values are interesting. In this arm, clk_get()
> > conditionally returns NULL or -ENOENT. While the clk_get() in clk.c
> > always returns -ENOENT on error. Now Viresh comes and defines a
> > clk_get() that always returns NULL on !CONFIG_HAVE_CLK.
> > 
> > What would be the difference between NULL and -ENOENT?
> 
> Look, it's all very very very very simple.
> 
> The clock API.  clk_get().  If IS_ERR() is true, then the pointer is
> _not_ valid, it is an error.
> 
> If IS_ERR() is false, then *all* *drivers* must assume that the cookie
> is valid as far as the driver is concerned.  It is up to the clk API
> to interpret these cookies in whatever way the clk API implementation
> sees fit.

That's understandable. Russell, do you think it good to add a check in
clk_disable()? This should gracefully avoid the kernel oops and still
catch buggy driver code.

--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -464,6 +464,9 @@ static void __clk_disable(struct clk *clk)
        if (!clk)
                return;
 
+       if (WARN_ON(clk == ERR_PTR(-ENOENT)))
+               return;
+
        if (WARN_ON(clk->enable_count == 0))
                return;

Thanks,
Fengguang
