From: broonie@kernel.org (Mark Brown)
Date: Fri, 12 Jul 2013 12:45:51 +0100
Subject: [PATCH v5 1/7] sound: codec: wm8731: add rates constraints
In-Reply-To: <1373559359-31607-2-git-send-email-richard.genoud@gmail.com>
References: <1373559359-31607-1-git-send-email-richard.genoud@gmail.com>
 <1373559359-31607-2-git-send-email-richard.genoud@gmail.com>
Message-ID: <20130712114551.GD24508@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 11, 2013 at 06:15:53PM +0200, Richard Genoud wrote:

Please always try to use commit logs that look like normal commit logs
for the subsystem.

>  	switch (freq) {
> -	case 11289600:
>  	case 12000000:
> +		wm8731->constraints = &wm8731_constraints_12000000;
> +		break;
>  	case 12288000:
> -	case 16934400:
>  	case 18432000:
> -		wm8731->sysclk = freq;
> +		wm8731->constraints = &wm8731_constraints_12288000_18432000;
> +		break;
> +	case 16934400:
> +	case 11289600:
> +		wm8731->constraints = &wm8731_constraints_11289600_16934400;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}

This isn't going to work with systems which have a variable clock as the
input to the CODEC.  If it's imposing constraints the driver needs to
allow setting the clock to zero as a way of removing constraints (and
any existing drivers should be updated to do this if needed).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130712/f6b906da/attachment.sig>
