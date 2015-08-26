From: ezequiel@vanguardiasur.com.ar (Ezequiel Garcia)
Date: Wed, 26 Aug 2015 16:29:52 -0300
Subject: CONFIG_DEBUG_SHIRQ and PM
In-Reply-To: <20150825195830.GH27534@saruman.tx.rr.com>
References: <20150825195830.GH27534@saruman.tx.rr.com>
Message-ID: <CAAEAJfCY1BRuoQCWfD2pCq36E54vDB5Coy2S7rz3RfL2BVLGaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Felipe,

On 25 August 2015 at 16:58, Felipe Balbi <balbi@ti.com> wrote:
> Hi Ingo,
>
> I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when using
> devm_request_*irq().
>

I may be jumping on the gun here, but I believe here's your problem.
Using devm_request_irq with shared IRQs is not a good idea.

Or at least, it forces you to handle interrupts after your device
is _completely_ removed (e.g. your IRQ cookie could be bogus).

AFAICS, the CONFIG_DEBUG_SHIRQ option is just triggering a couple
spurious interrupts, that are expected to happen anyway.

Your IRQ is shared, and so you may get any IRQ at any time,
coming from another device (not yours).

So, if I'm right, my suggestion is simple: use request_irq/free_irq
and free your IRQ before you disable your clocks, remove your device, etc.

> If we using devm_request_*irq(), that irq will be freed after device
> drivers' ->remove() gets called. If on ->remove(), we're calling
> pm_runtime_put_sync(); pm_runtime_disable(), device's clocks might get
> gated and, because we do an extra call to the device's IRQ handler when
> CONFIG_DEBUG_SHIRQ=y, we might trigger an abort exception if, inside the
> IRQ handler, we try to read a register which is clocked by the device's
> clock.
>
> This is, of course, really old code which has been in tree for many,
> many years. I guess nobody has been running their tests in the setup
> mentioned above (CONFIG_DEBUG_SHIRQ=y, pm_runtime_put_sync() on
> ->remove(), a register read on IRQ handler, and a shared IRQ handler),
> so that's why we never caught this before.
>
> Disabling CONFIG_DEBUG_SHIRQ, of course, makes the problem go away, but
> if driver *must* be ready to receive, and handle, an IRQ even during
> module removal, I wonder what the IRQ handler should do. We can't, in
> most cases, call pm_runtime_put_sync() from IRQ handler.
>
> I'm guessing the only way would be to move pm_runtime calls into the bus
> driver (in this case, the platform_bus) and make sure it only gets
> called after device managed resources are freed ?
>
> Any hints would be greatly appreciated.
>

Hope it helps!
-- 
Ezequiel Garc?a, VanguardiaSur
www.vanguardiasur.com.ar
