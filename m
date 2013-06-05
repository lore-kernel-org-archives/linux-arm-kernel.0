From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 5 Jun 2013 12:58:14 +0100
Subject: [PATCH 3/5] of: net: introduce a of_set_mac_address() helper
 function
In-Reply-To: <1370414409-29991-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1370414409-29991-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1370414409-29991-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <CACxGe6uoToKfiZMuJOLG0_YMF=8PNrt+-H2JT1JUk=5b8hvgPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 5, 2013 at 7:40 AM, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> The ARM MXS code already has some code to allocate and setup a
> property that contains the MAC address, and the Marvell Armada 370/XP
> code is going to gain a similar copy of this code. Therefore, let's
> add a small helper function that does that, in drivers/of/of_net.c.
>
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

For the vast majority of the kernel the device tree is supposed to be
a read-only structure. It's not something that should be modified at
all. If a platform has another source for obtaining a MAC address,
then it should either be injected into the DT by firmware. I'm not
saying no to this, but I am saying you need to be careful. If kexec is
ever used on this problem then the new kernel will get the updated mac
address which may or may not be what you want.

Looking at the mxs code, it would appear that the platform support
code will generate the mac address from a 32-bit value read out of
something like flash or eeprom. That in itself is fine, it is just a
question of how best to pass on that data. The other alternative is to
have an API for lookup hooks that platform code can hook into. That
could get quite a bit more complicated though.

Any DT mac address set function has a number of limits that need to be
applied. First; it needs to be called before any initcalls, and
probably before an of_platform_populate calls so that it doesn't cause
data to change under the feet of device drivers when the device is
created. If it is called too late, then it should output an error and
refuse to do anything. The mac address should not be allowed to change
under the feet of any driver using it. It would also need to be an
__init function. Finally, need to take care to make sure that the
sysfs & proc representations are correct after that function is
called. of_update_property() should take care of that, but you should
double check that it does.

Finally, if you are going to do this, then can you split the function
into two: of_set_property() and of_set_mac_address() and put all of
the memory allocation bits into the of_set_property() half. Sparc
actually already has an of_set_property() implementation, but it isn't
directly applicable due to the different back-end Sparc uses for
working with the device tree. Bonus points if you factor the common
bits out of the Sparc version at the same time. Make the Sparc version
use the prom_setprop() backend, while everyone else uses
of_update_property()

Other comments below...

> ---
>  drivers/of/of_net.c    | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/of_net.h |  6 ++++++
>  2 files changed, 42 insertions(+)
>
> diff --git a/drivers/of/of_net.c b/drivers/of/of_net.c
> index ffab033..02af898 100644
> --- a/drivers/of/of_net.c
> +++ b/drivers/of/of_net.c
> @@ -92,3 +92,39 @@ const void *of_get_mac_address(struct device_node *np)
>         return NULL;
>  }
>  EXPORT_SYMBOL(of_get_mac_address);
> +
> +/**
> + * Set a MAC address of a given network interface device tree node, if
> + * none was already defined.
> + */
> +int of_set_mac_address(struct device_node *np, const void *mac)

__init

> +{
> +       struct property *pp;
> +       int ret;
> +
> +       if (of_get_mac_address(np))
> +               return 0;
> +
> +       pp = kzalloc(sizeof(struct property) + ETH_ALEN, GFP_KERNEL);
> +       if (!pp)
> +               return -ENOMEM;
> +
> +       pp->value = pp + 1;

&pp[1].

> +       pp->length = ETH_ALEN;
> +       memcpy(pp->value, mac, ETH_ALEN);
> +       pp->name = kstrdup("local-mac-address", GFP_KERNEL);

"local-mac-address" is a static string. You're safe to directly assign
it here. I do realize that one of the property free paths does a
kfree() on the name field, but that only works on OF_DYNAMIC nodes.
You're not working with OF_DYNAMIC here. Other of_update_property()
calls already use the static name.

As an aside, it would probably be a good idea to modify the OF_DYNAMIC
path to make the name field and property structure allocated in the
same kzalloc() call, but that's a change for another patch set.

> +       if (!pp->name) {
> +               kfree(pp);
> +               return -ENOMEM;
> +       }
> +
> +       ret = of_update_property(np, pp);
> +       if (ret < 0) {
> +               kfree(pp->name);
> +               kfree(pp);
> +               return ret;
> +       }
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL(of_set_mac_address);

Don't export this symbol. Make it built-in only.

> diff --git a/include/linux/of_net.h b/include/linux/of_net.h
> index 61bf53b..a5086d9 100644
> --- a/include/linux/of_net.h
> +++ b/include/linux/of_net.h
> @@ -11,6 +11,7 @@
>  #include <linux/of.h>
>  extern const int of_get_phy_mode(struct device_node *np);
>  extern const void *of_get_mac_address(struct device_node *np);
> +extern int of_set_mac_address(struct device_node *np, const void *mac);
>  #else
>  static inline const int of_get_phy_mode(struct device_node *np)
>  {
> @@ -21,6 +22,11 @@ static inline const void *of_get_mac_address(struct device_node *np)
>  {
>         return NULL;
>  }
> +
> +static inline int of_set_mac_address(struct device_node *np, const void *mac)
> +{
> +       return -ENODEV;
> +}
>  #endif
>
>  #endif /* __LINUX_OF_NET_H */
> --
> 1.8.1.2
>
