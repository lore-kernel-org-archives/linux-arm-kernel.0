From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Wed, 9 May 2018 07:06:04 +0100
Subject: [PATCH v7 08/24] ASoC: qdsp6: q6core: Add q6core driver
In-Reply-To: <46511158-ed1d-7f07-0a8f-b325c088e386@codeaurora.org>
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-9-srinivas.kandagatla@linaro.org>
 <46511158-ed1d-7f07-0a8f-b325c088e386@codeaurora.org>
Message-ID: <9ea47387-d849-19e8-1075-74a5e7e11a22@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks Banajit for the review!

On 04/05/18 20:04, Banajit Goswami wrote:
>> +
>> +static int q6core_callback(struct apr_device *adev, struct 
>> apr_resp_pkt *data)
>> +{
>> +    struct q6core *core = dev_get_drvdata(&adev->dev);
>> +    struct aprv2_ibasic_rsp_result_t *result;
>> +    struct apr_hdr *hdr = &data->hdr;
>> +
>> +    result = data->payload;
>> +    switch (hdr->opcode) {
>> +    case APR_BASIC_RSP_RESULT:{
>> +        result = data->payload;
>> +        switch (result->opcode) {
>> +        case AVCS_GET_VERSIONS:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->get_version_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        case AVCS_CMD_GET_FWK_VERSION:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->fwk_version_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        case AVCS_CMD_ADSP_EVENT_GET_STATE:
>> +            if (result->status == ADSP_EUNSUPPORTED)
>> +                core->get_state_supported = false;
>> +            core->resp_received = true;
>> +            break;
>> +        }
>> +        break;
>> +    }
>> +    case AVCS_CMDRSP_GET_FWK_VERSION: {
>> +        struct avcs_cmdrsp_get_fwk_version *fwk;
>> +        int bytes;
>> +
>> +        fwk = data->payload;
>> +        core->fwk_version_supported = true;
>> +        bytes = sizeof(*fwk) + fwk->num_services *
>> +                sizeof(fwk->svc_api_info[0]);
>> +
>> +        core->fwk_version = kzalloc(bytes, GFP_ATOMIC);
>> +        if (!core->fwk_version)
>> +            return -ENOMEM;
> When the above allocation fails,  core->fwk_version_supported will be 
> still true, and q6core_get_fwk_versions() will return 0 (timeout as 
> core->resp_received will not be set to true). This can cause a NULL 
> pointer dereference inside the if() loop pointed below (added comment).
> Please move the line to set core->fwk_version_supported flag to after 
> memset() to copy fwk version info.

Yes, makes sense, I fixed this and other comments in v8.

thanks,
srini
>> +
>> +        memcpy(core->fwk_version, data->payload, bytes);
>> +
>> +        core->resp_received = true;
>> +
>> +        break;
>> +    }
>> +    case AVCS_GET_VERSIONS_RSP: {
>> +        struct avcs_cmdrsp_get_version *v;
>> +        int len;
>> +
>> +        v = data->payload;
>> +        core->get_version_supported = true;
>> + 
