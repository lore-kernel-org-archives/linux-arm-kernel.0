From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 2 Jun 2015 11:05:21 +0200
Subject: [PATCH 0/3] GPIO support for BRCMSTB
In-Reply-To: <CADtm3G4ao=3sHx2F1+V9rwS=jWf6ZdEQi4d24HxQ6MEc+CQ8CQ@mail.gmail.com>
References: <1430901477-10678-1-git-send-email-gregory.0xf0@gmail.com>
 <CACRpkda3EDa7YdzeT6FQ=cQw1RrDath7pQsCos-JeB2y4r18gw@mail.gmail.com>
 <CADtm3G45-u82Rp_0dHf2EfdMokf8E4FaQ84PHnocpvXxU+5_+g@mail.gmail.com>
 <CACRpkdaTYAr-7K5_QZh1CyeyA1224obqEB2Sz8UHZmrWcfv+ow@mail.gmail.com>
 <CADtm3G4ao=3sHx2F1+V9rwS=jWf6ZdEQi4d24HxQ6MEc+CQ8CQ@mail.gmail.com>
Message-ID: <CACRpkdY_-zq-1srBC213MK_RoVvPsfTpRTQyx-4yRvCOV5JdxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 27, 2015 at 5:26 AM, Gregory Fong <gregory.0xf0@gmail.com> wrote:

> I've now actually attempted to use the gpiolib irqchip code.  This
> driver can't directly use gpiochip_irqchip_add() because of the
> multiple gpiochip : one irqchip map.  At first, I thought it might be
> possible to simply add a new argument (or break things into a helper
> function) to allow setting the associated IRQ domain, but then I can't
> use the generic map and unmap functions which expect the irq_domain
> host_data member to be struct gpiochip *, which makes no sense in this
> case.  That puts me right back to implementing a special version of
> the map and unmap function.

I see.

I wonder if it is better to use one device per bank, and then set
IRQF_SHARED when you issue request_irq(), and have the
IRQ handler return IRQ_NONE if the IRQ comes from this
bank, or IRQ_HANDLED if it has handled an IRQ from its own
space.

This way multiple banks can share a single interrupt line.

Yours,
Linus Walleij
