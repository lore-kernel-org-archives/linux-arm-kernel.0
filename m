From: olof@lixom.net (Olof Johansson)
Date: Tue, 5 Nov 2013 14:46:51 -0800
Subject: [PATCH v9 16/18] arm, arm64: do not always merge biovec if we are
 running on Xen
In-Reply-To: <1382698313-13161-16-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1310251144020.26077@kaball.uk.xensource.com>
 <1382698313-13161-16-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <CAOesGMjdfGoEp+yCRa1WhQi=c_LHBCjrU3H9WUqf0Fn_cqkz_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Oct 25, 2013 at 3:51 AM, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> This is similar to what it is done on X86: biovecs are prevented from merging
> otherwise every dma requests would be forced to bounce on the swiotlb buffer.
>
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>


This is spewing 800+ warnings on ape6evm_defconfig on ARM that doesn't
have CONFIG_BLOCK enabled, since struct bio_vec is protected by that
in include/linux/blk_types.h. I guess it could be argued that those
ifdefs could be removed, but still:

../../arch/arm/include/asm/io.h:378:24: warning: its scope is only
this definition or declaration, which is probably not what you want
[enabled by default]
In file included from ../../include/linux/scatterlist.h:10:0,
                 from ../../include/linux/dmaengine.h:27,
                 from ../../include/linux/skbuff.h:31,
                 from ../../include/crypto/algapi.h:18,
                 from ../../crypto/internal.h:16,
                 from ../../crypto/cipher.c:21:
../../arch/arm/include/asm/io.h:378:24: warning: 'struct bio_vec'
declared inside parameter list [enabled by default]
           const struct bio_vec *vec2);


-Olof
