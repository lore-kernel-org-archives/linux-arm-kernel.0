From: mlangsdo@redhat.com (Mark Langsdorf)
Date: Fri, 09 Jan 2015 08:27:06 -0600
Subject: Linux 3.19-rc3
In-Reply-To: <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
References: <CA+55aFwsxoyLb9OWMSCL3doe_cz_EQtKsEFCyPUYn_T87pbz0A@mail.gmail.com>	<54AE7D53.2020305@redhat.com>	<20150109121348.GD12942@leverpostej>
 <CAPvkgC23LHhs7Tw4rdAPFooimonji8R7kEAbWYRKPJwouwUzBA@mail.gmail.com>
Message-ID: <54AFE53A.4020004@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2015 08:19 AM, Steve Capper wrote:
> On 9 January 2015 at 12:13, Mark Rutland <mark.rutland@arm.com> wrote:
>> On Thu, Jan 08, 2015 at 12:51:31PM +0000, Mark Langsdorf wrote:
>>> I'm consistently getting an out of memory killer triggered when
>>> compiling the kernel (make -j 16 -s) on a 16 core ARM64 system
>>> with 16 GB of memory. This doesn't happen when running a 3.18
>>> kernel.
>>>
>>> I'm going to start bisecting the failure now, but here's the crash
>>> log in case someone can see something obvious in it.
>>
>> FWIW I've just reproduced this with v3.19-rc3 defconfig +
>> CONFIG_ARM64_64K_PAGES=y by attempting a git clone of mainline. My
>> system has 16GB of RAM and 6 CPUs.
>>
>> I have a similarly dodgy looking number of pages reserved
>> (18446744073709544451 A.K.A. -7165). Log below.
>>
>
> I think the negative page reserved count is a consequence of another bug.
>
> We have the following reporting code in lib/show_mem.c:
> #ifdef CONFIG_CMA
>          printk("%lu pages reserved\n", (reserved - totalcma_pages));
>          printk("%lu pages cma reserved\n", totalcma_pages);
> #else
>
> With totalcma_pages being reported as 8192, that would account for the
> -7000ish values reported.
>
> That change appears to have come from:
> 49abd8c lib/show_mem.c: add cma reserved information
>
> Is the quickest way to exacerbate this OOM a kernel compile?

I haven't really tried to characterize this. Compiling a kernel
on a 64K page machine causes a failure reasonably quickly and
doesn't require a lot of thought. I think that time spent finding
a faster reproducer wouldn't pay off.

Also, contrary to last night's report and in line with Linus'
assumption, the failure still occurs with 4K pages. It just
takes substantially longer to occur.

--Mark Langsdorf
