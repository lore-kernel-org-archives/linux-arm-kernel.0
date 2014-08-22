From: broonie@kernel.org (Mark Brown)
Date: Fri, 22 Aug 2014 17:00:56 -0500
Subject: [PATCH v7][ 3/5] video: mx3fb: Introduce regulator support.
In-Reply-To: <5397083D.4090400@eukrea.com>
References: <1394788369-5096-1-git-send-email-denis@eukrea.com>
 <1394788369-5096-3-git-send-email-denis@eukrea.com>
 <20140317062026.GZ17250@pengutronix.de>
 <5397083D.4090400@eukrea.com>
Message-ID: <20140822220056.GE24407@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 10, 2014 at 03:29:33PM +0200, Denis Carikli wrote:
> On 03/17/2014 07:20 AM, Sascha Hauer wrote:

> >This patch adds regulator support for the display of a i.MX3 IPU. The
> >problem Denis has to solve here is that he needs to get the regulator,
> >but the display devicenode doesn't have a struct device associated with
> >it, so he cannot provide one to regulator_get(). One way out here could
> >be a of_regulator_get(struct device_node *). Mark, would this be ok with
> >you?

> Here, the display devicenode has no struct device associated with it like
> mentioned above.
> Because of that, retriving the regulator from the devicetree, for instance
> like regulator_dev_lookup() does, would require a different approach.

> As I understand it, what happen in regulator_dev_lookup when
> regulator_get(NULL, regulator_name) is used is the following:

> Since the struct device is NULL, it skips the struct device based lookup,
> but also the devicetree lookup (it uses dev->of_node for that)
> At the end it falls back on a match on the regulator name to find it.

> would keeping regulator_get(NULL, regulator_name); in the driver instead be
> better for now?

It would be much better to have an actual device to get things for,
using a hard coded regulator name is very much deprecated.  Using a hard
coded name is fragile and we don't have support for mapping this
properly in the device tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140822/16a51093/attachment.sig>
