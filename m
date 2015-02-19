From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 19 Feb 2015 20:03:48 +0100
Subject: [PATCH] arm64: dts: Fix GIC reg sizes for APM X-Gene
In-Reply-To: <CAL_JsqJQcuX2cp50oHod-QAbhdMg48TaRP+gLGEO2kbFnQ3B+A@mail.gmail.com>
References: <1422342206-4750-1-git-send-email-psawargaonkar@apm.com>
 <CAL_JsqJQcuX2cp50oHod-QAbhdMg48TaRP+gLGEO2kbFnQ3B+A@mail.gmail.com>
Message-ID: <20150219190348.GB24460@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 19, 2015 at 12:23:15PM -0600, Rob Herring wrote:
> On Tue, Jan 27, 2015 at 1:03 AM, Pranavkumar Sawargaonkar
> <psawargaonkar@apm.com> wrote:
> > In APM X-Gene, GIC register space is 64K aligned while the sizes mentioned
> > in the dt are 4K aligned. This breaks KVM when kernel is built with 64K page
> > size due to size alignment checking in vgic driver for VCPU Control and
> > VCPU register.
> >
> > This patch corrects the sizes to be inline with the hardware spec.
> 
> This does not make sense. The GIC regions are still only 4 or 8KB and
> the h/w description should reflect that. For implementations using
> gic-400 and the addressing decode trick, the rest of the register
> range is also not safe to access given it is multiple mapped. Also,
> this wastes virtual space, but I guess we don't care on 64-bit.
> 
> KVM should be fixed to only check base address alignment. Size
> alignment does not matter (if it does, then you need to fix all
> register blocks).
> 
It matters if you want to ensure that the 64K page you are assigning to
a guest for the GIC virtual CPU interface contains only GIC virtual CPU
mappings, and not other random stuff that the guest is not allowed to
touch.

How else should this be enforced?

-Christoffer
