From: drinkcat@chromium.org (Nicolas Boichat)
Date: Thu, 22 Nov 2018 08:52:46 +0800
Subject: [PATCH v2 2/3] mm: Add support for SLAB_CACHE_DMA32
In-Reply-To: <01000167378bf31a-a639b46c-4d1d-43de-9bed-9cdd9c07fa94-000000@email.amazonses.com>
References: <20181111090341.120786-1-drinkcat@chromium.org>
 <20181111090341.120786-3-drinkcat@chromium.org>
 <01000167378bf31a-a639b46c-4d1d-43de-9bed-9cdd9c07fa94-000000@email.amazonses.com>
Message-ID: <CANMq1KD4j=Zh1izN8Ujn3+ZsdMMzCLPurfkXTkM9TyQaTptjFw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 2:32 AM Christopher Lameter <cl@linux.com> wrote:
>
> On Sun, 11 Nov 2018, Nicolas Boichat wrote:
>
> > SLAB_CACHE_DMA32 is only available after explicit kmem_cache_create calls,
> > no default cache is created for kmalloc. Add a test in check_slab_flags
> > for this.
>
> This does not define the dma32 kmalloc array. Is that intentional?

Yes that's intentional, AFAICT there is no user, so there is no point
creating the cache.

 (okay, I could find one, but it's probably broken:
git grep GFP_DMA32 | grep k[a-z]*alloc
drivers/media/platform/vivid/vivid-osd.c: dev->video_vbase =
kzalloc(dev->video_buffer_size, GFP_KERNEL | GFP_DMA32);
).

> In that
> case you need to fail any request for GFP_DMA32 coming in via kmalloc.

Well, we do check for these in check_slab_flags (aka GFP_SLAB_BUG_MASK
before patch 1/3 of this series), so, with or without this patch,
calls with GFP_DMA32 will end up failing in check_slab_flags.
