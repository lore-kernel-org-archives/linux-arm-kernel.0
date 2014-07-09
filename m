From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Wed, 09 Jul 2014 19:20:05 +0200
Subject: [alsa-devel] [PATCH V3 2/2] ASoC: samsung: Add machine driver for
 Odroid X2/U3
In-Reply-To: <CAD8Lp44JFtbcD22c+0PVb5S4U1kVTTxHD=PgqiKzhVypFW5Prg@mail.gmail.com>
References: <1404479625-25385-1-git-send-email-s.nawrocki@samsung.com>
 <1404479625-25385-2-git-send-email-s.nawrocki@samsung.com>
 <CAD8Lp44JFtbcD22c+0PVb5S4U1kVTTxHD=PgqiKzhVypFW5Prg@mail.gmail.com>
Message-ID: <53BD79C5.3060604@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 08/07/14 11:15, Daniel Drake wrote:
> On Fri, Jul 4, 2014 at 2:13 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> This patch adds the sound subsystem driver for Odroid-X2 and
>> Odroid-U3 boards. The codec works in I2S master mode; there
>> are two separate audio routing paths defined, as there are
>> differences in the signal routing between the X2 and U3 boards,
>> i.e. U3 uses single jack for headphones and microphone.
>>
>> Signed-off-by: Chen Zhen <zhen1.chen@samsung.com>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> 
> Testing on ODROID-U2, v3 is not quite working for me, but v2 of the
> patch was fine.
> I boot up, run:
> # speaker-test -c 2 -t wav
> 
> As soon as I hear the word "front" I press ctrl+c and then run the
> command again.
> Now the command hangs with no audible output.
> 
> Any ideas? Let me know if you have trouble reproducing.

Thanks the feedback, we have also noticed this issue.
It sounds like a bug in the Samsung I2S driver, which sets the
CDCLK pin to input mode in the i2s_shutdown callback and never
restores it. AFAICS this setting should not be lost after a call
to struct soc_snd_dai_ops::shutdown().
I'm going will prepare a proper patch soon, until then you could
try and see if this fixes the problem for you:

---8<---
diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index d80121e..42c4f3e 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -724,10 +724,6 @@ static void i2s_shutdown(struct snd_pcm_substream *substream,

        spin_unlock_irqrestore(&lock, flags);

-       /* Gate CDCLK by default */
-       if (!is_opened(other))
-               i2s_set_sysclk(dai, SAMSUNG_I2S_CDCLK,
-                               0, SND_SOC_CLOCK_IN);
 }
--->8---

--
Thanks,
Sylwester
