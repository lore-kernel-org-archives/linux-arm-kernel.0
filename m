From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Apr 2013 15:28:30 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <20130422141719.GJ14496@n2100.arm.linux.org.uk>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
 <20130408142406.GL17995@n2100.arm.linux.org.uk>
 <20130408155749.GS17476@mudshark.cambridge.arm.com>
 <CD54D5A4-2E19-49D9-B6E7-051F36AB5DF8@oracle.com>
 <20130416172258.GE3770@mudshark.cambridge.arm.com>
 <20130418162232.GB23112@arm.com>
 <20130422141719.GJ14496@n2100.arm.linux.org.uk>
Message-ID: <20130422142830.GA7398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 22, 2013 at 03:17:19PM +0100, Russell King - ARM Linux wrote:
> On Thu, Apr 18, 2013 at 05:22:33PM +0100, Catalin Marinas wrote:
> > I would rather add individual entries like atomicd. User space does not
> > need to know whether LPAE is supported or not.
> 
> I'm not sure that userspace should know this detail.

Which detail, LPAE or atomic double accesses?

> | LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM,
> | VLDR, VSTM, and VSTR instructions are executed as a sequence of word-
> | aligned word accesses. Each 32-bit word access is guaranteed to be
> | single-copy atomic. The architecture does not require subsequences
> | of two or more word accesses from the sequence to be single-copy
> | atomic.
> | 
> | In an implementation that includes the Large Physical Address Extension,
> | LDRD and STRD accesses to 64-bit aligned locations are 64-bit single-copy
> | atomic as seen by translation table walks and accesses to translation
> | tables.
> | ...
> | Load/store multiple instructions, such as LDM, LDRD, STM, and STRD,
> | generate multiple word accesses, each of which is a separate access
> | for the purpose of determining ordering.
> 
> Note carefully the wording in the ARM ARM in the second paragraph -
> it's not saying that LDRD and STRD accesses are single-copy atomic
> to all viewers, but it's limited to the translation tables.

Yes, I raised this (in private I think) when Will proposed similar
kernel changes. But we discussed with the ARM architecture guys and even
though the ARM ARM states that this, in practice the CPUs just implement
full 64-bit atomic accesses.

> Sure, you can argue that the translation tables are just normal memory
> accesses, but in that case why use the above wording if not to permit
> them to be multiple-copy accesses as stated in the paragraph above
> and elsewhere in the ARM ARM in the paragraph below.
> 
> Maybe an error in the ARM ARM?  It doesn't seem wise through to permit
> userspace to assume that LDRD/STRD are atomic in userspace given the
> above wording unless the ARM ARM gets fixed.

Not an error in the ARM ARM but I don't think ARM is going to extend
this definition (not an easy process for such modifications). For
practical purposes, CPUs with LPAE implement 64-bit atomics and it's of
real benefit for some user-space cases.

Maybe a better alternative would be to add it via __v7_proc on
individual CPUs (A7 and A15).

-- 
Catalin
