From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2012 16:13:27 +0100
Subject: [PATCH] ARM: mutex: use generic atomic_dec-based implementation
 for ARMv6+
In-Reply-To: <20120713143026.GV18079@mudshark.cambridge.arm.com>
References: <1342177463-21238-1-git-send-email-will.deacon@arm.com>
 <201207131414.37078.arnd@arndb.de>
 <20120713143026.GV18079@mudshark.cambridge.arm.com>
Message-ID: <20120713151318.GW18079@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 03:30:26PM +0100, Will Deacon wrote:
> If Nicolas is happy with it, I'd be tempted to use mutex-xchg.h regardless
> of the architecture version (unfortunately we can't use generic-y for that).

So I looked at the disassambly for the mutex operations on ARMv7 when using
xchg compare with atomic decrement. The lock/unlock operations look pretty
much the same (essentially xchg moves an instruction out of the critical
section) although trylock looks pretty hairy at first glance:


 10c:   e1a03000        mov     r3, r0
 110:   f57ff05f        dmb     sy
 114:   e3a02000        mov     r2, #0
 118:   e1930f9f        ldrex   r0, [r3]
 11c:   e1831f92        strex   r1, r2, [r3]
 120:   e3310000        teq     r1, #0
 124:   1afffffb        bne     118 <mutex_trylock+0xc>
 128:   f57ff05f        dmb     sy
 12c:   e3500000        cmp     r0, #0
 130:   a12fff1e        bxge    lr

 134:   f57ff05f        dmb     sy
 138:   e1932f9f        ldrex   r2, [r3]
 13c:   e1831f90        strex   r1, r0, [r3]
 140:   e3310000        teq     r1, #0
 144:   1afffffb        bne     138 <mutex_trylock+0x2c>
 148:   f57ff05f        dmb     sy
 14c:   e1c20fc2        bic     r0, r2, r2, asr #31
 150:   e12fff1e        bx      lr


but it's really not all that bad, since that second hunk is only for the
contended case. In light of that, I'll post a v2 using the xchg-based
version unconditionally.

Will
