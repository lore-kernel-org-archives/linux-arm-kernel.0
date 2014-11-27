From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 18:30:58 +0000
Subject: [PATCH v4 2/7] regulator: dt-bindings: Document the ena-gpios
 property
In-Reply-To: <1417087253-12306-3-git-send-email-k.kozlowski@samsung.com>
References: <1417087253-12306-1-git-send-email-k.kozlowski@samsung.com>
 <1417087253-12306-3-git-send-email-k.kozlowski@samsung.com>
Message-ID: <20141127183058.GB7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 12:20:48PM +0100, Krzysztof Kozlowski wrote:

> +- ena-gpios: GPIO to use for enable control. Actual implementation depends
> +  on regulator driver. The bindings documentation for given driver describes
> +  which regulator actually supports it.
> +- ena-gpio-open-drain: GPIO is open drain type.

I'm relly not a big fan of adding a fixed name property here with no
override capability, it means that the naming won't reflect the specific
regulator design so closely and in practice for many of the PMICs the
GPIO control can do rather more than just control enables and supports
reprogramming.  The latter case where we've got a signal which can
sometimes be simply and enable but sometimes more makes it especially
worrying to have the property always be there, it's something that might
work in some configurations but could easily be broken if we try to
exploit more advanced functionality (things also triggering other
configuration changes at the same time).

Factoring out the code is good but it seems better to have it be
something which drivers can control, for example by having them
explicitly specify a property name to use or perhaps a flag to enable
the default name.

We also need an invert option.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/310d8ea9/attachment.sig>
