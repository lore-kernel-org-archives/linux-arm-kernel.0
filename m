From: djkurtz@chromium.org (Daniel Kurtz)
Date: Fri, 3 Jul 2015 14:28:17 +0800
Subject: [PATCH v2 4/4] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <1435901927.3526.48.camel@mtksdaap41>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-5-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omBRAJVN3uPYn9YdKZ3VBj61c-rpY_cNgnK6x9U0uJBPYw@mail.gmail.com>
 <CAGS+omBsu3zkBf0C_QECBP7NShFhkMih36z1vynvVQ5wCLfZ8w@mail.gmail.com>
 <1435901927.3526.48.camel@mtksdaap41>
Message-ID: <CAGS+omCaQp8k41rRQeamsAg9Zn1w5jM_7x5XiQfdM==4D7bQDg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 3, 2015 at 1:38 PM, James Liao <jamesjj.liao@mediatek.com> wrote:
> Hi Daniel,
>
> On Wed, 2015-07-01 at 23:22 +0800, Daniel Kurtz wrote:
>> This looks like 3 separate gate clocks in a chain, with a timing
>> constraint: USB_LPF must be enabled 100 us after USB_TX.
>>
>>   26MHz--> [GATE] --USB_TX--> [LPF] --USB_LPF--> [GATE] --USB_OUT-->
>>             ^                  ^                  ^
>>             +--------------+   |                  |
>> AP_PLL_CON2.REF2USB_TX_EN -+   |                  |
>> AP_PLL_CON2.REF2USB_TX_LPF_EN -+                  |
>> AP_PLL_CON2.REF2USB_TX_OUT_EN --------------------+
>>
>>
>> I think we can model the gate parts using a proper clock tree model
>> and the existing clock gate semantics.
>> I'm not sure the best way to model the delay; but in theory that could
>> be handled by the clock user (USB driver).
>
> Do you mean to create 3 hierarchical clocks (may be clock gates) to
> model these clocks as the following ?
>
> EN -- LPF -- OUT_EN
>
> (EN is the parent of LPF, and LPF is the parent of EN)
>
> If we model these 3 clocks like above, we can't prevent clock users to
> enable OUT_EN directly, and there will be no delay between EN and LPF.
>
> Or you have other suggestions to model these 3 clcoks?

I don't really know.
I was hoping someone would know of a way to add a "delay" when
enabling a clock gate. :-)
Why do we need the delay anyway?
Is the delay really between LPF and OUT_EN?
Or, is the delay between enabling OUT_EN and when the USB block can
use the clock?

Some ideas:
(1) Handled the LPF delay in the USB driver itself:
  (a) if the delay is really between OUT_EN and when it is used:
  /* Enabling USB_OUT will enable its parents, USB_LPF and USB_TX */
  clk_enable(clk_usb_out);
  udelay();

  (b) Or if the delay is really needed between LPF and OUT, this can
be implemented in the USB driver:

  /* Enable LPF and its parent USB_TX */
  clk_enable(clk_lpf);
  udelay();
  clk_enable(clk_usb_out);

 (2) Add a "delay" property to "struct mtk_clk_gate", with a non-zero
value for just this one special LPF clock.  The downside is then every
gate clock would have to carry this extra field.

 (3) Add a new clk type, struct mtk_clk_delayed_gate, that includes a
struct mtk_clk_gate, plus a delay.  I would add this to its own file,
or maybe clk-gate.c, though, rather than mediatek/clk-mt8173.c.  And
then use this for instantiating the LPF clock.

-Dan



> Best regards,
>
> James
>
