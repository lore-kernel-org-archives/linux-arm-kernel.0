From: alexdeucher@gmail.com (Alex Deucher)
Date: Tue, 10 Nov 2015 15:17:00 -0500
Subject: [PATCH] drm/amdgpu: fix seq_printf format string
In-Reply-To: <6655728.oIVJfmhexk@wuerfel>
References: <6655728.oIVJfmhexk@wuerfel>
Message-ID: <CADnq5_P6niWuGbVx4kLkPZgUn669saBYsBfgpAd3wnMZmn6AOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 10, 2015 at 7:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> The amdgpu driver has a debugfs interface that shows the amount of
> VRAM in use, but the newly added code causes a build error on
> all 32-bit architectures:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1076:17: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'long long int' [-Wformat=]
>
> This fixes the format string to use "%llu" for printing 64-bit
> numbers, which works everywhere, as long as we also cast to 'u64'.
> Unlike atomic64_t, u64 is defined as 'unsigned long long' on
> all architectures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: a2ef8a974931 ("drm/amdgpu: add vram usage into debugfs")


Applied.  thanks!

Alex

> ---
> This appeared a few weeks ago with ARM allmodconfig. I was waiting for
> someone to complain about the warning on x86 first, but that apparently
> has not happened.
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 81bb8e9fc26d..d4bac5f49939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1073,10 +1073,10 @@ static int amdgpu_mm_dump_table(struct seq_file *m, void *data)
>         ret = drm_mm_dump_table(m, mm);
>         spin_unlock(&glob->lru_lock);
>         if (ttm_pl == TTM_PL_VRAM)
> -               seq_printf(m, "man size:%llu pages, ram usage:%luMB, vis usage:%luMB\n",
> +               seq_printf(m, "man size:%llu pages, ram usage:%lluMB, vis usage:%lluMB\n",
>                            adev->mman.bdev.man[ttm_pl].size,
> -                          atomic64_read(&adev->vram_usage) >> 20,
> -                          atomic64_read(&adev->vram_vis_usage) >> 20);
> +                          (u64)atomic64_read(&adev->vram_usage) >> 20,
> +                          (u64)atomic64_read(&adev->vram_vis_usage) >> 20);
>         return ret;
>  }
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
