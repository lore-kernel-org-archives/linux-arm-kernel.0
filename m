From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 13 Jun 2018 16:04:20 +0800
Subject: [PATCH v2 14/27] drm/sun4i: Don't check for panel or bridge on TV
 TCONs
In-Reply-To: <20180613074621.5phumovcyymbkfbn@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net>
 <20180612200036.21483-15-jernej.skrabec@siol.net>
 <20180613074621.5phumovcyymbkfbn@flea>
Message-ID: <CAGb2v66QWr2CQhcfQ9BQds-0xeG=pS4MDzaNn7_HGz+q3gfkWA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 13, 2018 at 3:46 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Tue, Jun 12, 2018 at 10:00:23PM +0200, Jernej Skrabec wrote:
>> TV TCONs are always connected to TV or HDMI encoder, so it doesn't make
>> sense to check if panel or bridge is connected to them.
>>
>> Check if TCON has channel 0 and only then check for connected panel or
>> bridges.
>>
>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
>> ---
>>  drivers/gpu/drm/sun4i/sun4i_tcon.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> index b1205a7bc20f..c9ffa5381185 100644
>> --- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> +++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
>> @@ -1189,13 +1189,19 @@ static const struct component_ops sun4i_tcon_ops = {
>>  static int sun4i_tcon_probe(struct platform_device *pdev)
>>  {
>>       struct device_node *node = pdev->dev.of_node;
>> +     const struct sun4i_tcon_quirks *quirks;
>>       struct drm_bridge *bridge;
>>       struct drm_panel *panel;
>>       int ret;
>>
>> -     ret = drm_of_find_panel_or_bridge(node, 1, 0, &panel, &bridge);
>> -     if (ret == -EPROBE_DEFER)
>> -             return ret;
>> +     quirks = of_device_get_match_data(&pdev->dev);
>
> We should probably check ofr the pointer value before dereferencing it.

I think we've discussed this before. If the driver has data structures
for all the supported compatible strings, and it is device tree only,
then we should just let it blow up in the user's face, since they are
obviously doing something they shouldn't be doing to get the driver
to probe without a compatible string match.

ChenYu
