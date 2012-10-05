From: robherring2@gmail.com (Rob Herring)
Date: Thu, 04 Oct 2012 22:04:03 -0500
Subject: alignment faults in 3.6
In-Reply-To: <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
 <CAG5Tg6Wuybruc31x1eh6mFafsg=7cOgYLgpZUBuJUo75ap3osQ@mail.gmail.com>
 <506E3E58.80703@gmail.com>
 <CAG5Tg6V0Vj9HTy3=AU-q+Qa3DuJs6R1Kw+3uOWU_jOGfkgyXzw@mail.gmail.com>
Message-ID: <506E4E23.4020803@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2012 09:25 PM, Mans Rullgard wrote:
> On 5 October 2012 02:56, Rob Herring <robherring2@gmail.com> wrote:
>> On 10/04/2012 08:26 PM, Mans Rullgard wrote:
>>> On 5 October 2012 01:58, Michael Hope <michael.hope@linaro.org> wrote:
>>>> On 5 October 2012 12:10, Rob Herring <robherring2@gmail.com> wrote:
>>>>> I've been scratching my head with a "scheduling while atomic" bug I
>>>>> started seeing on 3.6. I can easily reproduce this problem when doing a
>>>>> wget on my system. It ultimately seems to be a combination of factors.
>>>>> The "scheduling while atomic" bug is triggered in do_alignment which
>>>>> gets triggered by this code in net/ipv4/af_inet.c, line 1356:
>>>>>
>>>>> id = ntohl(*(__be32 *)&iph->id);
>>>>> flush = (u16)((ntohl(*(__be32 *)iph) ^ skb_gro_len(skb)) | (id ^ IP_DF));
>>>>> id >>= 16;
>>>>>
>>>>> This code compiles into this using "gcc version 4.6.3 (Ubuntu/Linaro
>>>>> 4.6.3-1ubuntu5)":
>>>>>
>>>>> c02ac020:       e8920840        ldm     r2, {r6, fp}
>>>>> c02ac024:       e6bfbf3b        rev     fp, fp
>>>>> c02ac028:       e6bf6f36        rev     r6, r6
>>>>> c02ac02c:       e22bc901        eor     ip, fp, #16384  ; 0x4000
>>>>> c02ac030:       e0266008        eor     r6, r6, r8
>>>>> c02ac034:       e18c6006        orr     r6, ip, r6
>>>>>
>>>>> which generates alignment faults on the ldm. These are silent until this
>>>>> commit is applied:
>>>>
>>>> Hi Rob.  I assume that iph is something like:
>>>>
>>>> struct foo {
>>>>     u32 x;
>>>>     char id[8];
>>>> };
>>>>
>>>> struct foo *iph;
>>>>
>>>> GCC merged the two adjacent loads of x and id into one ldm.  This is
>>>> an ARM specific optimisation done in load_multiple_sequence() and
>>>> enabled with -fpeephole2.
>>>>
>>>> I think the assembly is correct - GCC knows that iph is aligned and
>>>> knows the offsets of both x and id.  Happy to be corrected if I'm
>>>> wrong, but I think the assembly is valid given the C code.
>>>
>>> The struct looks like this:
>>>
>>> struct iphdr {
>>> #if defined(__LITTLE_ENDIAN_BITFIELD)
>>>       __u8    ihl:4,
>>>               version:4;
>>> #elif defined (__BIG_ENDIAN_BITFIELD)
>>>       __u8    version:4,
>>>               ihl:4;
>>> #else
>>> #error        "Please fix <asm/byteorder.h>"
>>> #endif
>>>       __u8    tos;
>>>       __be16  tot_len;
>>>       __be16  id;
>>>       __be16  frag_off;
>>>       __u8    ttl;
>>>       __u8    protocol;
>>>       __sum16 check;
>>>       __be32  saddr;
>>>       __be32  daddr;
>>>       /*The options start here. */
>>> };
>>>
>>> In a normal build (there's some magic for special checkers) __be32 is a plain
>>> __u32 so the struct should be at least 4-byte aligned.  If somehow it is not,
>>> that is the real bug.
>>
>> This struct is the IP header, so a struct ptr is just set to the
>> beginning of the received data. Since ethernet headers are 14 bytes,
>> often the IP header is not aligned unless the NIC can place the frame at
>> a 2 byte offset (which is something I need to investigate). So this
>> function cannot make any assumptions about the alignment. Does the ABI
>> define structs have some minimum alignment? Does the struct need to be
>> declared as packed or something?
> 
> The ABI defines the alignment of structs as the maximum alignment of its
> members.  Since this struct contains 32-bit members, the alignment for the
> whole struct becomes 32 bits as well.  Declaring it as packed tells gcc it
> might be unaligned (in addition to removing any holes within).

Unfortunately, declaring the struct or __be32* cast as packed have no
effect. I still get an ldm emitted.

Rob
