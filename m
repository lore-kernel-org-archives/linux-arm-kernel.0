From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 Sep 2009 11:44:17 +0100
Subject: [PATCH 03/10] S3C64XX I2S: Codec Clock Gating Option
In-Reply-To: <1253008955-10505-1-git-send-email-jassi.brar@samsung.com>
References: <1253008955-10505-1-git-send-email-jassi.brar@samsung.com>
Message-ID: <20090915104417.GF22878@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 07:02:35PM +0900, Jassi wrote:
> In SoC-Master mode, CODCLK maybe gated out as MCLK of the CODEC.
> In SoC-Slave mode, CODCLK needs to be cut-off from PAD inorder
> to avoid collision with MCLK from CODEC.
> Option to gate/block CODCLK is implemented in this patch.

Just to confuse matters the datasheet appears to use both CODCLK and
CDCLK to refer to the same signal (as far as I can tell, anyway -
there's only a couple of references to CODCLK).  The drivers are
currently using CDCLK as the name, it'd be better to stick with just
one.

In terms of functionality it might be clearer to describe what's going
on here as switching the function of CDCLK from being an input to being
an output.  The actual implementation appears to be done by gating the
output of the internal clock signal to the CDCLK pin but in terms of
what the user can see externally the clock isn't gated, it's still
active but it changed direction.

> +#define S3C64XX_IISMOD_CDCLK_EXT	(1 << 12)
> +

The datasheet calls this bit CDLKCON - it'd be better to preserve that
naming unless there is a good reason to diverge?

> @@ -99,6 +99,14 @@ static int s3c64xx_i2s_set_sysclk(struct snd_soc_dai *cpu_dai,
>  		iismod |= S3C64XX_IISMOD_IMS_SYSMUX;
>  		break;
>  
> +	case S3C64XX_CODCLKSRC_INT:
> +		iismod &= ~S3C64XX_IISMOD_CDCLK_EXT;
> +		break;
> +
> +	case S3C64XX_CODCLKSRC_EXT:
> +		iismod |= S3C64XX_IISMOD_CDCLK_EXT;
> +		break;
> +

This should really be done using the direction parameter - clk_id should
specify that CDCLK should be used and the direction parameter be used to
say if it's an input or output.

Ideally this would also be more joined up with the rest of the
configuration so the machine driver could just specify the master clock
for the IIS block and have all the clock switching (the system
controller mux and IMS) updated appropriately.  That should make it
easier for users to set up the clocking since they don't need to worry
about the implementation details of the IIS block.
