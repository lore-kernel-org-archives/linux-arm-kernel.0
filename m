From: mporter@ti.com (Matt Porter)
Date: Mon, 1 Oct 2012 08:32:42 -0400
Subject: [PATCH v2 4/7] ARM: davinci: Add support for an L3RAM gen_pool
In-Reply-To: <506986B2.1030000@ti.com>
References: <1348861072-14507-1-git-send-email-mporter@ti.com>
 <1348861072-14507-5-git-send-email-mporter@ti.com>
 <506986B2.1030000@ti.com>
Message-ID: <20121001123242.GJ5641@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 01, 2012 at 05:34:02PM +0530, Sekhar Nori wrote:
> Hi Matt,
> 
> On 9/29/2012 1:07 AM, Matt Porter wrote:
> > L3RAM (shared SRAM) is needed for use by several drivers.
> > This creates a genalloc pool and a hook for the platform code
> > to provide the struct gen_pool * in platform data.
> > 
> > Signed-off-by: Matt Porter <mporter@ti.com>
> 
> I am not sure if any of the DaVinci devices have a need to allocate from
> *both* ARM RAM and shared RAM. Shared RAM is not present on all DaVinci
> devices AFAIR, and on DA850, there is just 8KB ARM RAM so I am not sure
> if there is much point in trying to allocate from there.
> 
> Can you instead see if Ben's earlier patch[1] to use shared RAM for SRAM
> allocation on DA850 makes sense for your case? If yes, can you repost
> with Ben's patch included in your series instead of this patch? I would
> prefer that over creating a new pool for shared RAM.

Hrm, I did look at Ben's earlier patch. The reason I added a separate
pool mostly was so I didn't have to touch the PM code at all. That can
continue using the private SRAM API with the ARM RAM as it is now. The
idea here was to allow that to be separate since no other bus masters
can access the ARM RAM anyway and do something that didn't require
regression testing PM. Also, I figured there's really no reason to use
even a tiny bit of the shared SRAM on PM if we have that ARM RAM there
and working fine for that use case.

The other thing is that Ben's patch needs to be rewritten to at least
have the hook I added so we can provide the gen_pool in platform data.
If you prefer this path still, I can add the needed hook on top of his
original patch. Ultimately, I only *need* genalloc support for the
shared sram so I can remove the private SRAM API from uio_pruss...so I'm
happy with any way to get at it.

Oh, and to be honest...it's not just for uio_pruss, but also to cleanly
remove the private SRAM API usage from the davinci ASoC driver too.

Thanks,
Matt
