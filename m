From: LW@KARO-electronics.de (=?utf-8?Q?Lothar_Wa=C3=9Fmann?=)
Date: Thu, 7 Apr 2011 13:21:44 +0200
Subject: [PATCH V4 0/4] add the GPMI controller driver for IMX23/IMX28
In-Reply-To: <4D9C4133.6080708%40freescale.com>
Message-ID: <19869.40520.368078.270732@ipc1.ka-ro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Huang Shijie writes:
> Does some one have any comments about this driver?
> 
I'm still not happy with the rom-helper code that IMO does not belong
in this driver.
You could enable CONFIG_MTD_CMDLINE_PARTS and add something like:
"mtdparts=gpmi-nfc-main:2m(gpmi-nfc-0-boot)ro,-(gpmi-nfc-general-use)"
to the kernel cmdline to achieve the same without any special code
inside the chip driver.

Also, I would integrate the code from the hal-*.c files into the main
file and remove all the function hooks, since the functions are the
same for all the current variants anyway. You might hook the 'begin()'
and 'is_ready()' functions which are the only ones that are different
in the current variants so that the distinction can be made once upon
initialization rather than on every function call:
+static int mx23_is_ready(struct gpmi_nfc_data *this, unsigned chip)
+{
+	struct resources  *resources = &this->resources;
+	uint32_t          mask;
+	uint32_t          reg;
+
+	mask = MX23_BM_GPMI_DEBUG_READY0 << chip;
+	reg = __raw_readl(resources->gpmi_regs + HW_GPMI_DEBUG);
+
+	return !!(reg & mask);
+}
+
+static void mx28_begin(struct gpmi_nfc_data *this)
+{
+	struct resources                 *resources = &this->resources;
{...]
+}
+
+static int mx28_is_ready(struct gpmi_nfc_data *this, unsigned chip)
+{
+	struct resources  *resources = &this->resources;
+	uint32_t          mask;
+	uint32_t          reg;
+
+	mask = MX28_BF_GPMI_STAT_READY_BUSY(1 << chip);
+	reg = __raw_readl(resources->gpmi_regs + HW_GPMI_STAT);
+
+	return !!(reg & mask);
+}
[...]
+static int gpmi_nfc_probe(struct platform_device *pdev)
[...]
+	if (CPU_IS_MX23()) {
+		this->is_ready = mx23_is_ready;
+	} else if (CPU_IS_MX28()) {
+		this->is_ready = mx28_is_ready;
+		this->begin = mx28_begin;
+	}
Since the begin() function is a NOP for i.MX23, the function pointer
could be left unassigned and the function only be called if the
pointer is not NULL or an empty function could be assigned.

Further I wouldn't name the macro for distinguishing the different
controller variants CPU_IS_... but something like GPMI_IS


Lothar Wa?mann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstra?e 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Gesch?ftsf?hrer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info at karo-electronics.de
___________________________________________________________
