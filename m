From: vgoyal@redhat.com (Vivek Goyal)
Date: Tue, 14 Jul 2015 10:42:48 -0400
Subject: [PATCH 3/3] kexec: Change the timing of callbacks related to
 "crash_kexec_post_notifiers" boot option
In-Reply-To: <20150710113331.4368.77050.stgit@softrs>
References: <20150710113331.4368.10495.stgit@softrs>
 <20150710113331.4368.77050.stgit@softrs>
Message-ID: <20150714144248.GC10792@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 10, 2015 at 08:33:31PM +0900, Hidehiro Kawai wrote:
> This patch fixes problems reported by Daniel Walker
> (https://lkml.org/lkml/2015/6/24/44), and also replaces the bug fix
> commits 5375b70 and f45d85f.
> 
> If "crash_kexec_post_notifiers" boot option is specified,
> other cpus are stopped by smp_send_stop() before entering
> crash_kexec(), while usually machine_crash_shutdown() called by
> crash_kexec() does that.  This behavior change leads two problems.
> 
>  Problem 1:
>  Some function in the crash_kexec() path depend on other cpus being
>  still online.  If other cpus have been offlined already, they
>  doesn't work properly.
> 
>   Example:
>    panic()
>     crash_kexec()
>      machine_crash_shutdown()
>       octeon_generic_shutdown() // shutdown watchdog for ONLINE cpus
>      machine_kexec()
> 
>  Problem 2:
>  Most of architectures stop other cpus in the machine_crash_shutdown()
>  path and save register information at the same time.  However, if
>  smp_send_stop() is called before that, we can't save the register
>  information.
> 
> To solve these problems, this patch changes the timing of calling
> the callbacks instead of changing the timing of crash_kexec() if
> crash_kexec_post_notifiers boot option is specified.
> 
>  Before:
>   if (!crash_kexec_post_notifiers)
>       crash_kexec()
> 
>   smp_send_stop()
>   atomic_notifier_call_chain()
>   kmsg_dump()
> 
>   if (crash_kexec_post_notifiers)
>       crash_kexec()
> 
>  After:
>   crash_kexec()
>       machine_crash_shutdown()
>       if (crash_kexec_post_notifiers) {
>           atomic_notifier_call_chain()
>           kmsg_dump()
>       }
>       machine_kexec()
> 
>   smp_send_stop()
>   if (!crash_kexec_post_notifiers) {
>       atomic_notifier_call_chain()
>       kmsg_dump()
>   }
> 

I think this new code flow looks bad. Now we are calling kmsg_dump()
and atomic_notifier_call_chain() from inside the crash_kexec() as well
as from inside panic(). This is bad.

So basic problem seems to be that cpus need to be stopped once (with
or without panic notifiers. So why don't we look into desiginig a 
function which stops cpus, saves register states first and then does
rest of the processing.

Something like.

stop_cpus_save_register_state;

if (!crash_kexec_post_notifiers)
	crash_kexec()

atomic_notifier_call_chain()
kmsg_dump()

Here crash_kexec() will have to be modified and it will assume that cpus
have already been stopped and register states have already been saved.

IOW, is there a reason that we can't get rid of smp_send_stop() and
use the mechanism crash_kexec() is using to stop cpus after panic()?

Thanks
Vivek
