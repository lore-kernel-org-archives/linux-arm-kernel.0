From: broonie@kernel.org (Mark Brown)
Date: Fri, 30 Jun 2017 13:10:26 +0100
Subject: [RFC 0/5] drivers: Add boot constraints core
In-Reply-To: <20170630084330.GB29665@vireshk-i7>
References: <1522ae7b-fd5b-5403-62bf-b0140e116d65@gr13.net>
 <20170630031648.GR29665@vireshk-i7>
 <CAGb2v64UabHPN79-zFzgxhsJwPF=fe_dM8jwnbxj_XR4LzsnwQ@mail.gmail.com>
 <20170630035533.GV29665@vireshk-i7>
 <CAGb2v67hxVciKFLD=8pgfm+UJ1i2Zb0aByTEa556O5uGcX7Oug@mail.gmail.com>
 <20170630041211.GX29665@vireshk-i7>
 <CAGb2v641UyXS5ccmo0j9Dvty8soB+DqwF2w8zKHsM78oK7b1aw@mail.gmail.com>
 <20170630051203.GY29665@vireshk-i7>
 <CAGb2v64CE2cUKgFuXd0f+FEdzQqmpOgMWqk76RndjeOz98=H0A@mail.gmail.com>
 <20170630084330.GB29665@vireshk-i7>
Message-ID: <20170630121026.azppihjqls5i6bbr@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 30, 2017 at 02:13:30PM +0530, Viresh Kumar wrote:
> On 30-06-17, 14:36, Chen-Yu Tsai wrote:

> Operable ranges of the regulator: 1.8 - 3.0 V
> Range required by LCD: 2.0 - 3.0 V
> Range required by DMA: 1.8 - 2.5 V

> Here DMA can't work with regulator voltages > 2.5 V, but regulator can
> go max to 3.0 V. Of course if the DMA driver has done
> regulator_set_voltage(), then we will be within 2.5 V range. But that
> doesn't force us to have regulator-max-microvolt set to 2.5 V.

> And so the DT node shall have this:

>         regulator-min-microvolt = <1800000>;
>         regulator-max-microvolt = <3000000>;

> Isn't it ?

If the DMA can't tolerate more than 2.5V then why would the constraints
allow the voltage to float that far?  Similarly on the low end?

Please remember that devices shouldn't be managing their voltages unless
they are actively changing them at runtime, simply setting them at
startup is the job of the constraints.  I would be very surprised to see
a DMA controller doing anything like DVFS.

> 
> > This might be unrelated, but I think it is a similar problem. When a
> > clk rate change is propagated up the clk tree, any affected sibling
> > clks aren't automatically readjusted, i.e. try to keep roughly the
> > same output clk rate by adjusting its own dividers. This might be
> > one side of the problem you are trying to solve.
> 
> I am not sure how this problem can be solved with what this set is
> proposing. :(
> 
> -- 
> viresh
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170630/a79eddbb/attachment.sig>
