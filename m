From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 1 Jun 2016 10:30:34 +0100
Subject: [PATCH 3/5] coresight: Fix csdev connections initialisation
In-Reply-To: <CANLsYkzQJVY3CDC7D9_Miw3Lu7iqV-6ABsVbTUCpivc-R0WB+Q@mail.gmail.com>
References: <1464695858-29284-1-git-send-email-suzuki.poulose@arm.com>
 <1464695858-29284-4-git-send-email-suzuki.poulose@arm.com>
 <CANLsYkzQJVY3CDC7D9_Miw3Lu7iqV-6ABsVbTUCpivc-R0WB+Q@mail.gmail.com>
Message-ID: <574EAB3A.6040303@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31/05/16 18:55, Mathieu Poirier wrote:
> On 31 May 2016 at 05:57, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>> This is a cleanup patch.
>>
>> coresight_device->conns holds an array to point to the devices
>> connected to the OUT ports of a component. Sinks, e.g ETR, do not
>> have an OUT port (nr_outport = 0), as it streams the trace to
>> memory via AXI.
>>
>> At coresight_register() we do :
>>
>>          conns = kcalloc(csdev->nr_outport, sizeof(*conns), GFP_KERNEL);
>>          if (!conns) {
>>                  ret = -ENOMEM;
>>                  goto err_kzalloc_conns;
>>          }
>>
>> For ETR, since the total size requested for kcalloc is zero, the return value is,
>> ZERO_SIZE_PTR ( != NULL). Hence, csdev->conns = ZERO_SIZE_PTR which cannot be
>> verified later to contain a valid pointer. The code which accesses the csdev->conns
>> is bounded by the csdev->nr_outport check, hence we don't try to dereference the
>> ZERO_SIZE_PTR. This patch cleans up the csdev->conns and csdev->refcnt, initialisation
>> to make sure we initialise it properly(i.e, either NULL or valid conns array).
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight.c | 42 +++++++++++++++++++--------------
>>   1 file changed, 24 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
>> index 0fdaaf4..8410420 100644
>> --- a/drivers/hwtracing/coresight/coresight.c
>> +++ b/drivers/hwtracing/coresight/coresight.c
>> @@ -890,7 +890,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>>          int nr_refcnts = 1;
>>          atomic_t *refcnts = NULL;
>>          struct coresight_device *csdev;
>> -       struct coresight_connection *conns;
>> +       struct coresight_connection *conns = NULL;
>>
>>          csdev = kzalloc(sizeof(*csdev), GFP_KERNEL);
>>          if (!csdev) {
>> @@ -908,29 +908,35 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
>>                          nr_refcnts = desc->pdata->nr_outport;
>>          }
>>
>> -       refcnts = kcalloc(nr_refcnts, sizeof(*refcnts), GFP_KERNEL);
>> -       if (!refcnts) {
>> -               ret = -ENOMEM;
>> -               goto err_kzalloc_refcnts;
>> -       }
>> +       if (nr_refcnts) {
>
> Did you manage to find a usecase where "nr_refcnts == 0" ?  Since
> components have at least one port this condition will always be true.

No, I didn't find one. While I was fixing the nr_outport, I thought it would
be good to check the refcnts as well.

>>
>> -       csdev->conns = conns;
>> +               for (i = 0; i < csdev->nr_outport; i++) {
>> +                       conns[i].outport = desc->pdata->outports[i];
>> +                       conns[i].child_name = desc->pdata->child_names[i];
>> +                       conns[i].child_port = desc->pdata->child_ports[i];
>> +               }
>> +
>> +               csdev->conns = conns;
>
> The purpose of your patch is to correctly initialise csdev->conns to
> NULL if there is no output port to speak of.  As such shouldn't the
> above statement be out of the if (csdev->nr_outport) {} ?.

Not necessarily. We do a kzalloc() for csdev, which implies csdev->conns
is already NULL. I can move the code to make that explicit assignment.

>
> I'm also getting a couple of checkpatch.pl warnings on this patch.

I can fix those warnings. I ignored them initially, as it was for the length of the comment.

Cheers
Suzuki
