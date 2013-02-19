From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Feb 2013 22:04:44 +0000
Subject: [PATCH 06/35] mfd: ab8500-core: Sysfs chip id modification
In-Reply-To: <1360933026-30325-7-git-send-email-lee.jones@linaro.org>
References: <1360933026-30325-1-git-send-email-lee.jones@linaro.org>
 <1360933026-30325-7-git-send-email-lee.jones@linaro.org>
Message-ID: <201302192204.45153.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 February 2013, Lee Jones wrote:
>         struct ab8500 *ab8500;
> +       int chip_id = -EINVAL;
>
>         ab8500 = dev_get_drvdata(dev);
> -       return sprintf(buf, "%#x\n", ab8500 ? ab8500->chip_id : -EINVAL);
> +       if(ab8500) {
> +               chip_id = ab8500->chip_id;
> +               if((is_ab8505(ab8500) || is_ab9540(ab8500)) && ab8500->version != 0xFF)
> +                       chip_id = (ab8500->version << 8) | chip_id;
> +       }
> +       return sprintf(buf, "%#x\n", chip_id);
>  }

What's the use of printing "ffffffea" for unknown versions here?

	Arnd
