From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 4 Aug 2011 11:24:54 +0530
Subject: [PATCH 09/18] dmaengine/amba-pl08x: Schedule tasklet in case
	of error interrupt
In-Reply-To: <1312431918.1536.559.camel@vkoul-udesk3>
References: <cover.1311936523.git.viresh.kumar@st.com>	
	<9c81beb9cd84f84b58abbd24ebfae85dfe8d8ee1.1311936524.git.viresh.kumar@st.com>	
	<1311941799.1536.532.camel@vkoul-udesk3>	
	<CAOh2x==_g+JQzTizgVTdH8Dyg_5+KpyYm+G_Ddu5mO15N6n-tw@mail.gmail.com>
	<1312431918.1536.559.camel@vkoul-udesk3>
Message-ID: <4E3A342E.5080503@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2011 09:55 AM, Koul, Vinod wrote:
> Yes that's the whole point, today callback mechanism doesn't tell the
> _status_ of the transfer (which if we need change can be discussed as
> well), but to counter argue I have never been able to generate the error
> interrupt, are you able to do on your controller?

Yes, if we supply unaligned address, with access width as word, then it gives
error interrupt.

Regarding your point of updating callback for reporting errors,
I think it is required and should be a common issue.

> 
> One more point wrt this patch, what do we gain here from calling
> tasklet, are you cleaning up your queue for the error descriptor or
> something, I think not. so just calling to print doesn't make sense to
> me, comments?

Tasklet does following:
- If any other transfer request is queued up, then it is started
- else, it releases physical channel, by clearing it completely.

Finally it unmap buffers, frees txd, and call callback.

This probably is enough to end transfer for which user was waiting.
If user hasn't used any timeout mechanisms then he will never come
to know that an error occurred. So its better to call its callback,
to tell him, transfer has completed, successfully or unsuccessfully.

-- 
viresh
