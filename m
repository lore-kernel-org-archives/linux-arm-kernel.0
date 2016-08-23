From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 23 Aug 2016 11:37:20 -0400 (EDT)
Subject: [PATCH v6 4/8] usb: core: add power sequence handling for USB
 devices
In-Reply-To: <20160823031021.GB13986@shlinux2>
Message-ID: <Pine.LNX.4.44L0.1608231130330.2093-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 23 Aug 2016, Peter Chen wrote:

> I will add #ifdef CONFIG_OF for related code. And put the content at
> hub_pwrseq_on at hub_probe directly, how about below?
> 
> hub_probe() {
> 
> 	...
> 
> 	if (hub_configure(hub, endpoint) >= 0) {
> #ifdef CONFIG_OF
> 		for_each_child_of_node(parent->of_node, np) {
> 			ret = generic_pwrseq_on(np, hub);
> 			if (ret)
> 				return ret;
> 		}
> #else
> 		return 0;
> #endif
> 	}

Please make this a separate subroutine like you had before, but now in 
hub.c:

#ifdef CONFIG_OF
static int hub_of_pwrseq_on(struct usb_hub *hub)
{
...
}

#else
static inline int hub_of_pwrseq_on(struct usb_hub *hub)
{
	return 0;
}
#endif /* CONFIG_OF */


Alan Stern
