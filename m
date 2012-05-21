From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 21 May 2012 09:31:58 +0200
Subject: [RFC] pl08x: don't use dma_slave_config direction argument
In-Reply-To: <20120517170329.GB19548@n2100.arm.linux.org.uk>
References: <20120516110451.GA9571@n2100.arm.linux.org.uk>
 <20120517170329.GB19548@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYRX-ouR5wmLkZGPBWvLtkS=SCEJZ-OeQk48=WSPHY-0g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 7:03 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:

> I've just been testing this on the Versatile PB926 with my only working
> peripheral (PL011) and the runtime PM support which was added to the PL08x
> driver is totally breaking this setup.

Ouch! That was a nasty bug.

> So, the only solution I can see is to strip out all the runtime PM stuff
> from PL08x, which is buggy anyway.

I'd just kill it FTM, maybe the patch can simply be reverted?

What worries me is that this is such a straight-forward use of the runtime PM
API, the semantic difficulties with this API has caused me a lot of headache
recently. It just looks simple but isn't.

*_get_sync() should never be called in interrupt context, OK, but this is even
nastier, no calling under any spinlock ... how can we ever guarantee that?

Yours,
Linus Walleij
