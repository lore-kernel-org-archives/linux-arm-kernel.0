From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Mar 2016 13:46:51 +0000
Subject: DWord alignment on ARMv7
In-Reply-To: <72900410.JPa1IHPXo5@wuerfel>
References: <56D8BA3F.7050508@pengutronix.de> <3093807.B56fh7Radq@wuerfel>
 <CAKv+Gu_HttHOutHAw-k_uwmTUGjUsTWCotVHroqRK0NQDOGkNg@mail.gmail.com>
 <72900410.JPa1IHPXo5@wuerfel>
Message-ID: <20160304134651.GB19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 04, 2016 at 02:30:23PM +0100, Arnd Bergmann wrote:
> Ah, I thought it only required 32-bit alignment like ldm/stm, but it
> seems that it won't do that. However, an implementation like
> 
> unsigned long long get_unaligned_u64(void *p)
> {
>         unsigned long long upper, lower;
>         lower = *(unsigned long*)p;
>         upper = *(unsigned long*)(p+4);
> 
>         return lower | (upper << 32);
> }
> 
> does get compiled into
> 
> 00000000 <f>:
>    0:   e8900003        ldm     r0, {r0, r1}
>    4:   e12fff1e        bx      lr

I think it may be something of a bitch to work around, because the
compiler is going to do stuff like that behind your back.

The only way around that would be to bypass the compiler by using
asm(), but then you end up bypassing the instruction scheduling too.
That may not matter, as the resulting overhead may still be lower.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
