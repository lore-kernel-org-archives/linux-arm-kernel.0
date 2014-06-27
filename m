From: andreas.dilger@intel.com (Dilger, Andreas)
Date: Fri, 27 Jun 2014 11:20:06 +0000
Subject: [PATCH] staging/lustre: disable virtual block device for 64K pages
In-Reply-To: <4592947.kMtdJTsB2U@wuerfel>
References: <20140619183321.GA23200@fluid.dannf>
 <20140619191051.GA26573@kroah.com> <4592947.kMtdJTsB2U@wuerfel>
Message-ID: <CFD2ABC9.ADA2F%andreas.dilger@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch looks mostly OK, though I see there is also a
CONFIG_PPC_256K_PAGES
define that should probably be handled.

Cheers, Andreas

On 2014/06/20, 6:23 AM, "Arnd Bergmann" <arnd@arndb.de> wrote:

>The lustre virtual block device cannot handle 64K pages and fails at
>compile
>time. To avoid running into this error, let's disable the Kconfig option
>for this driver in cases it doesn't support.
>
>Reported-by: Dann Frazier <dann.frazier@canonical.com>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
>---
>On Thursday 19 June 2014 12:10:51 Greg KH wrote:
>> On Thu, Jun 19, 2014 at 12:33:21PM -0600, dann frazier wrote:
>> > drivers/staging/lustre/lustre/llite/lloop.c:523:18: error: previously
>>used here
>> >   CLASSERT(PAGE_CACHE_SIZE < (1 << (sizeof(unsigned short) * 8)));
>> >                   ^
>> 
>> Looks like lustre can't handle 64K page sizes, so it refuses to build :(
>> 
>> I sugest turning this code off, you really don't want to be running it
>> anyway...
>
>something like this?
>
>diff --git a/drivers/staging/lustre/lustre/Kconfig
>b/drivers/staging/lustre/lustre/Kconfig
>index 209e4c7..4f65ba1 100644
>--- a/drivers/staging/lustre/lustre/Kconfig
>+++ b/drivers/staging/lustre/lustre/Kconfig
>@@ -57,4 +57,5 @@ config LUSTRE_TRANSLATE_ERRNOS
> config LUSTRE_LLITE_LLOOP
> 	tristate "Lustre virtual block device"
> 	depends on LUSTRE_FS && BLOCK
>+	depends on !PPC_64K_PAGES && !ARM64_64K_PAGES
> 	default m
>
>


Cheers, Andreas
-- 
Andreas Dilger

Lustre Software Architect
Intel High Performance Data Division
