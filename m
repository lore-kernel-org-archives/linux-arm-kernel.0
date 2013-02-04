From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 04 Feb 2013 17:59:19 +0100
Subject: alsa usb-audio sound corruption caused by cached vmalloc mapping
In-Reply-To: <510FE6D3.9020904@parrot.com>
References: <510FE6D3.9020904@parrot.com>
Message-ID: <s5hzjzk10d4.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Mon, 4 Feb 2013 17:50:27 +0100,
Matthieu CASTET wrote:
> 
> Hi,
> 
> on a armv5 soc, we have audio corruption while using a usb-audio sound card.
> After analysis, it comes from alsa vmalloc mapping.

Yeah, it's a known issue since long time ago...

> in the current kernel vmalloc mapping used by alsa are cached.
> 
> This cause coherency problem on armv5 architecture because the cache are VIVT :
> - alsa kernel driver map a buffer with vmalloc. The memory attribute is cached
> - userspace map vmalloc buffer.  The memory attribute is cached
> 
> But because the cache are VIVT, these two mapping don't share the same cache
> line and won't see the same data.
> This corruption can be hidden by context switch because cache are flushed on
> context switch.
> 
> On x86 or armv7, the cache are PIPT and there is no such problem.
> 
> 
> 
> There was a commit "pcm - Call pgprot_noncached() for vmalloc'ed buffers"
> (c32d977b8157bf67cdf47729ce7dd054a26eb534), that made the userspace mapping not
> cached, but this caused issues because the kernel vmalloc mapping was still cached.
> 
> Instead of revering this commit, we could have made the kernel vmalloc noncached
> (see attached patch). It fix the issue on armv5.
> 
> But on some architecture (armv7 for example) you can't have mapping for the same
> physical memory cached (normal cached) and noncached (device memory).
> So the vmalloc and userspace mapping will conflict with the kernel direct RAM
> mapping.
> 
> A workaround could be to use writecombine protection instead of noncached.
> This work because writecombine is mapped on armv7 as L_PTE_MT_BUFFERABLE (normal
> uncached) that is compatible with cached memory (the same trick is used for
> dmacoherent).
> But that's architecture specific may not work on others architectures.
> 
> 
> 
> What's the best way the fix this issue on all architecture ?

I don't think there is no proper way to fix in the driver side unless
a generic API for mmappable (noncached or such) vmalloc variant.

A simple workaround for now would be to give an option (either
arch-specific ifdef or Kconfig) to make snd-usb-audio driver using the
normal page allocation instead of vmalloc.


Takashi

> 
> 
> Matthieu
> [2 vmalloc_uncached.diff <text/x-diff (7bit)>]
> commit f3d13b6752e20cdd193d0265cc6b8f1d814dd869
> Author: Matthieu CASTET <matthieu.castet@parrot.com>
> Date:   Wed Jan 30 15:27:00 2013 +0100
> 
>     make snd_pcm_lib_alloc_vmalloc_buffer memory uncached
> 
> diff --git a/sound/core/pcm_memory.c b/sound/core/pcm_memory.c
> index 69e01c4..1740d39 100644
> --- a/sound/core/pcm_memory.c
> +++ b/sound/core/pcm_memory.c
> @@ -425,7 +425,7 @@ int _snd_pcm_lib_alloc_vmalloc_buffer(struct snd_pcm_substream *substream,
>  			return 0; /* already large enough */
>  		vfree(runtime->dma_area);
>  	}
> -	runtime->dma_area = __vmalloc(size, gfp_flags, PAGE_KERNEL);
> +	runtime->dma_area = __vmalloc(size, gfp_flags, pgprot_noncached(PAGE_KERNEL));
>  	if (!runtime->dma_area)
>  		return -ENOMEM;
>  	runtime->dma_bytes = size;
