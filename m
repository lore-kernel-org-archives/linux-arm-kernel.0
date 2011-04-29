From: viresh.kumar@st.com (viresh kumar)
Date: Fri, 29 Apr 2011 15:47:19 +0530
Subject: [PATCH V3 2/7] dmaengine/dw_dmac: Replace spin_lock* with	irqsave
	variants
In-Reply-To: <20110429091557.GZ17290@n2100.arm.linux.org.uk>
References: <cover.1303896566.git.viresh.kumar@st.com>
	<50dc2f47f2c9f94fce78583568830a66af49307d.1303896567.git.viresh.kumar@st.com>
	<20110428171020.GB17290@n2100.arm.linux.org.uk>
	<20110429091557.GZ17290@n2100.arm.linux.org.uk>
Message-ID: <4DBA902F.2080009@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2011 02:45 PM, Russell King - ARM Linux wrote:
> BTW, how this gets handled in other drivers is basically as follows in
> the tasklet:
> 
> tasklet()
> {
> 	LIST_HEAD(completed);
> 
> 	spin_lock_irqsave(lock, flags);
> 	for each txd(txd) {
> 		if (completed(txd))
> 			list_move_tail(&txd->node, &completed);
> 	}
> 	try to start new txd();
> 	spin_unlock_irqrestore(lock, flags);
> 
> 	for each list entry safe(txd, &completed) {
> 		void (*callback)(void *) = txd->callback;
> 		void *param = txd->callback_param;
> 
> 		free_txd(txd);
> 
> 		if (callback)
> 			callback(param);
> 	}
> }
> 
> I'm not sure how easy it is to move dw_dmac to that kind of structure,

I will check that.

-- 
viresh
