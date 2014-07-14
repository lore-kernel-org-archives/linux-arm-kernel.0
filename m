From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 14 Jul 2014 08:24:29 +0200
Subject: [PATCH v4] devicetree: Add generic IOMMU device tree bindings
In-Reply-To: <CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
References: <1404487757-18829-1-git-send-email-thierry.reding@gmail.com>
 <20140712093917.GD18601@arm.com>
 <CAF6AEGutHp+3f3iPA+jjaRkqq=5T_vytZ_ESoSqsQ4RHZ8F8yQ@mail.gmail.com>
 <201407121422.02078.arnd@arndb.de>
 <CAF6AEGs7=3UByP2DLm-uwU03wr7M14x2t-0hLX-VPJ6_eZbU3g@mail.gmail.com>
Message-ID: <20140714062428.GC2081@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 12, 2014 at 08:57:31AM -0400, Rob Clark wrote:
> On Sat, Jul 12, 2014 at 8:22 AM, Arnd Bergmann <arnd@arndb.de> wrote:
[...]
> > The way that Thierry's binding does that is the obvious solution to this,
> > and it mirrors what we do in practically every other subsystem. I definitely
> > want the SMMU to change before anybody starts using it in a real system,
> > which we fortunately do not have yet.
> 
> hmm, well if some of the things I need for (like this or batching
> mappings) are too weird and gpu specific, I'm willing to duplicate the
> IOMMU driver in drm/msm.  It really isn't so much code, and that gives
> me a lot more more flexibility to do crazy things... at some point I'm
> probably going to want to do context switches by banging the IOMMU
> registers directly from the gpu.

If the IOMMU API doesn't provide for what you need, then perhaps it's
time to enhance it? We do that all the time in other parts of the
kernel, why should IOMMU be special?

It seems to me like context switching for per-process address space
isolation is one of the important features of an IOMMU. If the current
API doesn't let you do that then we should think of ways how it can be
improved. And if it doesn't do it fast enough, then we should equally
find ways to speed it up.

This is part of why I think it would be good to have explicit objects
associated with IOMMU contexts. That would give us a good place to add
caching for this kind of situation. Currently we're required to handle
most of this in drivers (map from struct device to context, ...).

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140714/00035cca/attachment.sig>
