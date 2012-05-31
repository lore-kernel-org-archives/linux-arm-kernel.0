From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 May 2012 13:19:27 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC6FC38.8090904@gmail.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
 <4FC45E6B.2070202@gmail.com>
 <20120530063858.GB6484@mudshark.cambridge.arm.com>
 <4FC5F017.4050202@gmail.com> <20120531030016.GB29372@mbp>
 <4FC6E172.4080601@gmail.com>
 <20120531031941.GA29906@mbp> <4FC6E7CE.9090004@gmail.com>
 <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
 <4FC6FC38.8090904@gmail.com>
Message-ID: <CAHkRjk4jJphxST86km4ybuVTGxAr-a=3Ag9cQpEysLYxBt-6WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2012 13:06, bill4carson <bill4carson@gmail.com> wrote:
> On 2012?05?31? 11:58, Catalin Marinas wrote:
>> I still didn't fully understand what the problem is. So, to make sure,
>> if you run some applications from flash using a yaffs filesystem, you
>> get random crashes. Is this correct? If yes, a solution is to actually
>> call flush_dcache_page() on the CPU that does the page copying from
>> flash into RAM, which could be the yaffs filesystem.
>
> The story goes like this:
> function "flush_dcache_page" should be global effective
> but in ARMv6 MPCore, it was not, it was just local effective due
> to hardware design.

Yes, I know this.

> This may cause error in some cases for example:
>
> 1) Task running on Core-0 loading text section into memory.
> ? It was preempted and then migrate into Core-1;

BTW, do you have CONFIG_PREEMPT enabled?

To be clear - is your application reading some data from flash and
trying to execute or it's the kernel doing the load via the
page/prefetch abort mechanism?

If the latter, task running on core 0 gets a prefetch abort when
trying to execute some code. The kernel reads the page from flash (via
mtd, block layer, VFS) and copies it into RAM. It can be on any CPU as
long as it calls flush_dcache_page on the same CPU that copied the
data.

No matter where the task was running or migrated to, if the code doing
the copy also called flush_dcache_page() on the same core, there is no
data left in the D-cache for that page.

> 2) On Core-1, this task continue loading it and then
> ? "flush_dcache_page" to make sure the loaded text section write
> ? into main memory.

The flush_dcache_page() must be called by the code doing the copy. If
that copy happened on core 0, the call is done there and not where the
task migrated. We don't do lazy flushing on ARM11MPCore.

> 3) Task tend to the loaded text section and running it.
>
> If the "flush_dcache_page" was not global effective,
> there maybe data still in Core-0's data cache, not write
> into main memory. Thus in step 3, error instruction maybe
> fetched thus cause strange error.

This can only happen if you have either preempt enabled (so that the
kernel code doing the copy is migrated) or the mtd driver or fs do not
call flush_dcache_page().

-- 
Catalin
