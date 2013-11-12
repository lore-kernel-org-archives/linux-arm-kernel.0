From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 12 Nov 2013 14:37:55 +0100
Subject: Physical memory start contraints in the Linux kernel (Was: Re:
 Xen osstest on Calxeda midway progress (Was: Re: [Xen-devel] [xen-unstable
 test] 21486: tolerable FAIL - PUSHED))
In-Reply-To: <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
References: <osstest-21486-mainreport@xen.org>
 <1384250005.1883.35.camel@kazak.uk.xensource.com>
 <alpine.DEB.2.02.1311121212240.26077@kaball.uk.xensource.com>
Message-ID: <201311121437.55826.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 November 2013, Stefano Stabellini wrote:

Hi Stefano,

I haven't given it too much thought, but here is what I believe should
be done:

> The question for you, as arm-soc maintainers, is: do you think this
> should work and if we find any issues we should just fix them or report
> them as bugs?

Modifying the DT to mark anything as "reserved" or absent that Dom0
should or can not touch sounds like the correct way to do this. Whether
this needs to be done by modifying the reg property of the device node
or through a different method I can't tell.

If you find bugs in the kernel that prevent this from working, but it
works fine for everyone else, it's up to you to provide a bug-fix,
which would most likely be up to Russell to apply.

> Is this entirely going away with multiplatform kernels so we shouldn't
> worry about it?

Multiplatform kernels are by definition relocatable using
CONFIG_ARM_PATCH_PHYS_VIRT, within some limitations such as the
granularity of the mapping. You certainly can't move the start of memory
to an address of smaller than 2MB (hugepage) alignment, but you might
need something larger than that.

> Or is this a lost fight and should we find a workaround (see below if we
> are curious) to make the start of memory look the same?

I don't see what hack you are referring to, can you elaborate?

My feeling is that we should maintain the requirement that that it must be
possible to enable Dom0 support on any virtualisation-capable platform
without breaking other platforms or causing an unreasonable run-time
overhead.

BTW, does Dom0 require an LPAE-enabled kernel or can it be a regular
non-LPAE ARMv6/v7 multiplatform build?

	Arnd
