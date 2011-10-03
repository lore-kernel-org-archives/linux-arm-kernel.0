From: khilman@ti.com (Kevin Hilman)
Date: Mon, 03 Oct 2011 16:02:57 -0700
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <20110922184614.25419.84606.stgit@ponder> (Grant Likely's message
	of "Thu, 22 Sep 2011 12:51:23 -0600")
References: <20110922184614.25419.84606.stgit@ponder>
Message-ID: <87d3edllum.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Grant Likely <grant.likely@secretlab.ca> writes:

> Allow drivers to report at probe time that they cannot get all the resources
> required by the device, and should be retried at a later time.
>
> This should completely solve the problem of getting devices
> initialized in the right order.  Right now this is mostly handled by
> mucking about with initcall ordering which is a complete hack, and
> doesn't even remotely handle the case where device drivers are in
> modules.  This approach completely sidesteps the issues by allowing
> driver registration to occur in any order, and any driver can request
> to be retried after a few more other drivers get probed.

This is great work, thanks!

For the TODO list:

While the proposed patch should solve probe order dependencies, I don't
think it will solve the suspend/resume ordering dependencies, which are
typically the same.

Currenly suspend/resume order is based on the order devices are *added*
(device_add() -> device_pm_add() -> device added to dpm_list), so
unfortunately, deferring probe isn't going to affect suspend/resume
ordering.

Extending this to also address suspend/resume ordering by also changing
when the device is added to the dpm_list (or possibly creating another
list) should probably be explored as well.

Kevin
