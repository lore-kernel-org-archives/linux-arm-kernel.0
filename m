From: murzin.v@gmail.com (Vladimir Murzin)
Date: Mon, 21 Apr 2014 17:18:48 +0100
Subject: [Xen-devel] [PATCH RFC] arm64: 32-bit tolerant sync bitops
In-Reply-To: <534FB009.5030904@citrix.com>
References: <1397723881-31648-1-git-send-email-murzin.v@gmail.com>
 <534FB009.5030904@citrix.com>
Message-ID: <CABV+yWsFY4AnNa+Bs54ZNswCUga1OtFh3+5PPWHSEA4zRXJD3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 11:42 AM, David Vrabel <david.vrabel@citrix.com> wrote:
> On 17/04/14 09:38, Vladimir Murzin wrote:
>> Xen assumes that bit operations are able to operate on 32-bit size and
>> alignment [1]. For arm64 bitops are based on atomic exclusive load/store
>> instructions to guarantee that changes are made atomically. However, these
>> instructions require that address to be aligned to the data size. Because, by
>> default, bitops operates on 64-bit size it implies that address should be
>> aligned appropriately. All these lead to breakage of Xen assumption for bitops
>> properties.
>>
>> With this patch 32-bit sized/aligned bitops is implemented.
>>
>> [1] http://www.gossamer-threads.com/lists/xen/devel/325613
>>
>> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
>> ---
>>  Apart this patch other approaches were implemented:
>>  1. turn bitops to be 32-bit size/align tolerant.
>>     the changes are minimal, but I'm not sure how broad side effect might be
>>  2. separate 32-bit size/aligned operations.
>>     it exports new API, which might not be good
>
> I've never been particularly happy with the way the events_fifo.c uses
> casts for the sync_*_bit() calls and I think we should do option 2.
>
> A generic implementation could be something like:
>
> bool sync_test_bit32(uint32_t *v, unsigned bit)
> {
>      if (sizeof(unsigned long) == 8 && (unsigned long)v & 0x4)
>          return sync_test_bit((unsigned long *)(v - 1), bit + 32);
>      else
>          return sync_test_bit((unsigned long *)v, bit);
> }
>
> David

Talking about separate 32-bit ops I mean arch specific bitops which
are targeting for 32-bit size/alignment.
With separate API for Xen it looks awkward for me, because currently
there are only a few users for sync_*_bit ops - Xen and HV.
Xen assumes that these ops are 32 bit and looks like never try to deal
with 64-bit (am I overlooking something?). So, sync ops are 32-bit
de-facto, having separate version means there is support for both
32-bit and 64-bit ops, but (by now) there is no user for 64-bit ops.
All this lead to obvious question why we need API conversion now? Is
not it easier to turn assumptions to requirements?
x86 world defines it's own sync ops, arm32 world alias them to
non-sync, so, probably arm64 could do something (may be different to
my patch) to make sure that sync bitops are 32-bit sized/aligned...

Hope to hear other opinions here ;)

Vladimir
