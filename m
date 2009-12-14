From: maramaopercheseimorto@gmail.com (Alberto Panizzo)
Date: Mon, 14 Dec 2009 18:59:00 +0100
Subject: [PATCH 1/4] mfd: mc13783: Take care of semantic inversion
	between read and write value of two bits in POWER_MISCELLANEUS
	register.
In-Reply-To: <4B26799F.1020507@ru.mvista.com>
References: <1260808880.2022.98.camel@climbing-alby>
	<1260810776.2022.130.camel@climbing-alby>
	<4B26799F.1020507@ru.mvista.com>
Message-ID: <1260813540.2022.174.camel@climbing-alby>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il giorno lun, 14/12/2009 alle 20.45 +0300, Sergei Shtylyov ha scritto:
> > +     if (offset == MC13783_REG_POWER_MISCELLANEOUS)
> > +             buf &= !(MC13783_REGCTRL_PWGT1SPIEN |
> >   
> 
>    Are you sure ! shouldn't be ~ here?
> 
> > +                      MC13783_REGCTRL_PWGT2SPIEN);
> >   
> 
>    !(MC13783_REGCTRL_PWGT1SPIEN | MC13783_REGCTRL_PWGT2SPIEN) would 
> evaluate to 0 which is most probably not what you want.
> 
> WBR, Sergei 

For sure, you are right. The correct patch below..

PWGT1DRV and PWGT1DRV are two digital output controlled by two corresponding
hardware signals (Pin PWGTnEN) that are meant to be used to control core power
supplies.
The register MC13783_REG_POWER_MISCELLANEOUS contain the two control and
status bit (PWGTnSPIEN) where write and read meaning is summarised by 
the following table:

 Bit PWGTxSPIEN | Pin PWGTxEN | PWGTxDRV |  Read Back
   0 = default  |             |          | PWGTxSPIEN
 ---------------+-------------+----------+------------
       1        |      x      |   Low    |     0
       0        |      0      |   High   |     1
       0        |      1      |   Low    |     0

Writing a 1 to those bits will turn off the corresponding core
power supply. As there is no way to read back the value of 
PWGTnSPIEN, the behaviour chosen is to let always the hardware
control itself leaving those bits at the default value.

This patch is especially needed for manipulate the other bits
in the same register, where the read-modify-write operation
can produce unwanted power fault.

Signed-off-by: Alberto Panizzo <maramaopercheseimorto@gmail.com>
---
 drivers/mfd/mc13783-core.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/mc13783-core.c b/drivers/mfd/mc13783-core.c
index a1ade23..3953297 100644
--- a/drivers/mfd/mc13783-core.c
+++ b/drivers/mfd/mc13783-core.c
@@ -171,6 +171,9 @@ int mc13783_reg_read(struct mc13783 *mc13783, unsigned int offset, u32 *val)
 }
 EXPORT_SYMBOL(mc13783_reg_read);
 
+#define MC13783_REG_POWER_MISCELLANEOUS        34
+#define MC13783_REGCTRL_PWGT1SPIEN     (1 << 15)
+#define MC13783_REGCTRL_PWGT2SPIEN     (1 << 16)
 int mc13783_reg_write(struct mc13783 *mc13783, unsigned int offset, u32 val)
 {
        u32 buf;
@@ -187,6 +190,13 @@ int mc13783_reg_write(struct mc13783 *mc13783, unsigned int offset, u32 val)
 
        buf = 1 << 31 | offset << MC13783_REGOFFSET_SHIFT | val;
 
+       /* Take care of table 4-24 in Freescale MC13783IGPLDRM.pdf making
+        * the assumption that PWGTnDRV signals controls core power supplies
+        * that software must not disable. */
+       if (offset == MC13783_REG_POWER_MISCELLANEOUS)
+               buf &= ~(MC13783_REGCTRL_PWGT1SPIEN |
+                        MC13783_REGCTRL_PWGT2SPIEN);
+
        memset(&t, 0, sizeof(t));
 
        t.tx_buf = &buf;
-- 
1.6.3.3
