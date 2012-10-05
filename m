From: mans.rullgard@linaro.org (Mans Rullgard)
Date: Fri, 5 Oct 2012 23:37:40 +0100
Subject: alignment faults in 3.6
In-Reply-To: <506F0454.3070304@gmail.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
 <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
 <20121005071216.GD4625@n2100.arm.linux.org.uk>
 <CAG5Tg6VciuxJ=k+fatzLugcehF54mGNOLHpUwdMX99oCnAVg8Q@mail.gmail.com>
 <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <506ED18C.3010009@gmail.com>
 <20590.58864.527467.746403@pilspetsen.it.uu.se>
 <506F0454.3070304@gmail.com>
Message-ID: <CAG5Tg6XJJ9a4Y+5BXG_T30hQ-xE7pyvyG18rV6A=jmjckcrPUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2012 17:01, Rob Herring <robherring2@gmail.com> wrote:
> Here's a testcase. Compiled on ubuntu precise with
> "arm-linux-gnueabihf-gcc -O2 -marm -march=armv7-a test.c".
>
> typedef unsigned short u16;
> typedef unsigned short __sum16;
> typedef unsigned int __u32;
> typedef unsigned char __u8;
> typedef __u32 __be32;
> typedef u16 __be16;
>
> struct iphdr {
>         __u8    ihl:4,
>                 version:4;
>         __u8    tos;
>         __be16  tot_len;
>         __be16  id;
>         __be16  frag_off;
>         __u8    ttl;
>         __u8    protocol;
>         __sum16 check;
>         __be32  saddr;
>         __be32  daddr;
>         /*The options start here. */
> };
>
> #define ntohl(x) __swab32((__u32)(__be32)(x))
> #define IP_DF           0x4000          /* Flag: "Don't Fragment"       */
>
> static inline __attribute__((const)) __u32 __swab32(__u32 x)
> {
>         __asm__ ("rev %0, %1" : "=r" (x) : "r" (x));
>         return x;
> }
>
> int main(void * buffer, unsigned int *p_id)
> {
>         unsigned int id;
>         int flush = 1;
>         const struct iphdr *iph = buffer;
>         __u32 len = *p_id;
>
>         id = ntohl(*(__be32 *)&iph->id);
>         flush = (u16)((ntohl(*(__be32 *)iph) ^ len) | (id ^ IP_DF));
>         id >>= 16;
>
>         *p_id = id;
>         return flush;
> }

The problem is the (__be32 *) casts.  This is a normal pointer to a 32-bit,
which is assumed to be aligned, and the cast overrides the packed attribute
from the struct.  Dereferencing these cast expressions must be done with the
macros from asm/unaligned.h

-- 
Mans Rullgard / mru
