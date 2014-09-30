From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 29 Sep 2014 22:02:04 -0700
Subject: [PATCH 1/4] ARM: DT: apq8064: add rpm support
In-Reply-To: <5429DA95.80505@codeaurora.org>
References: <1411982044-7873-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1411982092-7922-1-git-send-email-srinivas.kandagatla@linaro.org>
 <5429DA95.80505@codeaurora.org>
Message-ID: <20140930050203.GG28481@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 29 Sep 15:17 PDT 2014, Stephen Boyd wrote:

> On 09/29/14 02:14, Srinivas Kandagatla wrote:
> > @@ -246,6 +247,24 @@
> >  			#reset-cells = <1>;
> >  		};
> >  
> > +		apcs: syscon at 2011000 {
> > +			compatible = "syscon";
> > +			reg = <0x2011000 0x1000>;
> > +		};
> 
> This is actually a clock controller block that hw designers decided was
> good place to shove the ipc bits (because there's room!). Can we call it
> 
>                 l2cc: clock-controller at 2011000 {
>                         compatible = "syscon";
>                         reg = <0x2011000 0x1000>;
>                 };
> 
> Eventually I'll add the specific krait compatible when we merge krait
> clock support:
> 
>                 l2cc: clock-controller at 2011000 {
>                         compatible = "qcom,kpss-gcc", "syscon";
>                         reg = <0x2011000 0x1000>;
>                         clock-output-names = "acpu_l2_aux";
>                 };
> 

As long as we can get hold of the regmap that would be fine. I pressume the
idea is to have the kpss-gcc using syscon, just like the rpm. But hopefully the
syscon patches that are floating around (merged?) will allow any driver to
expose a "syscon regmap".

> > +
> > +		rpm at 108000 {
> > +			compatible	= "qcom,rpm-apq8064";
> > +			reg		= <0x108000 0x1000>;
> > +			qcom,ipc = <&apcs 0x8 2>;
> 
> There are actually 3 ipc bits. I guess if we ever have to use the other
> two we'll extend this binding to have the other bits specified some
> other way?

I haven't seen any indications of us using more than this bit. If we want to do
that, we could simply make it <&apcs 8 2 &apcs 8 3 &apcs 8 4> (or whatever
those indices are). That way this should be easy it keep compatible.

Regards,
Bjorn
