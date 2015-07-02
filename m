From: m-karicheri2@ti.com (Murali Karicheri)
Date: Thu, 2 Jul 2015 14:54:18 -0400
Subject: [PATCH] ARM: keystone: allow FORCE_MAX_ZONEORDER to be
 configurable on Keystone
In-Reply-To: <20150701184842.GM7557@n2100.arm.linux.org.uk>
References: <1435773182-23074-1-git-send-email-m-karicheri2@ti.com>
 <20150701184842.GM7557@n2100.arm.linux.org.uk>
Message-ID: <559588DA.4040300@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 07/01/2015 02:48 PM, Russell King - ARM Linux wrote:
> On Wed, Jul 01, 2015 at 01:53:02PM -0400, Murali Karicheri wrote:
>> Currently for Keystone devices, user can't change the
>> value of CONFIG_FORCE_MAX_ZONEORDER option in defconfig.
>> Users require capability to tune the value of this option on a target
>> board. So this patch adds this capability
>
> No they shouldn't.  If we do permit this, it should not be unrestricted -
> it's a power-of-2 of the page size, so specifying something like 32768 is
> insane.
>

Thanks for your comments

This was present in out internal version of the kernel. Only thing I can 
recall is that this patch was added to fix an isue in a DEBUG buid. 
Memory allocation for a large data structures used by a driver during 
probe (internal version) was failing as the data structure gets expanded 
as a result of DEBUG option related variables. There is no hurry to add 
this for now.

> In any case, it's well known that the Linux MM system fragments memory,
> and the higher order allocations will fail soon after boot - and the
> larger the order, the greater chance of it failing.Ok
>

Agree

> The only case that you want large allocations is for things like DMA, and
> we have a separate allocator for that called CMA, which is able to grab
> large chunks of memory, provided it's configured with a large enough zone.
>
> Please check whether CMA can be used _before_ considering using this
> option.  If you need to increase the order, it should be justified, and
> it should be done on a per SoC basis in a static way, not left to the
> user to dream up some power-of-2 figure.
I will explore these options when we upstream the internal driver. For 
now I will drop this patch.

Thanks
-- 
Murali Karicheri
Linux Kernel, Keystone
