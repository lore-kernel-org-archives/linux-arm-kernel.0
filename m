From: jamesjj.liao@mediatek.com (James Liao)
Date: Fri, 3 Jul 2015 13:38:47 +0800
Subject: [PATCH v2 4/4] clk: mediatek: Add USB clock support in MT8173
 APMIXEDSYS
In-Reply-To: <CAGS+omBsu3zkBf0C_QECBP7NShFhkMih36z1vynvVQ5wCLfZ8w@mail.gmail.com>
References: <1435633127-31952-1-git-send-email-jamesjj.liao@mediatek.com>
 <1435633127-31952-5-git-send-email-jamesjj.liao@mediatek.com>
 <CAGS+omBRAJVN3uPYn9YdKZ3VBj61c-rpY_cNgnK6x9U0uJBPYw@mail.gmail.com>
 <CAGS+omBsu3zkBf0C_QECBP7NShFhkMih36z1vynvVQ5wCLfZ8w@mail.gmail.com>
Message-ID: <1435901927.3526.48.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Wed, 2015-07-01 at 23:22 +0800, Daniel Kurtz wrote:
> This looks like 3 separate gate clocks in a chain, with a timing
> constraint: USB_LPF must be enabled 100 us after USB_TX.
> 
>   26MHz--> [GATE] --USB_TX--> [LPF] --USB_LPF--> [GATE] --USB_OUT-->
>             ^                  ^                  ^
>             +--------------+   |                  |
> AP_PLL_CON2.REF2USB_TX_EN -+   |                  |
> AP_PLL_CON2.REF2USB_TX_LPF_EN -+                  |
> AP_PLL_CON2.REF2USB_TX_OUT_EN --------------------+
> 
> 
> I think we can model the gate parts using a proper clock tree model
> and the existing clock gate semantics.
> I'm not sure the best way to model the delay; but in theory that could
> be handled by the clock user (USB driver).

Do you mean to create 3 hierarchical clocks (may be clock gates) to
model these clocks as the following ?

EN -- LPF -- OUT_EN

(EN is the parent of LPF, and LPF is the parent of EN)

If we model these 3 clocks like above, we can't prevent clock users to
enable OUT_EN directly, and there will be no delay between EN and LPF.

Or you have other suggestions to model these 3 clcoks?


Best regards,

James
