From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Thu, 19 Jul 2018 12:06:51 +0200
Subject: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
In-Reply-To: <20180719090929.arbysqo2bk3esoar@mwanda>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
 <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
 <20180719090929.arbysqo2bk3esoar@mwanda>
Message-ID: <CAMRc=Mdu5CLA99p48nNFZBSFHBKiERzp-m59vKDDe5STjjKZNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2018-07-19 11:09 GMT+02:00 Dan Carpenter <dan.carpenter@oracle.com>:
>
> Maybe it would be simpler as three separate functions:
>
> int of_eth_get_mac_address() <- rename existing function to this
> int nvmem_eth_get_mac_address() <- patch 2
> int mtd_eth_nvmem_get_mac_address() patch 3
>
>         int ret;
>
>         ret = of_eth_get_mac_address(dev, mac_addr);
>         if (!ret)
>                 return 0;
>         ret = nvmem_eth_get_mac_address(dev, mac_addr);
>         if (ret == -EPROBEDEFER)
>                 return ret;
>         if (!ret)
>                 return 0;
>         ret = mtd_eth_nvmem_get_mac_address(dev, mac_addr);
>         if (!ret)
>                 return 0;
>
>         return -ENODEV;
>
> regards,
> dan carpenter

It looks simpler as long as you don't add all the new routines
resulting from this approach. I've just tried to quickly implement
this solution and it resulted in much bigger and duplicated code
(checking the validity of mac_addr, copying it etc.). I would prefer
the current approach and would like to read someone else's opinion on
that.

Thanks,
Bart
>
