From: mporter@linaro.org (Matt Porter)
Date: Thu, 17 Apr 2014 18:30:04 -0400
Subject: [PATCH 2/4] mfd: bcm590xx: add support for second i2c slave
 address space
In-Reply-To: <20140416110603.GA19671@lee--X1>
References: <1397501428-8857-1-git-send-email-mporter@linaro.org>
 <1397501428-8857-3-git-send-email-mporter@linaro.org>
 <20140416110603.GA19671@lee--X1>
Message-ID: <20140417223004.GL23695@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 16, 2014 at 12:06:03PM +0100, Lee Jones wrote:
> On Mon, 14 Apr 2014, Matt Porter wrote:
> 
> > BCM590xx utilizes a second i2c slave address to access additional
> 
> s/i2c/I2C
> 
> > register space. Add support for the second address space by
> > instantiated a dummy i2c device with the appropriate secondary
> 
> s/instantiated/instantiating
> 
> > i2c slave address. Expose a second regmap register space so that
> 
> s/i2c/I2C
> 
> Exposing?
> 
> s/regmap/Regmap
> 
> > mfd drivers can access this secondary i2c slave address space.
> 
> s/mfd/MFD
> 
> s/i2c/I2C

Ok, I'll fix the capitalization and wording..except for regmap as
noted by Mark.

> 
> > Signed-off-by: Matt Porter <mporter@linaro.org>
> > ---
> >  drivers/mfd/bcm590xx.c       | 60 +++++++++++++++++++++++++++++++++-----------
> >  include/linux/mfd/bcm590xx.h |  9 ++++---
> >  2 files changed, 52 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/mfd/bcm590xx.c b/drivers/mfd/bcm590xx.c
> > index e9a33c7..b710ffa 100644
> > --- a/drivers/mfd/bcm590xx.c
> > +++ b/drivers/mfd/bcm590xx.c
> > @@ -28,39 +28,71 @@ static const struct mfd_cell bcm590xx_devs[] = {
> >  	},
> >  };
> >  
> > -static const struct regmap_config bcm590xx_regmap_config = {
> > +static const struct regmap_config bcm590xx_regmap_config_0 = {
> 
> Not loving _0 and _1 appendages.
> 
> Is one of them {primary|master} and the other {secondary|slave}?

I guess from a Linux I2C subsystem, we can view _1 as the
"secondary"...it does correspond the the i2c_new_dummy() device
that we create in the mfd probe. That device corresponds to the
ADDMAP=1 address on the PMU. This is why I used those appendages.

-Matt
