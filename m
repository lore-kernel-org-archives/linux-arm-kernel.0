From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 15 Dec 2010 08:48:11 +0100
Subject: [PATCH 1/5] msm: Secure Channel Manager (SCM) support
In-Reply-To: <1291619778-30289-2-git-send-email-johlstei@codeaurora.org>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-2-git-send-email-johlstei@codeaurora.org>
Message-ID: <20101215074811.GA2483@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> +/**
> + * struct scm_response - one SCM response buffer
> + * @len: total available memory for response
> + * @buf_offset: start of response data relative to start of scm_response
> + * @is_complete: indicates if the command has finished processing
> + */
> +struct scm_response {
> +	u32	len;
> +	u32	buf_offset;
> +	u32 is_complete;
> +};

Alignment is off here.

> +static u32 smc(dma_addr_t cmd_addr)
> +{
> +	int context_id;
> +	register u32 r0 asm("r0") = 1;
> +	register u32 r1 asm("r1") = (u32)&context_id;
> +	register u32 r2 asm("r2") = (u32)cmd_addr;

Are these neccessary?

> +	asm(
> +		__asmeq("%0", "r0")
> +		__asmeq("%1", "r0")
> +		__asmeq("%2", "r1")
> +		__asmeq("%3", "r2")
> +		"smc	#0	@ switch to secure world\n"
> +		: "=r" (r0)
> +		: "r" (r0), "r" (r1), "r" (r2)
> +		: "r3");
> +	return r0;
> +}

> +u32 scm_get_version(void)
> +{
> +	int context_id;
> +	static u32 version = -1;
> +	register u32 r0 asm("r0") = 0x1 << 8;
> +	register u32 r1 asm("r1") = (u32)&context_id;

And does this even work?

> +	if (version != -1)
> +		return version;
> +
> +	mutex_lock(&scm_lock);
> +	asm(
> +		__asmeq("%0", "r1")
> +		__asmeq("%1", "r0")
> +		__asmeq("%2", "r1")
> +		"smc	#0	@ switch to secure world\n"
> +		: "=r" (r1)
> +		: "r" (r0), "r" (r1)
> +		: "r2", "r3");
> +	version = r1;
> +	mutex_unlock(&scm_lock);
> +
> +	return version;
> +}
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
