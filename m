From: oss@buserror.net (Scott Wood)
Date: Tue, 13 Sep 2016 17:24:23 -0500
Subject: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
In-Reply-To: <HE1PR04MB08892E63EB2D579D6F0A7550F8FE0@HE1PR04MB0889.eurprd04.prod.outlook.com>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-6-git-send-email-yangbo.lu@nxp.com>
 <1473392840.30217.170.camel@buserror.net>
 <HE1PR04MB08892D8354E38EC32F549E98F8FF0@HE1PR04MB0889.eurprd04.prod.outlook.com>
 <1473722714.30217.196.camel@buserror.net>
 <HE1PR04MB08892E63EB2D579D6F0A7550F8FE0@HE1PR04MB0889.eurprd04.prod.outlook.com>
Message-ID: <1473805463.30217.206.camel@buserror.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-09-13 at 07:23 +0000, Y.B. Lu wrote:
> > 


> > 
> > -----Original Message-----
> > From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
> > owner at vger.kernel.org] On Behalf Of Scott Wood
> > Sent: Tuesday, September 13, 2016 7:25 AM
> > To: Y.B. Lu; linux-mmc at vger.kernel.org; ulf.hansson at linaro.org; Arnd
> > Bergmann
> > Cc: linuxppc-dev at lists.ozlabs.org; devicetree at vger.kernel.org; linux-arm-
> > kernel at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> > clk at vger.kernel.org; linux-i2c at vger.kernel.org; iommu at lists.linux-
> > foundation.org; netdev at vger.kernel.org; Mark Rutland; Rob Herring;
> > Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil; Bhupesh
> > Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B. Xie
> > Subject: Re: [v11, 5/8] soc: fsl: add GUTS driver for QorIQ platforms
> > 
> > BTW, aren't ls2080a and ls2085a the same die? ?And is there no non-E
> > version of LS2080A/LS2040A?
> [Lu Yangbo-B47093] I checked all the svr values in chip errata doc "Revision
> level to part marking cross-reference" table.
> I found ls2080a and ls2085a were in two separate doc. And I didn?t find non-
> E version of LS2080A/LS2040A in chip errata doc.
> Do you know is there any other doc we can confirm this?

No. ?Traditionally we've always had E and non-E versions of each chip, but I
have no knowledge of whether that has changed (I do note that the way that E-
status is indicated in SVR has changed).

But please label LS2080A and LS2085A as the same die (or provide strong
evidence that they are not).

> 
> > 
> > 
> > > 
> > > > > 
> > > > > +	do {
> > > > > +		if (!matches->soc_id)
> > > > > +			return NULL;
> > > > > +		if (glob_match(svr_match, matches->soc_id))
> > > > > +			break;
> > > > > +	} while (matches++);
> > > > Are you expecting "matches++" to ever evaluate as false?
> > > [Lu Yangbo-B47093] Yes, this is used to match the soc we use in
> > > qoriq_soc array until getting true.
> > > We need to get the name and die information defined in array.
> > I'm not asking whether the glob_match will ever return true. ?I'm saying
> > that "matches++" will never become NULL.
> [Lu Yangbo-B47093] The matches++ will never become NULL while it will return
> NULL after matching for all the members in array.

"matches++" will never "return NULL". ?It's just an incrementing address. ?It
won't be null until you wrap around the address space, and even if the other
loop terminators never kicked in you'd crash long before that happens.

Please rewrite the loop as something like:

	while (matches->soc_id) {
		if (glob_match(...))
			return matches;

		matches++;
	}

	return NULL;


> > > > > +	/* Register soc device */
> > > > > +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> > > > > +	if (!soc_dev_attr) {
> > > > > +		ret = -ENOMEM;
> > > > > +		goto out_unmap;
> > > > > +	}
> > > > Couldn't this be statically allocated?
> > > [Lu Yangbo-B47093] Do you mean we define this struct statically ?
> > > 
> > > static struct soc_device_attribute soc_dev_attr;
> > Yes.
> > 
> [Lu Yangbo-B47093] It's ok to define it statically. Is there any need to do
> that?

It's simpler.

-Scott
