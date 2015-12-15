From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Tue, 15 Dec 2015 16:47:35 +0000
Subject: memcpy alignment
In-Reply-To: <56703FC8.5050506@redhat.com> (Jon Masters's message of "Tue, 15
 Dec 2015 11:28:56 -0500")
References: <566F92D6.8060103@redhat.com>
 <20151215093406.GC19244@e104818-lin.cambridge.arm.com>
 <5670309D.1040309@redhat.com>
 <20151215153202.GC8644@n2100.arm.linux.org.uk>
 <56703507.2020004@redhat.com>
 <20151215160911.GH25034@bivouac.eciton.net>
 <56703FC8.5050506@redhat.com>
Message-ID: <yw1x60zzfyl4.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jon Masters <jcm@redhat.com> writes:

> On 12/15/2015 11:09 AM, Leif Lindholm wrote:
>> On Tue, Dec 15, 2015 at 10:43:03AM -0500, Jon Masters wrote:
>>>> If you get an __iomem pointer, then you must respect that it
>>>> essentially can not be non-dereferenced, and you must use one of the
>>>> standard kernel accessors (read[bwl]/ioread*/write[bwl]/iowrite*/
>>>> memcpy_fromio/memcpy_toio/memset_io) to access it.  That's the API
>>>> contract you implicitly signed up to by using something like ioremap()
>>>> or other mapping which gives you an iomem mapping.
>>>
>>> Thanks Russell. If it's definitely never allowed then the existing x86
>>> code needs to be fixed to use an IO access function in that case. I get
>>> that those accessors are there for this reason, but I wanted to make
>>> sure that we don't ever expect to touch Device memory any other way (for
>>> example, conflicting mappings between a VM and hypervisor). I am certain
>>> there's other non-ACPI code that is going to have this happen :)
>> 
>> A lot of code that has never run on anything other than x86 will have
>> such issues.
>> 
>> Tracking the use of page_is_ram() around the kernel, looking at what
>> it does for different architectures, and looking at how its (not
>> formalised) semantics are interpreted can also be quite unsettling.
>
> Yeah. That was the reason I didn't just change the existing initrd code
> in the first place (wanted to leave it as is). I *did not know* memcpy
> to/from Device memory was explicitly banned (and I get why, and I do
> know one is supposed to map Device memory as such, etc. etc.) for this
> reason.

Additionally to alignment constraints, IO regions often allow only
certain access sizes, and memcpy() doesn't make any promises as to what
it might do.

> I would /separately/ note that there's an inefficiency in that the
> existing code relies upon assumed equal alignment between src/dst so the
> hardware is probably doing a lot of silent unaligned writes.

This is the most efficient way.  Manually shifting things around to get
both reads and writes aligned costs more than letting the hardware
handle one side.  An unaligned store typically costs on average one
cycle more than an aligned store.  On some hardware (e.g. Cortex-A8), an
unaligned store within a cache line is free but one that crosses cache
lines needs several extra cycles.

-- 
M?ns Rullg?rd
