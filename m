From: carlo@caione.org (Carlo Caione)
Date: Sun, 29 May 2016 13:36:58 +0200
Subject: [PATCH v5 1/3] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <CANe6Qb8ECk_1S=pyJBACUwSRyNUi7ROF-GvybcpYLTks4L38fg@mail.gmail.com>
References: <1464520323-19531-1-git-send-email-carlo@caione.org>
 <1464520323-19531-2-git-send-email-carlo@caione.org>
 <CANe6Qb8ECk_1S=pyJBACUwSRyNUi7ROF-GvybcpYLTks4L38fg@mail.gmail.com>
Message-ID: <20160529113658.GA21309@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/05/16 12:27, Ben Dooks wrote:

[...]
> > +u32 meson_sm_call_read(struct meson_sm_firmware *fw, void *buffer,
> > +                      unsigned int cmd_index, u32 arg0, u32 arg1,
> > +                      u32 arg2, u32 arg3, u32 arg4)
> > +{
> > +       u32 size;
> > +
> > +       if (!fw->chip->cmd_shmem_out_base)
> > +               return -EINVAL;
> > +
> > +       size = meson_sm_call(fw, cmd_index, arg0, arg1, arg2, arg3, arg4);
> > +       if (size <= 0 || size > fw->chip->shmem_size)
> > +               return -EINVAL;
> > +
> u32 cannot be less than 0

Ouch. Definitely overlooked that. Fix coming.

[...]
> > +static int meson_sm_probe(struct platform_device *pdev)
> > +{
> > +       const struct meson_sm_chip *chip;
> > +       struct meson_sm_firmware *fw;
> > +
> > +       fw = devm_kzalloc(&pdev->dev, sizeof(*fw), GFP_KERNEL);
> > +       if (!fw)
> > +               return -ENOMEM;
> > +
> > +       fw->dev = &pdev->dev;
> > +
> > +       chip = of_device_get_match_data(fw->dev);
> > +       if (!chip) {
> > +               dev_err(fw->dev, "Unable to setup secure-monitor data\n");
> > +               return -ENODEV;
> > +       }
> -ENODEV not best return here. Return -EINVAL better. -ENODEV won't get
> reported by device layer

Ok

[...]
> > +               if (!fw->sm_shmem_in_base)
> > +                       goto out;
> > +       }
>   Maybe use WarnOn here

Alright.

Cheers,

-- 
Carlo Caione
