From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 25 Nov 2016 12:45:29 +0000
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <20161125045549.GC2698@localhost>
References: <58356EA8.2010806@free.fr>
 <20161125045549.GC2698@localhost>
Message-ID: <20161125124528.GJ14217@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 10:25:49AM +0530, Vinod Koul wrote:
> Looking at thread and discussion now, first thinking would be to ensure
> the transaction is completed properly and then isr fired. You may need
> to talk to your HW designers to find a way for that. It is quite common
> that DMA controllers will fire and complete whereas the transaction is
> still in flight.
> 
> If that is not doable, then since you claim this is custom part which
> other vendors wont use (hope we are wrong down the line), then we can
> have a custom api,
> 
> foo_sbox_configure(bool enable, ...);
> 
> This can be invoked from NFC driver when required for configuration and
> teardown. For very specific cases where people need some specific
> configuration we do allow custom APIs.
> 
> Only problem with that would be it wont be a generic solution and you
> seem to be fine with that.

Isn't this just the same problem as PL08x or any other system which
has multiple requests from devices, but only a limited number of
hardware channels - so you have to route the request signals to the
appropriate hardware channels according to the requests queued up?

If so, no new "custom" APIs are required, it's already able to be
solved within the DMA engine drivers...

(We also have more complex situations already supported, such as
PL08x with a FPGA routing on three of its request signals.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
