From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 18 Nov 2011 21:36:24 +0000
Subject: [PATCH] ARM: fix unwinding for XIP kernels
In-Reply-To: <alpine.LFD.2.02.1111181321390.13989@xanadu.home>
References: <1321537200-9532-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20111117141706.GI4748@arm.com>
 <alpine.LFD.2.02.1111181321390.13989@xanadu.home>
Message-ID: <CAHkRjk4r-SMW0P-9vtyA=zM+-s83iC8gSmD03-fEJW2LbjJ+LA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 November 2011 18:28, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Thu, 17 Nov 2011, Catalin Marinas wrote:
>
>> On Thu, Nov 17, 2011 at 01:40:00PM +0000, Uwe Kleine-K?nig wrote:
>> > The linker places the unwind tables in readonly sections. So when using
>> > an XIP kernel these are located in ROM and cannot be modified.
>> >
>> > For that reason don't convert the symbol addresses during boot (or
>> > module loading) but only when interpreting them in search_index().
>> > Moreover several consts are added to catch future writes and rename the
>> > member "addr" of struct unwind_idx to "addr_offset" to better match the
>> > new semantic.
>> >
>> > This fixes unwinding on XIP which compared prel31 offsets to absolute
>> > addresses because the initial conversion from prel31 to absolute failed.
>>
>> My only worry - does this increase the index search by doing the prel31
>> conversion every time? It could affect tools like lockdep that need to
>> get the backtrace regularly at run-time.
>
> We're talking about two constant shifts and an add. ?something that
> myght take around 2 cycles on ARM. ?Hardly noticeable I would say,
> especially given that lockdep is already quite costly and hardly
> something you want to keep around in production anyway.

Just doing some maths - the prel31 conversion takes 2 instructions on
ARMv7 (sbfx, add). The search_index() loop is executed for
log(nr-symbols) iterations. On a vmlinux I have around with ~15000
function symbols, it means 14 iterations, so we get ~28 more cycles
per stack frame. For an average backtrace of 8 function calls, it adds
~200 cycles per backtrace.

For lockdep, that's indeed unnoticeable but there are some other tools
that need tracing. If no-one complains about this increase, I'm ok
with the patch (I know in the past people complained that unwinding is
much slower than frame pointers).

-- 
Catalin
