From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Wed, 9 May 2018 16:39:20 +0200
Subject: [PATCH] mtd: nxp-spifi: decrement flash_np refcnt on error paths
In-Reply-To: <04eca940-cf53-d365-9899-336eb213e089@ispras.ru>
References: <1525812456-25877-1-git-send-email-khoroshilov@ispras.ru>
 <20180509114250.120eb299@bbrezillon>
 <04eca940-cf53-d365-9899-336eb213e089@ispras.ru>
Message-ID: <20180509163920.67a5f203@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2018 17:35:41 +0300
Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:

> On 09.05.2018 12:42, Boris Brezillon wrote:
> > On Tue,  8 May 2018 23:47:36 +0300
> > Alexey Khoroshilov <khoroshilov@ispras.ru> wrote:
> >   
> >> nxp_spifi_probe() increments refcnt of SPI flash device node by
> >> of_get_next_available_child() and then it passes the node
> >> to mtd device in nxp_spifi_setup_flash().
> >> But if a failure happens before mtd_device_register() succeed,
> >> the refcnt is left undecremented.  
> > 
> > Why not doing that in the error path of the probe function? Also, you
> > probably want to call of_node_put() in the ->remove() function.
> >   
> 
> 
> You are right.
> 
> I believed that after successful mtd_device_register()
> the node is managed by mtd device. I missed that it calls of_node_get()
> in add_mtd_device() by itself.
> 
> I will prepare v2.
> But I guess there is no need to have of_node_put() in ->remove(), since
> probe() finishes its own usage of flash_np, while mtd_device incremented
> refcnt by itself and will decrement it in ->remove() in
> mtd_device_unregister(&spifi->nor.mtd). So, I would propose
> of_node_put() on both successful and error path.

Sounds good.
