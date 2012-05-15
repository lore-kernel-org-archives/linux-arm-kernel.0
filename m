From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 15 May 2012 19:27:41 +0100
Subject: [PATCH 2/4] ASoC: Add mc13783 codec
In-Reply-To: <1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
References: <1337082832-9764-1-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-2-git-send-email-philippe.retornaz@epfl.ch>
 <1337082832-9764-3-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20120515182737.GF19592@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 01:53:50PM +0200, Philippe R?tornaz wrote:
> 
> Signed-off-by: Philippe R?tornaz <philippe.retornaz@epfl.ch>

This looks broadly good from a framework point of view but it's a bit
depressing that there are so many magic numbers even for register names
- it makes the code rather impenetrable and I wouldn't like to be
maintaining it.  I'll go ahead and apply it if Samuel is OK with patch 1
going via ASoC (there's a build dependency).

A few smallish things, please fix incrementally (or roll into a new
version if you're resubmitting for some reason):

> +	snd_soc_add_codec_controls(codec, mc13783_control_list,
> +					ARRAY_SIZE(mc13783_control_list));
> +
> +	snd_soc_dapm_new_controls(dapm, mc13783_dapm_widgets,
> +					ARRAY_SIZE(mc13783_dapm_widgets));
> +	snd_soc_dapm_add_routes(dapm, mc13783_routes,
> +					ARRAY_SIZE(mc13783_routes));

These should all be assigned in the CODEC driver structure.

> +static __init int mc13783_init(void)
> +{
> +	return platform_driver_register(&mc13783_codec_driver);
> +}
> +
> +static __exit void mc13783_exit(void)
> +{
> +	platform_driver_unregister(&mc13783_codec_driver);
> +}
> +
> +module_init(mc13783_init);
> +module_exit(mc13783_exit);

module_platform_driver().
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120515/f884de98/attachment.sig>
