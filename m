From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Fri, 4 May 2018 09:24:16 +0100
Subject: [alsa-devel] [PATCH v7 16/24] ASoC: qdsp6: q6asm: Add support to
 audio stream apis
In-Reply-To: <f3b3d90b-6504-328e-c9f4-a3b3f085d9dc@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
 <f3b3d90b-6504-328e-c9f4-a3b3f085d9dc@codeaurora.org>
Message-ID: <196824c5-2b0c-1f1b-edd9-0ba6e82ac0f7@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Rohit for testing this!


On 04/05/18 08:11, Rohit Kumar wrote:
> 
> 
> On 5/1/2018 5:38 PM, Srinivas Kandagatla wrote:
>> +static int __q6asm_run(struct audio_client *ac, uint32_t flags,
>> +          uint32_t msw_ts, uint32_t lsw_ts, bool wait)
>> +{
>> +    struct asm_session_cmd_run_v2 *run;
>> +    struct apr_pkt *pkt;
>> +    int pkt_size, rc;
>> +    void *p;
>> +
>> +    pkt_size = APR_HDR_SIZE + sizeof(*run);
>> +    p = kzalloc(pkt_size, GFP_KERNEL);
> Should be GFP_ATOMIC as this API is also called from interrupt context

Yes, these should be a GFP_ATOMIC, Will fix this up in next version.

thanks,
srini

>> +    if (!p)
>> +        return -ENOMEM;
>> +
> [..]
>> +int q6asm_read(struct audio_client *ac)
>> +{
>> +    struct asm_data_cmd_read_v2 *read;
>> +    struct audio_port_data *port;
>> +    struct audio_buffer *ab;
>> +    struct apr_pkt *pkt;
>> +    int pkt_size;
>> +    int rc = 0;
>> +    void *p;
>> +
>> +    if (!(ac->io_mode & ASM_SYNC_IO_MODE))
>> +        return 0;
>> +
>> +    pkt_size = APR_HDR_SIZE + sizeof(*read);
>> +    p = kzalloc(pkt_size, GFP_KERNEL);
> same here. GFP_ATOMIC
>> +    if (!p)
>> +        return -ENOMEM;
> [..]
>> +int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t 
>> msw_ts,
>> +               uint32_t lsw_ts, uint32_t flags)
>> +{
>> +    struct asm_data_cmd_write_v2 *write;
>> +    struct audio_port_data *port;
>> +    struct audio_buffer *ab;
>> +    struct apr_pkt *pkt;
>> +    int pkt_size;
>> +    int rc = 0;
>> +    void *p;
>> +
>> +    pkt_size = APR_HDR_SIZE + sizeof(*write);
>> +    p = kzalloc(pkt_size, GFP_KERNEL);
> GFP_ATOMIC
>> +    if (!p)
>> +        return -ENOMEM;
>>
> Thanks,
> Rohit
> 
