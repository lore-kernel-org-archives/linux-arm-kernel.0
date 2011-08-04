From: viresh.kumar@st.com (viresh kumar)
Date: Thu, 4 Aug 2011 14:12:49 +0530
Subject: [PATCH V2 08/20] dmaengine/amba-pl08x: support runtime PM
In-Reply-To: <1312442926.1539.0.camel@vkoul-udesk3>
References: <cover.1312190881.git.viresh.kumar@st.com>	
	<bc59bbd3709a7af1723d37ab846bf44c6867c00e.1312190881.git.viresh.kumar@st.com>	
	<20110803123953.GB23953@n2100.arm.linux.org.uk>
	<4E3A2BFC.3070907@st.com>	 <1312436185.1536.570.camel@vkoul-udesk3>
	<4E3A3CB7.8040505@st.com> <1312442926.1539.0.camel@vkoul-udesk3>
Message-ID: <4E3A5B89.9000703@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2011 12:58 PM, Koul, Vinod wrote:
>> > 
>> > Until this point we are not touching the registers at all. And they will
>> > accessed after this point only.
> But from maintainability POV it should be at the start.
> 

Sorry for missing this earlier, I looked at the code again and
realized why i put it at the end of the routine.

The routine looks like this

        for (all channels)
                if (!ch->serving)
                        break;

        if (i == pl08x->vd->channels) {
                /* No physical channel available, cope with it */
                return NULL;
        }

        pm_runtime_get_sync(&pl08x->adev->dev);

So, this has to be put at end only. We don't want to call this if no physical
channel is free.

-- 
viresh
