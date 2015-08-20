From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 20 Aug 2015 10:59:57 +0100
Subject: [Xen-devel] [PATCH v3 12/20] xen/balloon: Don't rely on the page
 granularity is the same for Xen and Linux
In-Reply-To: <1438966019-19322-13-git-send-email-julien.grall@citrix.com>
References: <1438966019-19322-1-git-send-email-julien.grall@citrix.com>
 <1438966019-19322-13-git-send-email-julien.grall@citrix.com>
Message-ID: <55D5A51D.2060106@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/08/15 17:46, Julien Grall wrote:
> For ARM64 guests, Linux is able to support either 64K or 4K page
> granularity. Although, the hypercall interface is always based on 4K
> page granularity.
> 
> With 64K page granularity, a single page will be spread over multiple
> Xen frame.
> 
> To avoid splitting the page into 4K frame, take advantage of the
> extent_order field to directly allocate/free chunk of the Linux page
> size.
> 
> Note that PVMMU is only used for PV guest (which is x86) and the page
> granularity is always 4KB. Some BUILD_BUG_ON has been added to ensure
> that because the code has not been modified.
[...]
>  #ifdef CONFIG_XEN_HAVE_PVMMU
> +		/* We don't support PV MMU when Linux and Xen is using
> +		 * different page granularity.
> +		 */
> +		BUILD_BUG_ON(XEN_PAGE_SIZE != PAGE_SIZE);

You don't need this BUILD_BUG_ON() twice.

Otherwise,

Reviewed-by: David Vrabel <david.vrabel@citrix.com>

David
