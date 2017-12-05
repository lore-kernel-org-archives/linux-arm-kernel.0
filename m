From: jonathanh@nvidia.com (Jon Hunter)
Date: Tue, 5 Dec 2017 14:30:21 +0000
Subject: [PATCH 1/2] drm/nouveau/bar/gf100: fix hang when calling ->fini()
 before ->init()
In-Reply-To: <be610a7596ad8fee7da092161888c532c2eb2908.1512411775.git.guillaume.tucker@collabora.com>
References: <be610a7596ad8fee7da092161888c532c2eb2908.1512411775.git.guillaume.tucker@collabora.com>
Message-ID: <6db622ac-319d-c640-91ab-9248e528b69b@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 04/12/17 18:37, Guillaume Tucker wrote:
> If the firmware fails to load then ->fini() will be called before the
> device has been initialised, causing the kernel to hang while trying
> to write to a register.  Add a test in ->fini() to avoid this issue.
> 
> This fixes a kernel hang on tegra124.
> 
> Fixes: b17de35a2ebbe ("drm/nouveau/bar: implement bar1 teardown")
> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> CC: Ben Skeggs <bskeggs@redhat.com>
> ---
>  drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c
> index a3ba7f50198b..95e2aba64aad 100644
> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c
> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c
> @@ -43,9 +43,12 @@ gf100_bar_bar1_wait(struct nvkm_bar *base)
>  }
>  
>  void
> -gf100_bar_bar1_fini(struct nvkm_bar *bar)
> +gf100_bar_bar1_fini(struct nvkm_bar *base)
>  {
> -	nvkm_mask(bar->subdev.device, 0x001704, 0x80000000, 0x00000000);
> +	struct nvkm_device *device = base->subdev.device;
> +
> +	if (base->subdev.oneinit)
> +		nvkm_mask(device, 0x001704, 0x80000000, 0x00000000);
>  }
>  
>  void

I have tested this and it works for me. Thanks for fixing this! Would be
good to get Ben's ACK, but you can have my ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
