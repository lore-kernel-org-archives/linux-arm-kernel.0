From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 30 Jan 2014 16:09:04 +0100
Subject: [PATCH v2 1/7] cpufreq: cpufreq-cpu0: allow optional safe voltage
 during frequency transitions
In-Reply-To: <CAJuA9ajLUPtsReomPuuzMpshTEiUz81sc4584DEVQnG=iwGb-g@mail.gmail.com>
References: <1390047057-2239-1-git-send-email-thomas.ab@samsung.com>
 <CAPtuhTj2ZOb+5LDbqghuOhQZfVy8i1xuWotoZ6ocbJFgMxnSMQ@mail.gmail.com>
 <CAJuA9ajLUPtsReomPuuzMpshTEiUz81sc4584DEVQnG=iwGb-g@mail.gmail.com>
Message-ID: <2009408.gnUEcoqA3p@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, 30. January 2014 18:23:44 Thomas Abraham wrote:
> Hi Mike,
> 
> On Wed, Jan 29, 2014 at 12:17 AM, Mike Turquette <mturquette@linaro.org> 
wrote:
> > On Mon, Jan 27, 2014 at 9:30 PM, Thomas Abraham <ta.omasab@gmail.com> 
wrote:
> >> Hi Mike,
> >> 
> >> On Tue, Jan 28, 2014 at 1:55 AM, Mike Turquette <mturquette@linaro.org> 
wrote:
> >>> Quoting Thomas Abraham (2014-01-18 04:10:51)
> >>> 
> > As far as I can tell
> > the remux does not happen because it is necessary to generate the
> > required clock rate, but because we don't want to run the ARM core out
> > of spec for a short time while the PLL relocks. Assuming I have that
> > part of it right, I prefer for the parent mux operation to be a part
> > of the CPUfreq driver's .target callback instead of hidden away in the
> > clock driver.
> 
> The re-parenting is mostly done to keep the ARM CPU clocked while the
> PLL is stopped, reprogrammed and restarted. One of the side effects of
> that is, the clock speed of the temporary parent could be higher then
> what is allowed due to the ARM voltage at the time of re-parenting.
> That is the reason to use the safe voltage.

The Rockchip-SoCs use something similar, so I'm following quite closely what 
Thomas is trying to do here, as similar solution would also solve this issue 
for me.

On some Rockchip-SoCs even stuff like pclk and hclk seems to be sourced from 
the divided armclk, creating additional constraints.

But on the RKs (at least in the upstream sources) the armclk is simply equal 
to the pll output. A divider exists, but is only used to make sure that the 
armclk stays below the original rate when sourced from the temp-parent, like

	if (clk_get_rate(temp_parent) > clk_get_rate(main_parent)
		set_divider(something so that rate(temp) <= rate(main)
	clk_set_parent(...)

Isn't there a similar possiblity on your platform, as it would remove the need 
for the safe-voltage?


In general I also like the approach of hiding the rate-change logic inside 
this composite clock, as the depending clocks can be easily kept in sync. As 
with the Rockchips the depending clocks are different for each of the three 
Cortex-A9 SoCs I looked at, it would be "interesting" if all of this would 
need to be done in a cpufreq driver.


Heiko
