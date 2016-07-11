From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jul 2016 10:03:25 +0200
Subject: [PATCH v2 06/10] soc: Add SoC specific driver support for nuc900
In-Reply-To: <1468135649-19980-7-git-send-email-vw@iommu.org>
References: <1468135649-19980-1-git-send-email-vw@iommu.org>
 <1468135649-19980-7-git-send-email-vw@iommu.org>
Message-ID: <4765191.NGpMC1JR46@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 10, 2016 3:27:26 PM CEST Wan Zongshun wrote:
> +       ret = of_property_read_string(np, "compatible", &soc_dev_attr->soc_id);
> +       if (ret)
>               return -EINVAL;
> +
> +       soc_dev_attr->machine = "NUC900EVB";
> +       soc_dev_attr->family = "NUC900";
> +       soc_dev = soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev)) {
> +               kfree(soc_dev_attr);
> +               return -ENODEV;
> +       }
> +
> +       ret = regmap_read(syscon_regmap, GCR_CHIPID, &nuc900_chipid);
> +       if (ret)
> +               return -ENODEV;
> +
> +       device_create_file(soc_device_to_device(soc_dev), &nuc900_chipid_attr);
> +       device_create_file(soc_device_to_device(soc_dev), &nuc900_version_attr);
> +
> +       dev_info(&pdev->dev, "Nuvoton Chip ID: 0x%x, Version ID:0x%x\n",
> +                nuc900_chipid & GCR_CHIPID_MASK,
> +                (nuc900_chipid >> 24) & 0xff);

I'm still a bit unsure about the set of attributes here.

- The "soc_id" is read from the device tree from the field that contains
  the board name, I think for consistency you should try to map the
  GCR_CHIPID to the name of the SoC and assign that here

- The "machine" is hardcoded to "NUC900EVB", which in turn looks like
  a particular board but not the one you are running on. Maybe read
  that from the DT instead?

- The "revision" is not filled at all, I would suggest using something
  derived from the GCR_CHIPID register here

- you have two nonstandard attributes "chipid" and "version", which
  I'd hope to avoid -- the set of standard attributes is supposed to
  give enough information about the machine, and platform independent
  user space will never read those.

	Arnd
