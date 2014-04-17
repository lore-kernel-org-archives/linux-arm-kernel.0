From: david.vrabel@citrix.com (David Vrabel)
Date: Thu, 17 Apr 2014 11:42:17 +0100
Subject: [Xen-devel] [PATCH RFC] arm64: 32-bit tolerant sync bitops
In-Reply-To: <1397723881-31648-1-git-send-email-murzin.v@gmail.com>
References: <1397723881-31648-1-git-send-email-murzin.v@gmail.com>
Message-ID: <534FB009.5030904@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/04/14 09:38, Vladimir Murzin wrote:
> Xen assumes that bit operations are able to operate on 32-bit size and
> alignment [1]. For arm64 bitops are based on atomic exclusive load/store
> instructions to guarantee that changes are made atomically. However, these
> instructions require that address to be aligned to the data size. Because, by
> default, bitops operates on 64-bit size it implies that address should be
> aligned appropriately. All these lead to breakage of Xen assumption for bitops
> properties.
> 
> With this patch 32-bit sized/aligned bitops is implemented. 
> 
> [1] http://www.gossamer-threads.com/lists/xen/devel/325613
> 
> Signed-off-by: Vladimir Murzin <murzin.v@gmail.com>
> ---
>  Apart this patch other approaches were implemented:
>  1. turn bitops to be 32-bit size/align tolerant.
>     the changes are minimal, but I'm not sure how broad side effect might be
>  2. separate 32-bit size/aligned operations.
>     it exports new API, which might not be good

I've never been particularly happy with the way the events_fifo.c uses
casts for the sync_*_bit() calls and I think we should do option 2.

A generic implementation could be something like:

bool sync_test_bit32(uint32_t *v, unsigned bit)
{
     if (sizeof(unsigned long) == 8 && (unsigned long)v & 0x4)
         return sync_test_bit((unsigned long *)(v - 1), bit + 32);
     else
         return sync_test_bit((unsigned long *)v, bit);
}

David
