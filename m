From: zyw@rock-chips.com (Chris Zhong)
Date: Wed, 15 Feb 2017 12:12:22 +0800
Subject: [PATCH v2 11/11] drm/rockchip/dsi: fix insufficient bandwidth of
 some panel
In-Reply-To: <20170117105450.360c6c69.john@metanate.com>
References: <1484561311-494-1-git-send-email-zyw@rock-chips.com>
 <1484561311-494-12-git-send-email-zyw@rock-chips.com>
 <20170116124453.2154def9.john@metanate.com> <587DE489.2010004@rock-chips.com>
 <20170117105450.360c6c69.john@metanate.com>
Message-ID: <58A3D526.7060707@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi John

On 01/17/2017 06:54 PM, John Keeping wrote:
> On Tue, 17 Jan 2017 17:31:53 +0800, Chris Zhong wrote:
>
>> On 01/16/2017 08:44 PM, John Keeping wrote:
>>> On Mon, 16 Jan 2017 18:08:31 +0800, Chris Zhong wrote:
>>>   
>>>> Set the lanes bps to 1 / 0.9 times of pclk, the margin is not enough
>>>> for some panel, it will cause the screen display is not normal, so
>>>> increases the badnwidth to 1 / 0.8.
>>>>
>>>> Signed-off-by: Chris Zhong <zyw@rock-chips.com>
>>>>
>>>> ---
>>>>
>>>>    drivers/gpu/drm/rockchip/dw-mipi-dsi.c | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>>>> index 9dfa73d..5a973fe 100644
>>>> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>>>> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi.c
>>>> @@ -501,8 +501,8 @@ static int dw_mipi_dsi_get_lane_bps(struct dw_mipi_dsi *dsi)
>>>>    
>>>>    	mpclk = DIV_ROUND_UP(dsi->mode->clock, MSEC_PER_SEC);
>>>>    	if (mpclk) {
>>>> -		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
>>>> -		tmp = mpclk * (bpp / dsi->lanes) * 10 / 9;
>>>> +		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
>>>> +		tmp = mpclk * (bpp / dsi->lanes) * 10 / 8;
>>> This and patch 9 are just hacking around the underlying problem in order
>>> to make particular panels work.  I'm pretty sure the actual issue is the
>>> use of hardcoded values when configuring the PHY, since the PHY
>>> parameters are specified in clock cycles but the MIPI spec requires
>>> absolute time durations.
>>>
>>> I posted a series addressing this a while ago, although I screwed up
>>> sending it so some patches were included twice and since no one
>>> expressed any interest I didn't post a cleaned up version.
>>>
>>> The relevant patch is here:
>>>
>>> https://patchwork.kernel.org/patch/9340193/
>> Thanks very much, your patches are very useful for me. It looks your
>> method is correct.
>> And I am very confused why Mark Yao and me did not receive your patches
>> before,
>> although we have subscribed the <linux-rockchip@lists.infradead.org>.
>>
>> In addition, could you tell me which device ware you testing with these
>> mipi patches.
>> I going to test them these day.
> I'm using RK3288 and I tested my patches with three different MIPI
> displays, two of which require commands to be sent in order to set up
> the panel.
>
> Thanks for testing the patches.
>
>
> John
I think we really need this patch, one mipi panel hit this problem 
again, with all your 24 patches
and my 6 MIPI DSI patches
So I will update my series to v7, and add this patch into it.

>
>
