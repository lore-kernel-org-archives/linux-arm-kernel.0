From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 4 Mar 2014 00:53:06 +0000
Subject: [PATCH v6 00/14] uprobes: Add uprobes support for ARM
In-Reply-To: <20140303205039.GA8949@redhat.com>
References: <1392017945-4507-1-git-send-email-dave.long@linaro.org>
 <20140301123026.GD21483@n2100.arm.linux.org.uk> <53131DBE.7020500@linaro.org>
 <20140303205039.GA8949@redhat.com>
Message-ID: <20140304005306.GO21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 03, 2014 at 09:50:39PM +0100, Oleg Nesterov wrote:
> On 03/02, David Long wrote:
> >
> > Oleg,
> >
> > I've been looking at arch/Kconfig and kernel/trace/Kconfig where they
> > deal with uprobes.  The relevant items are CONFIG_UPROBES and
> > CONFIG_UPROBE_EVENT.  It just doesn't look right to me.
> 
> Yes, this looks strange. I never understood these dependencies. In fact
> I even never tried. And I do not really understand kbuild, unfortunately...
> 
> >> --- a/arch/Kconfig
> >> +++ b/arch/Kconfig
> >> @@ -87,7 +87,8 @@ config KPROBES_ON_FTRACE
> >>
> >>  config UPROBES
> >>  	bool "Transparent user-space probes (EXPERIMENTAL)"
> >> -	depends on UPROBE_EVENT && PERF_EVENTS
> >> +	depends on ARCH_SUPPORTS_UPROBES
> >> +	depends on PERF_EVENTS
> 
> And why CONFIG_UPROBES should depend on PERF_EVENTS? uprobes can be
> used by (say) systemtap without UPROBE_EVENT/PERF_EVENTS.
> 
> But as Russell pointed out the events directory is only built if
> CONFIG_PERF_EVENTS=y, so it should depend on it or select...
> 
> 
> I dunno. Personally I vote for the patch from Srikar in
> 
> 	http://article.gmane.org/gmane.linux.kernel/1017186
> 
> This is what we currently have, currently CONFIG_UPROBES is not
> user-selectable anyway.

Yes, me too, but with the proviso that UPROBE_EVENT also sorts itself
out with PERF_EVENTS in some way too (either by selecting it, which
IMHO isn't nice, or by depending on it, or the build dependency itself
gets sorted.)

Maybe a simpler answer would be to change the build stuff (hand-crafted):

kernel/Makefile
-obj-$(CONFIG_PERF_EVENTS) += events/
+obj-y += events/

and kernel/events/Makefile:

-obj-y := core.o ring_buffer.o callchain.o
+perf-y := core.o ring_buffer.o callchain.o

-obj-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
+perf-$(CONFIG_HAVE_HW_BREAKPOINT) += hw_breakpoint.o
+
+obj-${CONFIG_PERF_EVENTS) += $(perf-y)

?

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
