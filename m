From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Tue, 12 Nov 2013 12:25:18 +0000
Subject: Physical memory start contraints in the Linux kernel  (Was: Re: Xen
 osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable test]
 21486: tolerable FAIL - PUSHED))
In-Reply-To: <1384250005.1883.35.camel@kazak.uk.xensource.com>
References: <osstest-21486-mainreport@xen.org>
 <1383731526.26213.25.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061111580.26077@kaball.uk.xensource.com>
 <1383736784.26213.72.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311061938080.26077@kaball.uk.xensource.com>
 <1383822868.26213.181.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311111825090.26077@kaball.uk.xensource.com>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
Message-ID: <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,
we have been having this discussion on xen-devel regarding whether Xen
should be allowed to modify the start address of the physical memory
region in device tree before passing it to dom0 or not.

The reason why this question is coming up now, is that we realized that
we are going to have to live with the 1:1 pseudo-physical to physical
mapping for dom0 for a while. This limits the ability of the hypervisor
of allocating dom0 memory wherever it wants. Xen can allocate dom0
memory from the low end but maybe not exactly from the start.

As a result we would adjust the start of physical memory in device tree
to match the start of the memory region allocated for dom0. For example
on the Arndale it could be 0x80800000 instead of 0x80000000.

Unfortunately not all the platforms can cope with this very well. In
particular the Arndale seems to have issues.


The question for you, as arm-soc maintainers, is: do you think this
should work and if we find any issues we should just fix them or report
them as bugs?
Is this entirely going away with multiplatform kernels so we shouldn't
worry about it?
Or is this a lost fight and should we find a workaround (see below if we
are curious) to make the start of memory look the same?




On Tue, 12 Nov 2013, Ian Campbell wrote:
> > However why do we even have a device tree property to express where the
> > memory start, when this property can only have a single value?
> > 
> > I think that Xen should be free to make the guest memory start at any
> > address it can express in device tree, within reasonable limits.
> > Otherwise we can go back to the world of add-hoc hardcoded constants and
> > get rid of device tree entirely.
> > If this doesn't work, why the kernel can't be fixed?
> > Am I being unreasonable about this?
> 
> Unfortunately the reality is that the Linux kernel has various
> constraints on where RAM might be and how it is aligned WRT to the
> kernel load address. This is particularly bad for non-multiplatform
> kernels (i.e. Julien had issues on Arndale) but there are aso some
> constraints on non-multiplatform ones (I don't think we've tripped over
> any of them).
> 
> We could fight this and try and fix it but it would basically be a case
> of "Xen dom0 is special compared to the real hardware", and it could
> involve some nasty start-of-day munging.
> 
> Overall a conceptually simple and well defined "ad-hoc hack" seems
> preferable to me.
