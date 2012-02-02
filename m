From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 2 Feb 2012 13:32:08 +0000
Subject: [RFC 7/7] MFD: TWL6040: Add regulator support for VIO, V2V1
 supplies
In-Reply-To: <4F2A8D11.9010705@ti.com>
References: <1328185019-29575-1-git-send-email-peter.ujfalusi@ti.com>
 <1328185019-29575-8-git-send-email-peter.ujfalusi@ti.com>
 <20120202125250.GJ7428@opensource.wolfsonmicro.com>
 <4F2A8D11.9010705@ti.com>
Message-ID: <20120202133207.GN7428@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2012 at 03:18:09PM +0200, Peter Ujfalusi wrote:
> On 02/02/2012 02:52 PM, Mark Brown wrote:

> > Looks like you want regulator_bulk_get() here.  Or (better yet though
> > it'd be a potential issue for merge via MFD and the benefits aren't that
> > exciting since you still need to disable) devm_regulator_bulk_get().

> I need separate control for the two power source since we can hit
> different power levels depending on which is powered/not powered:
> power down: vio, v2v1 is OFF
> deep sleep: vio is ON, v2v1 is OFF
> sleep/power on: vio, v2v1 is ON

> And we have certain sequence to move between power states.

That's not a problem for using the bulk get - the array is part of the
API so you can use regulator_bulk_get() and still look at individual
supplies within the array later on when enabling and disabling them.

> >> +	ret = regulator_enable(twl6040->vio);
> >> +	if (ret != 0) {
> >> +		dev_err(&client->dev, "Failed to enable VIO: %d\n", ret);
> >> +		goto power_err;
> >> +	}
> >> +	ret = regulator_enable(twl6040->v2v1);
> >> +	if (ret != 0) {
> >> +		dev_err(&client->dev, "Failed to enable V2V1: %d\n", ret);
> >> +		regulator_disable(twl6040->vio);

> I disable the vio here, if the v2v1 enable fails.

Oh, that's quite confusing when mixed in with the goto/unwind - it'd be
clearer to have the extra lable to jump to.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120202/f817d7b4/attachment.sig>
