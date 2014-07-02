From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 2 Jul 2014 22:28:17 +0200
Subject: [PATCH 0/3] ARM: mvebu: disable I/O coherency on !SMP
In-Reply-To: <20140702175857.GR32514@n2100.arm.linux.org.uk>
References: <1404318070-8503-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20140702164147.GQ32514@n2100.arm.linux.org.uk>
 <20140702191832.5e9f35fc@free-electrons.com>
 <20140702175857.GR32514@n2100.arm.linux.org.uk>
Message-ID: <20140702222817.1262a7b0@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Wed, 2 Jul 2014 18:58:57 +0100, Russell King - ARM Linux wrote:

> You say that, but Dove is PJ4B too (I forget whether it's PJ4B or not.)
> The only way to be sure is to compare the ID numbers.  The AP510 in
> Dove I have here has an ID register value of 0x560f5815.  This ties up
> with the PJ4B entry in proc-v7.S:
> 
>         .type   __v7_pj4b_proc_info, #object
> __v7_pj4b_proc_info:
>         .long   0x560f5800
>         .long   0xff0fff00
>         __v7_proc __v7_pj4b_setup, proc_fns = pj4b_processor_functions
>         .size   __v7_pj4b_proc_info, . - __v7_pj4b_proc_info
> 
> How does that compare to the ID you see on Armada 370 and XP?  (I've
> no idea what IDs you get there...)  If the ID is different, then we
> should be able to solve this pretty easily for these CPUs by creating
> a new proc_info record as I think I have previously suggested.

The ID for Armada 370 is 0x560f5811, but the last digit is the "Product
Revision Number", so I'm not sure it can be used to distinguish Dove
from Armada 370. However, I believe we could simply run Dove in a
Write-Allocate cache policy.

> With a separate record, we can set the S bit if we need to, and we can
> also set the write-allocate mode too, now that the patch I sent you
> is in mainline (which is something I definitely indicated along with
> that patch.)
> 
> I've not really said anything new in this email which I haven't said
> before, with the exception of stating what the ID is for the Dove SoC
> I have.  That's the only ID I know, and I assume that those working on
> mvebu have a better idea what ID numbers are found across all the
> families.

Russell, please again what I've asked numerous times. I already wrote
the patches that creates specific proc_info structures for Armada 370
and Armada XP to set the cache policy and S bit, as you suggested. But
this is only setting the PMD flags, but doesn't touch the TTB flags,
which remain only defined by ALT_UP/ALT_SMP conditional. And I remember
Catalin saying that having PMD flags varying from the TTB flags could
be a problem.

That is the question I'm asking to you since several e-mails that you
never answered, and that is completely unrelated to having separate
proc_info structure, because the TTB flags are *not* defined in the
proc_info structure.

Sorry to be a bit harsh here but you seem to assume that I'm an idiot
who didn't read what you said, and you simply repeat again and again
that your patch already solves the problem by allowing the proc_info
structure to define the PMD flags. But you never answered my question
about the TTB flags, which is the question I've been asking since
several e-mails already.

See the two attached patches for what I've already done for Armada 370
and Armada XP using the proc_info structures. Writing those patches
lead me to the problem of the TTB flags, which remains unanswered.

Thanks for your help!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ARM-mm-split-PJ4B-and-PJ4B-MP.patch
Type: text/x-patch
Size: 1231 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/c8f38af7/attachment.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-ARM-mm-set-appropriate-mm_mmuflags-for-PJ4B-variants.patch
Type: text/x-patch
Size: 1222 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140702/c8f38af7/attachment-0001.bin>
