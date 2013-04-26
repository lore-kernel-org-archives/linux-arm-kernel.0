From: tiwai@suse.de (Takashi Iwai)
Date: Fri, 26 Apr 2013 07:40:00 +0200
Subject: [PATCH 06/21] ALSA: ali5451: use mdelay instead of large udelay
 constants
In-Reply-To: <1366910944-3033663-7-git-send-email-arnd@arndb.de>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <1366910944-3033663-7-git-send-email-arnd@arndb.de>
Message-ID: <s5hy5c597f3.wl%tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At Thu, 25 Apr 2013 19:28:49 +0200,
Arnd Bergmann wrote:
> 
> ARM cannot handle udelay for more than 2 miliseconds, so we
> should use mdelay instead for those.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Takashi Iwai <tiwai@suse.de>
> Cc: alsa-devel at alsa-project.org

Thanks, applied to sound git tree.


Takashi


> ---
>  sound/pci/ali5451/ali5451.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/pci/ali5451/ali5451.c b/sound/pci/ali5451/ali5451.c
> index e760af9..53754f5 100644
> --- a/sound/pci/ali5451/ali5451.c
> +++ b/sound/pci/ali5451/ali5451.c
> @@ -451,10 +451,10 @@ static int snd_ali_reset_5451(struct snd_ali *codec)
>  	if (pci_dev) {
>  		pci_read_config_dword(pci_dev, 0x7c, &dwVal);
>  		pci_write_config_dword(pci_dev, 0x7c, dwVal | 0x08000000);
> -		udelay(5000);
> +		mdelay(5);
>  		pci_read_config_dword(pci_dev, 0x7c, &dwVal);
>  		pci_write_config_dword(pci_dev, 0x7c, dwVal & 0xf7ffffff);
> -		udelay(5000);
> +		mdelay(5);
>  	}
>  	
>  	pci_dev = codec->pci;
> @@ -463,14 +463,14 @@ static int snd_ali_reset_5451(struct snd_ali *codec)
>  	udelay(500);
>  	pci_read_config_dword(pci_dev, 0x44, &dwVal);
>  	pci_write_config_dword(pci_dev, 0x44, dwVal & 0xfffbffff);
> -	udelay(5000);
> +	mdelay(5);
>  	
>  	wCount = 200;
>  	while(wCount--) {
>  		wReg = snd_ali_codec_peek(codec, 0, AC97_POWERDOWN);
>  		if ((wReg & 0x000f) == 0x000f)
>  			return 0;
> -		udelay(5000);
> +		mdelay(5);
>  	}
>  
>  	/* non-fatal if you have a non PM capable codec */
> -- 
> 1.8.1.2
> 
