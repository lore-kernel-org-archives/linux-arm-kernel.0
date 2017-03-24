From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Mar 2017 12:54:38 +0000
Subject: [RFC 5/8] regulator: anatop: fix min dropout for bypass mode
In-Reply-To: <cd944a7223cfe68788c299082a5f262e8bea2136.1490199005.git.leonard.crestez@nxp.com>
References: <cover.1490199005.git.leonard.crestez@nxp.com>
 <cd944a7223cfe68788c299082a5f262e8bea2136.1490199005.git.leonard.crestez@nxp.com>
Message-ID: <20170324125438.5wy3r2mr3g5eaxvy@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 06:53:07PM +0200, Leonard Crestez wrote:

> +	if (anatop_reg->bypass)
> +		anatop_reg->rdesc.min_dropout_uV = 0;
> +	else
> +		anatop_reg->rdesc.min_dropout_uV = LDO_MIN_DROPOUT_UV;

No, this is completely broken - you can't expect to randomly change hthe
regulator description at runtime behind the back of the framework and
expect things to work.  If there is a need to do this we need an
interface for getting the current value and a way to notify of changes.

That said I would not expect the dropout voltage to be considered at
all when the regulator is bypassed, since the regulator is not
regulating it doesn't need any headroom.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170324/10f882db/attachment-0001.sig>
