From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Thu, 26 Jul 2012 16:34:02 +0100
Subject: [PATCH 20/24] xen: update xen_add_to_physmap interface
In-Reply-To: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
Message-ID: <1343316846-25860-20-git-send-email-stefano.stabellini@eu.citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update struct xen_add_to_physmap to be in sync with Xen's version of the
structure.
The size field was introduced by:

changeset:   24164:707d27fe03e7
user:        Jean Guyader <jean.guyader@eu.citrix.com>
date:        Fri Nov 18 13:42:08 2011 +0000
summary:     mm: New XENMEM space, XENMAPSPACE_gmfn_range

According to the comment:

"This new field .size is located in the 16 bits padding between .domid
and .space in struct xen_add_to_physmap to stay compatible with older
versions."

This is not true on ARM where there is not padding, but it is valid on
X86, so introducing size is safe on X86 and it is going to fix the
interace for ARM.

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
---
 include/xen/interface/memory.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/include/xen/interface/memory.h b/include/xen/interface/memory.h
index abbbff0..d8e33a9 100644
--- a/include/xen/interface/memory.h
+++ b/include/xen/interface/memory.h
@@ -163,6 +163,9 @@ struct xen_add_to_physmap {
     /* Which domain to change the mapping for. */
     domid_t domid;
 
+    /* Number of pages to go through for gmfn_range */
+    uint16_t    size;
+
     /* Source mapping space. */
 #define XENMAPSPACE_shared_info 0 /* shared info page */
 #define XENMAPSPACE_grant_table 1 /* grant table page */
-- 
1.7.2.5
