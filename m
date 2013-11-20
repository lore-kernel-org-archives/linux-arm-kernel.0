From: Li.Xiubo@freescale.com (Li Xiubo)
Date: Wed, 20 Nov 2013 03:37:45 +0000
Subject: [PATCHv2 1/8] ALSA: Add SAI SoC Digital Audio Interface driver.
In-Reply-To: <20131104043338.GA2345@MrMyself>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-2-git-send-email-Li.Xiubo@freescale.com>
 <20131101085904.GC28401@MrMyself>
 <1DD289F6464F0949A2FCA5AA6DC23F82874201@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131104043338.GA2345@MrMyself>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828AE980@039-SN2MPN1-012.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> The udelay just doesn't make sense to what you are talking about.
> 
> Does SAI really need 10us delay between two register-updating?
> 

No, this is not must be.

> We basically use udelay only if the IP hardware actually needs it: some
> IP needs time to boot itself up after doing software reset for example.
> But it doesn't look reasonable to me by using udelay to make sure "the
> last enabled".
> 
> And from the 'Synchronous mode' you just provided, there're another issue:
> 
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		tcsr |= FSL_SAI_CSR_TERE;
> +		rcsr |= FSL_SAI_CSR_TERE;
> +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> +		udelay(10);
> +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> +		break;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		if (!(dai->playback_active || dai->capture_active)) {
> +			tcsr &= ~FSL_SAI_CSR_TERE;
> +			rcsr &= ~FSL_SAI_CSR_TERE;
> +		}
> +		writel(rcsr, sai->base + FSL_SAI_RCSR);
> +		udelay(10);
> +		writel(tcsr, sai->base + FSL_SAI_TCSR);
> +		break;
> 
> ISSUE 1: You might make sure transmitter is the last enabled.
> 	 However, it's not the first disabled. Is this okay?
> 

Yes, this is just programming mistake. I'll revise it.

In this case the transmitter should be the last enabled and the first disabled.


> ISSUE 2: There are two cases listed in 'Synchronous mode'.
> 	 However, your driver doesn't take care of them.
> 	 The SAI's synchronous mode looks like more flexible
> 	 than SSI's. The driver needs to be more sophisticated
> 	 so that it can handle multiple cases when TX/RX clocks
> 	 are controlled by either TX or RX, and surely, the
> 	 asynchronous mode as well.
> 

Because in Vybrid the transmitter bit clock and frame sync are to be used by both the transmitter and receiver, and only this case can be used here, so now I only handle this case.

> 
> And there's another personal tip: I think you can first try to focus on
> this SAI driver and pend the others. There might be two many things you
> need to refine if you are doing them at the same time.
> 

I'll implement them later if needed.


--
Best Regards,
Xiubo
