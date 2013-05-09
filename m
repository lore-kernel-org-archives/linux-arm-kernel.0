From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 9 May 2013 12:50:46 +0100
Subject: [PATCH 1/3] driver core: Add API to wait for deferred probe to
 complete during init
In-Reply-To: <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
References: <1368076726-11492-1-git-send-email-skannan@codeaurora.org>
 <1368076726-11492-2-git-send-email-skannan@codeaurora.org>
 <CACVXFVMd_iRtEM8ZLK6Ps66gZO6SCp1mXSgY6JbWtRJjJUh+ag@mail.gmail.com>
Message-ID: <CACxGe6uHBNUcbD9SeRP5c3E8NN-Z2yjVV+9VAhuoJnXoBtTu2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 9, 2013 at 11:07 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Thu, May 9, 2013 at 1:18 PM, Saravana Kannan <skannan@codeaurora.org> wrote:
>>
>> The most obvious fallback of using late_initcall_sync() also doesn't work
>> since the deferred probing work initated during late_initcall() is done in
>> a workqueue. So, frameworks that want to wait for all devices to finish
>> probing during init will now have to wait for the deferred workqueue to
>> finish it's work. This patch adds a wait_for_init_deferred_probe_done() API
>
> flush_workqueue() has been added in deferred_probe_initcall(), so looks it
> should be OK for your problem, doesn't it?

It looks like Saravana is using a kernel that already does that based
on object bb5645e from the diff. So if he is still having problem,
then there is probably another deferred probe that is triggered after
the deferred probe lateinitcall is executed. It would be good to know
what driver is getting deferred past clearing the queue. Or has this
been rebased from an earlier kernel? It may no longer be necessary.

However, if a device that shuts down resources after init has
completed and then cannot turn those resources back on when another
driver requests them then it sounds like there is a bigger design
problem. We're in a hotplug world and most of the time a driver cannot
assume that a resource will never get requested after initcalls have
completed. It sounds like a design bug in the driver if it cannot
handle that use case.

g.
