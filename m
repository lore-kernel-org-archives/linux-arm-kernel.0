From: tiwai@suse.de (Takashi Iwai)
Date: Mon, 06 Aug 2018 21:37:52 +0200
Subject: [alsa-devel] [PATCH 9/9] ALSA: intel_hdmi: remove redundant
 variable cfg_val
In-Reply-To: <a5a408bc-cc58-946e-5b36-496548a6316f@linux.intel.com>
References: <20180801104742.4328-1-colin.king@canonical.com>
 <20180801104742.4328-10-colin.king@canonical.com>
 <s5hin4unyh0.wl-tiwai@suse.de>
 <a5a408bc-cc58-946e-5b36-496548a6316f@linux.intel.com>
Message-ID: <s5hwot3gub3.wl-tiwai@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 06 Aug 2018 20:37:53 +0200,
Pierre-Louis Bossart wrote:
> 
> On 8/1/18 6:00 AM, Takashi Iwai wrote:
> > On Wed, 01 Aug 2018 12:47:42 +0200,
> > Colin King wrote:
> >>
> >> From: Colin Ian King <colin.king@canonical.com>
> >>
> >> Variable cfg_val is being assigned but is never used hence it is
> >> redundant and can be removed.
> >>
> >> Cleans up clang warning:
> >> warning: variable 'cfg_val' set but not used [-Wunused-but-set-variable]
> >>
> >> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> >> ---
> >>   sound/x86/intel_hdmi_audio.c | 2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
> >> index edc9f5a34eff..fa7dca5a68c8 100644
> >> --- a/sound/x86/intel_hdmi_audio.c
> >> +++ b/sound/x86/intel_hdmi_audio.c
> >> @@ -290,7 +290,6 @@ static void had_reset_audio(struct snd_intelhad *intelhaddata)
> >>   static int had_prog_status_reg(struct snd_pcm_substream *substream,
> >>   			struct snd_intelhad *intelhaddata)
> >>   {
> >> -	union aud_cfg cfg_val = {.regval = 0};
> >>   	union aud_ch_status_0 ch_stat0 = {.regval = 0};
> >>   	union aud_ch_status_1 ch_stat1 = {.regval = 0};
> >>   @@ -298,7 +297,6 @@ static int had_prog_status_reg(struct
> >> snd_pcm_substream *substream,
> >>   					  IEC958_AES0_NONAUDIO) >> 1;
> >>   	ch_stat0.regx.clk_acc = (intelhaddata->aes_bits &
> >>   					  IEC958_AES3_CON_CLOCK) >> 4;
> >> -	cfg_val.regx.val_bit = ch_stat0.regx.lpcm_id;
> >
> > Actually this made me wonder what is the definition of val_bit.
> > It seems always 1 in the current code after the commit 964ca8083c02.
> > Pierre?
> 
> This val_bit is only there for debug/test, it should be set to one by
> default and has nothing to do with the lpcm_id. This variable was set
> even in patches before upstream submission and was never needed, I
> guess it must be a 9-yr old issue. Good catch!
> 
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Good to hear, applied the patch now.

> BTW looking at the structures in intel_hdmi_lpe_audio.h, the field
> format:3 in audio_ch_status_0 is misleading at best, it should be the
> emphasis if I look at the SPDIF/AES docs. It's not used but I'll have
> to relook at all this when I find some time... We should really set
> the registers to mirror what the aes_bits are, not just the non_audio
> and clock accuracy fields.

A fix patch is always welcome ;)


Takashi
