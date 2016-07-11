From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 12:36:16 +0200
Subject: [PATCH v2 06/10] soc: Add SoC specific driver support for nuc900
In-Reply-To: <CAKT61h_vxcvVqqaDOn2XgtF7cBEpziSjfHRaY3eCWmM1ATfDXw@mail.gmail.com>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1606219.BzcByuFgJm@wuerfel>
 <CAKT61h_vxcvVqqaDOn2XgtF7cBEpziSjfHRaY3eCWmM1ATfDXw@mail.gmail.com>
Message-ID: <3879062.QodNaKgPKS@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 11, 2016 6:28:57 PM CEST Wan ZongShun wrote:
> 2016-07-11 18:24 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> > On Monday, July 11, 2016 5:07:01 PM CEST Wan Zongshun wrote:
> >>
> >> On 2016?07?11? 16:03, Arnd Bergmann wrote:
> >> > On Sunday, July 10, 2016 3:27:26 PM CEST Wan Zongshun wrote:
> >> >> +       ret = of_property_read_string(np, "compatible", &soc_dev_attr->soc_id);
> >> >> +       if (ret)
> >> >>                return -EINVAL;
> >> >> +
> >> >> +       soc_dev_attr->machine = "NUC900EVB";
> >> >> +       soc_dev_attr->family = "NUC900";
> >> >> +       soc_dev = soc_device_register(soc_dev_attr);
> >> >> +       if (IS_ERR(soc_dev)) {
> >> >> +               kfree(soc_dev_attr);
> >> >> +               return -ENODEV;
> >> >> +       }
> >> >> +
> >> >> +       ret = regmap_read(syscon_regmap, GCR_CHIPID, &nuc900_chipid);
> >> >> +       if (ret)
> >> >> +               return -ENODEV;
> >> >> +
> >> >> +       device_create_file(soc_device_to_device(soc_dev), &nuc900_chipid_attr);
> >> >> +       device_create_file(soc_device_to_device(soc_dev), &nuc900_version_attr);
> >> >> +
> >> >> +       dev_info(&pdev->dev, "Nuvoton Chip ID: 0x%x, Version ID:0x%x\n",
> >> >> +                nuc900_chipid & GCR_CHIPID_MASK,
> >> >> +                (nuc900_chipid >> 24) & 0xff);
> >> >
> >> > I'm still a bit unsure about the set of attributes here.
> >> >
> >> > - The "soc_id" is read from the device tree from the field that contains
> >> >    the board name, I think for consistency you should try to map the
> >> >    GCR_CHIPID to the name of the SoC and assign that here
> >>
> >> I will try to get chipid and map it to soc name like: ?nuc970?, "nuc910".
> >>
> >> And I will set this soc name to soc_id, ok?
> >
> > Ok.
> 
> Maybe I also can set versionid as soc name partly, like
> nuc970-version1,nuc970-version2? and then set the to soc_id, make
> sense?
> 

I didn't exactly understand what the suggestion is, maybe send that
as code so I see what you mean.

	Arnd
