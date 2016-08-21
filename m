From: christophe.jaillet@wanadoo.fr (Christophe JAILLET)
Date: Sun, 21 Aug 2016 23:20:25 +0200
Subject: [PATCH] serial: vt8500_serial: Fix a parameter of find_first_zero_bit.
Message-ID: <1471814425-18949-1-git-send-email-christophe.jaillet@wanadoo.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 2nd parameter of 'find_first_zero_bit' is the number of bits to search.
In this case, we are passing 'sizeof(vt8500_ports_in_use)'.
'vt8500_ports_in_use' is an 'unsigned long'. So the sizeof is likely to
return 4.

A few lines below, we check if it is below VT8500_MAX_PORTS, which is 6.

It is likely that the number of bits in a long was expected here, so use
BITS_PER_LONG instead.


It has been spotted by the following coccinelle script:
@@
expression ret, x;

@@
*  ret = \(find_first_bit \| find_first_zero_bit\) (x, sizeof(...));

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Other options are possible:
  - 'vt8500_ports_in_use' being a 'unsigned long', use ffz to reduce
    code verbosity
  - VT8500_MAX_PORTS, in order to be consistent with the test below
---
 drivers/tty/serial/vt8500_serial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 23cfc5e16b45..935076c50cb1 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -664,7 +664,7 @@ static int vt8500_serial_probe(struct platform_device *pdev)
 	if (port < 0) {
 		/* calculate the port id */
 		port = find_first_zero_bit(&vt8500_ports_in_use,
-					sizeof(vt8500_ports_in_use));
+					   BITS_PER_LONG);
 	}
 
 	if (port >= VT8500_MAX_PORTS)
-- 
2.7.4


---
L'absence de virus dans ce courrier ?lectronique a ?t? v?rifi?e par le logiciel antivirus Avast.
https://www.avast.com/antivirus
