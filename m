From: broonie@kernel.org (Mark Brown)
Date: Thu, 24 Apr 2014 14:34:51 +0100
Subject: [RESEND PATCH] regulator: core: Disable unused regulators after
 deferred probing is done
In-Reply-To: <1398294650-24821-1-git-send-email-nm@ti.com>
References: <1398294650-24821-1-git-send-email-nm@ti.com>
Message-ID: <20140424133451.GZ12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 06:10:50PM -0500, Nishanth Menon wrote:
> From: Saravana Kannan <skannan@codeaurora.org>
> 
> regulator_init_complete does a scan of regulators which dont have
> always-on or consumers are automatically disabled as being unused.
> However, with deferred probing, late_initcall() is too soon to
> declare a regulator as unused as the regulator itself might not
> have registered due to defferal - Example: A regulator deffered due
> to i2bus not available which in turn is deffered due to pinctrl
> availability.
> 
> Since deferred probing is done in late_initcall(), do the cleanup of
> unused regulators by regulator_init_complete in late_initcall_sync
> instead of late_initcall.

I'll apply this however since as we discussed on IRC last night it's
going to make the issues with unconfigured regulators getting powered
off more severe before I do so I'll change things so that regulators
with no configuration at all don't get touched by the core.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/ba3ce5f6/attachment.sig>
