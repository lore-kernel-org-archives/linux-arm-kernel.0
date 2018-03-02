From: philippe.cornu@st.com (Philippe CORNU)
Date: Fri, 2 Mar 2018 13:15:49 +0000
Subject: [PATCH] drm/bridge/synopsys: dsi: readl_poll_timeout return value
 clean up
In-Reply-To: <290c749a-70bf-2b74-1fb9-2de26708d001@samsung.com>
References: <20180204213624.18288-1-philippe.cornu@st.com>
 <CGME20180301090106epcas2p3c47f4436b0c8a31ce71cfd3909dc77ae@epcas2p3.samsung.com>
 <172e7f68-8f4b-7e5f-3e9f-7aaf10a51dc9@st.com>
 <290c749a-70bf-2b74-1fb9-2de26708d001@samsung.com>
Message-ID: <587f8a32-b9b3-0e81-d91d-69ea256bdc29@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrzej,


On 03/02/2018 11:21 AM, Andrzej Hajda wrote:
> On 01.03.2018 10:00, Philippe CORNU wrote:
>> Hi Archit, Andrzej & Laurent,
>>
>> May I ask you please your feedback on this small patch?
>> Many thanks,
>>
>> Philippe :-)
>>
>> On 02/04/2018 10:36 PM, Philippe Cornu wrote:
>>> The readl_poll_timeout() return value is 0 in case of success
>>> so it is better to detect errors without taking care of the
>>> return value sign.
>>>
>>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
> 
> The patch is of course correct. However I am not sure if necessary. For
> sure functionally it does not change anything.
> AFAIK kernel CodingStyle says nothing about it, so I suppose it is
> matter of personal taste.

I sent this tiny patch in order to homogenize the dw mipi driver because 
there were both cases "if (ret)" & "if (ret < 0)" in the source code.

I did not really find a preferred way in the kernel source code so I 
selected what sounds the best to me ie "if (ret)" but it is not a 
problem to make another patch for "if (ret < 0)" everywhere :-)

In any case, the most important from my pov is to have a homogeneous 
source code :-)

Does anyone have a preferred choice between "if (ret)" & "if (ret < 0)" 
after a "ret = readl_poll_timeout()"?

> Anyway I can give it:
> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

Many thanks,
Philippe :)

> 
>  ?--
> Regards
> Andrzej
> 
>>> ---
>>>    drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 10 +++++-----
>>>    1 file changed, 5 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> index 65aeb3f78b48..4d0e8471a15c 100644
>>> --- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
>>> @@ -342,7 +342,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>>>    	ret = qq(dsi->base + DSI_CMD_PKT_STATUS,
>>>    				 val, !(val & GEN_CMD_FULL), 1000,
>>>    				 CMD_PKT_STATUS_TIMEOUT_US);
>>> -	if (ret < 0) {
>>> +	if (ret) {
>>>    		dev_err(dsi->dev, "failed to get available command FIFO\n");
>>>    		return ret;
>>>    	}
>>> @@ -353,7 +353,7 @@ static int dw_mipi_dsi_gen_pkt_hdr_write(struct dw_mipi_dsi *dsi, u32 hdr_val)
>>>    	ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>>    				 val, (val & mask) == mask,
>>>    				 1000, CMD_PKT_STATUS_TIMEOUT_US);
>>> -	if (ret < 0) {
>>> +	if (ret) {
>>>    		dev_err(dsi->dev, "failed to write command FIFO\n");
>>>    		return ret;
>>>    	}
>>> @@ -385,7 +385,7 @@ static int dw_mipi_dsi_write(struct dw_mipi_dsi *dsi,
>>>    		ret = readl_poll_timeout(dsi->base + DSI_CMD_PKT_STATUS,
>>>    					 val, !(val & GEN_PLD_W_FULL), 1000,
>>>    					 CMD_PKT_STATUS_TIMEOUT_US);
>>> -		if (ret < 0) {
>>> +		if (ret) {
>>>    			dev_err(dsi->dev,
>>>    				"failed to get available write payload FIFO\n");
>>>    			return ret;
>>> @@ -716,13 +716,13 @@ static void dw_mipi_dsi_dphy_enable(struct dw_mipi_dsi *dsi)
>>>    
>>>    	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS, val,
>>>    				 val & PHY_LOCK, 1000, PHY_STATUS_TIMEOUT_US);
>>> -	if (ret < 0)
>>> +	if (ret)
>>>    		DRM_DEBUG_DRIVER("failed to wait phy lock state\n");
>>>    
>>>    	ret = readl_poll_timeout(dsi->base + DSI_PHY_STATUS,
>>>    				 val, val & PHY_STOP_STATE_CLK_LANE, 1000,
>>>    				 PHY_STATUS_TIMEOUT_US);
>>> -	if (ret < 0)
>>> +	if (ret)
>>>    		DRM_DEBUG_DRIVER("failed to wait phy clk lane stop state\n");
>>>    }
>>>    
> 
> 
