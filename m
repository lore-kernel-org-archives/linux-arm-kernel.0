From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 13 Mar 2018 13:55:40 +0000
Subject: [alsa-devel] [PATCH v4 15/24] ASoC: qdsp6: q6core: Add q6core
 driver
In-Reply-To: <21207441-4e81-284e-343c-bdeb01c9d06f@codeaurora.org>
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-16-srinivas.kandagatla@linaro.org>
 <21207441-4e81-284e-343c-bdeb01c9d06f@codeaurora.org>
Message-ID: <e1d119f8-146a-b549-3dd9-da6d8b0f3e9f@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Rohit for review comments,

On 13/03/18 11:46, Rohit Kumar wrote:
> 
> 
> On 3/10/2018 7:54 AM, srinivas.kandagatla at linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> [..]
>> +static int q6core_get_svc_versions(struct q6core *core)
>> +{
>> +    struct apr_device *adev = core->adev;
>> +    struct apr_hdr hdr = {0};
>> +    int rc;
>> +
>> +    core->get_version_supported = true;
> 
> core->get_version_supported should be set to true only after we get 
> proper response from adsp in callback(). In case,we get wrong response 
> from adsp, memory for g_core->svc_version
>   will not get allocated and there will be NULL pointer dereference in  
> q6core_get_svc_api_info() in below statement

I totally agree with you , this line seems to be a leftover from 
previous patches, It should be removed.

thanks,
srini
> +    } else if (g_core->get_version_supported) {
> +        for (i = 0; i < g_core->svc_version->num_services; i++) {
> 
> 
>> +    hdr.hdr_field = APR_HDR_FIELD(APR_MSG_TYPE_SEQ_CMD,
>> +                      APR_HDR_LEN(APR_HDR_SIZE), APR_PKT_VER);
>> +    hdr.pkt_size = APR_HDR_SIZE;
>> +    hdr.opcode = AVCS_GET_VERSIONS;
>> +
>> +    rc = apr_send_pkt(adev, &hdr);
>> +    if (rc < 0)
>> +        return rc;
>> +
