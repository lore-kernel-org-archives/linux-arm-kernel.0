From: tixy@yxit.co.uk (Tixy)
Date: Fri, 25 Mar 2011 21:19:04 +0000
Subject: [PATCH] kprobes/arm: fix emulation of LDR/STR instruction when
	Rn == PC
In-Reply-To: <1301072519-27937-1-git-send-email-viktor.rosendahl@nokia.com>
References: <1301072519-27937-1-git-send-email-viktor.rosendahl@nokia.com>
Message-ID: <1301087944.2744.85.camel@computer2.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-03-25 at 19:01 +0200, Viktor Rosendahl wrote:
> The Rn value from the emulation is unconditionally written back; this is fine
> as long as Rn != PC because in that case, even if the instruction isn't a write
> back instruction, it will only result in the same value being written back.
> 
> In case Rn == PC, then the emulated instruction doesn't have the actual PC
> value in Rn but an adjusted value; when this is written back, it will result in
> the PC being incorrectly updated.

It looks like we have the same problem with emulate_ldrd and
emulate_strd as well.

> An altenative solution would be to check bits 24 and 22 to see whether the
> instruction actually is a write back instruction or not. I think it's
> enough to check whether Rn != PC,  because:
> - it's looks cheaper than the alternative
> - to my understaning it's not permitted to update the PC with a write back
> instruction, so we don't lose any ability to emulate legal instructions.
> - in case of writing back for non write back instructions where Rn != PC, it
> doesn't matter because the values are the same.

I agree that the check for Rn != PC seems simplest and sufficient.

> Regarding the second point above, it would possibly be prudent to add some
> checking to prep_emulate_ldr_str(), so that instructions with write back and
> Rn == PC would be rejected.

I don't think it is worth adding code to check for illegal instructions.
The toolchain shouldn't generate them in the first place, and there are
many places in the kprobe code which doesn't bother checking; there are
even comments like "may be invalid, don't care".

[...]

I'm currently working on implementing Thumb support in kprobes and am
writing test code as part of that. I planned on adding test cases for
ARM so hopefully will catch a few more instruction emulation bugs (if
there are any to be found).

-- 
Tixy
