From: davidb@codeaurora.org (David Brown)
Date: Wed, 15 Dec 2010 06:05:58 -0800
Subject: [PATCH 1/5] msm: Secure Channel Manager (SCM) support
In-Reply-To: <20101215074811.GA2483@ucw.cz>
References: <1291619778-30289-1-git-send-email-johlstei@codeaurora.org>
	<1291619778-30289-2-git-send-email-johlstei@codeaurora.org>
	<20101215074811.GA2483@ucw.cz>
Message-ID: <20101215140558.GA9736@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 15, 2010 at 08:48:11AM +0100, Pavel Machek wrote:

> > +static u32 smc(dma_addr_t cmd_addr)
> > +{
> > +	int context_id;
> > +	register u32 r0 asm("r0") = 1;
> > +	register u32 r1 asm("r1") = (u32)&context_id;
> > +	register u32 r2 asm("r2") = (u32)cmd_addr;
> 
> Are these neccessary?

The values have to be in specific registers.  Without them it doesn't
generate the right code.

> > +	asm(
> > +		__asmeq("%0", "r0")
> > +		__asmeq("%1", "r0")
> > +		__asmeq("%2", "r1")
> > +		__asmeq("%3", "r2")
> > +		"smc	#0	@ switch to secure world\n"
> > +		: "=r" (r0)
> > +		: "r" (r0), "r" (r1), "r" (r2)
> > +		: "r3");
> > +	return r0;
> > +}
> 
> > +u32 scm_get_version(void)
> > +{
> > +	int context_id;
> > +	static u32 version = -1;
> > +	register u32 r0 asm("r0") = 0x1 << 8;
> > +	register u32 r1 asm("r1") = (u32)&context_id;
> 
> And does this even work?

In what sense?  It generates the desired code.

> > +	if (version != -1)
> > +		return version;
> > +
> > +	mutex_lock(&scm_lock);
> > +	asm(
> > +		__asmeq("%0", "r1")
> > +		__asmeq("%1", "r0")
> > +		__asmeq("%2", "r1")
> > +		"smc	#0	@ switch to secure world\n"
> > +		: "=r" (r1)
> > +		: "r" (r0), "r" (r1)
> > +		: "r2", "r3");
> > +	version = r1;
> > +	mutex_unlock(&scm_lock);
> > +
> > +	return version;
> > +}

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
