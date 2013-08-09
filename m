From: broonie@kernel.org (Mark Brown)
Date: Fri, 9 Aug 2013 11:27:57 +0100
Subject: Proposal: I2C device power (Was: hwmon: (lm90) Add power control)
In-Reply-To: <1376027820.695103970@f416.i.mail.ru>
References: <1375944991-29182-1-git-send-email-wni@nvidia.com>
 <20130808211825.GN6427@sirena.org.uk> <52040DE2.50201@roeck-us.net>
 <1376027820.695103970@f416.i.mail.ru>
Message-ID: <20130809102757.GT6427@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 09, 2013 at 09:57:00AM +0400, Alexander Shiyan wrote:

> Instead of adding the support of regulators in each device, let's think about
> whether it is possible to create a global regulator for any device on the I2C bus.

> I see it like this:
> We add an extra field in the i2c_board_info structure "power_name" and handle
> it in the i2c_device_{probe/remove} functions.

This would need to be an array of supplies, relatively few devices need
only a single power supply.  This is also not something that should be
handled in I2C, power is not something that's uniquely needed by devices
on an I2C bus.

> The question remains how to maintain such regulator in the PM functions,
> but we can discuss it.

Well, there's some basic stuff for this for clocks already - a similar
pattern should work.  You need to use runtime PM to hook in the power
management and it's not going to work for everything (especially things
that can be wake sources) but there's some value in trying to factor out
the basic use case.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130809/a404b149/attachment.sig>
