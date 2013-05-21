From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Tue, 21 May 2013 14:16:58 +0000
Subject: Query on pinctrl usage for DT nodes
In-Reply-To: <20130423181753.GK10155@atomide.com>
References: <CA+V-a8uiPwsAD--OHFAE=i2ed+-wbXm4p2deZXr92+Zv6GDS1w@mail.gmail.com>
 <515C5C76.3080009@wwwdotorg.org>
 <CA+V-a8t3wtP77DdeUoQHKMjAuWmV+ude+1J3UjJmMTqobgStjA@mail.gmail.com>
 <5162FD4A.1030909@wwwdotorg.org>
 <CA+V-a8vwdCkyMqiynj5BodXbjwJ=e4qNb-29FhLweqbjc7DBQA@mail.gmail.com>
 <5165A22B.4070200@wwwdotorg.org> <20130410203408.GP10155@atomide.com>
 <516BB99F.2080502@ti.com> <20130416213232.GU10155@atomide.com>
 <51763B7B.707@ti.com> <20130423181753.GK10155@atomide.com>
Message-ID: <A73F36158E33644199EB82C5EC81C7BC3EA661EB@DBDE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Apr 23, 2013 at 23:47:54, Tony Lindgren wrote:
> * Peter Ujfalusi <peter.ujfalusi@ti.com> [130423 00:47]:
> > On 04/16/2013 11:32 PM, Tony Lindgren wrote:
> > > * Peter Ujfalusi <peter.ujfalusi@ti.com> [130415 01:30]:
> > >> On 04/10/2013 10:34 PM, Tony Lindgren wrote:
> > >>> Yeah how about just change the pintctrl-single,bits register
> > >>> naming to be register + bit?  Something like 0xdeadbeef.0 and
> > >>> 0xdeadbeef.1 and so on.
> > >>
> > >> Something like this might work I think. It is going to be a bit tricky IMHO
> > >> since we might need span out new 'register' every time a device requests for a
> > >> new pinctrl-single,bits for already used register in the
> > >> pinctrl-single,bit-per-mux area. In this way we still can make sure that
> > >> certain bit are only used by a single driver.
> > > 
> > > OK. If it's one bit per mux type register we should be able to create
> > > the right amount of entries based on the submask in pinctrs-single,bit?
> > 
> > Right now it seams to be true that we have one bit per mux (in DEVCONF0 on
> > OMAP3 for example). So that would work fine, but There could be different
> > registers around with more than one bit per mux.
> 
> Yes you are right, we should cover that case too. But maybe we
> can wait until we have such an example :)
>  
> > Another way to deal with this is to:
> > in case of pinctrl-single,bit-per-mux we assume one bit per mux and create
> > entries based on the pinctrl-single,function-mask's bits.
> > 
> > In case we have more than one bit for the mux in the register we could have
> > optional property stating the number of different muxes handled by the register.
> 
> Yes that's doable.
>  
> > One bit per mux type:
> > 
> > control_devconf0: pinmux at 48002274 {
> >         compatible = "pinctrl-single";
> >         reg = <0x48002274 4>;   /* Single register */
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >         pinctrl-single,bit-per-mux;
> >         pinctrl-single,register-width = <32>;
> >         pinctrl-single,function-mask = <0x5F>;
> > };
> > 
> > Results six entries.
> 
> Yup, I think this is the way to go for now, see below..
>  
> > control_devconf0: pinmux at 48002274 {
> >         compatible = "pinctrl-single";
> >         reg = <0x48002274 4>;   /* Single register */
> >         #address-cells = <1>;
> >         #size-cells = <0>;
> >         pinctrl-single,bit-per-mux;
> >         pinctrl-single,functions-in-register = <3>;
> >         pinctrl-single,register-width = <32>;
> >         pinctrl-single,function-mask = <0x5F>;
> > };
> > 
> > Will results three entries.
> 
> ..but let's not add this. The reason why I'd like to postpone adding
> pinctrl-single,functions-in-register is because we may be able to
> do it automatically.
> 

I have posted patch to take care of this:
http://davinci-linux-open-source.1494791.n2.nabble.com/PATCH-0-3-pinctrl-pinctrl-single-Add-full-fledge-support-to-configure-multiple-pins-of-different-mods-tt7583066.html

Please review this solution.

Thanks,
Prakash
