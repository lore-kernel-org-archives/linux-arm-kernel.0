From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 09 May 2018 21:35:07 -0500
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
In-Reply-To: <20180509152505.GA25559@xps15> (Mathieu Poirier's message of
 "Wed, 9 May 2018 09:25:05 -0600")
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
 <87d0y5toed.fsf@xmission.com> <20180509152505.GA25559@xps15>
Message-ID: <87k1scs0f8.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mathieu Poirier <mathieu.poirier@linaro.org> writes:

> On Tue, May 08, 2018 at 11:59:38PM -0500, Eric W. Biederman wrote:
>> Kim Phillips <kim.phillips@arm.com> writes:
>> 
>> > This patch is in the context of allowing the Coresight h/w
>> > trace driver suite to be loaded as modules.  Coresight uses
>> > find_task_by_vpid when running in direct capture mode (via sysfs)
>> > when getting/setting the context ID comparator to trigger on
>> > (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).
>> 
>> Aside from my objection about how bad an interface a pid in sysfs is.
>> The implementation of coresight_vpid_to_pid is horrible.
>> 
>> The code should be just:
>> 
>> static inline pid_t coresight_vpid_to_pid(pid_t vpid)
>> {
>> 	rcu_read_lock();
>>         pid = pid_nr(find_vpid(vpid));
>> 	rcu_read_unlock();
>> 
>> 	return pid;
>> }
>> Which takes find_task_by_vpid out of the picture.
>
> Many thanks for pointing out the right way to do this.  When Chunyan added
> this feature she broadly published her work and find_task_by_vpid() is the
> function she was asked to used.

Clearly no one was thinking through the implications of a sysfs file
which does not have pid namespace support on namespacing.  I am quite
upset at this mess of an API.  It is not a maintainable way to do things.

>> But reading further I am seeing code writing a pid to hardware.  That is
>> broken.  That is a layering violation of the first order.  Giving
>> implementation details like that to hardware.
>
> This is how the feature works - as Robin pointed out tracers are designed to
> match pid values with the CPU's contextID register.  The input value has no
> other effect than triggering trace collection, which has absolutely no baring on
> the CPU.

So please tell me how we make the tracer pid namespace aware.  Or is it
guaranteed that only the global root user will use this functionality?

As you are taking a vpid it looks like users with lesser privileges are
able to request this.   From the other reply it appears this is the
value the tracer returns to put in logs.  Perhaps I missed it but I
didn't see anything that translated from the global pid to something
else.  Which would make using this feature in a pid namespace confusing
and a problematic information leak if I have understood what has been
said so far.

Eric
