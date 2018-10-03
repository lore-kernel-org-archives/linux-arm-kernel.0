From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Wed, 3 Oct 2018 22:15:23 +0200
Subject: [PATCH v2 00/29] at24: remove at24_platform_data
In-Reply-To: <20180831194643.GA62862@ban.mtv.corp.google.com>
References: <20180810080526.27207-1-brgl@bgdev.pl>
 <20180831194643.GA62862@ban.mtv.corp.google.com>
Message-ID: <CAMRc=MejZLV1EQ7uAddsxLY0MTUF8WyiBn=F0ZhkWQJpET0EDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

pt., 31 sie 2018 o 21:46 Brian Norris <computersforpeace@gmail.com> napisa?(a):
>
> Hi,
>
> On Fri, Aug 10, 2018 at 10:04:57AM +0200, Bartosz Golaszewski wrote:
> > Most boards use the EEPROM to store the MAC address. This series adds
> > support for cell lookups to the nvmem framework, registers relevant
> > cells for all users, adds nvmem support to eth_platform_get_mac_address(),
> > converts davinci_emac driver to using it and replaces at24_platform_data
> > with device properties.
>
> We already have:
>
> of_get_nvmem_mac_address() (which does exactly what you're adding,
> except it's DT specific)
> of_get_mac_address()
> fwnode_get_mac_address()
> device_get_mac_address()
>
> and now you've taught me that this exists too:
>
> eth_platform_get_mac_address()
>
> These mostly don't share code, and with your series, they'll start to
> diverge even more as to what they support. Can you please help rectify
> that, instead of widening the gap?
>
> For instance, you can delete most of eth_platform_get_mac_address() and
> replace it with device_get_mac_address() [1]. And you could add your new
> stuff to fwnode_get_mac_address().
>
> And important part to note here is that you code isn't just useful for
> ethernet -- it could be useful for Wifi devices too. So IMO, sticking it
> only in an "eth" function is the wrong move.
>
> Brian
>
> [1] arch_get_platform_mac_address() is the only part I wouldn't want to
> replicate into a truly generic helper. The following should be a no-op
> refactor, AIUI:
>

The only user of arch_get_platform_mac_address() is sparc. It returns
an address that seems to be read from some kind of EEPROM. I'm not
familiar with this arch though. I'm wondering if we could somehow
seamlessly remove this call and then convert all users of
eth_platform_get_mac_address() to using device_get_mac_address()?

David: I couldn't find a place in sparc code where any ethernet device
would be registered, so is there a chance that nobody is using it?

Best regards,
Bartosz Golaszewski

> diff --git a/net/ethernet/eth.c b/net/ethernet/eth.c
> index ee28440f57c5..b738651f71e1 100644
> --- a/net/ethernet/eth.c
> +++ b/net/ethernet/eth.c
> @@ -47,12 +47,12 @@
>  #include <linux/inet.h>
>  #include <linux/ip.h>
>  #include <linux/netdevice.h>
> +#include <linux/property.h>
>  #include <linux/etherdevice.h>
>  #include <linux/skbuff.h>
>  #include <linux/errno.h>
>  #include <linux/init.h>
>  #include <linux/if_ether.h>
> -#include <linux/of_net.h>
>  #include <linux/pci.h>
>  #include <net/dst.h>
>  #include <net/arp.h>
> @@ -528,19 +528,11 @@ unsigned char * __weak arch_get_platform_mac_address(void)
>  int eth_platform_get_mac_address(struct device *dev, u8 *mac_addr)
>  {
>         const unsigned char *addr;
> -       struct device_node *dp;
>
> -       if (dev_is_pci(dev))
> -               dp = pci_device_to_OF_node(to_pci_dev(dev));
> -       else
> -               dp = dev->of_node;
> -
> -       addr = NULL;
> -       if (dp)
> -               addr = of_get_mac_address(dp);
> -       if (!addr)
> -               addr = arch_get_platform_mac_address();
> +       if (device_get_mac_address(dev, mac_addr, ETH_ALEN))
> +               return 0;
>
> +       addr = arch_get_platform_mac_address();
>         if (!addr)
>                 return -ENODEV;
>
