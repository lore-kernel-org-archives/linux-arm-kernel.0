From: mans.rullgard@linaro.org (Mans Rullgard)
Date: Fri, 5 Oct 2012 02:26:34 +0100
Subject: alignment faults in 3.6
In-Reply-To: <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
Message-ID: <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5 October 2012 01:58, Michael Hope <michael.hope@linaro.org> wrote:
> On 5 October 2012 12:10, Rob Herring <robherring2@gmail.com> wrote:
>> I've been scratching my head with a "scheduling while atomic" bug I
>> started seeing on 3.6. I can easily reproduce this problem when doing a
>> wget on my system. It ultimately seems to be a combination of factors.
>> The "scheduling while atomic" bug is triggered in do_alignment which
>> gets triggered by this code in net/ipv4/af_inet.c, line 1356:
>>
>> id = ntohl(*(__be32 *)&iph->id);
>> flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id ^ IP_DF));
>> id >>= 16;
>>
>> This code compiles into this using "gcc version 4.6.3 (Ubuntu/Linaro
>> 4.6.3-1ubuntu5)":
>>
>> c02ac020:       e8920840        ldm     r2, {r6, fp}
>> c02ac024:       e6bfbf3b        rev     fp, fp
>> c02ac028:       e6bf6f36        rev     r6, r6
>> c02ac02c:       e22bc901        eor     ip, fp, #16384  ; 0x4000
>> c02ac030:       e0266008        eor     r6, r6, r8
>> c02ac034:       e18c6006        orr     r6, ip, r6
>>
>> which generates alignment faults on the ldm. These are silent until this
>> commit is applied:
>
> Hi Rob.  I assume that iph is something like:
>
> struct foo {
>     u32 x;
>     char id[8];
> };
>
> struct foo *iph;
>
> GCC merged the two adjacent loads of x and id into one ldm.  This is
> an ARM specific optimisation done in load_multiple_sequence() and
> enabled with -fpeephole2.
>
> I think the assembly is correct - GCC knows that iph is aligned and
> knows the offsets of both x and id.  Happy to be corrected if I'm
> wrong, but I think the assembly is valid given the C code.

The struct looks like this:

struct iphdr {
#if defined(__LITTLE_ENDIAN_BITFIELD)
	__u8	ihl:4,
		version:4;
#elif defined (__BIG_ENDIAN_BITFIELD)
	__u8	version:4,
  		ihl:4;
#else
#error	"Please fix <asm/byteorder.h>"
#endif
	__u8	tos;
	__be16	tot_len;
	__be16	id;
	__be16	frag_off;
	__u8	ttl;
	__u8	protocol;
	__sum16	check;
	__be32	saddr;
	__be32	daddr;
	/*The options start here. */
};

In a normal build (there's some magic for special checkers) __be32 is a plain
__u32 so the struct should be at least 4-byte aligned.  If somehow it is not,
that is the real bug.

-- 
Mans Rullgard / mru
