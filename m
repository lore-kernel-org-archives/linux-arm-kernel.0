From: andy.gross@linaro.org (Andy Gross)
Date: Mon, 16 May 2016 00:08:04 -0500
Subject: [Patch v5 5/8] firmware: qcom: scm: Convert to streaming DMA APIS
In-Reply-To: <20160513234852.GH1256@tuxbot>
References: <1463111221-6963-1-git-send-email-andy.gross@linaro.org>
 <1463111221-6963-6-git-send-email-andy.gross@linaro.org>
 <20160513234852.GH1256@tuxbot>
Message-ID: <20160516050804.GB32019@hector>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 13, 2016 at 04:48:52PM -0700, Bjorn Andersson wrote:
> > +	cmd->len = cpu_to_le32(alloc_len);
> > +	cmd->buf_offset = cpu_to_le32(sizeof(*cmd));
> > +	cmd->resp_hdr_offset = cpu_to_le32(sizeof(*cmd) + cmd_len);
> > +
> >  	cmd->id = cpu_to_le32((svc_id << 10) | cmd_id);
> >  	if (cmd_buf)
> > -		memcpy(qcom_scm_get_command_buffer(cmd), cmd_buf, cmd_len);
> > +		memcpy(cmd->buf, cmd_buf, cmd_len);
> > +
> > +	rsp = (void *)cmd->buf + le32_to_cpu(cmd->resp_hdr_offset);
> 
> I believe resp_hdr_offset counts from the beginning of the buffer and
> that this therefor is supposed to be:
> 
> 	rsp = (void *)cmd + le32_to_cpu(cmd->resp_hdr_offset);
> 
> With that corrected, feel free to add:
> 
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

I'll fix that up.  Thanks for the review.


Andy
