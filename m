From: ranjit.waghmode@xilinx.com (Ranjit Abhimanyu Waghmode)
Date: Fri, 4 Sep 2015 12:02:21 +0000
Subject: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
 stripe
In-Reply-To: <20150903121232.GW12027@sirena.org.uk>
References: <1440570367-22569-1-git-send-email-ranjit.waghmode@xilinx.com>
 <1440570367-22569-2-git-send-email-ranjit.waghmode@xilinx.com>
 <20150903121232.GW12027@sirena.org.uk>
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3C014B0D67@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

> -----Original Message-----
> From: Mark Brown [mailto:broonie at kernel.org]
> Sent: Thursday, September 03, 2015 5:43 PM
> To: Ranjit Abhimanyu Waghmode
> Cc: dwmw2 at infradead.org; computersforpeace at gmail.com; Michal Simek;
> Soren Brinkmann; zajec5 at gmail.com; ben at decadent.org.uk; marex at denx.de;
> b32955 at freescale.com; knut.wohlrab at de.bosch.com; juhosg at openwrt.org;
> beanhuo at micron.com; linux-mtd at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-spi at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Harini Katakam; Punnaiah Choudary Kalluri
> Subject: Re: [LINUX RFC v2 1/4] spi: add support of two chip selects & data
> stripe
> 
> On Wed, Aug 26, 2015 at 11:56:04AM +0530, Ranjit Waghmode wrote:
> 
> > To support dual parallel mode operation of ZynqMP GQSPI controller
> > following API's are added inside the core:
> 
> As covered in SubmittingPatches please try to make each patch a single change
> rather than having multiple separate changes in one commit.
I will split the patch.
> 
> > +	/* Controller may support more than one chip.
> > +	 * This flag will enable that feature.
> > +	 */
> > +#define SPI_MASTER_BOTH_CS		BIT(8)		/* enable both
> chips */
> 
> This isn't saying that the controller supports more than one chip, it's saying that
> the controller supports asserting more than one chip select at once which isn't
> the same thing.  I'm also not entirely sure that this makes sense as a separate
> feature to the data striping one - I'm struggling to think of a way to use this
> sensibly separately to that.
If the SPI controller is having more than one chip select and the data lines are distributed equally.
And also there is requirement to activate all the chip selects in one go.

Now we can consider following use cases:

Suppose we need to send the same data to multiple slaves of same kind:
Here the application need not to do individual slave access for writing, instead it can send data to all the devices in one go.

Let's take another case where application is trying to send data in such a way that first nibble of the byte will got to the one slave and the second nibble of the byte will go to the other slave:
Here data in slave devices can be organized by taking advantage of above topology along with the support in hardware.

Regards,
Ranjit
