From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 15 Jun 2017 11:19:40 +0100
Subject: [PATCH 06/12] coresight tmc: Expose DBA and AXICTL
In-Reply-To: <20170614175042.GB22030@xps15>
References: <1497278211-5001-1-git-send-email-suzuki.poulose@arm.com>
 <1497278211-5001-7-git-send-email-suzuki.poulose@arm.com>
 <20170614175042.GB22030@xps15>
Message-ID: <b72bb2fa-7bbc-cee0-caaf-018b5552cad7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/06/17 18:50, Mathieu Poirier wrote:
> On Mon, Jun 12, 2017 at 03:36:45PM +0100, Suzuki K Poulose wrote:
>> Expose DBALO,DBAHI and AXICTL registers
>
> Why is this needed?  I fear we are exposing internal kernel information.
>

Mathieu,

These are useful to analyse/debug the trace session. e.g, we could compare
RRP/RWP with DBA to see if the trace is actually generated or not.
As such, we already expose RRP/RWP. Exposing DBA doesn't expose
more information than we do already. Also, when we add SG support
this will be useful, as DBA will never match (or be in the range of) RRP/RWP.

The AXICTL may not be of any significance right now, but will be
useful once we add scatter gather support, to check which mode
are we operating in.

Let me know if you still have concerns.

Suzuki

>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>  drivers/hwtracing/coresight/coresight-tmc.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
>> index 7025982..fd5a2e0 100644
>> --- a/drivers/hwtracing/coresight/coresight-tmc.c
>> +++ b/drivers/hwtracing/coresight/coresight-tmc.c
>> @@ -228,9 +228,11 @@ coresight_tmc_simple_func(ffcr, TMC_FFCR);
>>  coresight_tmc_simple_func(mode, TMC_MODE);
>>  coresight_tmc_simple_func(pscr, TMC_PSCR);
>>  coresight_tmc_simple_func(devid, CORESIGHT_DEVID);
>> +coresight_tmc_simple_func(axictl, TMC_AXICTL);
>>
>>  coresight_simple_reg64(struct tmc_drvdata, rrp, TMC_RRP, TMC_RRPHI);
>>  coresight_simple_reg64(struct tmc_drvdata, rwp, TMC_RWP, TMC_RWPHI);
>> +coresight_simple_reg64(struct tmc_drvdata, dba, TMC_DBALO, TMC_DBAHI);
>>
>>  static struct attribute *coresight_tmc_mgmt_attrs[] = {
>>  	&dev_attr_rsz.attr,
>> @@ -244,6 +246,8 @@ static struct attribute *coresight_tmc_mgmt_attrs[] = {
>>  	&dev_attr_mode.attr,
>>  	&dev_attr_pscr.attr,
>>  	&dev_attr_devid.attr,
>> +	&dev_attr_dba.attr,
>> +	&dev_attr_axictl.attr,
>>  	NULL,
>>  };
>>
>> --
>> 2.7.4
>>
