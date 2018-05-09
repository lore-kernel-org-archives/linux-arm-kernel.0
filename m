From: ebiederm@xmission.com (Eric W. Biederman)
Date: Tue, 08 May 2018 23:59:38 -0500
Subject: [PATCH 2/4] pid: Export find_task_by_vpid for use in external
 modules
In-Reply-To: <20180508140640.0e312dba025df75cbf205cdb@arm.com> (Kim Phillips's
 message of "Tue, 8 May 2018 14:06:40 -0500")
References: <20180508140640.0e312dba025df75cbf205cdb@arm.com>
Message-ID: <87d0y5toed.fsf@xmission.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kim Phillips <kim.phillips@arm.com> writes:

> This patch is in the context of allowing the Coresight h/w
> trace driver suite to be loaded as modules.  Coresight uses
> find_task_by_vpid when running in direct capture mode (via sysfs)
> when getting/setting the context ID comparator to trigger on
> (/sys/bus/coresight/devices/<x>.etm/ctxid_pid).

Aside from my objection about how bad an interface a pid in sysfs is.
The implementation of coresight_vpid_to_pid is horrible.

The code should be just:

static inline pid_t coresight_vpid_to_pid(pid_t vpid)
{
	rcu_read_lock();
        pid = pid_nr(find_vpid(vpid));
	rcu_read_unlock();

	return pid;
}
Which takes find_task_by_vpid out of the picture.

But reading further I am seeing code writing a pid to hardware.  That is
broken.  That is a layering violation of the first order.  Giving
implementation details like that to hardware.

Any chance while you are working on this you can modify this code so
that it does something sensible and defensible instead of every line of
code I read be wrong in at least one detail?

Thank you,
Eric
