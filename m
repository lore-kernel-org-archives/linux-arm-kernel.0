From: balbi@ti.com (Felipe Balbi)
Date: Tue, 25 Aug 2015 14:58:30 -0500
Subject: CONFIG_DEBUG_SHIRQ and PM
Message-ID: <20150825195830.GH27534@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ingo,

I'm facing an issue with CONFIG_DEBUG_SHIRQ and pm_runtime when using
devm_request_*irq().

If we using devm_request_*irq(), that irq will be freed after device
drivers' ->remove() gets called. If on ->remove(), we're calling
pm_runtime_put_sync(); pm_runtime_disable(), device's clocks might get
gated and, because we do an extra call to the device's IRQ handler when
CONFIG_DEBUG_SHIRQ=y, we might trigger an abort exception if, inside the
IRQ handler, we try to read a register which is clocked by the device's
clock.

This is, of course, really old code which has been in tree for many,
many years. I guess nobody has been running their tests in the setup
mentioned above (CONFIG_DEBUG_SHIRQ=y, pm_runtime_put_sync() on
->remove(), a register read on IRQ handler, and a shared IRQ handler),
so that's why we never caught this before.

Disabling CONFIG_DEBUG_SHIRQ, of course, makes the problem go away, but
if driver *must* be ready to receive, and handle, an IRQ even during
module removal, I wonder what the IRQ handler should do. We can't, in
most cases, call pm_runtime_put_sync() from IRQ handler.

I'm guessing the only way would be to move pm_runtime calls into the bus
driver (in this case, the platform_bus) and make sure it only gets
called after device managed resources are freed ?

Any hints would be greatly appreciated.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150825/091ce5a7/attachment.sig>
