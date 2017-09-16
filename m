From: amworsley@gmail.com (Andrew Worsley)
Date: Sat, 16 Sep 2017 13:02:52 +1000
Subject: [PATCH] Fix Bug for cadence i2c interrupt overrunning buffer
Message-ID: <20170916030252.10680-1-amworsley@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c interrupt handler was not checking against the length of
supplied buffer so if the hardware supplied more data than requested in
the i2c transfer it happily copies it right past the end of the buffer!

Signed-off-by: Andrew Worsley <amworsley@gmail.com>
---

  This bug reliably caused a stack corruption when the hardware provided more data than
asked for in the i2c request. The hardware (a tpm) very occasionally appends a burst of
0xff to the end of the data requested and the i2c interrupt handler mindlessly copies all
the data right past the end of the buffer and in my case across the stack. :-(

  With this patch the transfer now terminates with an -EIO but with out voilating the
buffer boundaries. I would prefer to just make the transfer succeed while not retrieving
additional bytes but I wasn't able to find an easy way to do this. As this is definitely a
fault that causes a kernel oops I just wanted to get a fix out there for others to avoid
the problem as it has taken me a few weeks to chase down this oops. If someone has a
better or nicer fix I would appreciate it or a pointer to how to do this.

    Thanks

    Andrew
 drivers/i2c/busses/i2c-cadence.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cadence.c b/drivers/i2c/busses/i2c-cadence.c
index b13605718291..c1f61ca6843e 100644
--- a/drivers/i2c/busses/i2c-cadence.c
+++ b/drivers/i2c/busses/i2c-cadence.c
@@ -234,6 +234,7 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 	if (id->p_recv_buf &&
 	    ((isr_status & CDNS_I2C_IXR_COMP) ||
 	     (isr_status & CDNS_I2C_IXR_DATA))) {
+		unsigned char *p = id->p_recv_buf;
 		/* Read data if receive data valid is set */
 		while (cdns_i2c_readreg(CDNS_I2C_SR_OFFSET) &
 		       CDNS_I2C_SR_RXDV) {
@@ -246,6 +247,12 @@ static irqreturn_t cdns_i2c_isr(int irq, void *ptr)
 			    !id->bus_hold_flag)
 				cdns_i2c_clear_bus_hold(id);
 
+			if (id->recv_count == 0) {
+				pr_notice("%s: i2c receive buffer filled : %u aborting transfer %p - %p\n",
+					__func__, (id->p_recv_buf - p));
+				break;
+			}
+
 			*(id->p_recv_buf)++ =
 				cdns_i2c_readreg(CDNS_I2C_DATA_OFFSET);
 			id->recv_count--;
-- 
2.11.0
