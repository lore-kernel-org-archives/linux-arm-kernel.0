From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 30 Jan 2015 05:18:56 +0000
Subject: [PATCH v2 1/3] ARM: shmobile: armadillo800eva: Properly specify
 HDMI audio link format
In-Reply-To: <1421847492-8857-1-git-send-email-lars@metafoo.de>
References: <1421847492-8857-1-git-send-email-lars@metafoo.de>
Message-ID: <87d25wg804.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Lars, Simon

> The DAI link format should be specified for the whole link rather than just
> one component on the link. So move the format specification for the HDMI
> audio link from the CPU component to the link itself.
> 
> Since the sh-mobile-hdmi DAI driver doesn't implement the set_fmt() callback
> in this case there is no functional difference between only specifying the
> the format for the CPU side or for the whole link, but the later it will
> allow us to remove support for just specifying the format for one component.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

I tested these 3 patches on armadillo800eva

	[PATCH v2 1/3] ARM: shmobile: armadillo800eva: Properly specify HDMI audio link format
	[PATCH v2 2/3] ASoC: sh: fsi: Fix clock inversion
	[PATCH v2 3/3] ASoC: simple-card: Remove support for setting differing DAI formats

Tested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

2/3 patch changed behavior for clock inversion on FSI driver.
FSI + wm8978 on armadillo800eva worked without any issues,
but, I don't know how much effect it has for other board.
We used this inversion flags on each board for historical reasons (copy-paste),
but, almost all these were not needed (except some picky board) on FSI.
Maybe Lars's 2/3 patch is correct, but, it is difficult to check/confirm for all boards.
And unfortunately, Renesas don't use FSI anymore.
So, I think keeping current FSI driver as-is is more safety for old boards.
armadillo800eva works well with below patch (as 2/3 patch)

--------------
diff --git a/arch/arm/mach-shmobile/board-armadillo800eva.c b/arch/arm/mach-shmobile/board-armadillo800eva.c
index 75de26c..36aaeb1 100644
--- a/arch/arm/mach-shmobile/board-armadillo800eva.c
+++ b/arch/arm/mach-shmobile/board-armadillo800eva.c
@@ -1015,7 +1015,6 @@ static struct asoc_simple_card_info fsi_wm8978_info = {
        .platform       = "sh_fsi2",
        .daifmt         = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_CBM_CFM,
        .cpu_dai = {
-               .fmt    = SND_SOC_DAIFMT_IB_NF,
                .name   = "fsia-dai",
        },
        .codec_dai = {
--------------
