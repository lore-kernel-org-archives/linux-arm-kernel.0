From: pmladek@suse.com (Petr Mladek)
Date: Tue, 16 Aug 2016 10:04:01 +0200
Subject: [PATCH v7 4/4] nmi_backtrace: generate one-line reports for idle
 cpus
In-Reply-To: <12bc082c-067b-2b85-6c17-ff0a6c011add@mellanox.com>
References: <1470672218-16059-1-git-send-email-cmetcalf@mellanox.com>
 <1470672218-16059-5-git-send-email-cmetcalf@mellanox.com>
 <20160809124325.GG13300@pathway.suse.cz>
 <feaaca8f-cc09-5847-ea3f-d27052704d9b@mellanox.com>
 <20160811152538.GH13300@pathway.suse.cz>
 <12bc082c-067b-2b85-6c17-ff0a6c011add@mellanox.com>
Message-ID: <20160816080401.GJ13300@pathway.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2016-08-15 12:41:54, Chris Metcalf wrote:
> On 8/11/2016 11:25 AM, Petr Mladek wrote:
> >On Mon 2016-08-08 12:03:38, Chris Metcalf wrote:
> >>>>When doing an nmi backtrace of many cores, most of which are idle,
> >>>>the output is a little overwhelming and very uninformative.  Suppress
> >>>>messages for cpus that are idling when they are interrupted and just
> >>>>emit one line, "NMI backtrace for N skipped: idling at pc 0xNNN".
> >Hmm, the problem is that native_safe_halt() is called from default_idle()
> >here. The function is marked as inline but the compiler did not inline
> >it.
> >
> >It helped me to put native_safe_halt() into the __cpuidle_text section:
> 
> Following Peter Z's suggestion, I have added an __always_inline marker
> to native_safe_halt.  For consistency, I also did arch_safe_halt(), since that
> invokes native_safe_halt, and then also native_halt() and halt(), so that
> we're not being weirdly inconsistent with markings for halt inlines.
> 
> There are also the native_irq_enable(), etc., accessors in that same header
> that are still only marked "inline" not "always_inline", but I wanted to stop
> before I was touching too much unrelated code.

Sounds fine.

> >I wonder if it would be possible to detect the idle thread an other
> >way. For example, I wonder if it would be enough to check for the
> >PID 0.
> 
> No, the problem is that pid 0 can also go off and run "interesting" code
> for things like power management, etc., so we really just want to
> focus on being quite sure that the running code isn't interesting before
> we suppress the backtrace information.
> 
> See the thread around here:
> 
> https://lkml.kernel.org/r/20160307204317.GR6344 at twins.programming.kicks-ass.net

Makes sense. Thanks for the poitner.

Best Regards,
Petr
