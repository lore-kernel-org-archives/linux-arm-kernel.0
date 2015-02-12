From: hjl.tools@gmail.com (H.J. Lu)
Date: Thu, 12 Feb 2015 08:30:10 -0800
Subject: [PATCHv3 00/24] ILP32 support in ARM64
In-Reply-To: <20150212155023.GA25491@e104818-lin.cambridge.arm.com>
References: <20141002155217.GH32147@e104818-lin.cambridge.arm.com>
 <20150210181302.GA23886@brightrain.aerifal.cx>
 <CAMe9rOqX-VpjZ+E-JCusk+e4Kpw1V1tsFq1Kjtai5DR9saKLaA@mail.gmail.com>
 <20150211190252.GB23507@brightrain.aerifal.cx>
 <CAMe9rOoME1fct=Dk1YFeoJbayvhdsaCUBZCY2YD6jK58J7=MkA@mail.gmail.com>
 <20150211192558.GE23507@brightrain.aerifal.cx>
 <CAMe9rOpr6j1siK5gJ_HPLTOfjG_sLOL48TFzaLx+shCS9O8ahA@mail.gmail.com>
 <20150211194741.GI23507@brightrain.aerifal.cx>
 <CAMe9rOrVGFcQN3J1-pkXWd9j4MaQv2QxPrA5cTtLPBPaQ2-zfw@mail.gmail.com>
 <54DBB87C.5060901@amacapital.net>
 <20150212155023.GA25491@e104818-lin.cambridge.arm.com>
Message-ID: <CAMe9rOpNeA3T8bqsr1rXE0tO1CyZUBxQN5o-wq99v904BP4t+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 12, 2015 at 7:50 AM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Wed, Feb 11, 2015 at 12:15:56PM -0800, Andy Lutomirski wrote:
>> On 02/11/2015 11:57 AM, H.J. Lu wrote:
>> >>>>trivially satisfied if you consider x32 and x86_64 separate
>> >>>>compilation environments, but it's not related to the core issue: that
>> >>>>the definition of timespec violates core (not obscure) requirements of
>> >>>>both POSIX and C11. At the time you were probably unaware of the C11
>> >>>>requirement. Note that it's a LOT harder to effect change in the C
>> >>>>standard, so even if the Austin Group would be amenable to changing
>> >>>>the requirement for timespec to allow something like nseconds_t,
>> >>>>getting WG14 to make this change to work around a Linux/glibc mistake
>> >>>>does not sound practical.
>> >>>
>> >>>That is very unfortunate.  I consider it is too late for x32 to change.
>> >>
>> >>Why? It's hardly an incompatible ABI change, as long as the
>> >>kernel/libc fills the upper bits (for old programs that read them
>> >>based on the old headers) when structs are read from the kernel to the
>> >>application, and ignores the upper bits (potentially set or left
>> >>uninitialized by the application) when strings are passed from
>> >>userspace to the kernel. Newly built apps using the struct definition
>> >>with 32-bit tv_nsec would need new libc to ensure that the high bits
>> >>aren't interpreted, but this could be handled by symbol versioning.
>> >>
>> >
>> >We have considered this option.  But since kernel wouldn't change
>> >tv_nsec/tv_usec handling just for x32, it wasn't selected.
>>
>> Did anyone *ask* the kernel people (e.g. hpa)?
>
> It seems so:
>
> https://lkml.org/lkml/2011/8/31/244
>
> Couple of more replies from hpa:
>
> https://lkml.org/lkml/2011/8/31/261
> https://lkml.org/lkml/2012/2/8/408
>
> It looks like hpa was going to talk the POSIX committee but I don't know
> what the conclusion was and didn't follow the thread (at the time I
> wasn't interested in ARM ILP32).

Just for the record,  tv_nsec/tv_usec can be changed to long
as long as kernel always read them as 32 bits and write them
as 64 bits for both LP64 and ILP32 in 64-bit  imespec amd timeval.
In glibc, they can be changed to long without breaking existing binaries.
For x86-32, 64-bit __time_t must be 64-bit aligned.  Otherwise, there will
be no padding in 64-bit timespec nor timeval.

-- 
H.J.
