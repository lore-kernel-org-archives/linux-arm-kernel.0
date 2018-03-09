From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 09 Mar 2018 09:18:41 -0800
Subject: [Freedreno] [PATCH 2/2] arm64: dts: sdm845: Support GPU/GMU
In-Reply-To: <20180309160355.GC10589@jcrouse-lnx.qualcomm.com>
References: <20180302215638.6145-1-jcrouse@codeaurora.org>
 <20180302215638.6145-3-jcrouse@codeaurora.org>
 <20180305044221.GC23018@vireshk-i7>
 <20180305152818.GC15200@jcrouse-lnx.qualcomm.com>
 <20180306042656.GJ23018@vireshk-i7>
 <20180306153757.GD15200@jcrouse-lnx.qualcomm.com>
 <20180307050624.GR23018@vireshk-i7>
 <20180308201438.GA10589@jcrouse-lnx.qualcomm.com>
 <20180309034332.GO6842@vireshk-i7>
 <20180309160355.GC10589@jcrouse-lnx.qualcomm.com>
Message-ID: <152061592175.13890.6455929815877326231@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(I wrote an email that seems to have been lost)

Quoting Jordan Crouse (2018-03-09 08:03:55)
> On Fri, Mar 09, 2018 at 09:13:32AM +0530, Viresh Kumar wrote:
> > On 08-03-18, 13:14, Jordan Crouse wrote:
> > > It seems to me that performance_state has a direct relationship with genpd
> > > which is good for CPU votes but in this case, we're just passing along raw data
> > > to an independent microcontroller. The 'qcom,arc-level' is used to construct
> > > the actual values that the GMU will program into the RPMh. Since these are
> > 
> > The "genpd" here is created specially for this RPM. The performance-state thing
> > is designed to solve this very specific problem of qualcomm SoCs and there is no
> > way we are going to add another property for this now.
> > 
> > > informational (from the CPU perspective) rather than functional I feel like
> > > that using performance_state for this would be as hacky as using opp-microvolt
> > > or something else.
> > 
> > There is some WIP stuff here Rajendra is testing currently.
> > 
> > ssh://git at git.linaro.org/people/viresh.kumar/mylinux.git opp/genpd/qcom
> > 
> > Please have a talk with Rajendra who can help you understand on how this can be
> > used for GPUs.
> 
> I don't think we are understanding each other. The GMU is a separate
> microcontroller. It is given a magic number (actually a combination of magic
> numbers) that it then uses to directly interact with the other hardware to make
> the vote. The only responsibility that the CPU has is to construct that magic
> number (once, at init) and send it across when asked.
> 
> Looking at the sdhc code from the testing tree it makes perfect sense
> that you have a device that needs to eventually do a RPMh vote from the CPU and
> so the 'required-opp' and performance state come together to do the right thing.
> This is good code.
> 
> None of this is true for the GPU. The CPU never votes for the GPU so there 
> isn't any need to connect it to the power domain drivers. Even if you did
> there isn't any current mechanism for the rpmpd driver to pass the right magic
> number to the GPU driver which is what it really needs.
> 
> I suppose that instead of using 'qcom,arc-level' we could use 'qcom-corner' but
> then thats just a naming dispute. We still need a way for the GPU to query the
> magic values.
> 

Agreed. Forcing genpd and set_performance_state APIs on GMU doesn't make
any sense if the GMU is doing it all itself.

The binding should be the same between sdhc and GMU if they're actually
talking about the same thing though. I think they are, because I suspect
GMU needs to translate the human reasonable value of qcom,corner into
the hardware qcom,arc-level value to write into it's hardware so the GMU
can auto-transition performance states. If I'm wrong, then
qcom,arc-level needs to be created alongside of qcom,corner because
they're different number spaces.

BTW, it's qcom,corner and not qcom-corner right?
