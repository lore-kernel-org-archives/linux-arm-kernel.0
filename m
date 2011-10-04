From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 4 Oct 2011 09:52:52 -0600
Subject: [RFC PATCH v3] drivercore: Add driver probe deferral mechanism
In-Reply-To: <87d3edllum.fsf@ti.com>
References: <20110922184614.25419.84606.stgit@ponder> <87d3edllum.fsf@ti.com>
Message-ID: <CACxGe6vHJUD4rVFixo0SU954x+28496v4-MDST3C+fkDetxojg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 3, 2011 at 5:02 PM, Kevin Hilman <khilman@ti.com> wrote:
> Grant Likely <grant.likely@secretlab.ca> writes:
>
>> Allow drivers to report at probe time that they cannot get all the resources
>> required by the device, and should be retried at a later time.
>>
>> This should completely solve the problem of getting devices
>> initialized in the right order. ?Right now this is mostly handled by
>> mucking about with initcall ordering which is a complete hack, and
>> doesn't even remotely handle the case where device drivers are in
>> modules. ?This approach completely sidesteps the issues by allowing
>> driver registration to occur in any order, and any driver can request
>> to be retried after a few more other drivers get probed.
>
> This is great work, thanks!
>
> For the TODO list:
>
> While the proposed patch should solve probe order dependencies, I don't
> think it will solve the suspend/resume ordering dependencies, which are
> typically the same.
>
> Currenly suspend/resume order is based on the order devices are *added*
> (device_add() -> device_pm_add() -> device added to dpm_list), so
> unfortunately, deferring probe isn't going to affect suspend/resume
> ordering.
>
> Extending this to also address suspend/resume ordering by also changing
> when the device is added to the dpm_list (or possibly creating another
> list) should probably be explored as well.

Hmm, yes, I think this is worth exploring.  It doesn't help with
runtime pm dependencies, but it has the potential to make PM just work
if the list order is updated each time a device is successfully bound
to a driver.  Manjunath, can you investigate what it would take to do
this? (after getting the core deferral patch finalized; I don't want
to block that work)?

g.
