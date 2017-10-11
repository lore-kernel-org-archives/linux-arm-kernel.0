From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 11 Oct 2017 16:04:04 +0800
Subject: [PATCH v4 00/11] drm/sun4i: hdmi: Support HDMI controller on A31
In-Reply-To: <20171011080056.i2eodfsujdhcvxpi@flea.lan>
References: <20171010032008.682-1-wens@csie.org>
 <20171011080056.i2eodfsujdhcvxpi@flea.lan>
Message-ID: <CAGb2v66B=U5uRvJVcaDSRbNBs+1DAU7=ZmOd4sej=xMeRqX3vg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 11, 2017 at 4:00 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Oct 10, 2017 at 03:19:57AM +0000, Chen-Yu Tsai wrote:
>> Hi everyone,
>>
>> This is v4 of my A31 HDMI support series. The DTS patches depend on
>> the patch "clk: sunxi-ng: sun6i: Export video PLLs" alreay merged.
>> The DRM patches depend on "regmap: add iopoll-like polling macro for
>> regmap_field" already merged on a topic branch in the regmap repository.
>>
>> Changes since v3:
>>
>>     - Renamed sun4i_get_first_tcon() to sun4i_get_tcon0()
>>
>>     - Made sun4i_get_tcon0() return NULL when it fails, and
>>       sun6i_tcon_set_mux() will error out if that happens.
>>
>>     - Removed has_unknown_mux field in tcon_quirks structure,
>>       as its function is replaced by the per-soc muxing function
>>       pointer.
>>
>>     - Dropped clk and regmap patches that were merged.
>>
>> Changes since v2:
>>
>>     - TCON muxing moved into functions for each platform, with pointers
>>       to them in the TCON quirks structure.
>>
>>     - CCU "hdmi-ddc" clock renamed to "ddc".
>>
>>     - Added Maxime's acks.
>>
>> Changes since v1:
>>
>>     - Core changes to sun4i-drm to support two display pipelines
>>       have been merged into drm-misc and thus dropped from this
>>       version
>>
>>     - Reworked DDC variant support onto new exposed I2C interface bits.
>>
>>     - Reworked DDC variant support to use regmap_fields.
>>
>>     - Patches to add variant support to various (TMDS, DDC, HDMI
>>       controller) sub-blocks have been merged into one patch.
>>
>> This series adds support for the HDMI controller found on Allwinner
>> A31/A31s SoCs. It builds upon Maxime's work that added support for
>> the HDMI controller on the Allwinner A10s SoC.
>>
>> The HDMI controllers in the older generation Allwinner SoCs is very
>> similar. The A10/A10s/A20 all have the same hardware block, with the
>> A10 having slightly different initial configuration values. The A31's
>> variant splits out the DDC parent clock, has different formulas for
>> the DDC and TMDS clocks, and a different register layout for the DDC
>> block.
>
> Applied everything, thanks!

Looks like regmap/topic/field (which holds a required patch) was not
merged in. This means there will be some build breakage on drm-misc.

>> Also, it does not expose the CEC pins outside of the SoC, which is
>> unfortunate.
>
> Maybe we shouldn't register the CEC adapter in that case then? Can you
> send an additional patch for that?

My bad. This series started off pre-CEC support. I'll send another patch
for that.

ChenYu

>
> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
