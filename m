From: mw@semihalf.com (Marcin Wojtas)
Date: Tue, 12 Jan 2016 23:40:40 +0100
Subject: [PATCH net-next 10/10] net: mvneta: Use the new hwbm framework
In-Reply-To: <1452625834-22166-11-git-send-email-gregory.clement@free-electrons.com>
References: <1452625834-22166-1-git-send-email-gregory.clement@free-electrons.com>
 <1452625834-22166-11-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <CAPv3WKcKK8fS-6koSgV7ABi8bvkRgzaqJDpOETCpGoTc2sWV=w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

A quick remark below. All changes look fine to me at a first look, but
I will test and dig more into code soon.

>
> @@ -3946,11 +3965,6 @@ static int mvneta_probe(struct platform_device *pdev)
>         dev->priv_flags |= IFF_UNICAST_FLT;
>         dev->gso_max_segs = MVNETA_MAX_TSO_SEGS;
>
> -       err = register_netdev(dev);
> -       if (err < 0) {
> -               dev_err(&pdev->dev, "failed to register\n");
> -               goto err_free_stats;
> -       }

The purpose of shifting register_netdev() was to be able to obtain
pp->id from net_device, before mvneta_bm_port_init is called. It is
needed for proper port - pool mapping control.

>
>         pp->id = dev->ifindex;
>
> @@ -3965,6 +3979,12 @@ static int mvneta_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       err = register_netdev(dev);
> +       if (err < 0) {
> +               dev_err(&pdev->dev, "failed to register\n");
> +               goto err_free_stats;
> +       }
> +
>         err = mvneta_init(&pdev->dev, pp);
>         if (err < 0)
>                 goto err_netdev;

Best regards,
Marcin
