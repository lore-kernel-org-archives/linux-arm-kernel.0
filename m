From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Mar 2012 13:29:53 +0000
Subject: [PATCH v6 2/2] Regulator: Add Anatop regulator driver
In-Reply-To: <20120304065145.GD10743@S2101-09.ap.freescale.net>
References: <1330593052-15184-1-git-send-email-paul.liu@linaro.org>
 <1330671641-6439-1-git-send-email-paul.liu@linaro.org>
 <1330671641-6439-2-git-send-email-paul.liu@linaro.org>
 <20120304065145.GD10743@S2101-09.ap.freescale.net>
Message-ID: <20120304132953.GB3083@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 04, 2012 at 02:51:48PM +0800, Shawn Guo wrote:

> > +	sreg = devm_kzalloc(dev, sizeof(struct anatop_regulator), GFP_KERNEL);
> > +	if (!sreg)
> > +		return -EINVAL;
> > +	rdesc = devm_kzalloc(dev, sizeof(struct regulator_desc), GFP_KERNEL);
> > +	if (!rdesc)
> > +		return -EINVAL;

> Would something like the following be better?

> 	sreg = devm_kzalloc(dev, sizeof(*sreg) + sizeof(*rdesc), GFP_KERNEL);
> 	if (!sreg)
> 		return -ENOMEM;
> 	rdesc = (struct regulator_desc *)(sreg + 1);

No, that sort of pointer arithmetic would be much worse - it's harder to
read and more likely to break.  However, embedding the regulator_desc in
sreg would achieve the same result without the legibility issues.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120304/81dfb3ad/attachment.sig>
