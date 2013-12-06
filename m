From: hrhaan@gmail.com (Harro Haan)
Date: Fri, 6 Dec 2013 13:39:09 +0100
Subject: i.MX6/PCIe and MSI interrupts
In-Reply-To: <201312061243.56069.marex@denx.de>
References: <201312061032.31944.jbe@pengutronix.de>
 <201312061243.56069.marex@denx.de>
Message-ID: <CAB5oZtC_X6Tk+6c5sZB06kDmhOgqmqW0_QG1GKWAJgqNpg2tag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6 December 2013 12:43, Marek Vasut <marex@denx.de> wrote:
> On Friday, December 06, 2013 at 10:32:31 AM, J?rgen Beisert wrote:
>> Hi,
>>
>> is anybody out there who has MSI interrupts successfully working on i.MX6?
>> I tried with my i.MX6 and a Gbit network card but without success. In
>> legacy interrupt mode it works.
>
> What precise model of card do you use ? Do you have a PCIe switch in the path or
> just direct RC-EP connection ?
>
>> I'm using various patches here from the list and the PCIe itself works. The
>> designware driver is prepared for MSI interrupts and the Exynos driver
>> makes use of it.
>
> OK
>
>> I added the same glue code to the i.MX6 driver but I can't get the INTD
>> interrupt to fire when MSI arrives (while the INTA fires in legacy
>> interrupt mode). Some idea what needs to be done in the i.MX6 to get MSI
>> working? The Exynos driver additionally changes some bits in its chipset
>> beside the PCIe unit to enable the MSI interrupt to its CPU. Are there
>> some 'hidden' bits in the i.MX6 as well?
>
> Can you post your prototype patch for the PCIe MSI so we can see what you did
> there please?

Attached are my patches of the first attempt to get MSI working for
the i.MX6. It looks like MSI is working but MSIX is not in combination
with e1000e and SabreSD. I did some successful iperf tests in MSI
mode. I did the following hack in
drivers/net/ethernet/intel/e1000e/param.c to disable MSIX:

-		if (adapter->flags & FLAG_HAS_MSIX) {
+		if (!(adapter->flags & FLAG_HAS_MSIX)/*TEMP*/) {

In MSIX mode, the imx6_pcie_msi_irq_handler occurs, but
e1000_intr_msix_rx, e1000_intr_msix_tx or e1000_intr_msix_other does
not get called.

My MSI tests are not successful when testing it with a Xilinx PCIe
development board, while this FPGA design works properly with FSL
imx_3.0.35 (or on x86).

Best regards,

Harro
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-dts-imx6qdl.dtsi-add-msi-interrupt.patch
Type: text/x-patch
Size: 1056 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/c0c0bb8e/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-PCI-imx6-add-support-for-MSI.patch
Type: text/x-patch
Size: 2085 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131206/c0c0bb8e/attachment-0001.bin>
