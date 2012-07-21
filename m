From: gilles.chanteperdrix@xenomai.org (Gilles Chanteperdrix)
Date: Sat, 21 Jul 2012 16:40:56 +0200
Subject: [PATCH] ARM: mm: avoid attempting to flush the gate_vma with
 VIVT caches
In-Reply-To: <20120721143517.GB26790@mudshark.cambridge.arm.com>
References: <1342455826-9425-1-git-send-email-will.deacon@arm.com>
 <20120719122814.GE29153@mudshark.cambridge.arm.com>
 <5009C26B.6080901@xenomai.org> <500AAC2B.5060300@xenomai.org>
 <20120721143517.GB26790@mudshark.cambridge.arm.com>
Message-ID: <500ABF78.10208@xenomai.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/21/2012 04:35 PM, Will Deacon wrote:
> Hi Gilles,
> 
> On Sat, Jul 21, 2012 at 02:18:35PM +0100, Gilles Chanteperdrix wrote:
>> On 07/20/2012 10:41 PM, Gilles Chanteperdrix wrote:
>>> Being 0 or 1 whether we want to flush the vector page (I believe we do
>>> not want to flush it, but am not sure).
>>
>> Actually, I believe we want to flush the vector page, at least on
>> systems with VIVT cache: on systems with VIVT cache, the vector page is
>> writeable in kernel mode, so may have been modified, and the address
>> used by elf_core_dump is not the vectors address, but the address in the
>> kernel direct-mapped RAM region where the vector page was allocated, so
>> there is a cache aliasing issue.
> 
> It may be writable, but we never actually write to it after it has been
> initialised so there's no need to worry about caching issues (the cache is
> flushed in devicemaps_init).

Except if CONFIG_TLS_REG_EMUL is enabled, or if some faulty code wrote
by accident to the vector page, which caused the application to crash.
What is the reason to include the vector page in the core dump if not to
help debugging?

-- 
                                                                Gilles.
