From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 15 Oct 2015 11:29:12 +0100
Subject: [PATCH v4 75/79] include/uapi/xen/privcmd.h: fix compilation
 in userspace
In-Reply-To: <1444888618-4506-76-git-send-email-mikko.rapeli@iki.fi>
References: <1444888618-4506-1-git-send-email-mikko.rapeli@iki.fi>
 <1444888618-4506-76-git-send-email-mikko.rapeli@iki.fi>
Message-ID: <561F7FF8.9030703@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/15 06:56, Mikko Rapeli wrote:
> xen/interface/xen.h is not exported from kernel headers so remove the
> dependency and provide needed defines for domid_t and xen_pfn_t if they
> are not already defined by some other e.g. Xen specific headers.
> 
> Suggested by Andrew Cooper <andrew.cooper3@citrix.com> on lkml message
> <5569F9C9.8000607@citrix.com>.
> 
> The ifdef for ARM is ugly but did not find better solutions for it.
> 
> Fixes userspace compilation error:
> 
> xen/privcmd.h:38:31: fatal error: xen/interface/xen.h: No such file or directory
[...]
> --- a/include/uapi/xen/privcmd.h
> +++ b/include/uapi/xen/privcmd.h
> @@ -35,7 +35,19 @@
>  
>  #include <linux/types.h>
>  #include <linux/compiler.h>
> -#include <xen/interface/xen.h>
> +
> +/* Might be defined by Xen specific headers, but if not */
> +#ifndef domid_t
> +typedef __u16 domid_t;
> +#endif /* domid_t */

As the kbuild bot points out, this does not work since the existence of
a typedef cannot be checked with #ifdef.

I'm not really sure what problem you're trying to solve.  A user space
program making use of this interface gets the domid_t and xen_pfn_t etc
typedefs from the headers provided as part of the libxenctrl library.

David
