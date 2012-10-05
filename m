From: robherring2@gmail.com (Rob Herring)
Date: Fri, 05 Oct 2012 11:08:16 -0500
Subject: alignment faults in 3.6
In-Reply-To: <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
References: <506E1762.3010601@gmail.com>
 <CANLjY-no-L9=LRCvCetC5XCHicOoSWOfRZmUd7itAiUHWBhAyw@mail.gmail.com>
Message-ID: <506F05F0.4050401@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2012 07:58 PM, Michael Hope wrote:
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

I'm probably on some watch list now after searching for peephole...

It's not clear what all turning this off would affect. Is it just struct
or array loading? Or does this turn off lots of different optimizations?

Rob
