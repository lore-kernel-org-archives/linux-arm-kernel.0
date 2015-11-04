From: cl@linux.com (Christoph Lameter)
Date: Wed, 4 Nov 2015 07:53:50 -0600 (CST)
Subject: [PATCH] arm64: Increase the max granular size
In-Reply-To: <20151104123640.GK7637@e104818-lin.cambridge.arm.com>
References: <1442944788-17254-1-git-send-email-rric@kernel.org>
 <20151028190948.GJ8899@e104818-lin.cambridge.arm.com>
 <CAMuHMdWQygbxMXoOsbwek6DzZcr7J-C23VCK4ubbgUr+zj=giw@mail.gmail.com>
 <20151103120504.GF7637@e104818-lin.cambridge.arm.com>
 <20151103143858.GI7637@e104818-lin.cambridge.arm.com>
 <CAMuHMdWk0fPzTSKhoCuS4wsOU1iddhKJb2SOpjo=a_9vCm_KXQ@mail.gmail.com>
 <20151103185050.GJ7637@e104818-lin.cambridge.arm.com>
 <alpine.DEB.2.20.1511031724010.8178@east.gentwo.org>
 <20151104123640.GK7637@e104818-lin.cambridge.arm.com>
Message-ID: <alpine.DEB.2.20.1511040748590.17248@east.gentwo.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 4 Nov 2015, Catalin Marinas wrote:

> The simplest option would be to make sure that off slab isn't allowed
> for caches of KMALLOC_MIN_SIZE or smaller, with the drawback that not
> only "kmalloc-128" but any other such caches will be on slab.

The reason for an off slab configuration is denser object packing.

> I think a better option would be to first check that there is a
> kmalloc_caches[] entry for freelist_size before deciding to go off-slab.

Hmmm.. Yes seems to be an option.

Maybe we simply revert commit 8fc9cf420b36 instead? That does not seem to
make too much sense to me and the goal of the commit cannot be
accomplished on ARM. Your patch essentially reverts the effect anyways.

Smaller slabs really do not need off slab management anyways since they
will only loose a few objects per slab page.
