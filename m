From: hrhaan@gmail.com (Harro Haan)
Date: Thu, 12 Dec 2013 19:43:30 +0100
Subject: i.MX6/PCIe and MSI interrupts
In-Reply-To: <201312101512.01840.marex@denx.de>
References: <201312061032.31944.jbe@pengutronix.de>
 <CAB5oZtC_X6Tk+6c5sZB06kDmhOgqmqW0_QG1GKWAJgqNpg2tag@mail.gmail.com>
 <201312061515.50436.jbe@pengutronix.de>
 <201312101512.01840.marex@denx.de>
Message-ID: <CAB5oZtBg2ogFXFw=ndH=sHux3DddyRxe67hmue0anX0zvvS3EA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 December 2013 15:12, Marek Vasut <marex@denx.de> wrote:
> On Friday, December 06, 2013 at 03:15:50 PM, J?rgen Beisert wrote:
>> Hi Harro,
>>
>> On Friday 06 December 2013 13:39:09 Harro Haan wrote:
>> > [...]
>> > Attached are my patches of the first attempt to get MSI working for
>> > the i.MX6. It looks like MSI is working but MSIX is not in combination
>> > with e1000e and SabreSD. I did some successful iperf tests in MSI
>> > mode. I did the following hack in
>> > drivers/net/ethernet/intel/e1000e/param.c to disable MSIX:
>> >
>> > -           if (adapter->flags & FLAG_HAS_MSIX) {
>> > +           if (!(adapter->flags & FLAG_HAS_MSIX)/*TEMP*/) {
>>
>> Arrrgh, after applying this change it starts to work immediately. So many
>> hours...
>>
>> > My MSI tests are not successful when testing it with a Xilinx PCIe
>> > development board, while this FPGA design works properly with FSL
>> > imx_3.0.35 (or on x86).
>>
>> Same here. Network chip works with MSI, PCIe FPGA does not.
>
> Can you try patch from Message-ID: <20131210043409.GA2734@pratyush-vbox> ?

I assume you mean the following patch:
[PATCH 08/12] pcie: designware: Fix IO transfers
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/218048.html

This patch did not solve the problem with the FPGA design. After
further debugging it turned out that I was missing MSI IRQs. Therefore
the following patch is supplied:
[PATCH] pci: designware: fix missing msi irqs
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-December/218629.html

Regards,

Harro
