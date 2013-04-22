From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Apr 2013 15:17:19 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <20130418162232.GB23112@arm.com>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
 <20130408142406.GL17995@n2100.arm.linux.org.uk>
 <20130408155749.GS17476@mudshark.cambridge.arm.com>
 <CD54D5A4-2E19-49D9-B6E7-051F36AB5DF8@oracle.com>
 <20130416172258.GE3770@mudshark.cambridge.arm.com>
 <20130418162232.GB23112@arm.com>
Message-ID: <20130422141719.GJ14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 05:22:33PM +0100, Catalin Marinas wrote:
> I would rather add individual entries like atomicd. User space does not
> need to know whether LPAE is supported or not.

I'm not sure that userspace should know this detail.

| LDM, LDC, LDC2, LDRD, STM, STC, STC2, STRD, PUSH, POP, RFE, SRS, VLDM,
| VLDR, VSTM, and VSTR instructions are executed as a sequence of word-
| aligned word accesses. Each 32-bit word access is guaranteed to be
| single-copy atomic. The architecture does not require subsequences
| of two or more word accesses from the sequence to be single-copy
| atomic.
| 
| In an implementation that includes the Large Physical Address Extension,
| LDRD and STRD accesses to 64-bit aligned locations are 64-bit single-copy
| atomic as seen by translation table walks and accesses to translation
| tables.
| ...
| Load/store multiple instructions, such as LDM, LDRD, STM, and STRD,
| generate multiple word accesses, each of which is a separate access
| for the purpose of determining ordering.

Note carefully the wording in the ARM ARM in the second paragraph -
it's not saying that LDRD and STRD accesses are single-copy atomic
to all viewers, but it's limited to the translation tables.

Sure, you can argue that the translation tables are just normal memory
accesses, but in that case why use the above wording if not to permit
them to be multiple-copy accesses as stated in the paragraph above
and elsewhere in the ARM ARM in the paragraph below.

Maybe an error in the ARM ARM?  It doesn't seem wise through to permit
userspace to assume that LDRD/STRD are atomic in userspace given the
above wording unless the ARM ARM gets fixed.
