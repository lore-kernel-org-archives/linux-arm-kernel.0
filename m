From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 1 Oct 2013 23:31:27 +0200
Subject: [PATCH 09/10] pwm-backlight: Use an optional power supply
In-Reply-To: <524B37BF.2090300@wwwdotorg.org>
References: <1379972467-11243-1-git-send-email-treding@nvidia.com>
 <1379972467-11243-10-git-send-email-treding@nvidia.com>
 <524B17ED.1080806@wwwdotorg.org>
 <20131001205310.GD9201@ulmo.nvidia.com>
 <524B37BF.2090300@wwwdotorg.org>
Message-ID: <20131001213120.GG9201@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 01, 2013 at 02:59:43PM -0600, Stephen Warren wrote:
> On 10/01/2013 02:53 PM, Thierry Reding wrote:
> > On Tue, Oct 01, 2013 at 12:43:57PM -0600, Stephen Warren wrote:
> >> On 09/23/2013 03:41 PM, Thierry Reding wrote:
> >>> Many backlights require a power supply to work properly. This
> >>> commit uses a power-supply regulator, if available, to power up
> >>> and power down the panel.
> >> 
> >> I think that all backlights require a power supply, albeit the
> >> supply may not be SW-controllable. Hence, shouldn't the regulator
> >> be mandatory in the binding, yet the driver be defensively coded
> >> such that if one isn't specified, the driver continues to work?
> > 
> > That has already changed in my local version of this patch.
> > 
> >>> diff --git a/drivers/video/backlight/pwm_bl.c
> >>> b/drivers/video/backlight/pwm_bl.c
> >> 
> >>> @@ -253,6 +264,16 @@ static int pwm_backlight_probe(struct
> >>> platform_device *pdev) } }
> >>> 
> >>> +	pb->power_supply = devm_regulator_get_optional(&pdev->dev,
> >>> "power");
> >> 
> >> ... so I think that should be devm_regulator_get(), since the
> >> regulator isn't really optional.
> >> 
> >>> +	if (IS_ERR(pb->power_supply)) { +		if
> >>> (PTR_ERR(pb->power_supply) != -ENODEV) { +			ret =
> >>> PTR_ERR(pb->power_supply); +			goto err_gpio; +		} + +
> >>> pb->power_supply = NULL;
> >> 
> >> If devm_regulator_get_optional() returns an error value or a
> >> valid value, then I don't think that this driver should transmute
> >> error values into NULL; NULL might be a perfectly valid regulator
> >> value. Related, I think the if (pb->power_supply) tests should be
> >> replaced with if (!IS_ERR(pb->power_supply)) instead.
> > 
> > All of that is already done in my local tree. This actually turns
> > out to work rather smoothly with the new support for optional
> > regulators. The regulator core will give you a dummy regulator
> > (assuming it's there physically but hasn't been wired up in
> > software) that's always on, so the driver doesn't even have to
> > special case it anymore.
> 
> OK, hopefully it (the regulator core) complains about the missing DT
> property though; I assume you're using regulator_get() not
> regulator_get_optional(), since the supply really is not optional.

It doesn't always. There's a pr_warn() in _regulator_get(), but that's
only for non-DT (since for DT, has_full_constraints is set to true in
regulator_init_complete()). Actually that would mean that the regulator
core will complain as long as init isn't complete. But since, like many
other drivers, pwm-backlight could use deferred probing it's likely to
end up being probed after init.

Cc'ing Mark Brown.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131001/103e6b89/attachment-0001.sig>
