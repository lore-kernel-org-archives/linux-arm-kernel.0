From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 3 Jul 2017 11:45:52 +0530
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170630121026.azppihjqls5i6bbr@sirena.org.uk>
References: <20170630031648.GR29665@vireshk-i7>
 <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
 <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
 <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
 <20170630051203.GY29665@vireshk-i7>
 <CAGb2v64CE2cUKgFuXd0f+FEdzQqmpOgMWqk76RndjeOz98=H0A@mail.gmail.com>
 <20170630084330.GB29665@vireshk-i7>
 <20170630121026.azppihjqls5i6bbr@sirena.org.uk>
Message-ID: <20170703061552.GB3532@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-06-17, 13:10, Mark Brown wrote:
> On Fri, Jun 30, 2017 at 02:13:30PM +0530, Viresh Kumar wrote:
> > On 30-06-17, 14:36, Chen-Yu Tsai wrote:
> 
> > Operable ranges of the regulator: 1.8 - 3.0 V
> > Range required by LCD: 2.0 - 3.0 V
> > Range required by DMA: 1.8 - 2.5 V
> 
> > Here DMA can't work with regulator voltages > 2.5 V, but regulator can
> > go max to 3.0 V. Of course if the DMA driver has done
> > regulator_set_voltage(), then we will be within 2.5 V range. But that
> > doesn't force us to have regulator-max-microvolt set to 2.5 V.
> 
> > And so the DT node shall have this:
> 
> >         regulator-min-microvolt = <1800000>;
> >         regulator-max-microvolt = <3000000>;
> 
> > Isn't it ?
> 
> If the DMA can't tolerate more than 2.5V then why would the constraints
> allow the voltage to float that far?  Similarly on the low end?

The above regulator-min/max-microvolt values I mentioned were for the regulator
device and not what the consumers would request. Yes, DMA will request something
between 1.8 to 2.5 V, but in the above example LCD can request from 2.0 to 3.0 V
and so I had those limits for the regulator device (in DT).

> Please remember that devices shouldn't be managing their voltages unless
> they are actively changing them at runtime, simply setting them at
> startup is the job of the constraints.  I would be very surprised to see
> a DMA controller doing anything like DVFS.

Sure, DMA would most likely set a constraint from probe. Maybe I could have used
MMC in the above example, which may actually do DVFS at runtime.

-- 
viresh
