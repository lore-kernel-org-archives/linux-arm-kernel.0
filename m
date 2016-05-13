From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 13 May 2016 15:59:59 +0200
Subject: [PATCH] PM / Runtime: Defer resuming of the device in
 pm_runtime_force_resume()
In-Reply-To: <CAJZ5v0jTAM74asCM5gG5wBWn+gvSQ21_W6dY9WQD+cMybUnEEg@mail.gmail.com>
References: <1461234842-22820-1-git-send-email-ulf.hansson@linaro.org>
 <5465506.Z3sjI0lQh6@avalon>
 <CAPDyKFpOxabizwQqhtKb-h0vGpTRtrCa0nPxAKMY22rnjLCouw@mail.gmail.com>
 <4661739.p5SU9QcIps@avalon>
 <CAJZ5v0jTAM74asCM5gG5wBWn+gvSQ21_W6dY9WQD+cMybUnEEg@mail.gmail.com>
Message-ID: <CAPDyKFqJqq7hUFBvo91hc-5H7fwu2WfcOzxGO25VopZ3CwNoXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2016 at 22:28, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, May 12, 2016 at 9:01 PM, Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> Hello,
>>
>> On Wednesday 27 Apr 2016 16:23:49 Ulf Hansson wrote:
>>> [...]
>>>
>>> >> Following you reasoning, I agree!
>>> >>
>>> >> Let's put this patch on hold for a little while. I am already working
>>> >> on changing genpd, so it shouldn't take long before I can post some
>>> >> additional genpd patches improving the behaviour.
>>> >
>>> > I'd like to see something merged for v4.7 if possible. I agree that my
>>> > patch isn't a long term solution (we want to avoid adding additional
>>> > fields to the device power structure), but it has the benefit of being
>>> > available now and fixing the problem I ran into with drivers that would
>>> > be broken on v4.7 without a fix. Do you think you could get a better fix
>>> > ready in time for v4.7 ? If so I'm fine with dropping this patch, but
>>> > otherwise I'd prefer to get it merged and reverted as part of your better
>>> > implementation for v4.8.
>>>
>>> My impression was that devices becomes unnecessary resumed when they
>>> don't need to. They won't stay resumed as the PM core invokes
>>> pm_runtime_put() in the system PM complete phase.
>>>
>>> So, in the end I think we are trying to optimize a behaviour here, but
>>> not fix something that is "broken", correct?
>>>
>>> Anyway, I have no objections to your proposed solution, so I leave it
>>> to Rafael and Kevin to decide what to do.
>>
>> Kevin, Rafael, any comment ? I need to fix PM support in a driver that is
>> currently broken partly due to this issue. Which of "PM / Runtime: Only force-
>> resume device if it has been force-suspended" and this patch should we merge,
>> if any ?
>
> My and Kevin's assumption was that Ulf would provide a better fix
> shortly, but I'm not sure how realistic that is.

First, is this really a fix we are talking about or an optimization? Laurent?

Second, I currently have patches for genpd etc that I think may deals
with this better, although I need a day or two before I can post them.

Additionally, "[PATCH v3 1/2] PM / Domains: Allow genpd to power on
during the system PM phases", has been posted [1] already.
That change, will prevent Laurent's approach to work and it's because
genpd will force a runtime resume of the device in the system PM
prepare phase. This means pm_genpd_force_resume() will anyway *always*
resume the device.

Kind regards
Uffe

[1]
http://www.spinics.net/lists/dri-devel/msg107210.html
