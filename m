From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Fri, 15 Jun 2012 12:36:13 +0530
Subject: [PATCH v3 4/4] memory: emif: add device tree support to emif
 driver
In-Reply-To: <20120614154820.GG17140@kroah.com>
References: <1339669764-27244-1-git-send-email-santosh.shilimkar@ti.com>
 <1339669764-27244-5-git-send-email-santosh.shilimkar@ti.com>
 <20120614154820.GG17140@kroah.com>
Message-ID: <CAMQu2gx5CCDyrvozX06neBnA8J2heg+HL7DOewDm5voxqbpetw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 14, 2012 at 9:18 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jun 14, 2012 at 03:59:24PM +0530, Santosh Shilimkar wrote:
> > From: Aneesh V <aneesh@ti.com>
> >
> > Device tree support for the EMIF driver.
> >
> > Reviewed-by: Benoit Cousson <b-cousson@ti.com>
> > Reviewed-by: Grant Likely <grant.likely@secretlab.ca>
> > Tested-by: Lokesh Vutla <lokeshvutla@ti.com>
> > Signed-off-by: Aneesh V <aneesh@ti.com>
> > [santosh.shilimkar at ti.com: Rebased against 3.5-rc]
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Am I the memory maintainer now taking these patches?
>
I assumed that.
With your ack, $subject patch should go along with other 3 OMAP
platform patches because of dependency.

> > @@ -1267,7 +1534,13 @@ static int __init_or_module emif_probe(struct
> > platform_device *pdev)
> > ? ? ? struct resource ? ? ? ? *res;
> > ? ? ? int ? ? ? ? ? ? ? ? ? ? irq;
> >
> > - ? ? emif = get_device_details(pdev);
> > +#if defined(CONFIG_OF)
> > + ? ? if (pdev->dev.of_node)
> > + ? ? ? ? ? ? emif = of_get_device_details(pdev->dev.of_node,
> > &pdev->dev);
> > + ? ? else
> > +#endif
> > + ? ? ? ? ? ? emif = get_device_details(pdev);
> > +
>
> Can't you do this without the #ifdef?
>
Can be done. Just need to have empty of_get_device_details()
for the !CONFIG_OF build to avoid build break.

Will fix that.

Regards
santosh
