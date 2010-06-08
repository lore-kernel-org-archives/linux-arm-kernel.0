From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 8 Jun 2010 14:20:18 +0300
Subject: [PATCH 3/3 v3] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <4C0CA7F8.3080506@alcatel-lucent.com>
References: <alpine.LFD.2.00.1006031224180.24526@xanadu.home>
	<1275819882-8373-1-git-send-email-saeed@marvell.com>
	<4C0CA7F8.3080506@alcatel-lucent.com>
Message-ID: <AANLkTilEM81aUCdIaTyN1s8es6LMETuMOGXh3a67sWgf@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 7, 2010 at 11:04 AM, Benjamin Zores
<benjamin.zores@alcatel-lucent.com> wrote:
> On 06/06/2010 12:24, Saeed Bishara wrote:
>>
>> This patch extens the kirkwood's PCIe support up to 2 controllers as in
>> the 6282 devices.
>>
>> diff --git a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
>> b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
>> index 39bdf4b..c428348 100644
>> --- a/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
>> +++ b/arch/arm/mach-kirkwood/db88f6281-bp-setup.c
>> @@ -74,9 +74,15 @@ static void __init db88f6281_init(void)
>>
>> ?static int __init db88f6281_pci_init(void)
>> ?{
>> - ? ? ? if (machine_is_db88f6281_bp())
>> - ? ? ? ? ? ? ? kirkwood_pcie_init();
>> + ? ? ? if (machine_is_db88f6281_bp()) {
>> + ? ? ? ? ? ? ? u32 dev, rev;
>>
>> + ? ? ? ? ? ? ? kirkwood_pcie_id(&dev,&rev);
>> + ? ? ? ? ? ? ? if (dev == MV88F6282_DEV_ID)
>> + ? ? ? ? ? ? ? ? ? ? ? kirkwood_pcie_init(KW_PCIE1 | KW_PCIE0);
>> + ? ? ? ? ? ? ? else
>> + ? ? ? ? ? ? ? ? ? ? ? kirkwood_pcie_init(KW_PCIE0);
>> + ? ? ? }
>> ? ? ? ?return 0;
>>
>
> This is still not likely to be possible: I don't think a given board can
> have 2 different SoCs.
well, it works because the 6282 is "pin-compatible" to 6281 and the
differences between the two boards are the additional pcie and few
mpps that set by the bootloader.
>
>> +#define CGC_PEX1 ? ? ? ? ? ? ? (1<< ?18)
>> ?#define CGC_GE1 ? ? ? ? ? ? ? ? ? ? ? (1<< ?19)
>> ?#define CGC_TDM ? ? ? ? ? ? ? ? ? ? ? (1<< ?20)
>> ?#define CGC_RESERVED ? ? ? ? ?((1<< ?18) | (0x6<< ?21))
>>
>
> (1 << 18) is no longer reserved.
>
> Except from that you still miss the mapping definition and phy
> initialization in common.c
>
> See
> http://lists.infradead.org/pipermail/linux-arm-kernel/2010-June/017176.html
> for details.
I applied your comments except to the io table, I don't think it's
worth to add, the pcie0 entry is always added even if that interface
is not used.
saeed
