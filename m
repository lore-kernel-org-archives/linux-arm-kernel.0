From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jul 2011 12:10:49 +0100
Subject: [PATCH 15/18] dmaengine/amba-pl08x: Pass flow controller
	information with slave channel data
In-Reply-To: <2f6001455c4e54f56716a245c7e319eb25a9bb0d.1311936524.git.viresh.kumar@st.com>
References: <cover.1311936523.git.viresh.kumar@st.com>
	<2f6001455c4e54f56716a245c7e319eb25a9bb0d.1311936524.git.viresh.kumar@st.com>
Message-ID: <20110729111049.GI25640@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Apart from my initial question in this thread...

On Fri, Jul 29, 2011 at 04:19:25PM +0530, Viresh Kumar wrote:
> +	if (plchan->cd->fc)
> +		tmp = plchan->cd->fc;
> +	else
> +		tmp = (direction == DMA_TO_DEVICE) ? PL080_FLOW_MEM2PER :
> +			PL080_FLOW_PER2MEM;
> +
> +	txd->ccfg |= tmp << PL080_CONFIG_FLOW_CONTROL_SHIFT;
> +

Please, no, don't go back to encoding the flow mask into the platform
data.  Instead use 'fc' as an indication of who should be the flow
controller, and hav ethis select the flow control based on both
'fc' and the direction.
