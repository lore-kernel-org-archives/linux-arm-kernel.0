From: balbi@ti.com (Felipe Balbi)
Date: Fri, 24 Oct 2014 15:08:33 -0500
Subject: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
In-Reply-To: <20141024195532.GF19377@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
 <20141024160845.GM26941@saruman> <20141024190251.GB19377@localhost>
 <20141024192540.GD11455@saruman> <20141024192948.GE11455@saruman>
 <20141024193655.GD19377@localhost> <20141024194442.GG11455@saruman>
 <20141024195532.GF19377@localhost>
Message-ID: <20141024200833.GI11455@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 09:55:32PM +0200, Johan Hovold wrote:
> On Fri, Oct 24, 2014 at 02:44:42PM -0500, Felipe Balbi wrote:
> > On Fri, Oct 24, 2014 at 09:36:55PM +0200, Johan Hovold wrote:
> > > On Fri, Oct 24, 2014 at 02:29:48PM -0500, Felipe Balbi wrote:
> > > > Hi,
> > > > 
> > > > On Fri, Oct 24, 2014 at 02:25:40PM -0500, Felipe Balbi wrote:
> 
> > > > > with this I always get to "Power off failed -- system halted". If I
> > > > > switch to v3.18-rc1 vanilla, then it works. So it's definitely caused by
> > > > > your rtc-only patches.
> > > 
> > > That's expected (see below). It works with v3.18-rc1 vanilla because
> > > machine_halt is called instead of machine_power_off as there is no
> > > registered power-off handler.
> > 
> > yeah, that much I figured :-)
> > 
> > > > ok, so it seems like it takes more than 1 second for things to
> > > > propagate. If I increase that mdelay() to 3000, then everything works
> > > > fine on my end. I think we should get RMK's input on this 3000ms delay
> > > > to machine_power_off(). Should it be generic, or should we add it to our
> > > > rtc pm_power_off implementation ?
> > > 
> > > As I wrote above, we still need a 2-second mdelay in rtc-omap, which I
> > > intend to add to the pmic_power_en patch.
> > 
> > oh, alright then. If you can Cc me, I'll make sure to test that too ;-)
> 
> I will. :) Just wanted to see whether Andrew preferred I resend the
> whole series or just that one patch first.
> 
> The diff is minimal:
> 
> diff --git a/drivers/rtc/rtc-omap.c b/drivers/rtc/rtc-omap.c
> index e74750f00b18..e4f97ad9eb21 100644
> --- a/drivers/rtc/rtc-omap.c
> +++ b/drivers/rtc/rtc-omap.c
> @@ -423,6 +423,8 @@ static void omap_rtc_power_off(void)
>         val = rtc_read(rtc, OMAP_RTC_INTERRUPTS_REG);
>         rtc_writel(rtc, OMAP_RTC_INTERRUPTS_REG,
>                         val | OMAP_RTC_INTERRUPTS_IT_ALARM2);
> +
> +       mdelay(2000);
>  }

you can add my:

Tested-by: Felipe Balbi <balbi@ti.com>

for this too. Now it's all good.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141024/50526f0d/attachment.sig>
