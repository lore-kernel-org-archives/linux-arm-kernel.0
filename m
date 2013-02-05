From: tony@atomide.com (Tony Lindgren)
Date: Tue, 5 Feb 2013 15:21:10 -0800
Subject: [PATCH v8 12/12] document: devicetree: bind pinconf with pin
 single
In-Reply-To: <CAN1soZytx7w8a1C=-C7924_MW6FPH5b=gsvSH=BpDU4ZhJia4w@mail.gmail.com>
References: <1359825953-15663-1-git-send-email-haojian.zhuang@linaro.org>
 <1359825953-15663-13-git-send-email-haojian.zhuang@linaro.org>
 <20130205040721.GE25185@atomide.com>
 <CAN1soZytx7w8a1C=-C7924_MW6FPH5b=gsvSH=BpDU4ZhJia4w@mail.gmail.com>
Message-ID: <20130205232109.GP25185@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [130205 00:09]:
> On Tue, Feb 5, 2013 at 12:07 PM, Tony Lindgren <tony@atomide.com> wrote:
> 
> > For the cases where there's a value to be set I'm still wondering how does
> > a client driver change the value if that needs to be changed dynamically?
> > Can the value be passed as value + PIN_CONFIG_END?
> >
> pinconf_to_config_packed() can help to bind param & argument into config
> variable.

OK good to hear you've looked into that.
...
 
> And I think that we need four parameters with your format.
>       <user setting on bias enable/disable, expected enable value,
> expected disable value, mask */
> Otherwise, how could we know user's setting? Especially, we need to
> configure pullup.
> In your case, expected pullup enable & expected pullup disable are set
> in bias-pullup property.
> >                 /* enable value, disable value, mask */
> >                 pinctrl-single,bias-pullup = <0 1 1>;
> 
> Actually, I'm OK to use enable value. And it needs 4 parameters since
> disable value may not be zero.

OK. Four values makes sense to me so we can configure the default
pinconf value like we already do for pinmux.
 
> By the way, bias property would be the format in below with 4 parameters.
> * Without bias enable/disable bit.
>           bias-enable = <0, 0, 0, set of both pullup and pulldown mask>;
> 
> * With bias enable/disable bit.
>           bias-enable = <user setting, expected enable, expected
> disable, mask of only enable/disable bit>;
> 
> Behavior of pinconf_clear():
>      - call bias-disable
>      - call the expected bias setting.

Hmm I was thinking pinconf_clear() would get passed the same parameters
as pinconf_set() except it just does the opposite. But maybe I'm not
following you here.
 
> DISABLE --> PULLUP, user call config BIAS_PULLUP without additional argument.
> PULLUP --> PULLDOWN, user call with config BIAS_PULLDOWN without
> additional argument.
> PULLUP --> DISABLE, user call with config BIAS_ENABLE and 0 for argument.
> 
> The switch from PULLUP to DISABLE is a little strange since we have to
> call BIAS_ENABLE.
> Is it good for you?

I'm not sure I follow your example here, but sounds like the PULLUP to
DISABLE case can be maybe handled by covering both bits in the mask?
 
> > Then regarding pinconf_set(), don't we also need pinconf_clear() in
> > addition to pinconf_set()?
> >
> > Otherwise we need both ENABLE and DISABLE enumeration, which seems
> > unnecessary to me. So rather than have both PIN_CONFIG_BIAS_ENABLE and
> > PIN_CONFIG_BIAS_DISABLE, we just need PIN_CONFIG_BIAS_ENABLE.
> I can append pinconf_clear() to handle it.
 
OK great, I guess then we should have everything in place to make it
usable from client drivers also.

Regards,

Tony
