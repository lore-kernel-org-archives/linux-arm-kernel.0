From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 10 May 2018 09:40:58 +0100
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
In-Reply-To: <87k1scs0f8.fsf@xmission.com>
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com> <20180509152505.GA25559@xps15>
 <87k1scs0f8.fsf@xmission.com>
Message-ID: <20180510084057.GT16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2018 at 09:35:07PM -0500, Eric W. Biederman wrote:
> Mathieu Poirier <mathieu.poirier@linaro.org> writes:
> 
> > On Tue, May 08, 2018 at 11:59:38PM -0500, Eric W. Biederman wrote:
> >> Kim Phillips <kim.phillips@arm.com> writes:
> >> 
> >> > This patch is in the context of allowing the Coresight h/w
> >> > trace driver suite to be loaded as modules.  Coresight uses
> >> > find_task_by_vpid when running in direct capture mode (via sysfs)
> >> > when getting/setting the context ID comparator to trigger on
> >> > (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).
> >> 
> >> Aside from my objection about how bad an interface a pid in sysfs is.
> >> The implementation of coresight_vpid_to_pid is horrible.
> >> 
> >> The code should be just:
> >> 
> >> static inline pid_t coresight_vpid_to_pid(pid_t vpid)
> >> {
> >> 	rcu_read_lock();
> >>         pid = pid_nr(find_vpid(vpid));
> >> 	rcu_read_unlock();
> >> 
> >> 	return pid;
> >> }
> >> Which takes find_task_by_vpid out of the picture.
> >
> > Many thanks for pointing out the right way to do this.  When Chunyan added
> > this feature she broadly published her work and find_task_by_vpid() is the
> > function she was asked to used.
> 
> Clearly no one was thinking through the implications of a sysfs file
> which does not have pid namespace support on namespacing.  I am quite
> upset at this mess of an API.  It is not a maintainable way to do things.
> 
> >> But reading further I am seeing code writing a pid to hardware.  That is
> >> broken.  That is a layering violation of the first order.  Giving
> >> implementation details like that to hardware.
> >
> > This is how the feature works - as Robin pointed out tracers are designed to
> > match pid values with the CPU's contextID register.  The input value has no
> > other effect than triggering trace collection, which has absolutely no baring on
> > the CPU.
> 
> So please tell me how we make the tracer pid namespace aware.  Or is it
> guaranteed that only the global root user will use this functionality?
> 
> As you are taking a vpid it looks like users with lesser privileges are
> able to request this.   From the other reply it appears this is the
> value the tracer returns to put in logs.  Perhaps I missed it but I
> didn't see anything that translated from the global pid to something
> else.  Which would make using this feature in a pid namespace confusing
> and a problematic information leak if I have understood what has been
> said so far.

Let's look to see what's placed into the context ID register - this is
done by arch/arm/mm/context.c::contextidr_notifier():

        pid = task_pid_nr(thread->task) << ASID_BITS;

This is documented in linux/sched.h as:

 * task_xid_nr()     : global id, i.e. the id seen from the init namespace;

So, what ends up in the context ID register is the _global_ PID, not a
namespace specific PID.  This means the hardware deals with global PID
values.

It seems quite logical to use the global PID value for the hardware,
because that is a globally unique value - especially as the hardware
uses this for filtering events.  So asking for a namespace's pid 1
gets mapped to the global pid value, which won't match some other
namespace's pid 1.

The problem comes _if_ the event stream delivered to userspace contains
the global PID values and the event stream is being looked at from
within a namespace.

This does not leak information from other namespaces because of the
uniqueness of the global PID.  However, what it does leak is the value
of the global PID which is meaningless in the namespace.  So, before
the event stream is delivered to userspace, this value needs to be
re-written to the namespace's PID value.

Things get more yucky with this when you look at the ctxid_masks stuff
 - which looks to me like it implements a mask on the PID value.  Masks
on the pid value are irrelevant from within a namespace, because the
mask is applied to the global PID value, not the namespace's PID value.
You can't really define how a set of namespace PIDs will map to global
PIDs, so masking the context ID PID value in the presence of namespaces
is pretty useless - and potentially ends up being an information leak.

As for the sysfs file thing, I think the simple solution to that is
the sysfs file should accept a PID value in the current namespace,
and translate that to the global namespace - and the global PID value
should be stored.  When reading, the global PID value should be
translated back to the current namespace, or an error/empty given if
the PID doesn't exist in that namespace.  The current solution to
store the vpid and simply return it irrespective of the namespace is
just nonsense.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync@8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
