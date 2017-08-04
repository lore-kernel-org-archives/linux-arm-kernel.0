From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 4 Aug 2017 17:21:03 +0300
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <58bf2f7c-faf1-d1e9-3c87-d7964d1ba3d4@st.com>
References: <1499343623-5964-1-git-send-email-pierre-yves.mordret@st.com>
 <1499343623-5964-3-git-send-email-pierre-yves.mordret@st.com>
 <20170722065133.GT3053@localhost>
 <2b916330-9b65-f4d5-817f-79b66cc236b3@st.com>
 <20170726052930.GF3053@localhost>
 <f2908e38-dc4d-3886-4058-52a7ad845415@st.com>
 <20170731123157.GJ3053@localhost>
 <e3a76a50-4160-d111-cce9-132b46b66c33@st.com>
 <20170802045522.GU3053@localhost>
 <7d2091fe-a2e5-78bb-b63d-9cb66bdb7e84@ti.com>
 <7bcad698-fa1a-3dc2-e918-4400639ca6d7@st.com>
 <47ceba83-1097-072e-bed6-d1964bce7a25@ti.com>
 <0e16a519-3d60-f683-5517-12a520e0e521@st.com>
 <f0db566e-5613-8914-e070-915c8c4d9b9f@ti.com>
 <71b7ef2a-d745-d16b-4538-567c856cce9a@st.com>
 <401305f0-15d8-1996-60d6-69c13cbacc06@ti.com>
 <58bf2f7c-faf1-d1e9-3c87-d7964d1ba3d4@st.com>
Message-ID: <6e8e19f1-8d0f-183b-e02f-1ec8c4dd57b3@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2017 03:50 PM, Pierre Yves MORDRET wrote:
> Our DMAMUX can manage up to 255 request lines (only 128 is eventually assigned
> though) onto 16 events: 8 events mapped on 1 DMA and the 8 others onto the
> second DMA. Request line numbering is fixed (a peripheral DMA request is
> assigned to one MUX input) and but can be routed randomly onto the any 16
> channels. We use chanID to mux input on event.
> chanID given by dma_get_any_slave_channe is enough in our case.

I would think that if you have in the router node:
dma-masters = <&dma1>, <&dma2>;

and request a DMA via the router:
dmas = <&dma_router req_in param1 param2>;

then the router driver would decide which dma-master it is going to assign the
given request line and craft the dma-spec based on this decision. This
requires no callback to the router from the DMA master driver at all.

The idea of the dma event router is to be transparent for the DMA clients
(peripherals needing DMA channel) and for the DMA drivers as well. Neither
should know that the events are muxed as it does not really matter for them.

-- 
P?ter
