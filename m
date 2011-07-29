From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Jul 2011 17:08:00 +0530
Subject: [PATCH 18/18] dmaengine/amba-pl08x: Call pl08x_free_txd()	instead
	of calling kfree() directly
In-Reply-To: <20110729111538.GJ25640@n2100.arm.linux.org.uk>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<90793b4b9824f8152aa4cea07fd91a8ecd3481e8.1311936524.git.viresh.kumar@st.com>
	<20110729111538.GJ25640@n2100.arm.linux.org.uk>
Message-ID: <4E329B98.8070502@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/29/2011 04:45 PM, Russell King - ARM Linux wrote:
>> > @@ -1193,7 +1193,7 @@ static int pl08x_prep_channel_resources(struct pl08x_dma_chan *plchan,
>> >  
>> >  	num_llis = pl08x_fill_llis_for_desc(pl08x, txd);
>> >  	if (!num_llis) {
>> > -		kfree(txd);
>> > +		pl08x_free_txd(pl08x, txd);
> pl08x_free_txd() is supposed to be called under the channel spinlock,
> which is why it isn't used here.  We don't want to hold the spinlock
> throughout the LLI filling because that could cause some problems,
> and potentially worsen IRQ latency.
> 
> It's something which needs more work...

Maybe we can place lock-unlock around this call to pl08x_free_txd()?

-- 
viresh
