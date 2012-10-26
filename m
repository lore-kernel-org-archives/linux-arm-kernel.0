From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 26 Oct 2012 09:47:25 +0800
Subject: [PATCH 08/10] pinctrl: single: support pinconf generic
In-Reply-To: <20121025234328.GF11928@atomide.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
 <1350551224-12857-8-git-send-email-haojian.zhuang@gmail.com>
 <20121019191333.GT4730@atomide.com>
 <CAN1soZzE_tTkmPBechvUcdAbWKSScwcaqe_cb0TTmnRJi9gtRg@mail.gmail.com>
 <20121022170917.GB4730@atomide.com>
 <20121025234328.GF11928@atomide.com>
Message-ID: <CAN1soZyosQJYZAT61tUig6PGVrfXzwDeiC1R0hnKWoFLVP4Ayw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 26, 2012 at 7:43 AM, Tony Lindgren <tony@atomide.com> wrote:
> * Tony Lindgren <tony@atomide.com> [121022 10:11]:
>> * Haojian Zhuang <haojian.zhuang@gmail.com> [121022 03:11]:
>> > On Sat, Oct 20, 2012 at 3:13 AM, Tony Lindgren <tony@atomide.com> wrote:
>> > > * Haojian Zhuang <haojian.zhuang@gmail.com> [121018 02:08]:
>> > >> Add pinconf generic support with POWER SOURCE, BIAS PULL.
>> > > ...
>> > >
>> > >> +     case PIN_CONFIG_POWER_SOURCE:
>> > >> +             if (pcs->psmask == PCS_OFF_DISABLED
>> > >> +                     || pcs->psshift == PCS_OFF_DISABLED)
>> > >> +                     return -ENOTSUPP;
>> > >> +             data &= pcs->psmask;
>> > >> +             data = data >> pcs->psshift;
>> > >> +             *config = data;
>> > >> +             return 0;
>> > >> +             break;
>> > >
>> > > Hmm, only slightly related to this patch, mostly a generic
>> > > question to others: Do others have any mux registers with
>> > > status bits for things like PIN_CONFIG_POWER_SOURCE?
>> > >
>> > > I could use PIN_CONFIG_POWER_SOURCE for controlling the PBIAS
>> > > for omap MMC. But there's also a status bit that needs to be
>> > > checked for that. I think there was some other similar mux
>> > > register for USB PHY that has a status register.
>> > >
>> > > So I'm wondering should the checking for status bit be handled
>> > > in the pinctrl consume driver? Or should we have some bindings
>> > > for that?
>> > >
>> >
>> > Do you mean that the status register only exists in USB PHY controller or
>> > MMC controller?
>>
>> The status register is in the MMC PBIAS register that is mux
>> related otherwise. From OMAP4470_ES1.0_PUBLIC_TRM_vE.pdf,
>> Table 19-599. CONTROL_PBIASLITE:
>>
>> Bits
>> 26    MMC1_PWDNZ
>> 25    MMC1_PBIASLITE_HIZ_MODE
>> 24    MMC1_PBIASLITE_SUPPLY_HI_OUT
>> 23    MMC1_PBIASLITE_VMODE_ERROR      then this bit needs to clear..
>> 22    MMC1_PBIASLITE_PWRDNZ
>> 21    MMC1_PBIASLITE_VMODE            ..after VMODE bit is set to 3V
>>
>> > If so, could we use regulator framework in USB PHY or MMC driver?
>>
>> Yes we could use regulator framework for that that. Or just read the
>> status in the MMC driver for that bit if nobody else has mixed
>> mux-regulator needs like this.
>>
>> The sequence is MMC specific, so from that point of view it would
>> make sense to have the logic in the MMC driver.
>
> Well it turns out the VMODE_ERROR bit is not just for VMODE, it's a
> comparator that can also triggers for the other invalid states for
> CONTROL_PBIASLITE pinconf register. So hiding VMODE_ERROR into a
> regulator would be wrong. For now, VMODE best handled using
> PIN_CONFIG_POWER_SOURCE and let the MMC driver do the checking
> using the pinconf API.
>
> Regards,
>
> Tony

Could you share the link of downloading the spec?

Regards
Haojian
