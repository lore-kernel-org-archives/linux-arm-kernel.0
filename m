From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 15 Jan 2015 09:28:44 +0100
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <20150114104610.GC4050@arm.com>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <1417453034-21379-9-git-send-email-will.deacon@arm.com>
 <54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
Message-ID: <20150115082843.GB30799@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
> On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
[...]
> > 2) Say you want to use the IOMMU API in your driver, and have an iommu 
> > property in your device's DT node. If by chance your IOMMU is registered 
> > early, you will already have a mapping automatically created even before 
> > your probe function is called. Can this be avoided? Is it even safe?
> 
> Currently, I think you have to either teardown the ops manually or return
> an error from of_xlate. Thierry was also looking at this sort of thing,
> so it might be worth talking to him.

I already explained in earlier threads why I think this is a bad idea.
It's completely unnatural for any driver to manually tear down something
that it didn't want set up in the first place. It also means that you
have to carefully audit any users of these IOMMU APIs to make sure that
they do tear down. That doesn't sound like a good incremental approach,
as evidenced by the breakage that Alex and Heiko have encountered.

The solution for me has been to completely side-step the issue and not
register the IOMMU with the new mechanism at all. That is, there's no
.of_xlate() implementation, which means that the ARM DMA API glue won't
try to be smart and use the IOMMU in ways it's not meant to be used.
This has several advantages, such as that I can also use the regular
driver model for suspend/resume of the IOMMU, and I get to enjoy the
benefits of devres in the IOMMU driver. Probe ordering is still a tiny
issue, but we can easily solve that using explicit initcall ordering
(which really isn't any worse than IOMMU_OF_DECLARE()).

Ideally of course I could use deferred probing to solve that. Hiroshi
and I posted patches to implement that over a year ago[0], but it was
mostly ignored after some, in my opinion, fruitful discussion.

That patch requires drivers to explicitly call iommu_attach() to
advertise that they want to use the IOMMU. This was done because a
previous attempt to call iommu_attach() from the driver core was
rejected on the sole argument that "it doesn't belong in the core",
without further explanation.

Note that with that approach things all happen at driver probe time, so
we can simply return -EPROBE_DEFER when the IOMMU isn't ready yet. At
the same time the IOMMU can be a regular driver just like any of the
other resource providers like clocks, regulators, etc.

That all said, I'm fine with the current situation, too. Nobody can
force the Tegra SMMU driver to register via IOMMU_OF_DECLARE() and I'm
actively recommending the use of the IOMMU API directly. That way we
get the control we need for drivers where it matters most (i.e. where
close control of the address space and switching of address spaces per
process are needed). Any other drivers, like USB or SDMMC simply use
the DMA API and get their buffers from a contiguous pool.

Thierry

[0]: https://lkml.org/lkml/2014/6/26/476
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/7220303e/attachment.sig>
