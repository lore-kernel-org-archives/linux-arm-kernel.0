From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 30 Aug 2012 10:43:18 -0700
Subject: [PATCH] ASoC: SAMSUNG: Add SND_SOC_DAIFMT_CONT option for
 snd_soc_set_fmt()
In-Reply-To: <001d01cd85d6$59298040$0b7c80c0$@samsung.com>
References: <003101cd8367$3476e650$9d64b2f0$@samsung.com>
 <20120827204550.GA4400@opensource.wolfsonmicro.com>
 <001d01cd85d6$59298040$0b7c80c0$@samsung.com>
Message-ID: <20120830174317.GG4356@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 08:06:32PM +0900, Sangsu Park wrote:

Please check your mailer configuration, it looks like it's reformatting
all the text with much longer line widths.

> On Sun, Aug 26, 2012 at 05:45:54PM +0900, Mark Brown wrote:

> > a whole lot of sense on the slave side, it's related to the clock generation so should have no
> > effect at all on the slave side.  The driver code looks reasonably sensible though.

> You mean cpu side is slave? 

Yes.


> > What specifically is going wrong here?

> SND_SOC_DAIFMT_CONT is used sound/soc/Samsung/pcm.c (s3c_pcm_set_fmt()) like below.

> switch (fmt & SND_SOC_DAIFMT_CLOCK_MASK) {
>         case SND_SOC_DAIFMT_CONT:
>                 pcm->idleclk = 1;
>                 break;
>         case SND_SOC_DAIFMT_GATED:
>                 pcm->idleclk = 0;
>                 break;
>         default:
>                 dev_err(pcm->dev, "Invalid Clock gating request!\n");
>                 ret = -EINVAL;
>                 goto exit;
>         }

> If fmt argument has no SND_SOC_DAIFMT_ option, s3c_pcm_set_fmt() return -EINVAL.

So, clearly this is unrelated to the change you mentioned in your commit
message - it looks like this is just a plain issue in the machine
driver.  That said the above code should be changed to at least ignore
the setting in slave mode (since the clock shouldn't be being driven and
it doesn't matter).
