From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 08 Dec 2010 11:59:46 -0800
Subject: [PATCH v2 2/6] msm: Secure Channel Manager (SCM) support
In-Reply-To: <20101208165317.GP9777@n2100.arm.linux.org.uk>
References: <1291782501-3909-1-git-send-email-johlstei@codeaurora.org>
	<1291782501-3909-3-git-send-email-johlstei@codeaurora.org>
	<20101208165317.GP9777@n2100.arm.linux.org.uk>
Message-ID: <4CFFE3B2.1060600@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2010 08:53 AM, Russell King - ARM Linux wrote:
>
> Ok, so the real command bytes come after this struct scm_command structure.
> So why not do this:
>
> +struct scm_command {
> +	u32	len;
> +	u32	buf_offset;
> +	u32	resp_hdr_offset;
> +	u32	id;
> +	u32	cmdwds[0];
> +};
>
> and
>
> 		cmd->buff_offset = offsetof(struct scm_command, cmdwds);
>
> sizeof(struct scm_command) will still be 32, but now you can do:
[snip]
>> +/**
>> + * scm_get_command_buffer() - Get a pointer to a command buffer
>> + * @cmd: command
>> + *
>> + * Returns a pointer to the command buffer of a command.
>> + */
>> +static inline void *scm_get_command_buffer(const struct scm_command *cmd)
>> +{
>> +	return (void *)cmd + cmd->buf_offset;
>
> and here becomes:
> 	return (void *)cmd->cmdwds;
> if it's necessary for it to exist at all.
>

Ok. I was thinking that the command should be treated the same as the
response, since the padding between the response header and response
buffer can be arbitrary (and not under our control). This isn't true for
the command header and command buffer since we define the padding.

I still like the idea of scm_get_command_buffer() though since it duals
scm_get_response_buffer().

>> +int scm_call(u32 svc_id, u32 cmd_id, const void *cmd_buf, size_t cmd_len,
>> +		void *resp_buf, size_t resp_len)
>> +{
>> +	int ret;
>> +	struct scm_command *cmd;
>> +	struct scm_response *rsp;
>> +	dma_addr_t handle;
>> +
>> +	cmd = alloc_scm_command(cmd_len, resp_len, &handle);
>> +	if (!cmd)
>> +		return -ENOMEM;
>> +
>> +	cmd->id = (svc_id << 10) | cmd_id;
>> +	if (cmd_buf)
>> +		memcpy(scm_get_command_buffer(cmd), cmd_buf, cmd_len);
>> +	wmb();
>> +
>> +	mutex_lock(&scm_lock);
>> +	ret = __scm_call(handle);
>> +	mutex_unlock(&scm_lock);
>> +	if (ret)
>> +		goto out;
>> +
>> +	rsp = scm_command_to_response(cmd);
>> +	do {
>> +		rmb();
>> +	} while (!rsp->is_complete);
>
> Hmm, this seems weird.  Doesn't the SMC call only return once the request
> has been completed?

No. __scm_call() returns once the request has been accepted. scm_call()
returns once the request has completed. Multiple scm_command's can be in
flight at the same time on the secure side.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
