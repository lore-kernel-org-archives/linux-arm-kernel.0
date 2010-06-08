From: saeed.bishara@gmail.com (saeed bishara)
Date: Tue, 8 Jun 2010 15:49:43 +0300
Subject: [PATCH 3/3 v4] [ARM] Kirkwood: add support for PCIe1
In-Reply-To: <4C0E3AEC.8040304@alcatel-lucent.com>
References: <AANLkTilEM81aUCdIaTyN1s8es6LMETuMOGXh3a67sWgf@mail.gmail.com>
	<1275996094-16929-1-git-send-email-saeed@marvell.com>
	<4C0E2CF0.3050307@alcatel-lucent.com>
	<AANLkTilq6R6_9aEBZ66mSnMe5GsOLYDqP4qbQQHJsb8b@mail.gmail.com>
	<4C0E3AEC.8040304@alcatel-lucent.com>
Message-ID: <AANLkTikCo3oDxCiBrIMYjTlbvvvSt0ugR8MvsJQ0lPdn@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 8, 2010 at 3:43 PM, Benjamin Zores
<benjamin.zores@alcatel-lucent.com> wrote:
> On 08/06/2010 14:20, saeed bishara wrote:
>>
>> On Tue, Jun 8, 2010 at 2:43 PM, Benjamin Zores
>> <benjamin.zores@alcatel-lucent.com> ?wrote:
>>
>>>
>>> On 08/06/2010 13:21, Saeed Bishara wrote:
>>>
>>>>
>>>> @@ -106,17 +108,21 @@ void __init kirkwood_setup_cpu_mbus(void)
>>>> ? ? ? ? ? ? ? ? ? ? ?TARGET_PCIE, ATTR_PCIE_IO,
>>>> KIRKWOOD_PCIE_IO_BUS_BASE);
>>>> ? ? ? ?setup_cpu_win(1, KIRKWOOD_PCIE_MEM_PHYS_BASE,
>>>> KIRKWOOD_PCIE_MEM_SIZE,
>>>> ? ? ? ? ? ? ? ? ? ? ?TARGET_PCIE, ATTR_PCIE_MEM,
>>>> KIRKWOOD_PCIE_MEM_BUS_BASE);
>>>> + ? ? ? setup_cpu_win(2, KIRKWOOD_PCIE1_IO_PHYS_BASE,
>>>> KIRKWOOD_PCIE1_IO_SIZE,
>>>> + ? ? ? ? ? ? ? ? ? ? TARGET_PCIE, ATTR_PCIE1_IO,
>>>> KIRKWOOD_PCIE1_IO_BUS_BASE);
>>>> + ? ? ? setup_cpu_win(3, KIRKWOOD_PCIE1_MEM_PHYS_BASE,
>>>> KIRKWOOD_PCIE1_MEM_SIZE,
>>>> + ? ? ? ? ? ? ? ? ? ? TARGET_PCIE, ATTR_PCIE1_MEM,
>>>> KIRKWOOD_PCIE1_MEM_BUS_BASE);
>>>>
>>>>
>>>>
>>>
>>> I'd have used an id, and incremented it at each setup_cpu_win() call.
>>> Also only doing the last 2 calls on 6282.
>>>
>>>
>>>>
>>>> ? ? ? ?/* Make sure those units are accessible */
>>>> - ? ? ? writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0,
>>>> CLOCK_GATING_CTRL);
>>>> + ? ? ? writel(curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0 | CGC_PEX1,
>>>> CLOCK_GATING_CTRL);
>>>>
>>>>
>>>>
>>>
>>> Why not (pseudo code):
>>>
>>> int flags = curr | CGC_SATA0 | CGC_SATA1 | CGC_PEX0;
>>> if (6282) flags |= CGC_PEX1;
>>> writel(flags, ...);
>>>
>>>
>>>>
>>>> + ? ? ? /* For PCIe 1: first shutdown the phy */
>>>> + ? ? ? if (dev == MV88F6282_DEV_ID) {
>>>> + ? ? ? ? ? ? ? if (!(kirkwood_clk_ctrl& ? ?CGC_PEX1)) {
>>>> + ? ? ? ? ? ? ? ? ? ? ? writel(readl(PCIE1_LINK_CTRL) | 0x10,
>>>> PCIE1_LINK_CTRL);
>>>> + ? ? ? ? ? ? ? ? ? ? ? while (1)
>>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? if (readl(PCIE1_STATUS)& ? ?0x1)
>>>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? break;
>>>> + ? ? ? ? ? ? ? ? ? ? ? writel(readl(PCIE1_LINK_CTRL)& ? ?~0x10,
>>>> PCIE1_LINK_CTRL);
>>>> + ? ? ? ? ? ? ? }
>>>> + ? ? ? } else ?/* keep this bit set for devices that don't have PCIe1
>>>> */
>>>> + ? ? ? ? ? ? ? kirkwood_clk_ctrl |= CGC_PEX1;
>>>>
>>>>
>>>>
>>>
>>> the else part is useless with the proposal above i guess.
>>>
>>> Except from that, when using your patch I was unable to boot kernel
>>> anymore
>>> on 6281 boards.
>>>
>>
>> can you try the patch I send regarding nand mpps?
>>
>
> Unfortunately no, I'm running on OpenRD currently.
does it boot if you remove the kirkwood_nand_init?
> Ben
>
