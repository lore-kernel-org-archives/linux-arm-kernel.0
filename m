From: dhobsong@igel.co.jp (Damian Hobson-Garcia)
Date: Tue, 22 Jan 2013 11:31:51 +0900
Subject: [PATCH] ARM: shmobile: ipmmu: Add basic PMB support
In-Reply-To: <1788080.QuLk5ExqBm@avalon>
References: <1358490910-30716-1-git-send-email-dhobsong@igel.co.jp>
 <1788080.QuLk5ExqBm@avalon>
Message-ID: <50FDFA17.5050107@igel.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

Thanks for your comments.
On 2013/01/21 22:12, Laurent Pinchart wrote:
> Hi Damian,
>
> Thank you for the patch.
>
> On Friday 18 January 2013 15:35:10 Damian Hobson-Garcia wrote:
>> The PMB can be used to remap 16, 64, 128 or 512 MiB pages from
>> the 0x80000000-0xffffffff address range to anywhere in the
>> 0x00000000-0x7fffffff range.
>
> Isn't it 0x80000000 - 0xbfffffff to 0x00000000 - 0xffffffff ?
Yes, looking again at the spec, your values are the correct ones.
>
>> It also has the ability to perform tiled-linear address translation,
>> which can be used to access a memory buffer as a series of n x m tiles,
>> useful for image encoding/decoding.
>> Currently only the userspace API via character device is supported.
>
> If I understand this correctly, you're allowing userspace to remap a virtual
> address block to a physical address block without performing any sanity check.
> Isn't that a major security issue ?
No, not really. The PMB will only remap physical addresses, not virtual 
addresses.  Moreover, the remapped address is only accessible from the 
IP blocks which are on the ICB bus, not the CPU.  I will update the 
comment to mention this.  These IP blocks already have access to the 
entire physical memory address space, so I don't think that adding the 
the PMB into mix introduces any new security issues.

...

>
>> +
>> +#define PMB_DEVICE_NAME "pmb"
>> +
>> +#define PMB_NR 16
>> +/* the smallest size that can be reserverd in the pmb */
>> +#define PMB_GRANULARITY (16 << 20)
>> +#define PMB_START_ADDR	0x80000000
>> +#define PMB_SIZE	0x40000000
>> +#define NUM_BITS(x)	((x) / PMB_GRANULARITY)
>> +#define NR_BITMAPS	((NUM_BITS(PMB_SIZE) + BITS_PER_LONG - 1) \
>> +				>> ilog2(BITS_PER_LONG))
>
> Does ilog2(BITS_PER_LONG) resolve to a compile-time constant ?
Yes it does.

Thanks for your other comments too.  I'll look into making those changes.

Damian
-- 
Damian Hobson-Garcia
IGEL Co.,Ltd
http://www.igel.co.jp
