From: sudeep.holla@arm.com (Sudeep Holla)
Date: Fri, 12 Jan 2018 15:41:57 +0000
Subject: [PATCH v5 06/20] firmware: arm_scmi: add initial support for
 performance protocol
In-Reply-To: <CALW4P+L-YJRNZ_qv1SohM7vCWekBf+KKZos7FuZE0Tu1Yh8i-g@mail.gmail.com>
References: <1514904162-11201-1-git-send-email-sudeep.holla@arm.com>
 <1514904162-11201-7-git-send-email-sudeep.holla@arm.com>
 <CALW4P+L-YJRNZ_qv1SohM7vCWekBf+KKZos7FuZE0Tu1Yh8i-g@mail.gmail.com>
Message-ID: <8f9853e7-ef8a-2bee-0760-7659aa919f8c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/01/18 14:55, Alexey Klimov wrote:
> On Tue, Jan 2, 2018 at 2:42 PM, Sudeep Holla <sudeep.holla@arm.com> wrote:
>> The performance protocol is intended for the performance management of
>> group(s) of device(s) that run in the same performance domain. It
>> includes even the CPUs. A performance domain is defined by a set of
>> devices that always have to run at the same performance level.
>> For example, a set of CPUs that share a voltage domain, and have a
>> common frequency control, is said to be in the same performance domain.
>>
>> The commands in this protocol provide functionality to describe the
>> protocol version, describe various attribute flags, set and get the
>> performance level of a domain. It also supports discovery of the list
>> of performance levels supported by a performance domain, and the
>> properties of each performance level.
>>
>> This patch adds basic support for the performance protocol.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> ---
>>  drivers/firmware/arm_scmi/Makefile |   2 +-
>>  drivers/firmware/arm_scmi/common.h |   1 +
>>  drivers/firmware/arm_scmi/perf.c   | 527 +++++++++++++++++++++++++++++++++++++
>>  include/linux/scmi_protocol.h      |  34 +++
>>  4 files changed, 563 insertions(+), 1 deletion(-)
> 
> [...]
> 

[..]

>> +
>> +static int scmi_perf_limits_notify_enable(const struct scmi_handle *handle,
>> +                                         u32 domain, bool enable)
>> +{
>> +       return __scmi_perf_notify_enable(handle, PERF_NOTIFY_LIMITS,
>> +                                        domain, enable);
>> +}
>> +
>> +static int scmi_perf_level_notify_enable(const struct scmi_handle *handle,
>> +                                        u32 domain, bool enable)
>> +{
>> +       return __scmi_perf_notify_enable(handle, PERF_NOTIFY_LEVEL,
>> +                                        domain, enable);
>> +}
>> +
> 
> Do you have any support to correctly handle notifications without
> errors/warnings?

Good catch.

> It looks like this two functions are accessible to some user through
> perf_ops. But are you sure that notifications will be correctly
> handled by transport, mailbox framework and scmi protocol?
> 

Indeed, it slipeed through the cracks. I have some rudimentary notifier
support with I have not put it as part of this series due to lack of
firmware to test.

> The reason I ask is that it looks like it's better to return
> -EOPNOTSUPP or -ENODEV, maybe -EINVAL here.

I agree, will change it.

> When you add notifications support you can allow these operations when
> it's safe to do it.
> 

Yes, sounds like that's good plan.

-- 
Regards,
Sudeep
