From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Mon, 16 May 2016 12:15:29 +0800
Subject: [PATCH 3/4] phy: rockchip-emmc: configure default output tap delay
In-Reply-To: <CAD=FV=WupNv+z86BgmR1n8bj+b6GKA5Ew7U9hgoAxV9dxF7gjQ@mail.gmail.com>
References: <1463092986-61777-1-git-send-email-briannorris@chromium.org>
 <1463092986-61777-3-git-send-email-briannorris@chromium.org>
 <CAD=FV=WupNv+z86BgmR1n8bj+b6GKA5Ew7U9hgoAxV9dxF7gjQ@mail.gmail.com>
Message-ID: <52567d92-d1d3-f089-65c2-a30f3a00386b@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 2016/5/14 6:25, Doug Anderson wrote:
> Hi,
>
> On Thu, May 12, 2016 at 3:43 PM, Brian Norris <briannorris@chromium.org> wrote:
>> The output tap delay controls helps maintain the hold requirements for
>> eMMC. The exact value is dependent on the SoC and other factors, though
>> it isn't really an exact science. But the default of 0 is not very good,
>> as it doesn't give the eMMC much hold time, so let's bump up to 4
>> (approx 90 degree phase?). If we need to configure this any further
>> (e.g., based on board or speed factors), we may need to consider a
>> device tree representation.
>
> As I understand it, this solves much the same problem as my patch in
> <https://patchwork.kernel.org/patch/9085581/>, but for the eMMC port
> on rk3399 (which doesn't use dw_mmc).  As argued in that patch and
> also in the discussion from
> <https://patchwork.kernel.org/patch/9030621/>, if we eventually end up
> needing to put something in the device tree we need to be really
> careful.  Specifically to get the exact right value here I think you
> need to consider the input clock, speed mode, and any SoC-specific
> delays differences between the clock and the data lines.  That would
> imply that, if anything, the device tree data would only contain
> information about the SoC-specific delay differences and all other
> work to set this value would involve coordination between the PHY and
> the SDHCI controller.
>
>
> However, as also discussed previously, we don't appear to need to be
> very exact about the value here.  It seems like setting this to 4 (~90
> degrees?) is a much better starting point than leaving it at the
> default of 0.

The value, 4, is based on real silicon test observed from the
oscilloscope, and of course it meets the requirement of speed modes.
For arasan't phy, its phase is very accurate, so the real timing of
the value you set almost won't vary too much for different Socs.

So explicitly assigning 4 here looks sane currently except for crazy
PCB layout...


>
>
> ...so I'd be all for landing this patch.  Perhaps Shawn can chime in
> and confirm that our understanding is correct and possibly we can
> update the commit message.  Then presumably someone at Rockchip can
> keep working to find a better way to set this long term.
>
> Sound good?
>
>
> -Doug
>
>
>


-- 
Best Regards
Shawn Lin
