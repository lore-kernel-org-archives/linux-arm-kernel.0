From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 02 Sep 2014 20:13:46 +0200
Subject: [RFC PATCH v2 6/7] arm: call iommu_init before
 of_platform_populate
In-Reply-To: <1409680587-29818-7-git-send-email-will.deacon@arm.com>
References: <1409680587-29818-1-git-send-email-will.deacon@arm.com>
 <1409680587-29818-7-git-send-email-will.deacon@arm.com>
Message-ID: <6406734.5D2q2gd403@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 02 September 2014 18:56:26 Will Deacon wrote:
> @@ -803,9 +804,11 @@ static int __init customize_machine(void)
>         if (machine_desc->init_machine)
>                 machine_desc->init_machine();
>  #ifdef CONFIG_OF
> -       else
> +       else {
> +               of_iommu_init();
>                 of_platform_populate(NULL, of_default_bus_match_table,
>                                         NULL, NULL);
> +       }
>  #endif
>         return 0;
>  }

I think it would be better to not have this depend on the presence
of an init_machine callback. Why not move of_iommu_init() in front
of the if()? It shouldn't do anything unless we have an iommu
driver that we should be using.

	Arnd
