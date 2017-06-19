From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 19 Jun 2017 13:57:20 +0200
Subject: [PATCH v2 12/12] ASoC: Fix use-after-free at card unregistration
In-Reply-To: <s5hefug72iu.wl-tiwai@suse.de> (Takashi Iwai's message of "Mon,
 19 Jun 2017 11:25:13 +0200")
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de>
Message-ID: <87injstckf.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Takashi Iwai <tiwai@suse.de> writes:

> On Mon, 19 Jun 2017 09:27:09 +0200,
> Robert Jarzmik wrote:
>> 
>> From: Takashi Iwai <tiwai@suse.de>
>> 
>> soc_cleanup_card_resources() call snd_card_free() at the last of its
>> procedure.  This turned out to lead to a use-after-free.
>> PCM runtimes have been already removed via soc_remove_pcm_runtimes(),
>> while it's dereferenced later in soc_pcm_free() called via
>> snd_card_free().
>> 
>> The fix is simple: just move the snd_card_free() call to the beginning
>> of the whole procedure.  This also gives another benefit: it
>> guarantees that all operations have been shut down before actually
>> releasing the resources, which was racy until now.
>> 
>> Reported-and-tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
>
> This patch must be superfluous :)
Haha :)

My serie shifted by one, so the very first of the serie is therefore missing,
formerly "ALSA: ac97: split out the generic ac97 registers" in
https://patchwork.kernel.org/patch/9398143/, and the shift triggered the
inclusion of the last patch of my tree, ie. yours :)

Cheers.

--
Robert
