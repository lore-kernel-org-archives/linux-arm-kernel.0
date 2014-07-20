From: xerofoify@gmail.com (Nick Krause)
Date: Sun, 20 Jul 2014 17:10:23 -0400
Subject: [PATCH] arm: Fix me in bios32.c
In-Reply-To: <20140720090935.GD21766@n2100.arm.linux.org.uk>
References: <1405829179-19476-1-git-send-email-xerofoify@gmail.com>
 <20140720090935.GD21766@n2100.arm.linux.org.uk>
Message-ID: <CAPDOMVgUwX47ToxSf__U6EYH8_xUpAJ3A43E2W3qO5g8bhy11w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 20, 2014 at 5:09 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Sun, Jul 20, 2014 at 12:06:19AM -0400, Nicholas Krause wrote:
>> This fixs a fix me in bios32.c for pci_fixup_it8152 as this if
>> statement is incorrect needs to be checked against the class bits
>> not the whole address for the two or conditions and since they don't
>> have define statements outside of their numeratical value.
>
> Unfortunately, this does not address the FIXME at all.  The FIXME does
> not state that the if statement is incorrect at all.
>
>> -     /* fixup for ITE 8152 devices */
>> -     /* FIXME: add defines for class 0x68000 and 0x80103 */
>>       if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
>> -         dev->class == 0x68000 ||
>> -         dev->class == 0x80103) {
>> +        (dev->class >> 8) == 0x680 ||
>> +        (dev->class >> 8) == 0x801) {
>
> The FIXME states that there should be defines for these values (0x68000
> and 0x80103).
>
> The FIXME statement itself is slightly wrong in that these values are
> *not* class IDs.  0x680 and 0x801 are the class ID values.
>
> We have definitions for class IDs 0x680 and 0x801 in
> include/linux/pci_ids.h, which are:
>
> #define PCI_CLASS_BRIDGE_OTHER          0x0680
> #define PCI_CLASS_SYSTEM_DMA            0x0801
>
> So, to fix the stated issue, without changing the functionality of the
> code, this is what I expected you to produce:
>
>         /* fixup for ITE 8152 devices */
>         if ((dev->class >> 8) == PCI_CLASS_BRIDGE_HOST ||
>             dev->class == PCI_CLASS_BRIDGE_OTHER << 8 ||
>             def->class == PCI_CLASS_SYSTEM_DMA << 8 | 0x03)
>
> The reason is that "PCI_CLASS_BRIDGE_OTHER << 8" evaluates to 0x68000
> and "PCI_CLASS_SYSTEM_DMA << 8 | 0x03" evaluates to 0x80103.  Therefore,
> the compiled code is the same as the original, because the actual
> numerical check is the same as it always was.
>
> As your solution results in a functional change to the code, that would
> introduce a new bug - it results in this test matching any PCI device
> with any programming interface for class "Bridge other" and "System DMA",
> whereas before the code was looking for a specific value there.
>
> Whether this results in the code incorrectly matching devices on the
> system(s) which use this code is difficult to know, so my only choice
> here is to reject your change.
>
> This is why my fellow kernel developers are asking you to stop trying to
> fix this stuff - unless you can produce provably correct patches (or at
> least patches that appear to have no functional change) then you are
> burdening people with your education, and you will get yourself an
> undesirable reputation.
>
> Even with patches which appear to have no functional change, some
> maintainers won't take them unless they have actually been tested on
> real hardware, or that other people agree that the change is a correct
> one.  That is because there is a long history of apparantly correct
> changes being made which result in subtle bugs.
>
> Bear in mind that a "FIXME" comment indicates that something is not
> fully correct in some way, and even though it may not be fully correct,
> the resulting code _works_ on the devices that it has been tested with.
> Fixing the "FIXME" may result in the code stopping working on those
> devices - especially if it changes the functionality of the code like
> your patch above.
>
> So, it's often best to leave FIXMEs alone if you don't know what the
> right solution should be.
>
> I hope you will pause, and think about the issues I've raised before
> continuing with your current project of trying to fix FIXMEs.
>
> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.

Hey Russell,
Fair enough. I thought it was wrong. I just guessed ,probably needed to search
for the define statements.
Cheers Nick
