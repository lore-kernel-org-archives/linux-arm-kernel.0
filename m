From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 23 Sep 2018 18:06:03 +0200
Subject: [RFC 2/3 net] lorawan: Add macro and definition for LoRaWAN class
 modlue
In-Reply-To: <f7ea222671a2bc6fe0a060c4bdb1ebae162d0d91.1535039998.git.starnight@g.ncu.edu.tw>
References: <cover.1535039998.git.starnight@g.ncu.edu.tw>
 <f7ea222671a2bc6fe0a060c4bdb1ebae162d0d91.1535039998.git.starnight@g.ncu.edu.tw>
Message-ID: <f74c033a-fadc-fb8c-9469-6e6a32339cd8@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jian-Hong,

Many thanks and sorry for the delay. This patch mostly looks good and
should go in before its first uses, so I would like to queue it soon for
my hardware-MAC module drivers - but some questions below. Also a typo
in the subject, and we should probably prepend "net: " and I would
personally not mention the module here as it's a userspace API.

Am 23.08.18 um 19:15 schrieb Jian-Hong Pan:
> This patch add the macro and definition for the implementation of
> LoRaWAN protocol.

I would fix up the grammar nits in my tree then.

> 
> Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
> ---
>  include/linux/socket.h              | 5 ++++-
>  include/uapi/linux/if_arp.h         | 1 +
>  include/uapi/linux/if_ether.h       | 1 +
>  net/core/dev.c                      | 4 ++--
>  security/selinux/hooks.c            | 4 +++-
>  security/selinux/include/classmap.h | 4 +++-
>  6 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index aa1e288b1659..e5c8381fd1aa 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -209,8 +209,9 @@ struct ucred {
>  				 */
>  #define AF_XDP		44	/* XDP sockets			*/
>  #define AF_LORA		45	/* LoRa sockets			*/
> +#define AF_LORAWAN	46	/* LoRaWAN sockets			*/
>  
> -#define AF_MAX		46	/* For now.. */
> +#define AF_MAX		47	/* For now.. */
>  
>  /* Protocol families, same as address families. */
>  #define PF_UNSPEC	AF_UNSPEC
> @@ -261,6 +262,7 @@ struct ucred {
>  #define PF_SMC		AF_SMC
>  #define PF_XDP		AF_XDP
>  #define PF_LORA		AF_LORA
> +#define PF_LORAWAN	AF_LORAWAN
>  #define PF_MAX		AF_MAX
>  
>  /* Maximum queue length specifiable by listen.  */
> @@ -343,6 +345,7 @@ struct ucred {
>  #define SOL_KCM		281
>  #define SOL_TLS		282
>  #define SOL_XDP		283
> +#define SOL_LORAWAN	284
>  
>  /* IPX options */
>  #define IPX_TYPE	1
> diff --git a/include/uapi/linux/if_arp.h b/include/uapi/linux/if_arp.h
> index 1ed7cb3f2129..2376f7839355 100644
> --- a/include/uapi/linux/if_arp.h
> +++ b/include/uapi/linux/if_arp.h
> @@ -99,6 +99,7 @@
>  #define ARPHRD_6LOWPAN	825		/* IPv6 over LoWPAN             */
>  #define ARPHRD_VSOCKMON	826		/* Vsock monitor header		*/
>  #define ARPHRD_LORA	827		/* LoRa				*/
> +#define ARPHRD_LORAWAN	828		/* LoRaWAN			*/
>  
>  #define ARPHRD_VOID	  0xFFFF	/* Void type, nothing is known */
>  #define ARPHRD_NONE	  0xFFFE	/* zero header length */
> diff --git a/include/uapi/linux/if_ether.h b/include/uapi/linux/if_ether.h
> index 45644dcf5b39..b1ac70d4a377 100644
> --- a/include/uapi/linux/if_ether.h
> +++ b/include/uapi/linux/if_ether.h
> @@ -148,6 +148,7 @@
>  					 * aggregation protocol
>  					 */
>  #define ETH_P_LORA	0x00FA		/* LoRa				*/
> +#define ETH_P_LORAWAN	0x00FB		/* LoRaWAN			*/
>  
>  /*
>   *	This is an Ethernet frame header.
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f68122f0ab02..b95ce79ec5a8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -297,7 +297,7 @@ static const unsigned short netdev_lock_type[] = {
>  	 ARPHRD_IRDA, ARPHRD_FCPP, ARPHRD_FCAL, ARPHRD_FCPL,
>  	 ARPHRD_FCFABRIC, ARPHRD_IEEE80211, ARPHRD_IEEE80211_PRISM,
>  	 ARPHRD_IEEE80211_RADIOTAP, ARPHRD_PHONET, ARPHRD_PHONET_PIPE,
> -	 ARPHRD_IEEE802154, ARPHRD_VOID, ARPHRD_NONE};
> +	 ARPHRD_IEEE802154, ARPHRD_LORAWAN, ARPHRD_VOID, ARPHRD_NONE};
>  
>  static const char *const netdev_lock_name[] = {
>  	"_xmit_NETROM", "_xmit_ETHER", "_xmit_EETHER", "_xmit_AX25",
> @@ -314,7 +314,7 @@ static const char *const netdev_lock_name[] = {
>  	"_xmit_IRDA", "_xmit_FCPP", "_xmit_FCAL", "_xmit_FCPL",
>  	"_xmit_FCFABRIC", "_xmit_IEEE80211", "_xmit_IEEE80211_PRISM",
>  	"_xmit_IEEE80211_RADIOTAP", "_xmit_PHONET", "_xmit_PHONET_PIPE",
> -	"_xmit_IEEE802154", "_xmit_VOID", "_xmit_NONE"};
> +	"_xmit_IEEE802154", "_xmit_LORAWAN", "_xmit_VOID", "_xmit_NONE"};
>  
>  static struct lock_class_key netdev_xmit_lock_key[ARRAY_SIZE(netdev_lock_type)];
>  static struct lock_class_key netdev_addr_lock_key[ARRAY_SIZE(netdev_lock_type)];

All your new constants except SOL_LORAWAN are always next to a LoRa one,
but not in these two arrays. I don't have such changes in my original
LoRa patch - am I missing such an array extension for ARPHRD_LORA then,
or what is the criteria for when to add this?

Other changes look fine to me.

Regards,
Andreas

> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index aaf520a689d8..0da3a1d69cb8 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1477,7 +1477,9 @@ static inline u16 socket_type_to_security_class(int family, int type, int protoc
>  			return SECCLASS_XDP_SOCKET;
>  		case PF_LORA:
>  			return SECCLASS_LORA_SOCKET;
> -#if PF_MAX > 46
> +		case PF_LORAWAN:
> +			return SECCLASS_LORAWAN_SOCKET;
> +#if PF_MAX > 47
>  #error New address family defined, please update this function.
>  #endif
>  		}
> diff --git a/security/selinux/include/classmap.h b/security/selinux/include/classmap.h
> index 060d4bf8385e..fa0151fe6f32 100644
> --- a/security/selinux/include/classmap.h
> +++ b/security/selinux/include/classmap.h
> @@ -244,9 +244,11 @@ struct security_class_mapping secclass_map[] = {
>  	  { COMMON_SOCK_PERMS, NULL } },
>  	{ "lora_socket",
>  	  { COMMON_SOCK_PERMS, NULL } },
> +	{ "lorawan_socket",
> +	  { COMMON_SOCK_PERMS, NULL } },
>  	{ NULL }
>    };
>  
> -#if PF_MAX > 46
> +#if PF_MAX > 47
>  #error New address family defined, please update secclass_map.
>  #endif
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
