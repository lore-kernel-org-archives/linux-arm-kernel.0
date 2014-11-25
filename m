From: broonie@kernel.org (Mark Brown)
Date: Tue, 25 Nov 2014 11:05:41 +0000
Subject: [RFC PATCH] regulator: core: do not disable regulator if boot_on
 is set
In-Reply-To: <1416912803-10772-1-git-send-email-pramod.gurav@smartplayin.com>
References: <1416912803-10772-1-git-send-email-pramod.gurav@smartplayin.com>
Message-ID: <20141125110540.GL7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 04:23:23PM +0530, Pramod Gurav wrote:
> Currently the regulator core disables the regulators which are unused
> or whose reference count is zero or if they are configured always_on.

No, it does *not* disable them if they are configured always_on (as the
code you're modifying shows).

> This change adds a check in this logic to see if a regulator is
> configured as boot_on and does not disable it if found true.

> -		if (c && c->always_on)
> +		if (c && (c->always_on || c->boot_on))
>  			continue;

This isn't what boot_on means.  It just means that the regulator is
expected to be enabled at initial power on, it doesn't mean it needs to
be enabled all the time.  Otherwise there'd be no point in having a
separate always_on flag.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141125/684aa272/attachment.sig>
