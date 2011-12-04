From: dirk.behme@googlemail.com (Dirk Behme)
Date: Sun, 04 Dec 2011 18:01:25 +0100
Subject: [PATCH] imx: add polled io uart methods
In-Reply-To: <20111017201725.GG18141@pengutronix.de>
References: <CAOMZO5CdVqCu8VvaYmxhDW-anG2NQt8Hn3CnM_a48g9V0q9bmA@mail.gmail.com>
 <1318821721-11965-1-git-send-email-compnerd@compnerd.org>
 <1318821721-11965-2-git-send-email-compnerd@compnerd.org>
 <20111017201725.GG18141@pengutronix.de>
Message-ID: <4EDBA765.6080600@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17.10.2011 22:17, Sascha Hauer wrote:
> On Sun, Oct 16, 2011 at 08:22:01PM -0700, Saleem Abdulrasool wrote:
>> These methods are invoked if the iMX uart is used in conjuction with kgdb during
>> early boot.  In order to access the UART without the interrupts, the kernel uses
>> the basic polling methods for IO with the device.  With these methods
>> implemented, it is now possible to enable kgdb during early boot over serial.
>>
>> Signed-off-by: Saleem Abdulrasool<compnerd@compnerd.org>
>> ---
>>   drivers/tty/serial/imx.c |   77 ++++++++++++++++++++++++++++++++++++++++++++++
>>   1 files changed, 77 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index 7e91b3d..4fcf9ca 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -102,6 +102,7 @@
>>   #define  UCR2_STPB       (1<<6)	 /* Stop */
>>   #define  UCR2_WS         (1<<5)	 /* Word size */
>>   #define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
>> +#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
>>   #define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
>>   #define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
>>   #define  UCR2_SRST 	 (1<<0)	 /* SW reset */
>> @@ -1075,6 +1076,77 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
>>   	return ret;
>>   }
>>
>> +
>> +#if defined(CONFIG_CONSOLE_POLL)
>> +static int imx_poll_get_char(struct uart_port *port)
>> +{
>> +	volatile unsigned int status;
>> +	unsigned int cr1, cr2, cr3;
>> +	unsigned char c;
>> +
>> +	/* save control registers */
>> +	cr1 = readl(port->membase + UCR1);
>> +	cr2 = readl(port->membase + UCR2);
>> +	cr3 = readl(port->membase + UCR3);
>> +
>> +	/* disable interrupts */
>> +	writel(UCR1_UARTEN, port->membase + UCR1);
>> +	writel(cr2&  ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
>> +	       port->membase + UCR2);
>> +	writel(cr3&  ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
>> +
>> +	/* poll */
>> +	do {
>> +		status = readl(port->membase + USR2);
>> +	} while (~status&  USR2_RDR);
>> +
>> +	/* read */
>> +	c = readl(port->membase + URXD0);
>> +
>> +	/* restore control registers */
>> +	writel(cr1, port->membase + UCR1);
>> +	writel(cr2, port->membase + UCR2);
>> +	writel(cr3, port->membase + UCR3);
>> +
>> +	return (c&  0xff);
>> +}
>> +
>> +static void imx_poll_put_char(struct uart_port *port, unsigned char c)
>> +{
>> +	volatile unsigned int status;
>> +	unsigned int cr1, cr2, cr3;
>> +
>> +	/* save control registers */
>> +	cr1 = readl(port->membase + UCR1);
>> +	cr2 = readl(port->membase + UCR2);
>> +	cr3 = readl(port->membase + UCR3);
>> +
>> +	/* disable interrupts */
>> +	writel(UCR1_UARTEN, port->membase + UCR1);
>> +	writel(cr2&  ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
>> +	       port->membase + UCR2);
>> +	writel(cr3&  ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
>> +
>> +	/* drain */
>> +	do {
>> +		status = readl(port->membase + USR1);
>> +	} while (~status&  USR1_TRDY);
>> +
>> +	/* write */
>> +	writel(c, port->membase + URTX0);
>> +
>> +	/* flush */
>> +	do {
>> +		status = readl(port->membase + USR2);
>> +	} while (~status&  USR2_TXDC);
>> +
>> +	/* restore control registers */
>> +	writel(cr1, port->membase + UCR1);
>> +	writel(cr2, port->membase + UCR2);
>> +	writel(cr3, port->membase + UCR3);
>> +}
>
> We should factor out the uart save/restore functionality instead of
> having the same code three times in the driver. I'm thinking about:
>
> imx_console_mode(struct uart_port *port, u32 *ucr1, u32 *ucr2, u32 *ucr2);
> imx_console_restore(struct uart_port *port, u32 ucr1, u32 ucr2, u32 ucr3);
>
> These functions could correctly handle ucr3 (which is missing in
> mainline) and i.MX1 (which is missing in your patch).

What's about anything like this? [1] [2]

Best regards

Dirk

[1]
From: Dirk Behme <dirk.behme@gmail.com>
Subject: [PATCH 1/2] imx: Add save/restore functions for UART control regs

Factor out the uart save/restore functionality instead of
having the same code several times in the driver.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
CC: Saleem Abdulrasool <compnerd@compnerd.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
CC: linux-serial at vger.kernel.org
---
  drivers/tty/serial/imx.c |   38 +++++++++++++++++++++++++++++++-------
  1 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..6a01c2a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -260,6 +260,31 @@ static inline int is_imx21_uart(struct imx_port 
*sport)
  }

  /*
+ * Save and restore functions for UCR1, UCR2 and UCR3 registers
+ */
+static void imx_console_mode(struct uart_port *port,
+			     unsigned int *ucr1,
+			     unsigned int *ucr2,
+			     unsigned int *ucr3)
+{
+	/* save control registers */
+	*ucr1 = readl(port->membase + UCR1);
+	*ucr2 = readl(port->membase + UCR2);
+	*ucr3 = readl(port->membase + UCR3);
+}
+
+static void imx_console_restore(struct uart_port *port,
+				unsigned int ucr1,
+				unsigned int ucr2,
+				unsigned int ucr3)
+{
+	/* restore control registers */
+	writel(ucr1, port->membase + UCR1);
+	writel(ucr2, port->membase + UCR2);
+	writel(ucr3, port->membase + UCR3);
+}
+
+/*
   * Handle any change of modem status signal since we were last called.
   */
  static void imx_mctrl_check(struct imx_port *sport)
@@ -1118,13 +1143,13 @@ static void
  imx_console_write(struct console *co, const char *s, unsigned int count)
  {
  	struct imx_port *sport = imx_ports[co->index];
-	unsigned int old_ucr1, old_ucr2, ucr1;
+	unsigned int old_ucr1, old_ucr2, old_ucr3, ucr1;

  	/*
-	 *	First, save UCR1/2 and then disable interrupts
+	 *	First, save UCR1/2/3 and then disable interrupts
  	 */
-	ucr1 = old_ucr1 = readl(sport->port.membase + UCR1);
-	old_ucr2 = readl(sport->port.membase + UCR2);
+	imx_console_mode(&sport->port, &old_ucr1, &old_ucr2, &old_ucr3);
+	ucr1 = old_ucr1;

  	if (is_imx1_uart(sport))
  		ucr1 |= IMX1_UCR1_UARTCLKEN;
@@ -1139,12 +1164,11 @@ imx_console_write(struct console *co, const 
char *s, unsigned int count)

  	/*
  	 *	Finally, wait for transmitter to become empty
-	 *	and restore UCR1/2
+	 *	and restore UCR1/2/3
  	 */
  	while (!(readl(sport->port.membase + USR2) & USR2_TXDC));

-	writel(old_ucr1, sport->port.membase + UCR1);
-	writel(old_ucr2, sport->port.membase + UCR2);
+	imx_console_restore(&sport->port, old_ucr1, old_ucr2, old_ucr3);
  }

  /*
-- 
1.7.7.4

[2]
From: Saleem Abdulrasool <compnerd@compnerd.org>
Subject: [PATCH 2/2 v2] imx: add polled io uart methods

These methods are invoked if the iMX uart is used in conjuction with 
kgdb during
early boot.  In order to access the UART without the interrupts, the 
kernel uses
the basic polling methods for IO with the device.  With these methods
implemented, it is now possible to enable kgdb during early boot over 
serial.

Signed-off-by: Saleem Abdulrasool <compnerd@compnerd.org>
Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
CC: linux-serial at vger.kernel.org
---
Note: Changes in the v2 compared to Saleem's original version:
       * Remove volatile form status variable
       * Remove blank line
       * Factor out imx_console_mode/restore()

  drivers/tty/serial/imx.c |   66 
++++++++++++++++++++++++++++++++++++++++++++++
  1 files changed, 66 insertions(+), 0 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 6a01c2a..cd81ac0 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -102,6 +102,7 @@
  #define  UCR2_STPB       (1<<6)	 /* Stop */
  #define  UCR2_WS         (1<<5)	 /* Word size */
  #define  UCR2_RTSEN      (1<<4)	 /* Request to send interrupt enable */
+#define  UCR2_ATEN       (1<<3)  /* Aging Timer Enable */
  #define  UCR2_TXEN       (1<<2)	 /* Transmitter enabled */
  #define  UCR2_RXEN       (1<<1)	 /* Receiver enabled */
  #define  UCR2_SRST 	 (1<<0)	 /* SW reset */
@@ -1104,6 +1105,66 @@ imx_verify_port(struct uart_port *port, struct 
serial_struct *ser)
  	return ret;
  }

+#if defined(CONFIG_CONSOLE_POLL)
+static int imx_poll_get_char(struct uart_port *port)
+{
+	unsigned int status, cr1, cr2, cr3;
+	unsigned char c;
+
+	/* save control registers */
+	imx_console_mode(port, &cr1, &cr2, &cr3);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
+
+	/* poll */
+	do {
+		status = readl(port->membase + USR2);
+	} while (~status & USR2_RDR);
+
+	/* read */
+	c = readl(port->membase + URXD0);
+
+	/* restore control registers */
+	imx_console_restore(port, cr1, cr2, cr3);
+
+	return c & 0xff;
+}
+
+static void imx_poll_put_char(struct uart_port *port, unsigned char c)
+{
+	unsigned int status, cr1, cr2, cr3;
+
+	/* save control registers */
+	imx_console_mode(port, &cr1, &cr2, &cr3);
+
+	/* disable interrupts */
+	writel(UCR1_UARTEN, port->membase + UCR1);
+	writel(cr2 & ~(UCR2_ATEN | UCR2_RTSEN | UCR2_ESCI),
+	       port->membase + UCR2);
+	writel(cr3 & ~(UCR3_DCD | UCR3_RI | UCR3_DTREN), port->membase + UCR3);
+
+	/* drain */
+	do {
+		status = readl(port->membase + USR1);
+	} while (~status & USR1_TRDY);
+
+	/* write */
+	writel(c, port->membase + URTX0);
+
+	/* flush */
+	do {
+		status = readl(port->membase + USR2);
+	} while (~status & USR2_TXDC);
+
+	/* restore control registers */
+	imx_console_restore(port, cr1, cr2, cr3);
+}
+#endif
+
  static struct uart_ops imx_pops = {
  	.tx_empty	= imx_tx_empty,
  	.set_mctrl	= imx_set_mctrl,
@@ -1121,6 +1182,11 @@ static struct uart_ops imx_pops = {
  	.request_port	= imx_request_port,
  	.config_port	= imx_config_port,
  	.verify_port	= imx_verify_port,
+
+#if defined(CONFIG_CONSOLE_POLL)
+	.poll_get_char  = imx_poll_get_char,
+	.poll_put_char  = imx_poll_put_char,
+#endif
  };

  static struct imx_port *imx_ports[UART_NR];
-- 
1.7.7.4





-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-imx-Add-save-restore-functions-for-UART-control-regs.patch
Type: text/x-patch
Size: 2728 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111204/7a2ff7dd/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-imx-add-polled-io-uart-methods.patch
Type: text/x-patch
Size: 3603 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20111204/7a2ff7dd/attachment-0001.bin>
