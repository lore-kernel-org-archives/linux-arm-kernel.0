From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 30 Sep 2015 14:57:24 +0100
Subject: [PATCH 1/4] of: Add of_parse_phandle_with_opt_args() helper
 function
In-Reply-To: <CAL_JsqLWPfi9ynLbkzHkpcSHHg3ciwCcAN1uGcjXhnBAXZ74zw@mail.gmail.com>
References: <1442944336-11754-1-git-send-email-marc.zyngier@arm.com>
 <1442944336-11754-2-git-send-email-marc.zyngier@arm.com>
 <CAL_JsqLWPfi9ynLbkzHkpcSHHg3ciwCcAN1uGcjXhnBAXZ74zw@mail.gmail.com>
Message-ID: <20150930135723.GK10997@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 29, 2015 at 06:28:11PM +0100, Rob Herring wrote:
> On Tue, Sep 22, 2015 at 12:52 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > of_parse_phandle_with_args() is slightly inflexible as it doesn't
> > allow the (unusual) case where the #*-cells property is not defined.
> > In order to support this, introduce of_parse_phandle_with_opt_args()
> > which assumes that #*-cells is zero when it is not defined,
> 
> zero or cell_count - 1?
> 
> I would be okay with always assuming zero rather than being an error
> if that simplifies things. It is not really the kernel's job to be a
> dtb validator.

In most other cases #$foo-cells is strictly required, and you could get
bizarre behaviour in drivers by assuming 0. It would be good to keep a
warning for those.

That said, I guess drivers should be checking that the number of cells
is what they expect, so maybe any warnings should exist there.

> Also, I assume this was done for some compatibility?

Yup. There are existing users without #msi-cells (which is effectively
the same as #msi-cells = 0).

> In general, we should be explicit, so "#msi-cells = <0>" should be
> recommended and we should update dts files if they are not.

I agree, assuming we retain support for existing DTBs which lack
#msi-cells.

Mark.
