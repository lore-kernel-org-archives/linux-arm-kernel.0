From: contact@paulk.fr (Paul Kocialkowski)
Date: Mon, 20 Aug 2018 14:34:44 +0200
Subject: [PATCH] drm/sun4i: Avoid failing to init fbdev without any
 connector
In-Reply-To: <20180820095657.rcs3wxikxprty55d@flea>
References: <20180807193919.4800-1-contact@paulk.fr>
 <20180807201801.GF3008@phenom.ffwll.local>
 <230112e8b2ad4b4e53b54fe1446e7f71aa09e514.camel@paulk.fr>
 <20180820095657.rcs3wxikxprty55d@flea>
Message-ID: <412de868a8d0a41aa2256a5fbe2f3701de582e1b.camel@paulk.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, 2018-08-20 at 11:56 +0200, Maxime Ripard wrote:
> On Tue, Aug 07, 2018 at 10:31:30PM +0200, Paul Kocialkowski wrote:
> > Hi,
> > 
> > Le mardi 07 ao?t 2018 ? 22:18 +0200, Daniel Vetter a ?crit :
> > > On Tue, Aug 07, 2018 at 09:39:19PM +0200, Paul Kocialkowski wrote:
> > > > Initializing and registering fbdev requires at least one DRM connector
> > > > and will fail otherwise. In order to support headless setups (for
> > > > instance for GPU rendering with the GBM backend, where a DRI card node
> > > > is required to provide GEM memory reservation), add a check on the
> > > > number of registered connectors before initializing fbdev.
> > > 
> > > sun4i is a pure kms driver, why exactly do you need it for gbm backed
> > > rendering? What exactly is rendering here, and why does it insist on a
> > > display card node, even if that display card node is 100% defunct?
> > 
> > The non-free Mali blobs provide GPU support with a GBM interface that
> > takes a DRM fd in order to reserve the memory it needs for its rendering
> > targets. This uses the GEM interface available through the DRI card node
> > (and there is no render node with the non-free Mali driver). Allwinner
> > has a minimalistic out-of-tree driver pretty much only for this purpose.
> > 
> > I crafted this patch when someone on IRC tried to get the out-of-tree
> > Mali GPU driver going with the mainline kernel in order to do rendering
> > in a GBM buffer, since it's apparently the only option for headless
> > rendering with the blob.
> > 
> > In my opinion, supporting the pipeline of an out-of-tree GPU driver that
> > only works with a non-free userspace blob is not a valid reason to do
> > anything. Still, it felt like adding support for the headless use-case
> > wouldn't hurt, whatever the underlying use case for it may be.
> 
> If you start considering the DMA constraints and the API in itself, it
> does hurt. You'll get buffers that are not meant for the GPU, and
> might not be accessible, and from another device without using
> dma-buf, which again works because the hardware is dumb enough, but is
> breaking a lot of expectations in the process.

You're right, this is too much abuse. I'm dropping this patch then.

Cheers,

Paul

> If one wants to do headless rendering, mali-drm or lima looks like a
> better solution.
> 
> Maxime
> 
-- 
Developer of free digital technology and hardware support.

Website: https://www.paulk.fr/
Coding blog: https://code.paulk.fr/
Git repositories: https://git.paulk.fr/ https://git.code.paulk.fr/
