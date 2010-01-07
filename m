From: m.nazarewicz@samsung.com (=?utf-8?B?TWljaGHFgiBOYXphcmV3aWN6?=)
Date: Thu, 07 Jan 2010 18:02:27 +0100
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5] arm/perfevents:
	implement perf event support for ARMv6)
In-Reply-To: <20100106153034.GV4179@wear.picochip.com>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912221751.39662.jpihet@mvista.com> <20091228075748.GC20039@elte.hu>
	<200912291452.16856.jpihet@mvista.com>
	<20091229163252.GA12409@gallagher>
	<op.u53904ge7p4s8u@localhost> <20100106153034.GV4179@wear.picochip.com>
Message-ID: <op.u559mdlm7p4s8u@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Wed, Jan 06, 2010 at 04:16:06PM +0100, Micha? Nazarewicz wrote:
>> Since I [...] will probably need to port tools/perf on ARM as well,
>> would you care to post any patches of your work in this area?

On Wed, 06 Jan 2010 16:30:34 +0100, Jamie Iles <jamie@jamieiles.com> wrote:
> The patches are in tip/master. [...] They should also be in Linus' tree.

Ah, thank you.  Now I don't know why I couldn't find it previously...

BTW. Did anyone got problems with stack protector? My ld complained it
could not find ssp_nonshared when checking for libelf.  I think the "-c"
should be dropped from the -fstack-protector-all support checking in
Makefile (diff included at the end of mail).


>> what's the idea behind tools/perf utility. As far as I understand it
>> provides a few generalized events and all other events are accessed via
>> critic r### [...] tool might be hard to use since users don't tend to
>> remember such numbers.  [...] perf would require front-end which would
>> provide textual description for those mysterious r###.

> True. However, for simple profiling, cycle counts are often enough plus all of
> the software events are always available. I do wonder if it would be worth
> having a mechanism for implementations to register a list of supported events
> with the perf subsystem that could be exported through debugfs. The perf tools
> could then read this to produce the list of events and would show all events
> that were available.

I would also consider using sysfs (/sys/devices/system/cpu/perf-events?) since
one may lack debugfs in their kernel.  It can be argued that if someone wants
to use performance counters we might just require debugfs however personally
I'd hate such requirement and prefer this information to be placed in sysfs.


Lets not argue about details though.  More important question is whether
such information is needed at all and I believe it is.

I agree that in many (if not most) cases the generalized events are enough
but imagine this poor fellow who needs to look through 1k-page CPU reference
manual to find "raw" event number because he wants to do more in-depth
profiling.

In my opinion, if the utility is to be widely used such database will be
created at one point or another and it can be either in kernel or user
space (some front-ends for pref cold emerge or maybe there'll be some other
utility that uses the same API and has its own database).  Furthermore,
I believe it's better done in kernel because it knows better what CPU
system is running on and what it supports.

So if you ask me I say that such list is needed, is needed to be done
in kernel and besides raw numbers should provide some textual names for
events so for example the same name can be used on two different
ARM CPUs which use different event number for the very same event.


And promised diff:
--
diff --git a/tools/perf/Makefile b/tools/perf/Makefile
index 652a470..434c5ec 100644
--- a/tools/perf/Makefile
+++ b/tools/perf/Makefile
@@ -250,7 +250,7 @@ PTHREAD_LIBS = -lpthread
  # explicitly what architecture to check for. Fix this up for yours..
  SPARSE_FLAGS = -D__BIG_ENDIAN__ -D__powerpc__

-ifeq ($(shell sh -c "echo 'int foo(void) {char X[2]; return 3;}' | $(CC) -x c -c -Werror -fstack-protector-all - -o /dev/null "$(QUIET_STDERR)" && echo y"), y)
+ifeq ($(shell sh -c "echo 'int foo(void) {char X[2]; return 3;}' | $(CC) -x c -Werror -fstack-protector-all - -o /dev/null "$(QUIET_STDERR)" && echo y"), y)
    CFLAGS := $(CFLAGS) -fstack-protector-all
  endif

-- 
Best regards,                                           _     _
  .o. | Liege of Serenely Enlightened Majesty of       o' \,=./ `o
  ..o | Computer Science,  Micha? "mina86" Nazarewicz     (o o)
  ooo +---<mina86@mina86.com>---<mina86@jabber.org>---ooO--(_)--Ooo--
