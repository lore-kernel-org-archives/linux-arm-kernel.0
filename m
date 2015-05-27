From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 27 May 2015 19:47:00 +0200
Subject: [PATCH v4 2/2] soc: Add driver for Freescale Vybrid Platform
In-Reply-To: <7df753efff77a96da285f0571f1316512787e83c.1432637313.git.maitysanchayan@gmail.com>
References: <cover.1432637313.git.maitysanchayan@gmail.com>
 <7df753efff77a96da285f0571f1316512787e83c.1432637313.git.maitysanchayan@gmail.com>
Message-ID: <CAGhQ9VxzpPP0+YiVcwE2to_8Ajm1r4659HuWM8pfxUk0jdOzcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 May 2015 at 13:36, Sanchayan Maity <maitysanchayan@gmail.com> wrote:
> This adds a SoC driver to be used by the Freescale Vybrid SoC's.
> We create the "fsl" directory for holding the different Freescale
> designs. Driver utilises syscon to get the various register values
> needed. After this sysfs exposes some SoC specific properties as
> below:
>
>> cd /sys/devices/soc0
>> ls
> family     machine    power      revision   soc_id     subsystem  uevent
>> cat family
> Freescale Vybrid VF610
>> cat machine
> Freescale Vybrid
>> cat revision
> 00000013
>> cat soc_id
> df6472a60c1c39d4
>
> Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> ---
[...]
> +static struct soc_device_attribute *soc_dev_attr;
> +static struct soc_device *soc_dev;

Now that this is a proper platform device consider putting these in a
struct and allocated it in probe to get rid of the global variables.

> +static int vf610_soc_probe(struct platform_device *pdev)
> +{
> +       struct regmap *ocotp_regmap, *mscm_regmap, *rom_regmap;
> +       struct device *dev = &pdev->dev;
> +       struct device_node *node = pdev->dev.of_node;
[...]
> +       soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +       if (!soc_dev_attr)
> +               return -ENOMEM;
> +
> +       soc_dev_attr->machine = kasprintf(GFP_KERNEL, "Freescale Vybrid");
> +       soc_dev_attr->soc_id = kasprintf(GFP_KERNEL, "%016llx", soc_id);
> +       soc_dev_attr->family = kasprintf(GFP_KERNEL, "Freescale Vybrid VF%s",
> +                                                                soc_type);
> +       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%08x", rom_rev);
> +
> +       soc_dev = soc_device_register(soc_dev_attr);
> +       if (IS_ERR(soc_dev)) {
> +               kfree(soc_dev_attr->revision);
> +               kfree(soc_dev_attr->family);
> +               kfree(soc_dev_attr->soc_id);
> +               kfree(soc_dev_attr->machine);
> +               kfree(soc_dev_attr);

Since you now have a device pointer you can now uses all the devm_*
functions to allocate your memory.
There is also a devm_kasprintf function.

> +               return -ENODEV;
> +       }
> +
> +       return 0;
> +}
> +
> +static int vf610_soc_remove(struct platform_device *pdev)
> +{
> +       if (soc_dev_attr) {
> +               kfree(soc_dev_attr->revision);
> +               kfree(soc_dev_attr->family);
> +               kfree(soc_dev_attr->soc_id);
> +               kfree(soc_dev_attr->machine);
> +               kfree(soc_dev_attr);

With devm_* you can remove this stuff.

> +       }
> +
> +       if (soc_dev)
> +               soc_device_unregister(soc_dev);
> +
> +       return 0;
> +}


regards,
Joachim Eastwood
