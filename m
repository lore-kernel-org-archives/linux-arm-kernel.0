From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Jan 2015 11:12:17 +0000
Subject: [PATCH v6 8/8] arm: dma-mapping: plumb our iommu mapping ops
 into arch_setup_dma_ops
In-Reply-To: <20150115082843.GB30799@ulmo>
References: <1417453034-21379-1-git-send-email-will.deacon@arm.com>
 <1417453034-21379-9-git-send-email-will.deacon@arm.com>
 <54B63028.3090701@nvidia.com> <20150114104610.GC4050@arm.com>
 <20150115082843.GB30799@ulmo>
Message-ID: <20150115111211.GF23475@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 15, 2015 at 08:28:44AM +0000, Thierry Reding wrote:
> On Wed, Jan 14, 2015 at 10:46:10AM +0000, Will Deacon wrote:
> > On Wed, Jan 14, 2015 at 09:00:24AM +0000, Alexandre Courbot wrote:
> [...]
> > > 2) Say you want to use the IOMMU API in your driver, and have an iommu 
> > > property in your device's DT node. If by chance your IOMMU is registered 
> > > early, you will already have a mapping automatically created even before 
> > > your probe function is called. Can this be avoided? Is it even safe?
> > 
> > Currently, I think you have to either teardown the ops manually or return
> > an error from of_xlate. Thierry was also looking at this sort of thing,
> > so it might be worth talking to him.
> 
> I already explained in earlier threads why I think this is a bad idea.
> It's completely unnatural for any driver to manually tear down something
> that it didn't want set up in the first place. It also means that you
> have to carefully audit any users of these IOMMU APIs to make sure that
> they do tear down. That doesn't sound like a good incremental approach,
> as evidenced by the breakage that Alex and Heiko have encountered.

Well, perhaps we hide that behind a get_iommu API or something. We *do*
need this manual teardown step to support things like VFIO, so it makes
sense to reuse it for other users too imo.

> The solution for me has been to completely side-step the issue and not
> register the IOMMU with the new mechanism at all. That is, there's no
> .of_xlate() implementation, which means that the ARM DMA API glue won't
> try to be smart and use the IOMMU in ways it's not meant to be used.
> This has several advantages, such as that I can also use the regular
> driver model for suspend/resume of the IOMMU, and I get to enjoy the
> benefits of devres in the IOMMU driver. Probe ordering is still a tiny
> issue, but we can easily solve that using explicit initcall ordering
> (which really isn't any worse than IOMMU_OF_DECLARE()).

That's a pity. I'd much rather extend what we currently have to satisfy
your use-case. Ho-hum.

Will
