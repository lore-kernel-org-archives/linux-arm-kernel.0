From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 19 Jul 2011 21:34:01 +0200
Subject: S3C6410 UART resume problem
Message-ID: <1534460.6WAISbrX4v@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

List,

I am experiencing a strange issue with UART ports on a Tiny6410 board, based 
on the S3C6410 SoC (hardware wise same as the Mini6410 supported by Linux), 
after enabling CONFIG_PM and suspending the SoC.

After triggering a wakeup event, it resumes till arch_suspend_enable_irqs() 
called by suspend_enter() and starts to get hammered by infinite amounts of 
UART interrupts.

I have tracked this down to disabling UART PCLK clock on suspend and the 
bootloader/reset/power down/whatever leaving the UART in an undefined state 
with interrupt bits set (specifically Tx interrupt), with the masked clock 
making it impossible to ack them by plat-samsung/irq-uart.c.

Any suggestions how to solve this problem?

Best regards,
Tomasz Figa
