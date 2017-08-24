From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Thu, 24 Aug 2017 08:47:56 +0300
Subject: [PATCH v3 2/5] dmaengine: Add STM32 DMAMUX driver
In-Reply-To: <f7ddd927-5db3-e1b1-b7f1-94050b508298@st.com>
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
 <6e8e19f1-8d0f-183b-e02f-1ec8c4dd57b3@ti.com>
 <f7ddd927-5db3-e1b1-b7f1-94050b508298@st.com>
Message-ID: <d1cc3cbb-c4aa-2acc-91ff-1d6713cb8867@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2017-08-21 12:34, Pierre Yves MORDRET wrote:
> OK. I will redesign my driver to take into account this idea.
> 
> I believe I should get rid of my custom API in DMA for channelID as well. Please
> confirm. Not very clear for me whether I can keep it or not.

Yes, you should be able to get rid of any custom API.
The DMA event router should be 'invisible' to both the DMA driver itself
and for the DMA users as well. If you end up still needing custom API
(which I doubt) then it is better to extend the core support to cover
that in a generic way since it is likely that other might have similar
needs.

You need to identify what you need to manage with the DMA router, again
in my cases:
am335x/am437x: The DMA channel is fixed, but the DMA event to be handled
by the channel (DMA event muxer) is selected by the router.
dra7x: The DMA event is the fixed part and I needed to translate that to
local eDMA/sDMA events and in eDMA I needed to pick a channel based on
the translated event.

The same router code works for eDMA and sDMA in dra7, while the two DMA
engines are different in their internal works.

At the end of the day I only needed to plug the DMA event routers and
there is no change in the DMA drivers at all.

I'm happy to answer any questions you might have, if I can.

- P?ter
