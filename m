From: mans.rullgard@linaro.org (Mans Rullgard)
Date: Tue, 9 Oct 2012 15:18:58 +0100
Subject: alignment faults in 3.6
In-Reply-To: <50742F40.4050704@linaro.org>
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
 <506F0454.3070304@gmail.com> <50742F40.4050704@linaro.org>
Message-ID: <CAG5Tg6W86iQoSCh4sNHCUSMggVGuXHh7aaKKR7SHyUTRZyNm-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 October 2012 15:05, Scott Bambrough <scott.bambrough@linaro.org> wrote:
> On 12-10-05 12:01 PM, Rob Herring wrote:
>> Here's a testcase. Compiled on ubuntu precise with
>> "arm-linux-gnueabihf-gcc -O2 -marm -march=armv7-a test.c".
>>
>> typedef unsigned short u16;
>> typedef unsigned short __sum16;
>> typedef unsigned int __u32;
>> typedef unsigned char __u8;
>> typedef __u32 __be32;
>> typedef u16 __be16;
>>
>> struct iphdr {
>>         __u8    ihl:4,
>>                 version:4;
>>         __u8    tos;
>>         __be16  tot_len;
>>         __be16  id;
>>         __be16  frag_off;
>>         __u8    ttl;
>>         __u8    protocol;
>>         __sum16 check;
>>         __be32  saddr;
>>         __be32  daddr;
>>         /*The options start here. */
>> };
>
>
> I was reading this thread with some interest.  AFAIK, with the default
> alignment rules the above struct is packed; there will be no holes in it.

Correct.  The problem here is that something is passing around a pointer to
such a struct which is not 4-byte aligned as required by the ABI rules.

>> #define ntohl(x) __swab32((__u32)(__be32)(x))
>> #define IP_DF           0x4000          /* Flag: "Don't Fragment"       */
>>
>> static inline __attribute__((const)) __u32 __swab32(__u32 x)
>> {
>>         __asm__ ("rev %0, %1" : "=r" (x) : "r" (x));
>>         return x;
>> }
>>
>> int main(void * buffer, unsigned int *p_id)
>> {
>>         unsigned int id;
>>         int flush = 1;
>>         const struct iphdr *iph = buffer;
>>         __u32 len = *p_id;
>>
>>         id = ntohl(*(__be32 *)&iph->id);
>
>
> The above statement is the problem.  I think it is poorly written networking
> code.  It takes the address of a 16 bit quantity (aligned on a halfword
> address),

The 'id' member starts 4 bytes into the struct, so if the struct is properly
aligned, there will be no fault here.  The problem is that networking code does
not always align these structs correctly.

> attempts to do a type conversion using pointers, then dereference
> it.  I would have thought:
>
> id = ntohs(iph->id);
>
> would have been enough.

I'm assuming the is intentionally merging two 16-bit fields into one 32-bit
value.  What you suggest would do something rather different.

-- 
Mans Rullgard / mru
