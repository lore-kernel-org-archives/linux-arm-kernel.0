From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 6 Jun 2012 23:49:58 +0100
Subject: Fwd: + clk-add-non-config_have_clk-routines.patch added to -mm
 tree
In-Reply-To: <20120606224225.GA9435@localhost>
References: <20120606214621.GA8892@localhost>
 <20120606145113.f0c8ddcf.akpm@linux-foundation.org>
 <20120606215951.GA9123@localhost>
 <20120606150619.8567afb4.akpm@linux-foundation.org>
 <20120606224225.GA9435@localhost>
Message-ID: <20120606224958.GA20538@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 07, 2012 at 07:42:25AM +0900, Fengguang Wu wrote:
> > I didn't merge this patchset because it still has the build error
> > reported by Paul, below.
> 
> I see. The arm's redefinitions are mostly empty function stubs that
> are identical to the ones provided by Viresh's patch. Except for this
> one, trying to act smarter:
> 
> arch/arm/mach-netx/fb.c:
> 
>         struct clk *clk_get(struct device *dev, const char *id)
>         {       
>                 return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
>         }
> 
> The return values are interesting. In this arm, clk_get()
> conditionally returns NULL or -ENOENT. While the clk_get() in clk.c
> always returns -ENOENT on error. Now Viresh comes and defines a
> clk_get() that always returns NULL on !CONFIG_HAVE_CLK.
> 
> What would be the difference between NULL and -ENOENT?

Look, it's all very very very very simple.

The clock API.  clk_get().  If IS_ERR() is true, then the pointer is
_not_ valid, it is an error.

If IS_ERR() is false, then *all* *drivers* must assume that the cookie
is valid as far as the driver is concerned.  It is up to the clk API
to interpret these cookies in whatever way the clk API implementation
sees fit.
