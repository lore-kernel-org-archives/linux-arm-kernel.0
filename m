From: vincenzo.frascino@arm.com (Vincenzo Frascino)
Date: Thu, 8 Nov 2018 17:10:18 +0000
Subject: [PATCH v10 17/22] kasan: add hooks implementation for tag-based
 mode
In-Reply-To: <5dd9582d3e4c6a8b144aea3913659c5a1befa0ac.1541525354.git.andreyknvl@google.com>
References: <cover.1541525354.git.andreyknvl@google.com>
 <5dd9582d3e4c6a8b144aea3913659c5a1befa0ac.1541525354.git.andreyknvl@google.com>
Message-ID: <6c56c19b-6929-af8d-d26b-31c969397a46@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/11/2018 17:30, Andrey Konovalov wrote:
> This commit adds tag-based KASAN specific hooks implementation and
> adjusts common generic and tag-based KASAN ones.
> 
> 1. When a new slab cache is created, tag-based KASAN rounds up the size of
>    the objects in this cache to KASAN_SHADOW_SCALE_SIZE (== 16).
> 
> 2. On each kmalloc tag-based KASAN generates a random tag, sets the shadow
>    memory, that corresponds to this object to this tag, and embeds this
>    tag value into the top byte of the returned pointer.
> 
> 3. On each kfree tag-based KASAN poisons the shadow memory with a random
>    tag to allow detection of use-after-free bugs.
> 
> The rest of the logic of the hook implementation is very much similar to
> the one provided by generic KASAN. Tag-based KASAN saves allocation and
> free stack metadata to the slab object the same way generic KASAN does.
> 
> Reviewed-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
> Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c | 116 ++++++++++++++++++++++++++++++++++++++--------
>  mm/kasan/kasan.h  |   8 ++++
>  mm/kasan/tags.c   |  48 +++++++++++++++++++
>  3 files changed, 153 insertions(+), 19 deletions(-)
> 

...

>  
> +	cache->align = round_up(cache->align, KASAN_SHADOW_SCALE_SIZE);
> +

Did you consider to set ARCH_SLAB_MINALIGN instead of this round up?

-- 
Regards,
Vincenzo
