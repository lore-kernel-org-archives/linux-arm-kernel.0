From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 21 May 2015 14:59:14 +0200
Subject: prealloc_buffer_size and buffer_bytes_max
In-Reply-To: <555DCF69.9090008@lysator.liu.se>
References: <555DCF69.9090008@lysator.liu.se>
Message-ID: <20150521125914.GA30345@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 21/05/2015 at 14:28:25 +0200, Peter Rosin wrote :
> I got my hopes up when I read the commit message for c14e2591bf54
> ASoC: atmel-pcm-dma: increase buffer_bytes_max. Quoting it:
> 
> 	atmel-pcm-dma is not limited to a buffer size of 64kB like
> 	atmel-pcm-pdc. Increase buffer_bytes_max to 512kB to allow
> 	for higher bit rates (i.e. 32bps at 192kHz) to work correctly.
> 	By default, keep the prealloc at 64kB.
> 
> However, as I (think I) request a bigger buffer it still caps out at 64kB.
> I'm using the latency argument of snd_pcm_set_params to control the buffer:
> 
> 	snd_pcm_set_params(pcm,
> 		SND_PCM_FORMAT_S32_LE,
> 		SND_PCM_ACCESS_RW_INTERLEAVED,
> 		2,      /* channels */
> 		250000, /* rate */
> 		0,      /* do not resample */
> 		90000); /* latency in us */
> 
> But snd_pcm_hw_params_get_buffer_size "only" returns 8192 frames (64kB)
> even if I request 9us * 250kHz * 2 * 4 = 180kB. If I change the prealloc
> from 64kB to 256kB I get a bigger buffer (and it works better too!).
> 
> Admittedly I backported this patch on top of the linux-3.18-at91
> branch from the Atmel git repo, so there might be some support
> missing that has gone in after 3.18?
> 
> Or have I completely misunderstood, and these are unrelated buffers?
> 

Those are somewhat related but not the same.

> Any insight in how I can get a big enough buffer without hacking the
> prealloc is appreciated!
>

You can change the prealloc size in
/proc/asound/card0/pcm0p/sub0/prealloc or by using
snd_pcm_lib_preallocate_pages_for_all(). I never experienced the issue
but what I did solved it for someone doing 32bits per sample at 192kHz.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
