From: broonie@kernel.org (Mark Brown)
Date: Wed, 26 Oct 2016 18:50:52 +0100
Subject: [PATCH 02/12] ASoC: dapm: Implement stereo mixer control support
In-Reply-To: <20161003110804.28235-3-wens@csie.org>
References: <20161003110804.28235-1-wens@csie.org>
 <20161003110804.28235-3-wens@csie.org>
Message-ID: <20161026175052.GE25322@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 03, 2016 at 07:07:54PM +0800, Chen-Yu Tsai wrote:

>  	/* find dapm widget path assoc with kcontrol */
>  	dapm_kcontrol_for_each_path(path, kcontrol) {
> +		/*
> +		 * If status for the second channel was given ( >= 0 ),
> +		 * consider the second and later paths as the second
> +		 * channel.
> +		 */
> +		if (found && rconnect >= 0)
> +			soc_dapm_connect_path(path, rconnect, "mixer update");
> +		else
> +			soc_dapm_connect_path(path, connect, "mixer update");
>  		found = 1;
> -		soc_dapm_connect_path(path, connect, "mixer update");

This really only works for two channels with the current inteface - the
comment makes it sound like it'll work for more but we can only pass in
two (and there's only support for specifying two everywhere).

> -	change = dapm_kcontrol_set_value(kcontrol, val);
> +	/* This assumes field width < (bits in unsigned int / 2) */
> +	change = dapm_kcontrol_set_value(kcontrol, val | (rval << width));

That seems like a bit of an assumption in cases where we've got a single
control for both power and volume?  They're very rare though, I'm not
even sure any exist.  It'd be good to have a check in the code just in
case it does come up, it'll likely be a nightmare to debug if someone
does run into it.

Otherwise I think this makes sense.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161026/6a7d0d11/attachment.sig>
