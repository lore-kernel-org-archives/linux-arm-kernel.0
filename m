From: hancock@sedsystems.ca (Robert Hancock)
Date: Mon, 26 Nov 2018 10:22:46 -0600
Subject: iMX6 PCIe MSI issues
In-Reply-To: <AM0PR0402MB357044467379F0C49D498ACA8CD70@AM0PR0402MB3570.eurprd04.prod.outlook.com>
References: <aad42775-52b6-6086-60a8-e45a17d50960@sedsystems.ca>
 <AM0PR0402MB357044467379F0C49D498ACA8CD70@AM0PR0402MB3570.eurprd04.prod.outlook.com>
Message-ID: <ce72540b-43c4-c9f5-10de-259bebc492af@sedsystems.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It doesn't appear that patch has any effect on this issue, because the
dw_handle_msi_irq function in question is never being called at all - I
added some printk messages to verify that.

I then suspected it could be some issues with an interrupt happening
during initialization blocking the processing of further interrupts, but
if I manually ack all of the possible interrupts by writing all ones to
the MSI Interrupt Status register,  I can see that the pending
interrupts are cleared, and if new interrupts are raised they show up in
that register again, but vector 152 for PCIe INTD/MSI is still not
asserted in the GIC. Manually asserting it by writing to the GIC pending
register causes the pending interrupts to be handled.

It's like the vector is somehow not hooked up to the GIC or there's some
other register that has to be set to enable the interrupts to actually
be raised that I'm not aware of, but I'm currently at a loss to explain it..

On 2018-11-25 7:53 p.m., Richard Zhu wrote:
> Hi Robert:
> Can you make reference to the following URL?
> 
> https://patchwork.ozlabs.org/patch/989802/
> It may be helpful.
> 
> 
> Best Regards
> Richard Zhu
> Office: 86-21-28937189
> Mobile: 86-13386059786
> 
> 
>> -----Original Message-----
>> From: Robert Hancock [mailto:hancock at sedsystems.ca]
>> Sent: 2018?11?24? 6:17
>> To: linux-arm-kernel at lists.infradead.org
>> Cc: Richard Zhu <hongxing.zhu@nxp.com>; l.stach at pengutronix.de
>> Subject: iMX6 PCIe MSI issues
>>
>> I am working with a custom FPGA PCI Express endpoint connected to an NXP
>> iMX6D processor running the 4.19.2 kernel. It seems happy using INTx
>> interrupts but when trying to enable MSI the device driver is not receiving any
>> interrupts.
>>
>> From some register poking I have figured out:
>> -the MSI address set on the PCIe device is correctly set in the iMX MSI
>> controller's MSI Controller Address register (0x1ffc820) -the interrupt vectors
>> are enabled in the MSI controller's Interrupt Enable register (0x1ffc828) -the
>> interrupt vectors are not masked in the MSI controller's Interrupt Mask
>> register (0x1ffc82c) -The MSI controller's Interrupt Status register (0x1ffc830)
>> shows that the requested interrupt vectors are pending -In the ARM GIC,
>> vector 152 (for msi_ctrl_int) is enabled in the IS enable register (0x00a01110),
>> but not set in the IS pending (0x00a01210) or IS active (0x00a01310) registers
>> -Vector 152 is not masked in the GPC interrupt mask (0x00a01310) -Vector
>> 152 is not active in the GPC interrupt status (0x00a01310)
>>
>> So it appears the MSI controller is receiving and recognizing the MSI from the
>> device, but the interrupt is not making it into the GIC for some reason. If I
>> manually set vector 152 to pending in the GIC, the dw_handle_msi_irq
>> handler in pci-designware-host.c does get called along with the interrupt
>> handler(s) for the PCIe device, so it appears the chain from that point on is
>> working:
>>
>> # devmem 0x00a01210 32 0x1000000
>>
>> I found someone else reporting this in 2014 with an unknown kernel version
>> on the NXP forums here, but with no resolution listed there:
>>
>> https://emea01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fcom
>> munity.nxp.com%2Fthread%2F318307&amp;data=02%7C01%7Chongxing.zhu
>> %40nxp.com%7C83e67fc00a0a488ed23908d651917763%7C686ea1d3bc2b4
>> c6fa92cd99c5c301635%7C0%7C0%7C636786082558025273&amp;sdata=c%
>> 2BATbyH0928oYCMejdXByUI9GSv5entWGgNlmZ4E7Nc%3D&amp;reserved=0
>>
>> Any ideas on what may be going wrong? My next step may be to try an older
>> kernel version to see if this got broken at some point.
>>
>> --
>> Robert Hancock
>> Senior Software Developer
>> SED Systems
>> Email: hancock at sedsystems.ca

-- 
Robert Hancock
Senior Software Developer
SED Systems
Email: hancock at sedsystems.ca
