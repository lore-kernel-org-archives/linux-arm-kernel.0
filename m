From: fengguang.wu@intel.com (Fengguang Wu)
Date: Thu, 7 Jun 2012 07:42:25 +0900
Subject: Fwd: + clk-add-non-config_have_clk-routines.patch added to -mm
 tree
In-Reply-To: <20120606150619.8567afb4.akpm@linux-foundation.org>
References: <20120606214621.GA8892@localhost>
 <20120606145113.f0c8ddcf.akpm@linux-foundation.org>
 <20120606215951.GA9123@localhost>
 <20120606150619.8567afb4.akpm@linux-foundation.org>
Message-ID: <20120606224225.GA9435@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I didn't merge this patchset because it still has the build error
> reported by Paul, below.

I see. The arm's redefinitions are mostly empty function stubs that
are identical to the ones provided by Viresh's patch. Except for this
one, trying to act smarter:

arch/arm/mach-netx/fb.c:

        struct clk *clk_get(struct device *dev, const char *id)
        {       
                return dev && strcmp(dev_name(dev), "fb") == 0 ? NULL : ERR_PTR(-ENOENT);
        }

The return values are interesting. In this arm, clk_get()
conditionally returns NULL or -ENOENT. While the clk_get() in clk.c
always returns -ENOENT on error. Now Viresh comes and defines a
clk_get() that always returns NULL on !CONFIG_HAVE_CLK.

What would be the difference between NULL and -ENOENT?

In my superficial view, -ENOENT is more error prone than plain NULL.
If ever clk_get() returns -ENOENT which is passed straight forward to
clk_disable() (eg. in the below code), we may get a kernel panic. The
below particular clk_get() might always succeed and hence be safe, but
such use scenarios look scary.

drivers/char/hw_random/mxc-rnga.c  mxc_rnga_remove():

        struct clk *clk = clk_get(&pdev->dev, "rng");

        [...]

        clk_disable(clk);

where clk_disable() only checks NULL:

        if (!clk)
                return;

Thanks,
Fengguang

> 
> 
> 
> Begin forwarded message:
> 
> Date: Fri, 25 May 2012 15:07:15 +0530
> From: viresh kumar <viresh.linux@gmail.com>
> To: Paul Gortmaker <paul.gortmaker@windriver.com>
> Cc: linux-arm-kernel at lists.infradead.org, linux-next at vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, spear-devel at list.st.com
> Subject: Re: [linux-next] "clk: add non CONFIG_HAVE_CLK routines" commit
> 
> 
> On May 23, 2012 5:18 AM, "Paul Gortmaker" <paul.gortmaker@windriver.com>
> wrote:
> >
> > Hi Viresh,
> >
> > The above listed commit, in linux-next as:
> >
> > commit ebbf0cb5d39cc3e22ef4c425475e76b7f45027de
> >
> >    "clk: add non CONFIG_HAVE_CLK routines"
> >
> > shows up as failures in the netx_defconfig, since there
> > are duplicate stub functions between your changes and the
> > file below:
> >
> >  arch/arm/mach-netx/fb.c:72:6: error: redefinition of 'clk_disable'
> >  include/linux/clk.h:299:51: note: previous definition of 'clk_disable'
> was here
> >  arch/arm/mach-netx/fb.c:76:5: error: redefinition of 'clk_set_rate'
> >  include/linux/clk.h:306:50: note: previous definition of 'clk_set_rate'
> was here
> >  arch/arm/mach-netx/fb.c:81:5: error: redefinition of 'clk_enable'
> >  include/linux/clk.h:294:50: note: previous definition of 'clk_enable'
> was here
> >  arch/arm/mach-netx/fb.c:86:13: error: redefinition of 'clk_get'
> >  include/linux/clk.h:280:58: note: previous definition of 'clk_get' was
> here
> >  arch/arm/mach-netx/fb.c:91:6: error: redefinition of 'clk_put'
> >  include/linux/clk.h:290:51: note: previous definition of 'clk_put' was
> here
> >  make[2]: *** [arch/arm/mach-netx/fb.o] Error 1
> >
> 
> Hi Paul,
> 
> I don't have access to any Linux machine for now as i am on leave.
> 
> Actually i have left ST and will join the next company in few weeks.
> 
> If you can provide a patch for this, i can review it.
> 
> --
> Viresh
