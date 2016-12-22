From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 22 Dec 2016 08:57:08 +0800
Subject: ARM: imx: mmdc: Fix completely broken cpu hotplug code
In-Reply-To: <alpine.DEB.2.20.1612211928430.3424@nanos>
References: <alpine.DEB.2.20.1612211917490.3424@nanos>
 <alpine.DEB.2.20.1612211928430.3424@nanos>
Message-ID: <20161222005705.GA11972@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 21, 2016 at 07:32:06PM +0100, Thomas Gleixner wrote:
> On Wed, 21 Dec 2016, Thomas Gleixner wrote:
> > The cpu hotplug support of this perf driver is broken in several ways:
> > 
> > 1) It adds a instance before setting up the state.
> > 
> > 2) The state for the instance is different from the state of the
> >    callback. It's just a randomly chosen state.
> > 
> > 3) The instance registration is not error checked so nobody noticed that
> >    the call can never succeed.
> > 
> > 4) The state for the multi install callbacks is chosen randomly and
> >    overwrites existing state. This is now prevented by the core code so the
> >    call is guaranteed to fail.
> > 
> > 5) The error exit path in the init function leaves the instance registered
> >    and then frees the memory which contains the enqueued hlist node.
> > 
> > 6) The remove function is removing the state and not the instance.
> > 
> > Fix it by:
> > 
> > - Setting up the state before adding instances. Use a dynamically allocated
> >   state for it.
> > 
> > - Install instances after the state has been set up
> > 
> > - Remove the instance in the error path before freeing memory
> > 
> > - Remove instance not the state in the driver remove callback
> > 
> > While at is use raw_cpu_processor_id(), because cpu_processor_id() cannot
> > be used in preemptible context, and set the driver data after successful
> > registration of the pmu.
> > 
> > Fixes: e76bdfd7403a ("ARM: imx: Added perf functionality to mmdc driver")
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Zhengyu Shen <zhengyu.shen@nxp.com>
> > Cc: Frank Li <frank.li@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>

Acked-by: Shawn Guo <shawnguo@kernel.org>

> 
> Shawn,
> 
> as I have the final hotplug notifier removal pending here, which will break
> also the compilation of this driver, I would prefer to merge that through
> my tree before the removal patches to avoid build breakage.

Okay, thanks for taking care of it.

Shawn
