From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Fri, 25 May 2018 11:35:38 -0700
Subject: [PATCH] arm64: dts: qcom: msm8996: Use UFS_GDSC for UFS
In-Reply-To: <CAFp+6iH5bS5rmqZ1oy09COb2Rzuz6zbN7pFwxz0WTJNOYTTbkg@mail.gmail.com>
References: <20180524223122.12601-1-bjorn.andersson@linaro.org>
 <CAFp+6iH5bS5rmqZ1oy09COb2Rzuz6zbN7pFwxz0WTJNOYTTbkg@mail.gmail.com>
Message-ID: <20180525183538.GH14924@minitux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 25 May 05:51 PDT 2018, Vivek Gautam wrote:

> Hi Bjorn,
> 
> On Fri, May 25, 2018 at 4:01 AM, Bjorn Andersson
> <bjorn.andersson@linaro.org> wrote:
> > The UFS host controller occationally (20%) fails to enable
> > gcc_ufs_axi_clk because the UFS GDSC is not enabled. In most cases it's
> > enabled through the UFS phy driver, but to make sure it's enabled let's
> > enable it directly from the UFS host controller directly as well.
> >
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/msm8996.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > index 380e14591686..03c7904bda14 100644
> > --- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
> > @@ -674,6 +674,8 @@
> >                         vccq-max-microamp = <450000>;
> >                         vccq2-max-microamp = <450000>;
> >
> > +                       power-domains = <&gcc UFS_GDSC>;
> > +
> 
> We shouldn't need power-domain with the phy. UFS_GDSC should
> be attached to the controller, as the phy is powered up only after
> the controller is power-up, and during collapse too, we turn off
> the phy first.

Afaict you're right, it should only be needed by the resources for the
HCD.

> Can you try testing keeping UFS_GDSC only with ufs controller and
> remove it from the ufs-phy node? We are doing same on the 4.14 release
> branch too for db820.

I test booted this 10 times, with 100% success :)

> I apologize to have missed this in your patch for ufs-related dt nodes.
> Can we please fix this now?

I'll send a v2, that moves the power-domain to the HCD, rather than just
adding it there too. Thanks for the quick review!

Regards,
Bjorn
