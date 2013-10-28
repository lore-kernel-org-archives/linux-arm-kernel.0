From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 28 Oct 2013 00:47:36 +0000
Subject: [PULL REQ] Big Endian initial patch series
In-Reply-To: <5262E2C7.7000106@codethink.co.uk>
References: <20131018205405.GA28835@codethink.co.uk>
 <20131019170954.GC25076@mudshark.cambridge.arm.com>
 <5262E2C7.7000106@codethink.co.uk>
Message-ID: <20131028004736.GG16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 19, 2013 at 08:51:35PM +0100, Ben Dooks wrote:
> On 19/10/13 18:09, Will Deacon wrote:
>> Hi Ben,
>>
>> A few nits here...
>>
>> Firstly, I'd suggest using [GIT PULL] instead of [PULL REQ] in the subject.
>> Many people filter on the first, so you might get missed with the latter.
>>
>> On Fri, Oct 18, 2013 at 09:54:05PM +0100, Ben Dooks wrote:
>>> This series has been well tested and it would be great to get this
>>> merged now. So here is the pull request:
>>>
>>> The following changes since commit 8b5ede69d24db939f52b47effff2f6fe1e83e08b:
>>>
>>>    powerpc/irq: Don't switch to irq stack from softirq stack (2013-10-07 14:19:39 -0700)
>>
>> Secondly, I'd suggest basing against a specific tag in mainline if possible,
>> rather than a random commit. I think -rc3 matches rmk's current
>> devel-stable branch.
>>
>>> are available in the git repository at:
>>>
>>>    ssh://git at git.baserock.org/delta/linux baserock/bjdooks/312-rc4/be/core-v2
>>
>> This is an ssh URL, so it can't be pulled without some form of
>> authentication! Use git:// instead for pull requests.
>>
>> It's also good form to put your pull requests on separate branches from what
>> you have been using for development, to make it clear that it is stable.
>> Another method is to use a signed tag (although this seems more common with
>> arm-soc than others).
>>
>> Do you think you could send another pull request please?
>
> Ok, sorted.

Pulled, but there was a conflict.  Please check this resolution (it's
copy'n'pasted).  I'll probably be in linux-next tomorrow in any case,
but any mistake here can be fixed.

Second thing, I prefer that pull requests have some blurb in them
describing what they are and the changes.  This makes composing my
pull request to Linus easier.

diff --cc arch/arm/kernel/head.S
index 54547947a4e9,a047acfa6b6d..000000000000
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@@ -602,28 -586,26 +606,39 @@@ __fixup_a_pv_table
        b       2f
  1:    add     r7, r3
        ldrh    ip, [r7, #2]
+ ARM_BE8(rev16 ip, ip)
 -      and     ip, 0x8f00
 -      orr     ip, r6  @ mask in offset bits 31-24
 +      tst     ip, #0x4000
 +      and     ip, #0x8f00
 +      orrne   ip, r6  @ mask in offset bits 31-24
 +      orreq   ip, r0  @ mask in offset bits 7-0
+ ARM_BE8(rev16 ip, ip)
        strh    ip, [r7, #2]
 +      ldrheq  ip, [r7]
 +      biceq   ip, #0x20
 +      orreq   ip, ip, r0, lsr #16
 +      strheq  ip, [r7]
  2:    cmp     r4, r5
        ldrcc   r7, [r4], #4    @ use branch for delay slot
        bcc     1b
        bx      lr
  #else
 +      moveq   r0, #0x400000   @ set bit 22, mov to mvn instruction
        b       2f
  1:    ldr     ip, [r7, r3]
+ #ifdef CONFIG_CPU_ENDIAN_BE8
+       @ in BE8, we load data in BE, but instructions still in LE
+       bic     ip, ip, #0xff000000
 -      orr     ip, ip, r6, lsl#24
++      tst     ip, #0x000f0000 @ check the rotation field
++      orrne   ip, ip, r6, lsl #24 @ mask in offset bits 31-24
++      biceq   ip, ip, #0x00004000 @ clear bit 22
++      orreq   ip, ip, r0, lsl #24 @ mask in offset bits 7-0
+ #else
        bic     ip, ip, #0x000000ff
 -      orr     ip, ip, r6      @ mask in offset bits 31-24
 +      tst     ip, #0xf00      @ check the rotation field
 +      orrne   ip, ip, r6      @ mask in offset bits 31-24
 +      biceq   ip, ip, #0x400000       @ clear bit 22
 +      orreq   ip, ip, r0      @ mask in offset bits 7-0
+ #endif
        str     ip, [r7, r3]
  2:    cmp     r4, r5
        ldrcc   r7, [r4], #4    @ use branch for delay slot
