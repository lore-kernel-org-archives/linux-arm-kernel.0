From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Fri, 19 Oct 2012 09:04:14 +0200
Subject: [PATCH net-next 00/21] treewide: Use consistent api style for
 address testing
In-Reply-To: <cover.1350618006.git.joe@perches.com>
References: <cover.1350618006.git.joe@perches.com>
Message-ID: <1350630254.2293.183.camel@edumazet-glaptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-10-18 at 20:55 -0700, Joe Perches wrote:
> ethernet, ipv4, and ipv6 address testing uses 3 different api naming styles.
> 
> ethernet uses:	is_<foo>_ether_addr
> ipv4 uses:	ipv4_is_<foo>
> ipv6 uses:	ipv6_addr_<foo>
> 
> Standardize on the ipv6 style of <prefix>_addr_<type> to reduce
> the number of styles to remember.
> 
> The new consistent styles are:
> 
> eth_addr_<foo>(const u8 *)
> ipv4_addr_<foo>(__be32)
> ipv6_addr_<foo>(const struct in6_addr *)
> 
> Add temporary backward compatibility #defines for the old names too.
> 
> Joe Perches (21):
>   etherdevice: Rename is_<foo>_ether_addr tests to eth_addr_<foo>
>   net: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   arch: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   wireless: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   drivers: net: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   staging: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   infiniband: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   scsi: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   of: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   s390: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   usb: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   uwb: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   Documentation: networking: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   llc_if.h: Convert is_<foo>_ether_addr uses to eth_addr_<foo>
>   in.h: Rename ipv4_is_<foo> functions to ipv4_addr_<foo>
>   net: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   infiniband: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   ath6kl: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   parisc: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   lockd: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>
>   sctp: Convert ipv4_is_<foo> uses to ipv4_addr_<foo>

Yes they are some names discrepancies, thats a big deal.

And we have alloc_skb() / kfree_skb() / skb_clone() 

Why not skb_alloc() / skb_free() / skb_clone() ?

Some people actually know current code by name of functions, they dont
want to change their mind and having to grep include files and git log
to learn the new names of an old function, especially when traveling and
using a laptop.

Sure, when we want to use eth_random_addr(), a grep into include files
to check if its still the right name (old one was random_ether_addr())
is OK because we dont use this one often.

If you think about it, eth_random_addr() was not the perfect name.

Think about all the documentation you can find outside of kernel tree,
RFC and things like that, copy/pasting some linux kernel code.

This kind of changes make our life more difficult, when we have to
backport patches or rebase code, or even perform some searches to find
prior issues/discussions.

Life of a kernel developer is not only dealing with latest Linus (or
-next) tree, and using automatic 'tools'.

Thats a real pain for me at least.
