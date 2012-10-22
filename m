From: tony@atomide.com (Tony Lindgren)
Date: Mon, 22 Oct 2012 10:09:18 -0700
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <CAN1soZzE_tTkmPBechvUcdAbWKSScwcaqe_cb0TTmnRJi9gtRg@mail.gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
 <20121019191333.GT4730@atomide.com>
 <CAN1soZzE_tTkmPBechvUcdAbWKSScwcaqe_cb0TTmnRJi9gtRg@mail.gmail.com>
Message-ID: <20121022170917.GB4730@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@gmail.com> [121022 03:11]:
> On Sat, Oct 20, 2012 at 3:13 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Haojian Zhuang <haojian.zhuang@gmail.com> [121018 02:08]:
> >> Add pinconf generic support with POWER SOURCE, BIAS PULL.
> > ...
> >
> >> +     case PIN_CONFIG_POWER_SOURCE:
> >> +             if (pcs->psmask == PCS_OFF_DISABLED
> >> +                     || pcs->psshift == PCS_OFF_DISABLED)
> >> +                     return -ENOTSUPP;
> >> +             data &= pcs->psmask;
> >> +             data = data >> pcs->psshift;
> >> +             *config = data;
> >> +             return 0;
> >> +             break;
> >
> > Hmm, only slightly related to this patch, mostly a generic
> > question to others: Do others have any mux registers with
> > status bits for things like PIN_CONFIG_POWER_SOURCE?
> >
> > I could use PIN_CONFIG_POWER_SOURCE for controlling the PBIAS
> > for omap MMC. But there's also a status bit that needs to be
> > checked for that. I think there was some other similar mux
> > register for USB PHY that has a status register.
> >
> > So I'm wondering should the checking for status bit be handled
> > in the pinctrl consume driver? Or should we have some bindings
> > for that?
> >
> 
> Do you mean that the status register only exists in USB PHY controller or
> MMC controller?

The status register is in the MMC PBIAS register that is mux
related otherwise. From OMAP4470_ES1.0_PUBLIC_TRM_vE.pdf,
Table 19-599. CONTROL_PBIASLITE:

Bits
26	MMC1_PWDNZ
25	MMC1_PBIASLITE_HIZ_MODE
24	MMC1_PBIASLITE_SUPPLY_HI_OUT
23	MMC1_PBIASLITE_VMODE_ERROR	then this bit needs to clear..
22	MMC1_PBIASLITE_PWRDNZ
21	MMC1_PBIASLITE_VMODE		..after VMODE bit is set to 3V
 
> If so, could we use regulator framework in USB PHY or MMC driver?

Yes we could use regulator framework for that that. Or just read the
status in the MMC driver for that bit if nobody else has mixed
mux-regulator needs like this.

The sequence is MMC specific, so from that point of view it would
make sense to have the logic in the MMC driver.

Regards,

Tony
