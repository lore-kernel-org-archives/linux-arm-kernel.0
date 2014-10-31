From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 31 Oct 2014 10:57:06 +0100
Subject: [PATCH v5 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20141031081803.GA8012@gondor.apana.org.au>
References: <1413728182-13569-1-git-send-email-clabbe.montjoie@gmail.com>
 <1413728182-13569-5-git-send-email-clabbe.montjoie@gmail.com>
 <20141021191149.GQ21108@lukather> <544A9FEA.6020304@gmail.com>
 <20141030171933.GR21251@lukather>
 <20141031072030.GA7563@gondor.apana.org.au>
 <20141031081323.GS21251@lukather>
 <20141031081803.GA8012@gondor.apana.org.au>
Message-ID: <20141031095706.GA8054@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 31, 2014 at 04:18:03PM +0800, Herbert Xu wrote:
> On Fri, Oct 31, 2014 at 09:13:23AM +0100, Maxime Ripard wrote:
> >
> > I don't understand here. Why would other drivers *not* being affected?
> > 
> > If the scatter list passed by AF_ALG can be in highmem, I guess it's
> > the case for every driver out there. Almost every kernel code I've
> > seen so far makes the assumption that the memory it has is mapped and
> > accessible.
> > 
> > Somehow, it's the driver's fault now, and not the part of kernel that
> > actually does the allocation?
> 
> If you are implementing a crypto driver that is meant to handle
> requests from the crypto API then yes you need to handle highmem.

Is that documented somewhere?

> As I said if enough drivers are unable to address highmem and
> require copying/software fallbacks then we could provide this
> through the API and the driver would then only need to declare
> its lack of highmem support or use a helper.

On a 3.18-rc2 kernel:

$ git grep kmap -- crypto/
crypto/ahash.c:                         walk->data = kmap(walk->pg);
crypto/ahash.c:                         walk->data = kmap_atomic(walk->pg);
crypto/async_tx/async_memcpy.c:         dest_buf = kmap_atomic(dest) + dest_offset;
crypto/async_tx/async_memcpy.c:         src_buf = kmap_atomic(src) + src_offset;
crypto/scatterwalk.c:                   return kmap_atomic(scatterwalk_page(walk)) +
crypto/shash.c:                         data = kmap_atomic(sg_page(sg));
crypto/shash.c:                         data = kmap_atomic(sg_page(sg));

None of the drivers are.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141031/c2ce2dc7/attachment.sig>
