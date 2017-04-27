From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 27 Apr 2017 11:49:22 +0200
Subject: stmmac still supporting spear600 ?
In-Reply-To: <0468e2fb-5a7d-97ec-c51c-2436a13dda69@st.com>
References: <20170309093412.33c0277d@free-electrons.com>
 <373e2760-94c5-4349-33aa-158bc8f4b19e@st.com>
 <20170309103236.3e16304f@free-electrons.com>
 <79049eda-5d37-6b70-8945-2d3ab55e56b8@st.com>
 <20170321155054.2f4cb921@free-electrons.com>
 <63405ec5-099c-b935-2724-6c85012fc9f7@st.com>
 <20170402233028.60acf612@free-electrons.com>
 <0468e2fb-5a7d-97ec-c51c-2436a13dda69@st.com>
Message-ID: <20170427114922.26324765@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Giuseppe,

On Mon, 3 Apr 2017 08:16:50 +0200, Giuseppe CAVALLARO wrote:

> I tested the SMSC on other platform (+ stmmac), not on SPEAr.
> 
> ok for reset, keep the radar on clock. Hmm, can you attach a piece of 
> log file to see the failure?

We finally identified the issue: in a MII configuration, the PS bit
need to be set for the DMA reset procedure to work, but setting the DMA
reset bit clears the PS bit. So you have to set the PS bit after
asserting the DMA reset, and before polling for the DMA reset bit to
clear.

I have sent a fix that works for us (tested GMII and MII platforms),
but not sure if the implementation is the most appropriate. Let me know
if you have better suggestions.

See: http://marc.info/?l=linux-netdev&m=149328635210461&w=2

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
