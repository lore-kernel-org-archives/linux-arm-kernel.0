From: broonie@kernel.org (Mark Brown)
Date: Tue, 27 Jan 2015 18:59:42 +0000
Subject: [alsa-devel] [PATCH v4 1/3] ASoC: samsung: Add machine driver
 for Trats2
In-Reply-To: <1421989410-12490-2-git-send-email-ideal.song@samsung.com>
References: <1421989410-12490-1-git-send-email-ideal.song@samsung.com>
 <1421989410-12490-2-git-send-email-ideal.song@samsung.com>
Message-ID: <20150127185942.GM21293@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 23, 2015 at 02:03:28PM +0900, Inha Song wrote:
> This patch add the sound machine driver for Trats2 board.
> The codec operate in master mode.

This looks like (and mostly should be) a DTified copy of the littlemill
driver.  The major differences are the fact that this lacks jack
detection, the management of the clock and the fact that instead of
picking a fixed clock frequency this tries to adjust based on
hw_params().  Ideally we'd be able to merge these drivers so we're
keeping up with best practice.

The reason we pick a fixed frequency for littlemill is that the device
supports analogue bypass paths which would be broken otherwise which
will apply here also I imagine.

> +config SND_SOC_SAMSUNG_TRATS2_WM1811
> +	tristate "SoC I2S Audio support for WM1811 on Tizen Trats2 board"
> +	depends on SND_SOC_SAMSUNG
> +	select SND_SAMSUNG_I2S
> +	select MFD_WM8994

For things outside the audio subsystem it's more common to use a depends
instead of a select - the selects are there because the drivers only
work with a machine driver and if we go outside the subsystem then since
selects aren't recursive we end up breaking elsewhere.  For example here
we'll end up not selecting MFD_CORE.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150127/c4a54074/attachment.sig>
