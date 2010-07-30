From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 30 Jul 2010 10:01:02 +0200
Subject: [PATCH 1/2] arm: msm: Add System MMU support.
In-Reply-To: <d493494df33aaf65e526181b1dbafce3.squirrel@www.codeaurora.org>
References: <20100729123512Y.fujita.tomonori@lab.ntt.co.jp>
	<20100729090607.GN26098@amd.com>
	<d493494df33aaf65e526181b1dbafce3.squirrel@www.codeaurora.org>
Message-ID: <201007301001.02509.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 July 2010 07:19:06 stepanm at codeaurora.org wrote:
> Unlike a more traditional system with one IOMMU between the bus and
> memory, MSM has multiple IOMMUs, with each one hard-wired to a dedicated
> device. Furthermore, each IOMMU can have more than one translation
> context. One of the use cases is being able to create mappings within
> multiple instances of one context, and arbitrarily context-switch the
> IOMMU on the fly.
> 
> It sounds like the domain abstraction and attach_device/detach_device can
> encapsulate this rather nicely and I am in the process of updating my
> driver to fit this framework.
> 
> My problem, however, is with iommu_domain_alloc(). This will set up a
> domain and call the ops function to initialize it, but I want to be able
> to pass it an ?IOMMU id" that will tell the underlying driver which IOMMU
> (and which "stream id") is to be associated with that domain instance.

This probably best fits into the device itself, so you can assign the
iommu data when probing the bus, e.g. (I don't know what bus you use)

struct msm_device {
	struct msm_iommu *iommu;
	struct device dev;
};

This will work both for device drivers using the DMA API and for KVM
with the IOMMU API.

> This can be a void* parameter that gets passed through to domain_init. I
> feel like this change will make it easy to deal with multiple
> IOMMUs/translation contexts, and implementations that have only a singular
> IOMMU/translation context are free to ignore that parameter.
> 
> The alternative for me is to have a separate msm_iommu_domain_alloc(void
> *context_id) function, to which I can specify which IOMMU I want to use,
> but I would like to fully use your API if possible.

No, that would require adding msm specific code to KVM and potential
other users.

	Arnd
