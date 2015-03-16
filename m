From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Mar 2015 19:52:55 +0000
Subject: Versatile Express randomly fails to boot - Versatile Express to
 be removed from nightly testing
In-Reply-To: <55072BF5.7030901@arm.com>
References: <20150315213330.GB8656@n2100.arm.linux.org.uk>
 <20150316000438.GD8656@n2100.arm.linux.org.uk>
 <20150316004239.GE8656@n2100.arm.linux.org.uk>
 <20150316093553.GF8656@n2100.arm.linux.org.uk>
 <20150316130419.GI8656@n2100.arm.linux.org.uk>
 <55071742.6000405@arm.com>
 <20150316181634.GK8656@n2100.arm.linux.org.uk>
 <55072BF5.7030901@arm.com>
Message-ID: <20150316195255.GM8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 16, 2015 at 07:16:05PM +0000, Sudeep Holla wrote:
> On 16/03/15 18:16, Russell King - ARM Linux wrote:
> >Can you dump the disassembly around this location for both CPU0 and CPU1
> >and the register values please?  I think it would be interesting to see
> >if they're both stuck on exactly the same address access.
> 
> (with v4.0-rc4 this time)

Thanks.

> CPU#0
> =====
...
> S:0x8021F80C : LSL      lr,r4,#3
> S:0x8021F810 : SUB      lr,lr,r4,LSL #1
> S:0x8021F814 : SUB      lr,lr,#6
> S:0x8021F818 : B        {pc}+8 ; 0x8021f820
> S:0x8021F81C : MOV      r5,r0
> S:0x8021F820 : LSR      r12,r1,lr
> S:0x8021F824 : SUB      lr,lr,#6
> S:0x8021F828 : AND      r12,r12,#0x3f
> S:0x8021F82C : ADD      r12,r12,#6
> S:0x8021F830 : LDR      r0,[r5,r12,LSL #2]
> 
> Core registers:
> R0           0x0000003F
> R1           0x00000010
> R2           0x00000000
> R3           0x00000000
> R4           0x00000001
> R5           0xBEC00000
> R6           0x00000000
> R7           0x00000000
> R8           0xBF004400
> R9           0x805F1F90
> R10          0x00000001
> R11          0x805EEB08
> R12          0xBEC00001
> SP           0x805F1EFC
> LR           0x00000000
> PC           0x8021F820
> CPSR         0x80000193
> 
> CPU#1
> =====
...
> S:0x8021F80C : LSL      lr,r4,#3
> S:0x8021F810 : SUB      lr,lr,r4,LSL #1
> S:0x8021F814 : SUB      lr,lr,#6
> S:0x8021F818 : B        {pc}+8 ; 0x8021f820
> S:0x8021F81C : MOV      r5,r0
> S:0x8021F820 : LSR      r12,r1,lr
> S:0x8021F824 : SUB      lr,lr,#6
> S:0x8021F828 : AND      r12,r12,#0x3f
> S:0x8021F82C : ADD      r12,r12,#6
> S:0x8021F830 : LDR      r0,[r5,r12,LSL #2]
> 
> Core registers:
> R0           0x0000003F
> R1           0x00000010
> R2           0x00000000
> R3           0x00000000
> R4           0x00000001
> R5           0xBEC00000
> R6           0xBF08BF94
> R7           0x00000000
> R8           0x805F92A0
> R9           0x00000000
> R10          0x00000000
> R11          0x00000000
> R12          0xBEC00001
> SP           0xBF08BF6C
> LR           0x00000000
> PC           0x8021F820
> CPSR         0x800001D3   Nzcvq_ge3ge2ge1ge0_inactive_eAIFtj_SVC

And we find that both CPUs have stopped at exactly the same place, which
is an arithmetic instruction.

If I had to guess, I'd say the reason it's stopped there (exactly on a
cache line boundary) is because both CPUs are waiting for an instruction
fetch to complete into its L1 I-cache, and for some reason, the L2
cache is not satisfying the request from either CPU.  The question of
course is... why not.

> >I guess one thing we need to confirm is whether we have exactly the same
> >hardware and firmware versions.  Here's my board's early boot messages:

Looks like we're broadly the same, apart from the boot loader version.
You have 1.1.2, whereas I have 1.1.1.

Co-incidentally, I just looked at the disassembly of my __radix_tree_lookup:

c0199750:       e0050495        mul     r5, r5, r4
c0199754:       e2455006        sub     r5, r5, #6
c0199758:       ea000000        b       c0199760 <__radix_tree_lookup+0x70>
c019975c:       e1a0c000        mov     ip, r0
c0199760:       e1a06531        lsr     r6, r1, r5
c0199764:       e206603f        and     r6, r6, #63     ; 0x3f
c0199768:       e2866006        add     r6, r6, #6
c019976c:       e79c0106        ldr     r0, [ip, r6, lsl #2]

The code is slightly different, but notice that the alignment of the
LSR instruction is the same as yours - at first I wondered whether that's
coincidence or not.  However, taking Olof's MMC changes back out of my
tree (which results in a booting kernel) makes no difference to the
placement of this code.

The start of the read-only data section doesn't change between the working
and non-working kernels, but the location of the spinlock and some scheduler
code does change (along with all the networking code.)

There's changes in the read-only data section, there's also changes to a
set of "descriptor.NNNNN" symbols towards the end of the data section,
which goes on to change the placement of the bss section.

The diff between the System.map is unpostable - it's about 1.3MB. :(

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
