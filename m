From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 19 Jul 2018 12:09:29 +0300
Subject: [PATCH v2 2/3] net: add support for nvmem to
 eth_platform_get_mac_address()
In-Reply-To: <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
References: <20180719082028.26116-1-brgl@bgdev.pl>
 <20180719082028.26116-3-brgl@bgdev.pl>
 <20180719084503.tfv6jllsukk2zv3f@mwanda>
 <CAMpxmJUgyB1hYi-G3KVxMsm0P+aKGuHOB8LSuH+bJbYfjengJA@mail.gmail.com>
Message-ID: <20180719090929.arbysqo2bk3esoar@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Maybe it would be simpler as three separate functions:

int of_eth_get_mac_address() <- rename existing function to this
int nvmem_eth_get_mac_address() <- patch 2
int mtd_eth_nvmem_get_mac_address() patch 3

	int ret;

	ret = of_eth_get_mac_address(dev, mac_addr);
	if (!ret)
		return 0;
	ret = nvmem_eth_get_mac_address(dev, mac_addr);
	if (ret == -EPROBEDEFER)
		return ret;
	if (!ret)
		return 0;
	ret = mtd_eth_nvmem_get_mac_address(dev, mac_addr);
	if (!ret)
		return 0;

	return -ENODEV;

regards,
dan carpenter
