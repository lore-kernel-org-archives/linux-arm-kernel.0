From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 13 Dec 2016 18:48:50 +0100
Subject: [PATCH 8/9] arm64: dts: rockchip: partially describe PWM
 regulators for Gru
In-Reply-To: <20161207170916.GA84287@google.com>
References: <1480645653-36943-1-git-send-email-briannorris@chromium.org>
 <2418784.7dMdkAyuIx@phil> <20161207170916.GA84287@google.com>
Message-ID: <13721273.q1HcHZAhdQ@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 7. Dezember 2016, 09:09:17 CET schrieb Brian Norris:
> Hi Heiko,
> 
> On Wed, Dec 07, 2016 at 05:48:24PM +0100, Heiko Stuebner wrote:
> > Am Donnerstag, 1. Dezember 2016, 18:27:32 CET schrieb Brian Norris:
> > > We need to add regulators to the CPU nodes, so cpufreq doesn't think it
> > > can crank up the clock speed without changing the voltage. However, we
> > > don't yet have the DT bindings to fully describe the Over Voltage
> > > Protection (OVP) circuits on these boards. Without that description, we
> > > might end up changing the voltage too much, too fast.
> > > 
> > > Add the pwm-regulator descriptions and associate the CPU OPPs, but leave
> > > them disabled.
> > > 
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > 
> > is there a specific reason for keeping this change separate?
> 
> Maybe not a great one. I figured they were somewhat controversial, so I
> at least wanted to split the "cpufreq patches" (i.e., this and the
> previous) from the main DTS(I) additions. I also figured we typically
> like to keep the base SoC changes separate from the board DTS(I)
> changes.

I was scratching my head for a bit where this was affecting the evb, until I 
found the include at the end of patch5 :-) .

> > While it is nice for documentation reasons, as it stands now the previous
> > patch introduces a regression (cpufreq trying to scale without regulators)
> > and immediately fixes it here.
> 
> Right. Additionally, as noted on the previous patch, we might do the
> same with EVB. But I don't know what the regulators are like for EVB.
> This is probably a bigger deal, since EVB has been working (allegedly)
> upstream for a while now.

Yep, it was at least booting :-) . I guess I should wire it up again. My shiny 
new Gru somehow did take up its space recently.

> There's no way to split these up without either breaking compilation or
> breaking bisectability. For Kevin/Gru, they don't function at all before
> this series, so I figured some "settle" time wasn't a huge deal.
> 
> > So if you're ok with it, I'd like to merge this one back into the previous
> > patch when applying.
> 
> That'd be OK with me, as long as we're also confident about EVB.

That somehow sounds unrelated, as this patch only touches gru stuff anyway. So 
if the evb breaks, it would do so after patch5 already.


> Maybe at a minimum, I should just patch in some empty regulator nodes,
> so cpufreq doesn't think there's no need to handle voltage.

So I guess going forward we could do, describe the evb pwm regulators (in 
disabled state), add general OPPs, add gru with pwm regulators?

I'll try to hook up my evb and check on the pwm-regulators in the schematics 
this week.


Heiko
