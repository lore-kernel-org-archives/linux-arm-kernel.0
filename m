From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Feb 2016 17:34:52 +0100
Subject: [PATCH] staging: amso1100: fix format string for 64-bit phys_addr
Message-ID: <2307631.X1DYNXxKPZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The amso1100 driver prints a phys_addr_t by casting it to a pointer,
which causes a warning when phys_addr_t is 64-bit and pointers
are 32-bit:

drivers/staging/rdma/amso1100/c2.c: In function 'c2_rx_error':
drivers/staging/rdma/amso1100/c2.c:430:4: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]

This changes the format string to print the address as a 64-bit
number all the time to avoids the warnings. Ideally we would use
the %pap format string for phys_addr_t, but that doesn't work
here easily as it requires passing a pointer to the address.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Found on ARM randconfig testing. This must have been there forever but is
rather hard to trigger even with randconfig builds.

diff --git a/drivers/staging/rdma/amso1100/c2.c b/drivers/staging/rdma/amso1100/c2.c
index b46ebd1ae15a..170a42a60552 100644
--- a/drivers/staging/rdma/amso1100/c2.c
+++ b/drivers/staging/rdma/amso1100/c2.c
@@ -426,8 +426,8 @@ static void c2_rx_error(struct c2_port *c2_port, struct c2_element *elem)
 		pr_debug("    index : %Zu\n",
 			elem - c2_port->rx_ring.start);
 		pr_debug("    len   : %u\n", rx_desc->len);
-		pr_debug("  rxp_hdr : %p [PA %p]\n", rxp_hdr,
-			(void *) __pa((unsigned long) rxp_hdr));
+		pr_debug("  rxp_hdr : %p [PA %016llx\n", rxp_hdr,
+			(u64)__pa((unsigned long) rxp_hdr));
 		pr_debug("    flags : 0x%x\n", rxp_hdr->flags);
 		pr_debug("    status: 0x%x\n", rxp_hdr->status);
 		pr_debug("    len   : %u\n", rxp_hdr->len);
