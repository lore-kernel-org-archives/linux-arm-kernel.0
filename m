From: liam.r.girdwood@linux.intel.com (Liam Girdwood)
Date: Wed, 28 Oct 2015 08:34:25 +0000
Subject: [PATCH] ASoC: dpcm: Make BE prepare possible in suspend state
In-Reply-To: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
References: <1445998534-38246-1-git-send-email-koro.chen@mediatek.com>
Message-ID: <1446021265.2443.3.camel@loki>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2015-10-28 at 10:15 +0800, Koro Chen wrote:
> During suspend/resume, there is a flow that if a driver does not support
> SNDRV_PCM_INFO_RESUME, it will fail at snd_pcm_resume(), and user space
> can then issue SNDRV_PCM_IOCTL_PREPARE to let audio continue to play.
> 
> However, in dpcm_be_dai_prepare() it only allows BEs to be prepared
> in state SND_SOC_DPCM_STATE_HW_PARAMS or SND_SOC_DPCM_STATE_STOP.
> The BE state will then stay in SND_SOC_DPCM_STATE_SUSPEND, consequently
> dpcm_be_dai_shutdown() is skipped in the end of playback and
> be_substream->runtime is not cleared while this runtime is actually freed
> by snd_pcm_detach_substream(). If another suspend comes, a NULL pointer
> dereference will happen in snd_pcm_suspend() when accessing
> BE substream's runtime.
> 
> Signed-off-by: Koro Chen <koro.chen@mediatek.com>

Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
