From: james.morse@arm.com (James Morse)
Date: Wed, 22 Feb 2017 10:13:28 +0000
Subject: [PATCH V10 07/10] efi: print unrecognized CPER section
In-Reply-To: <20170222011241.GX21222@n2100.armlinux.org.uk>
References: <1487188282-2568-1-git-send-email-tbaicar@codeaurora.org>
 <1487188282-2568-8-git-send-email-tbaicar@codeaurora.org>
 <58AC9093.5020303@arm.com> <20170222011241.GX21222@n2100.armlinux.org.uk>
Message-ID: <58AD6448.1070301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/02/17 01:12, Russell King - ARM Linux wrote:
> On Tue, Feb 21, 2017 at 07:10:11PM +0000, James Morse wrote:
>> Hi Tyler,
>>
>> On 15/02/17 19:51, Tyler Baicar wrote:
>>> +	} else {
>>> +		const void *unknown_err;
>>> +
>>> +		unknown_err = acpi_hest_generic_data_payload(gdata);
>>> +		printk("%ssection type: %pUl\n", newpfx, sec_type);
>>> +		printk("%ssection length: %d\n", newpfx,
>>
>> Nit: please use the "%s""section... that this file consistently uses. This means
>> this code will still work as expected when someone adds '%ss' support to printk!
> 
> No.  That is wrong:
> 
> "%s""section" is stored in memory as bytes containing:
> 
> '%' 's' 's' 'e' 'c' 't' 'i' 'o' 'n'
> 
> whereas "%ssection" is stored in memory as bytes containing:
> 
> '%' 's' 's' 'e' 'c' 't' 'i' 'o' 'n'
> 
> They're exactly the same, so when printk() comes to parse the string, it
> sees exactly the same byte sequence.  So, the only thing that's happening
> is code obfuscation for no good reason what so ever.
> 
> If you don't believe me, run some build tests and look at the resulting
> strings... also look at the C standard.  "Adjacent string literal tokens
> are concatenated."
> 
> Please get rid of this obfuscation.

Sure, I was always told not do this, clearly I didn't think about it for very long!

This file otherwise consistently uses the now-weird "%s""otherstring" pattern.



Thanks,

James
