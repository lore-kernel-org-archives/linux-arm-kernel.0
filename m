From: scott.branden@broadcom.com (Scott Branden)
Date: Thu, 8 Dec 2016 08:30:36 -0800
Subject: [PATCH 1/1] arm64: mm: add config options for page table
 configuration
In-Reply-To: <20161208100014.GE33075@MBP.local>
References: <1481139600-24455-1-git-send-email-scott.branden@broadcom.com>
 <1481139600-24455-2-git-send-email-scott.branden@broadcom.com>
 <20161208100014.GE33075@MBP.local>
Message-ID: <762b8bec-60da-0bb8-28f4-b407ad70687b@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

On 16-12-08 02:00 AM, Catalin Marinas wrote:
> On Wed, Dec 07, 2016 at 11:40:00AM -0800, Scott Branden wrote:
>> Make MAX_PHYSMEM_BITS and SECTIONS_SIZE_BITS configurable by adding
>> config options.
>> Default to current settings currently defined in sparesmem.h.
>> For systems wishing to save memory the config options can be overridden.
>> Example, changing MAX_PHYSMEM_BITS from 48 to 36 at the same time as
>> changing SECTION_SIZE_BITS from 30 to 26 frees 13MB of memory.
>
> I'm not keen on such change, it's a big departure from the single Image
> aims.
A single Image is not entirely possible when the system needs to be 
tuned for memory usage, boot time, and other performance related issues. 
  These are key features in embedded systems vs. general purpose computers.

I would rather reduce SECTION_SIZE_BITS permanently where
> feasible, like in this patch:
>
> http://lkml.kernel.org/r/1465821119-3384-1-git-send-email-jszhang at marvell.com
>
This patch does not meet my requirements as I need SECTION_SIZE_BITS to 
be set to 28 to reduce memory and to allow memory hotplug to allocate a 
256 MB section.  My patch future proofs the tuning of the parameters by 
allowing any section size to be made.  I could combine the patch you 
list such that SECTION_SIZE_BITS defaults to 30 when 
CONFIG_ARM64_64_PAGES is selected and 27 otherwise.  Should it default 
to something else for 16K and 4K pages?

In terms of MAX_PHYSMEM_BITS, if our SoCs only use 40 (or less) bits I 
would also like the configuration functionality.  This allows us to make 
the SECTION_SIZE_BITS smaller.

Regards,
Scott
