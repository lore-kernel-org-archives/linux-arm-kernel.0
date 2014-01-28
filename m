From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Jan 2014 22:05:45 +0100
Subject: iop32x: gpio breakage after "instantiate GPIO from platform device"
Message-ID: <4202760.m9CxkiIWk3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 7b85b867b9904 "ARM: plat-iop: instantiate GPIO from platform
device" nicely cleaned up the gpio register access for iop, but
forgot one board that directly pokes into the gpio registers
to do a system reset.

That board no longer compiles, and this patch just disables
the code in question to work around it so I can locally build
randconfig again, but it needs to be fixed properly.

diff --git a/arch/arm/mach-iop32x/em7210.c b/arch/arm/mach-iop32x/em7210.c
index 177cd07..f3cb8e1 100644
--- a/arch/arm/mach-iop32x/em7210.c
+++ b/arch/arm/mach-iop32x/em7210.c
@@ -178,8 +178,10 @@ static struct platform_device em7210_serial_device = {
 
 void em7210_power_off(void)
 {
+#if 0
 	*IOP3XX_GPOE &= 0xfe;
 	*IOP3XX_GPOD |= 0x01;
+#endif
 }
 
 static void __init em7210_init_machine(void)
