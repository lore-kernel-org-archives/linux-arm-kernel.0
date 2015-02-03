From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 03 Feb 2015 09:29:21 +0000
Subject: [PATCH v3] dma-buf: cleanup dma_buf_export() to make it easily
 extensible
In-Reply-To: <1422449643-7829-1-git-send-email-sumit.semwal@linaro.org>
References: <1422449643-7829-1-git-send-email-sumit.semwal@linaro.org>
Message-ID: <54D094F1.50404@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/01/15 12:54, Sumit Semwal wrote:
> At present, dma_buf_export() takes a series of parameters, which
> makes it difficult to add any new parameters for exporters, if required.
> 
> Make it simpler by moving all these parameters into a struct, and pass
> the struct * as parameter to dma_buf_export().
> 
> While at it, unite dma_buf_export_named() with dma_buf_export(), and
> change all callers accordingly.
> 
> Signed-off-by: Sumit Semwal <sumit.semwal@linaro.org>

Sorry, a few more comments. Should have sent these before but at least
the are all related only to documentation. Once that is fixed then:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


> ---
> v3: Daniel Thompson caught the C99 warning issue w/ using {0}; using
>     {.exp_name = xxx} instead.
> 
> v2: add macro to zero out local struct, and fill KBUILD_MODNAME by default
> 
>  drivers/dma-buf/dma-buf.c                      | 47 +++++++++++++-------------
>  drivers/gpu/drm/armada/armada_gem.c            | 10 ++++--
>  drivers/gpu/drm/drm_prime.c                    | 12 ++++---
>  drivers/gpu/drm/exynos/exynos_drm_dmabuf.c     |  9 +++--
>  drivers/gpu/drm/i915/i915_gem_dmabuf.c         | 10 ++++--
>  drivers/gpu/drm/omapdrm/omap_gem_dmabuf.c      |  9 ++++-
>  drivers/gpu/drm/tegra/gem.c                    | 10 ++++--
>  drivers/gpu/drm/ttm/ttm_object.c               |  9 +++--
>  drivers/gpu/drm/udl/udl_dmabuf.c               |  9 ++++-
>  drivers/media/v4l2-core/videobuf2-dma-contig.c |  8 ++++-
>  drivers/media/v4l2-core/videobuf2-dma-sg.c     |  8 ++++-
>  drivers/media/v4l2-core/videobuf2-vmalloc.c    |  8 ++++-
>  drivers/staging/android/ion/ion.c              |  9 +++--
>  include/linux/dma-buf.h                        | 34 +++++++++++++++----

Documentation/dma-buf-sharing.txt needs updating as a result of these
changes but its not in the diffstat.


>  14 files changed, 142 insertions(+), 50 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 5be225c2ba98..6d3df3dd9310 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -265,7 +265,7 @@ static inline int is_dma_buf_file(struct file *file)
>  }
>  
>  /**
> - * dma_buf_export_named - Creates a new dma_buf, and associates an anon file
> + * dma_buf_export - Creates a new dma_buf, and associates an anon file
>   * with this buffer, so it can be exported.
>   * Also connect the allocator specific data and ops to the buffer.
>   * Additionally, provide a name string for exporter; useful in debugging.
> @@ -277,31 +277,32 @@ static inline int is_dma_buf_file(struct file *file)
>   * @exp_name:	[in]	name of the exporting module - useful for debugging.
>   * @resv:	[in]	reservation-object, NULL to allocate default one.
>   *
> + * All the above info comes from struct dma_buf_export_info.
> + *

I'm not at all sure about this. Its a novel trick but won't this make
the HTML docs come out looking a bit weird? Is there any prior art for
double-documenting the structure members like this?


Daniel.
