From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 6 Nov 2018 17:21:00 +0000
Subject: [PATCH 00/12] error handling and pciehp maintenance
In-Reply-To: <20181106164751.GA6217@localhost.localdomain>
References: <20180918235848.26694-1-keith.busch@intel.com>
 <20181004214015.GK120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181004221137.GB21834@localhost.localdomain>
 <20181005173145.GL120535@bhelgaas-glaptop.roam.corp.google.com>
 <20181008161847.GA30971@localhost.localdomain>
 <20181106163400.GA21193@e107981-ln.cambridge.arm.com>
 <20181106164751.GA6217@localhost.localdomain>
Message-ID: <20181106172100.GA22063@e107981-ln.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 09:47:52AM -0700, Keith Busch wrote:
> On Tue, Nov 06, 2018 at 04:34:08PM +0000, Lorenzo Pieralisi wrote:
> > The question is whether we really need to dynamically patch the kernel
> > with ftrace to achieve what that patch does.
> > 
> > Furthermore, it would also be good to report what bugs we are actually
> > fixing, from what you are writing falling back to the current method if
> > !DYNAMIC_FTRACE_WITH_REGS is broken in many ways and I would start with
> > fixing the current behaviour with something that does not depend on arch
> > features that may not even be implemented.
> 
> There are two problems with the current method:
> 
>   1. It may dereference pci_dev after it was freed
>   2. The pci_dev's children inherit its fake pci_bus's ops on
>      enumeration
> 
> Both result in kernel panic.

That's my point, current test module is not robust, I wanted to ask if
there is a way to fix it that does not depend on arch features, because
if there is a dependency that is not met we are still not fixing the
current code, using it as a fallback can still create issues.

> The dynamic kernel patch just seemed like a cool way to inject errors
> without messing with the driver's structures. But if there's a more
> elegant way to do it, I'm all for it.

If you have a simple reproducer for the bugs I am happy to help you test
it (I can also apply arm64 DYNAMIC_FTRACE_WITH_REGS patches and test that
new code path if that's the final direction we are taking).

Thanks,
Lorenzo
