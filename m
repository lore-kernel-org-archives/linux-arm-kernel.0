From: monstr@monstr.eu (Michal Simek)
Date: Wed, 30 Oct 2013 15:32:09 +0100
Subject: [PATCH] ARM: mm: Fix ECC mem policy printk
In-Reply-To: <5271165A.4050509@monstr.eu>
References: <8986e8f1a3761e45a7927bdb0e54393c9155e6bf.1383137171.git.michal.simek@xilinx.com>
 <20131030130728.GA16735@n2100.arm.linux.org.uk> <5271165A.4050509@monstr.eu>
Message-ID: <52711869.60703@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 03:23 PM, Michal Simek wrote:
> On 10/30/2013 02:07 PM, Russell King - ARM Linux wrote:
>> On Wed, Oct 30, 2013 at 01:46:18PM +0100, Michal Simek wrote:
>>> Russell, Will: We discussed this at KS that will be good
>>> to rephrase it or have different logic around this.
>>> I am not sure if we can also test that this bit is
>>> implemented by particular SoC or not.
>>>
>>> Maybe logic should be that if SoC uses this bit
>>> that message is shown in origin format to declare
>>> that ECC is enabled or disabled.
>>> When SoC doesn't implement it then do not show this message.
>>
>> This is not quite what I meant - by making the change you have, you also
>> omit to print the data cache policy.
>>
>>> @@ -556,8 +556,9 @@ static void __init build_mem_type_table(void)
>>>  		mem_types[MT_CACHECLEAN].prot_sect |= PMD_SECT_WB;
>>>  		break;
>>>  	}
>>> -	printk("Memory policy: ECC %sabled, Data cache %s\n",
>>> -		ecc_mask ? "en" : "dis", cp->policy);
>>> +	if (ecc_mask)
>>> +		pr_info("Memory policy: ECC enabled, Data cache %s\n",
>>> +			cp->policy);
>>
>> 	pr_info("Memory policy: %sData cache %s\n",
>> 		ecc_mask ? "ECC enabled, " : "", cp->policy);
>>
>> is more what I was suggesting.
> 
> If this is what you would like to see it there, I am fine with that too.

btw: passing ecc=on through command line will caused that "ECC enabled" message
will be there even on systems which don't implement this bit.
It is just side effect for both these solutions.
Isn't there any easy way to test if this bit is implemented or not just by setting
it up and clear it?

Thanks,
Michal
-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131030/6574db73/attachment.sig>
