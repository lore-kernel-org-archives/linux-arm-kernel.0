From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Wed, 06 Jan 2010 16:16:06 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5] arm/perfevents:
	implement perf event support for ARMv6)
In-Reply-To: <20091229163252.GA12409@gallagher>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912221751.39662.jpihet@mvista.com> <20091228075748.GC20039@elte.hu>
	<200912291452.16856.jpihet@mvista.com>
	<20091229163252.GA12409@gallagher>
Message-ID: <op.u53904ge7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> * Jean Pihet <jpihet@mvista.com> wrote:
>>>> I am still facing some cross compilation problems of the
>>>> tools/perf utility.

>> On Monday 28 December 2009 08:57:48 Ingo Molnar wrote:
>>> Have you managed to solve these cross-compilation problems?
>>> If yes, it would be nice to merge the fixes into upstream perf.

> On Tue, Dec 29, 2009 at 02:52:16PM +0100, Jean Pihet wrote:
>> Yes I got them resolved but I needed to make a few changes:
>> - -Werror removed from the CFLAGS definition in tools/perf/Makefile.
>> Without the change the compilation stops after a warning about
>> include paths.

On Tue, 29 Dec 2009 17:32:52 +0100, Jamie Iles wrote:
> I've found that for the embedded platform I'm working on I need
> to build with NO_LIBPERL=1 otherwise the local include paths are
> used for perl. Obviously perl scripting will not be available.

>> - the rmb() macro in tools/perf/perf.h prevents the compilation.
>> I changed it to the definition from arch/arm/include/asm/system.h
>> (asm volatile("":::"memory")). Where is the original definition
>> from? Why is it specific to perf_events?

> I took this definition of rmb() from arch/arm/kernel/entry-armv.S.
> This give a CPU independent way of a real memory barrier. This
> compiles with the latest codesourcery toolchain and 2009q1.

Since I've just started to investigate the performance counter
architecture and will probably need to port tools/perf on ARM as well,
would you care to post any patches of your work in this area? It will
be greatly appreciated.  I couldn't find any of such patches posted
anywhere or in the tree.

Also, I would like to ask what's the idea behind tools/perf utility
anyway. As far as I understand it provides only a few generalized
events and all other events are accessed only via critic r### where
### is hardware dependent number.  If that's the case the tools might
be hard to use since users don't tend to remember such numbers.  This
means that perf would require some kind of front-end which would
provide a nice textual description for those mysterious r###.
													
-- 
Best regards,                                           _     _
  .o. | Liege of Serenely Enlightened Majesty of       o' \,=./ `o
  ..o | Computer Science,  Micha? "mina86" Nazarewicz     (o o)
  ooo +---<mina86@mina86.com>---<mina86@jabber.org>---ooO--(_)--Ooo--
