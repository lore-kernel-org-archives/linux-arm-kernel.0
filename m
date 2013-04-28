From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 28 Apr 2013 13:37:01 +1200
Subject: Array subscript above array bounds warning
In-Reply-To: <517C653B.7050908@elopez.com.ar>
References: <517C5F56.7040106@prisktech.co.nz> <517C653B.7050908@elopez.com.ar>
Message-ID: <517C7D3D.50207@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28/04/13 11:54, Emilio L?pez wrote:
> El 27/04/13 20:29, Tony Prisk escribi?:
>> Could someone clarify for me what I am missing here?
>>
>>
>> in drivers/net/ethernet/via/velocity.h is the following definition:
>>
>> struct mac_regs {
>> volatile u8 PAR[6]; /* 0x00 */
>> ...
>> }
>>
>> I am trying to add the following function but it keeps giving array
>> bounds warnings:
>>
>> static void velocity_set_power_state(struct velocity_info *vptr, char
>> state)
>> {
>> struct mac_regs __iomem *regs = vptr->mac_regs;
>>
>> if (vptr->bustype == BUS_PCI) {
>> pci_set_power_state(vptr->pdev, state);
>> } else {
>> writeb(state, (&regs->PAR[0]) + 0x154);
> This would be equivalent to
>
> writeb(state, regs->PAR + 0x154);
>
> or
>
> writeb(state, &regs->PAR[340]);
>
> Which would be out of bounds, right? As it's an u8 array with just 6
> elements, not 341+
Yeah sorry - stupid question.

I just thought about the code while out for a walk and realised I should 
have looked at what the original author was trying to do rather than 
copy it verbatim.I have solved the issue now.

Regards
Tony P
