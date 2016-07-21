From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 21 Jul 2016 09:05:27 -0600
Subject: [PATCH V2 5/6] coresight: adding sink parameter to function
 coresight_build_path()
In-Reply-To: <07484e7c-7d19-465f-04d9-1dbb4899b643@arm.com>
References: <1469047100-18131-1-git-send-email-mathieu.poirier@linaro.org>
 <1469047100-18131-6-git-send-email-mathieu.poirier@linaro.org>
 <07484e7c-7d19-465f-04d9-1dbb4899b643@arm.com>
Message-ID: <CANLsYkydbXRsHzuwQQczc7Od7g7CN4HgsJRX5rCtB0+7-m0hEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 July 2016 at 04:49, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 20/07/16 21:38, Mathieu Poirier wrote:
>>
>> Up to now function coresight_build_path() was counting on a sink to
>> have been selected (from sysFS) prior to being called.  This patch
>> adds a string argument so that a sink matching the argument can be
>> selected.
>>
>
>>  static int _coresight_build_path(struct coresight_device *csdev,
>> -                                struct list_head *path)
>> +                                struct list_head *path, const char *sink)
>>  {
>>         int i;
>>         bool found = false;
>>         struct coresight_node *node;
>>
>> -       /* An activated sink has been found.  Enqueue the element */
>> -       if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>> -            csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
>> csdev->activated)
>> -               goto out;
>> +       /*
>> +        * First see if we are dealing with a sink.  If we have one check
>> if
>> +        * it was selected via sysFS or the perf cmd line.
>> +        */
>> +       if (csdev->type == CORESIGHT_DEV_TYPE_SINK ||
>> +           csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) {
>> +               /* Activated via perf cmd line */
>> +               if (sink && !strcmp(dev_name(&csdev->dev), sink))
>> +                       goto out;
>> +               /* Activated via sysFS */
>> +               if (csdev->activated)
>
>
> When a sink is specified, should we skip an activated sink and continue to
> find the specified one ? or at least fail with an error as we may not be
> using
> the sink specified by the user ?
> i.e may be :
>                 if (!sink && csdev->activated)
>                         goto out;


I understand your point.  My goal though is to discourage people from
meddling in sysFS when using CS from the perf interface.  As such if
any code is to be added here, it would be to report an error when both
a sink has been specified from perf and activated from sysFS.

>
> Suzuki
