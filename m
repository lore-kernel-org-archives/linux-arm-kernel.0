From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 9 May 2018 12:17:25 +0100
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
In-Reply-To: <87d0y5toed.fsf@xmission.com>
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com>
Message-ID: <9f67480f-ac5b-6c53-3463-06a9319ddfad@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Eric,

On 09/05/18 05:59, Eric W. Biederman wrote:
> Kim Phillips <kim.phillips@arm.com> writes:
> 
>> This patch is in the context of allowing the Coresight h/w
>> trace driver suite to be loaded as modules.  Coresight uses
>> find_task_by_vpid when running in direct capture mode (via sysfs)
>> when getting/setting the context ID comparator to trigger on
>> (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).
> 
> Aside from my objection about how bad an interface a pid in sysfs is.
> The implementation of coresight_vpid_to_pid is horrible.
> 
> The code should be just:
> 
> static inline pid_t coresight_vpid_to_pid(pid_t vpid)
> {
> 	rcu_read_lock();
>          pid = pid_nr(find_vpid(vpid));
> 	rcu_read_unlock();
> 
> 	return pid;
> }
> Which takes find_task_by_vpid out of the picture.
> 
> But reading further I am seeing code writing a pid to hardware.  That is
> broken.  That is a layering violation of the first order.  Giving
> implementation details like that to hardware.

Note that the value here is nothing more than a token - the CoreSight 
hardware doesn't actually *do* anything with it other than match it 
against the same value which we also stash in the CPU in much the same 
fashion - see CONFIG_PID_IN_CONTEXTIDR for, if you'll pardon the pun, 
context.

TL;DR: the CPU has a special register whose only purpose is to allow the 
OS help external debug tools identify the currently executing process, 
by writing some arbitrary identifier in there. The trace hardware can 
spit that identifier out into the trace stream whenever it changes, such 
that the user can see context switches easily. Newer trace hardware can 
also use it to actively filter what the capture at source, such that 
only the portions of interest are traced at all. We could in theory make 
up any old value, but as I understand it the PID is/was the most 
user-friendly and easily correlatable thing to hand, and it's now 
probably too well-established to reasonably change.

Robin.

> Any chance while you are working on this you can modify this code so
> that it does something sensible and defensible instead of every line of
> code I read be wrong in at least one detail?
> 
> Thank you,
> Eric
> 
