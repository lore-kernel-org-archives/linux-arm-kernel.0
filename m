From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue,  8 Oct 2013 18:31:27 -0700
Subject: [RFC] Stricter kernel memory permissions
Message-ID: <1381282292-25251-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is an RFC to add more page table protection to ARM. As has been alluded to
in the past[1], the ARM kernel unconditionally maps everything as RWX which
presents a security problem. This is a fairly straight port of what we've been
using for a while for mitigation and is mostly provided as an example. Some
notes:

1) The original design mapped regions with permissions (RX/RO/RW) as appropriate
and then mapped the rest of the memory RW. I couldn't find a way to do this
cleanly in all cases so I went for the alternate approach: map all memory as RW,
clear the mapping and the set up the new mapping. This has some increased trade
offs described in #2

2) Rather than lose the TLB bonus for section mappings, the regions to be mapped
RO/RX are aligned to at least section size. For the new method of
clearing/remapping, this bumps up the alignment requirement to PMD_SIZE. This
does result in losing a bit of memory which is unfortunate.

3) This has not been tested on LPAE based systems

4) kprobes is broken with this since the text section is now RO. We had some
patches to allow temporarily marking the text writeable, but those did not take
into account section restrictions on SMP systems. I can post the patches if
there is interest.

Credit for the original work goes to Larry Bassel. I reworked parts of the
patches and added some new code.

Thanks,
Laura

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2013-July/187822.html
