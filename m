From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 28 Jun 2017 12:12:04 -0700
Subject: [PATCH] pinctrl: qcom: qdf2xxx: expose only some GPIO pins
In-Reply-To: <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
References: <1498164850-4738-1-git-send-email-timur@codeaurora.org>
 <CACRpkdZeDjS_g27=1e7uCmFpjnqX+sDSu5G2VAuwFr_GJW1mug@mail.gmail.com>
Message-ID: <20170628191204.GP18666@tuxbook>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri 23 Jun 05:33 PDT 2017, Linus Walleij wrote:

> On Thu, Jun 22, 2017 at 10:54 PM, Timur Tabi <timur@codeaurora.org> wrote:
> 
> > On Qualcomm Technologies QDF2xxx platforms, only a subset of the GPIOs
> > are actually available to the HLOS.  The others are blocked by the XPU,
> > and any attempt to access them will cause an XPU violation that halts
> > the system.
> 
> That's a bummer. Looking for Bj?rn's review on this patch.
> 

The TLMM block on this platform has N gpios, regardless of the XPU
configuration. The ACPI table provides the kernel with a list of
available "logical" GPIOs based on some system specification (or
reference design perhaps?).

I have not seen the Qualcomm server platforms, but I imagine that
customers can alter this list.


I think the numbering of the GPIOs should be that of the TLMM and the
"logical" names should be populated from ACPI by using gpio_chip->names.

The question left is how to represent the XPU locked gpios - a problem
we do share with in the mobile TLMM drivers.


It seems that if we extend the msm_pingroup with a flag to carry the XPU
lock information and then implement pinmux_ops->request() and deny any
requests on the locked pins, we should cover all[*] the normal GPIO code
paths.

[*] Except the reported case of gpiochip_add_data() looping over all
pins and calling get_direction() without first requesting the pin.

@Linus, do you see any flaws in this scheme?


PS. gpiochip_generic_request() ends up calling pinmux_ops->request()

Regards,
Bjorn
