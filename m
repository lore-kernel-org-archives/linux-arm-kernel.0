From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 21 Sep 2015 18:16:51 -0700
Subject: [PATCH v2 5/8] soc: qcom: smd: Remove use of VLAIS
In-Reply-To: <1441234011-4259-6-git-send-email-sboyd@codeaurora.org>
References: <1441234011-4259-1-git-send-email-sboyd@codeaurora.org>
 <1441234011-4259-6-git-send-email-sboyd@codeaurora.org>
Message-ID: <20150922011651.GQ13472@usrtlx11787.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 02 Sep 15:46 PDT 2015, Stephen Boyd wrote:

> Usage of VLAIS prevents clang from compiling this file, and it
> also opens us to the possibility of allocating a large structure
> on the stack to the point that we blow past the limit of the
> kernel stack. Remove the VLAIS and allocate a structure on the
> heap with kmalloc so that we're safer and more clang friendly.
> 
[..]
> diff --git a/drivers/soc/qcom/smd-rpm.c b/drivers/soc/qcom/smd-rpm.c
[..]
>  	struct {
>  		struct qcom_rpm_header hdr;
>  		struct qcom_rpm_request req;
> -		u8 payload[count];
> -	} pkt;
> +		u8 payload[];
> +	} *pkt;
> +	size_t size = sizeof(*pkt) + count;
>  
[..]
>  
> -	ret = qcom_smd_send(rpm->rpm_channel, &pkt, sizeof(pkt));
> +	ret = qcom_smd_send(rpm->rpm_channel, pkt, sizeof(*pkt));

It would be good if we actually include the request in the packet and
not just the headers :)

s/sizeof(*pkt)/size/

Sorry for not spotting this before, made my device not boot now that it
showed up in linux-next. And oddly the 8974 RPM seems to just ack the
messages, without any indication of the request being truncated...


@Andy, I presume this is only on your -next, can you update the commit?
Or do you want a patch for it?

With this tiny change what we have on next-20150921 seems to work fine.

Regards,
Bjorn
