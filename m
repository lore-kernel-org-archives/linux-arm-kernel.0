From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 May 2012 11:58:01 +0800
Subject: Query about: ARM11 MPCore: preemption/task migration cache
 coherency
In-Reply-To: <4FC6E7CE.9090004@gmail.com>
References: <4FAA34A9.5020708@gmail.com>
 <20120511085150.GA17453@mudshark.cambridge.arm.com>
 <4FC45E6B.2070202@gmail.com>
 <20120530063858.GB6484@mudshark.cambridge.arm.com>
 <4FC5F017.4050202@gmail.com> <20120531030016.GB29372@mbp>
 <4FC6E172.4080601@gmail.com>
 <20120531031941.GA29906@mbp> <4FC6E7CE.9090004@gmail.com>
Message-ID: <CAHkRjk4suj4x-mJwvLeOYCNga_YvudNmnz7YxTSzFZ4Jj0iJ+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 May 2012 11:38, bill4carson <bill4carson@gmail.com> wrote:
> On 2012?05?31? 11:19, Catalin Marinas wrote:
>> BTW, see this as a starting point (and a hack):
>>
>> http://article.gmane.org/gmane.linux.ports.arm.kernel/51556
>
> I think we has some mis-understanding here :(
>
> As for:v6_flush_kern_dcache_area/v6_flush_kern_dcache_all
> these two hooks is supposed to be globally effective, *not*
> locally!
>
> Hence, there should below fix to make it as globally effective.
>
>
> +#ifdef CONFIG_SMP
> + ? ? ? ldr ? ? r2, [r0] ? ? ? ? ? ? ? ? ? ? ? ?@ read for ownership
> + ? ? ? str ? ? r2, [r0] ? ? ? ? ? ? ? ? ? ? ? ?@ write for ownership
> +#endif /* CONFIG_SMP */
>
> Or there maybe some other better solution for this issue.

I still didn't fully understand what the problem is. So, to make sure,
if you run some applications from flash using a yaffs filesystem, you
get random crashes. Is this correct? If yes, a solution is to actually
call flush_dcache_page() on the CPU that does the page copying from
flash into RAM, which could be the yaffs filesystem.

-- 
Catalin
