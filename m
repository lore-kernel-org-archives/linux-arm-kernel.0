From: david.vrabel@citrix.com (David Vrabel)
Date: Fri, 2 Oct 2015 15:09:08 +0100
Subject: [PATCH v5 12/22] xen/balloon: Don't rely on the page granularity
 is the same for Xen and Linux
In-Reply-To: <1443609937-25278-13-git-send-email-julien.grall@citrix.com>
References: <1443609937-25278-1-git-send-email-julien.grall@citrix.com>
 <1443609937-25278-13-git-send-email-julien.grall@citrix.com>
Message-ID: <560E9004.8030604@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/15 11:45, Julien Grall wrote:
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

This causes a BUG() in x86 PV guests when decreasing the reservation.

Xen says:

(XEN) d0v2 Error pfn 0: rd=0 od=32753 caf=8000000000000001
taf=7400000000000001
(XEN) memory.c:250:d0v2 Bad page free for domain 0

And Linux BUGs with:

[   82.032654] kernel BUG at
/anfs/drall/scratch/davidvr/x86/linux/drivers/xen/balloon.c:540!

Which is a non-zero return value from the decrease_reservation hypercall.

The frame_list[] has been incorrectly populated.  The below patch fixes
it for me.  Please test as well.

--- a/drivers/xen/balloon.c
+++ b/drivers/xen/balloon.c
@@ -504,9 +504,10 @@ static enum bp_state decrease_reservation(unsigned
long nr_pages, gfp_t gfp)
 	 * Setup the frame, update direct mapping, invalidate P2M,
 	 * and add to balloon.
 	 */
+	i = 0;
 	list_for_each_entry_safe(page, tmp, &pages, lru) {
 		/* XENMEM_decrease_reservation requires a GFN */
-		frame_list[i] = xen_page_to_gfn(page);
+		frame_list[i++] = xen_page_to_gfn(page);

 #ifdef CONFIG_XEN_HAVE_PVMMU
 		/*

David
