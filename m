From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 21 Apr 2016 16:00:22 -0600
Subject: [PATCH V2 14/15] coresight: tmc: implementing TMC-ETR AUX space
 API
In-Reply-To: <5718FB80.90205@arm.com>
References: <1460483692-25061-1-git-send-email-mathieu.poirier@linaro.org>
 <1460483692-25061-15-git-send-email-mathieu.poirier@linaro.org>
 <5718FB80.90205@arm.com>
Message-ID: <CANLsYkz-3i4wnZ2s1ns0zjkrtJ_5UgYOFf31QPpmPuANHqz_tQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21 April 2016 at 10:10, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 12/04/16 18:54, Mathieu Poirier wrote:
>>
>> This patch implement the AUX area interfaces required to
>> use the TMC (configured as an ETR) from the Perf sub-system.
>>
>> The heuristic is heavily borrowed from the ETB10 and TMC-ETF
>> implementation.
>>
>> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>
>
>> +static void tmc_update_etr_buffer(struct coresight_device *csdev,
>> +                                 struct perf_output_handle *handle,
>> +                                 void *sink_config)
>> +{
>> +       struct cs_etr_buffers *buf = sink_config;
>> +
>> +       /*
>> +        * An ETR configured to work in contiguous memory mode works the
>> same
>> +        * was as an ETB or ETF.
>> +        */
>> +       tmc_update_etf_buffer(csdev, handle, &buf->tmc);
>
>
> Really ? I thought the ETR stores the data to the allocated System RAM and
> can
> be read directly from the memory than using the RRD ?

Using an ETR in contiguous mode is inefficient to start with.
Regardless of the approach taken trace data has to be copied to perf's
non-contiguous ring buffer pages.  It would be more efficient to copy
bigger chunks of data to the ring buffer (because we can), but I
rather spend my time enabling scatter-gather mode than optimizing a
sub-optimal mode of operation.

This currently work and enables people to use the IP block while
scatter-gather mode is in flight.  I should probably make that clear
in the commit log.

Thanks,
Mathieu

>
> Suzuki
>
>
>
