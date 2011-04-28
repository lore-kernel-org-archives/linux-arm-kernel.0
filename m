From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Apr 2011 18:12:27 +0100
Subject: [PATCH V3 4/7] dmaengine/dw_dmac: Enable resubmission from
	callback routine.
In-Reply-To: <adbd175c9fc15e65b584d342b65cd1c3c0c58322.1303896567.git.viresh.kumar@st.com>
References: <cover.1303896566.git.viresh.kumar@st.com>
	<adbd175c9fc15e65b584d342b65cd1c3c0c58322.1303896567.git.viresh.kumar@st.com>
Message-ID: <20110428171227.GD17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2011 at 03:06:46PM +0530, Viresh Kumar wrote:
>  static void
>  dwc_descriptor_complete(struct dw_dma_chan *dwc, struct dw_desc *desc,
> -		bool callback_required)
> +		bool callback_required, unsigned long flags)
>  {
...
>  	if (callback_required) {
> +		spin_unlock_irqrestore(&dwc->lock, flags);
>  		if (callback)
>  			callback(param);
> +		spin_lock_irqsave(&dwc->lock, flags);

Again, this isn't really on.  It seems to me that this code needs some
serious reworking.
