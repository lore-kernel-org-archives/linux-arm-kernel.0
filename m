From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 21 Mar 2013 17:21:33 -0300
Subject: [PATCH 06/16] thermal: mvebu: Convert to devm_ioremap_resource()
In-Reply-To: <20130321191751.GP4977@n2100.arm.linux.org.uk>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1363818997-23137-7-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321191751.GP4977@n2100.arm.linux.org.uk>
Message-ID: <20130321202131.GA3358@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 07:17:51PM +0000, Russell King - ARM Linux wrote:
> On Wed, Mar 20, 2013 at 07:36:27PM -0300, Ezequiel Garcia wrote:
> > Convert devm_request_and_ioremap() to the newly introduced
> > devm_ioremap_resource() which provides more consistent error handling.
> > 
> > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > ---
> >  drivers/thermal/mvebu_thermal.c |    6 ++----
> >  1 files changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
> > index ef04e4e..089b43d 100644
> > --- a/drivers/thermal/mvebu_thermal.c
> > +++ b/drivers/thermal/mvebu_thermal.c
> > @@ -86,11 +86,9 @@ static int mvebu_thermal_probe(struct platform_device *pdev)
> >  	if (!priv)
> >  		return -ENOMEM;
> >  
> > -	priv->sensor = devm_request_and_ioremap(&pdev->dev, res);
> > -	if (!priv->sensor) {
> > -		dev_err(&pdev->dev, "Failed to request_ioremap memory\n");
> > +	priv->sensor = devm_ioremap_resource(&pdev->dev, res);
> > +	if (!priv->sensor)
> >  		return -EADDRNOTAVAIL;
> 
> NAK.  It pays to understand the interface that you're using.  In this
> case, it *doesn't* return NULL on error, so you'll never reach
> -EADDRNOTAVAIL.  Please look this function up in lib/devres.c and
> understand its API.
> 

Yes, you're right, I'll fix this on v2.

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
