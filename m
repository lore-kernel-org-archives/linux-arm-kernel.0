From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 8 Jun 2012 06:10:24 +0800
Subject: [PATCH v1 3/5] ASOC: mmp: add sspa support
In-Reply-To: <1338791851-21038-4-git-send-email-zhangfei.gao@marvell.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-4-git-send-email-zhangfei.gao@marvell.com>
Message-ID: <20120607221019.GA14525@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2012 at 02:37:29PM +0800, Zhangfei Gao wrote:
> The SSPA is a configurable multi-channel audio serial (TDM) interface.
> It's configurable at runtime to support up to 128 channels and the
> number of bits per sample: 8, 12, 16, 20, 24 and 32 bits. It also
> support stereo format: I2S, left-justified or right-justified.

This looks mostly good (though you want to check your indentation a bit)
but...

> +static int __init mmp_sspa_modinit(void)
> +{
> +	audio_clk = clk_get(NULL, "mmp-audio");
> +	if (IS_ERR(audio_clk))
> +		return PTR_ERR(audio_clk);
> +
> +	sysclk = clk_get(NULL, "mmp-sysclk");
> +	if (IS_ERR(sysclk))
> +		return PTR_ERR(sysclk);
> +	clk_enable(audio_clk);

You should be doing this stuff from the driver, not from the module init
(and ideally you'd be managing the audio clock dynamically).  Even if
it's the same clock every time in current silicon it's still a good idea
to do this from a quality of implementation point of view.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120608/7c7f2870/attachment-0001.sig>
