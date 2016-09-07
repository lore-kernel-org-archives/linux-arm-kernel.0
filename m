From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 10:52:46 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <20160907074428.GB13903@b29397-desktop>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <20562703.Glp77l1PBf@wuerfel> <20160907074428.GB13903@b29397-desktop>
Message-ID: <4780626.ofOZnpf19s@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, September 7, 2016 3:44:28 PM CEST Peter Chen wrote:
> 
> The pre-condition of DT function at USB HCD core works is the host
> controller device has of_node, since it is the root node for USB tree
> described at DT. If the host controller device is not at DT, it needs
> to try to get its of_node, the chipidea driver gets it through its
> parent node [1]

> 
> [1] https://lkml.org/lkml/2016/8/8/119
> 

Ah, this is what I was referring to in the other mail.

However, the way you set the of_node might be dangerous too:
We should generally not have two platform_device structures with
the same of_node pointer, most importantly it may cause the
child device to be bound to the same driver as the parent
device since the probing is done by compatible string.

As you tested it successfully, it must work at the moment on your
machine, but it could easily break depending on deferred probing
or module load order.

	Arnd
