From: yangbo.lu@nxp.com (Y.B. Lu)
Date: Wed, 7 Sep 2016 04:10:32 +0000
Subject: [v11, 7/8] base: soc: introduce soc_device_match() interface
In-Reply-To: <6515108.aCEls7dUuW@wuerfel>
References: <1473150503-9550-1-git-send-email-yangbo.lu@nxp.com>
 <1473150503-9550-8-git-send-email-yangbo.lu@nxp.com>
 <CAPDyKFrvg3Qr5m3xXvywsCoVvaiF7ggHAj0Aw=WCOXg65Pt0PQ@mail.gmail.com>
 <6515108.aCEls7dUuW@wuerfel>
Message-ID: <HE1PR04MB088939A28A68035F3393A441F8F80@HE1PR04MB0889.eurprd04.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anrd and Uffe,

Thank you for your comment.
Please see my comment inline.



Best regards,
Yangbo Lu

> -----Original Message-----
> From: Arnd Bergmann [mailto:arnd at arndb.de]
> Sent: Tuesday, September 06, 2016 8:46 PM
> To: Ulf Hansson
> Cc: Y.B. Lu; linux-mmc; Scott Wood; linuxppc-dev at lists.ozlabs.org;
> devicetree at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-
> kernel at vger.kernel.org; linux-clk; linux-i2c at vger.kernel.org;
> iommu at lists.linux-foundation.org; netdev at vger.kernel.org; Mark Rutland;
> Rob Herring; Russell King; Jochen Friedrich; Joerg Roedel; Claudiu Manoil;
> Bhupesh Sharma; Qiang Zhao; Kumar Gala; Santosh Shilimkar; Leo Li; X.B.
> Xie
> Subject: Re: [v11, 7/8] base: soc: introduce soc_device_match() interface
> 
> On Tuesday, September 6, 2016 1:44:23 PM CEST Ulf Hansson wrote:
> > On 6 September 2016 at 10:28, Yangbo Lu <yangbo.lu@nxp.com> wrote:
> > > We keep running into cases where device drivers want to know the
> > > exact version of the a SoC they are currently running on. In the
> > > past, this has usually been done through a vendor specific API that
> > > can be called by a driver, or by directly accessing some kind of
> > > version register that is not part of the device itself but that
> > > belongs to a global register area of the chip.
> 
> Please add "From: Arnd Bergmann <arnd@arndb.de>" as the first line, to
> preserve authorship. If you use "git send-email" or "git format-patch",
> that should happen automatically if the author field is set right (if not,
> use 'git commit --amend --author="Arnd Bergmann <arnd@arndb.de>"'
> to fix it).
> 

[Lu Yangbo-B47093] Oh, I'm sorry for my careless. Will correct it in next version.

> > > +
> > > +/*
> > > + * soc_device_match - identify the SoC in the machine
> > > + * @matches: zero-terminated array of possible matches
> >
> > Perhaps also express the constraint on the matching entries. As you
> > need at least one of the ->machine(), ->family(), ->revision() or
> > ->soc_id() callbacks implemented, right!?
> 
> They are not callbacks, just strings. Having an empty entry indicates the
> end of the array, and this is not called.
> 
> > > + *
> > > + * returns the first matching entry of the argument array, or NULL
> > > + * if none of them match.
> > > + *
> > > + * This function is meant as a helper in place of of_match_node()
> > > + * in cases where either no device tree is available or the
> > > + information
> > > + * in a device node is insufficient to identify a particular
> > > + variant
> > > + * by its compatible strings or other properties. For new devices,
> > > + * the DT binding should always provide unique compatible strings
> > > + * that allow the use of of_match_node() instead.
> > > + *
> > > + * The calling function can use the .data entry of the
> > > + * soc_device_attribute to pass a structure or function pointer for
> > > + * each entry.
> >
> > I don't get the use case behind this, could you elaborate?
> >
> > Perhaps we should postpone adding the .data entry until we actually
> > see a need for it?
> 
> I think the interface is rather useless without a way to figure out which
> entry you got. Almost all users of of_match_node() actually use the
> returned ->data field, and I expect this to be the same here.
> 
> > > + */
> > > +const struct soc_device_attribute *soc_device_match(
> > > +       const struct soc_device_attribute *matches) {
> > > +       struct device *dev;
> > > +       int ret;
> > > +
> > > +       for (ret = 0; ret == 0; matches++) {
> >
> > This loop looks a bit weird and unsafe.
> 
> Ah, and I thought I was being clever ;-)
> 
> > 1) Perhaps using a while loop makes this more readable?
> > 2) As this is an exported API, I guess validation of the ->matches
> > pointer needs to be done before accessing it.
> 
> Sounds fine.

[Lu Yangbo-B47093] Ok, Will change this according to Uffe. 
And actually there is issue with this for() when I verified it again this morning.
We will get matches++ rather than matches which is correct finally :)

> 
> > > +               if (!(matches->machine || matches->family ||
> > > +                     matches->revision || matches->soc_id))
> > > +                       return NULL;
> > > +               dev = NULL;
> >
> > There's no need to use a struct device just to assign it to NULL.
> > Instead just provide the function below with NULL.
> >
> > > +               ret = bus_for_each_dev(&soc_bus_type, dev, (void
> *)matches,
> > > +                                      soc_device_match_one);
> 
> 
> I don't remember what led to this, I think you are right, we should just
> pass NULL as most other callers.

[Lu Yangbo-B47093] Will correct it. Thanks. :)

> 
> Thanks for the review.
> 
> 	ARnd
