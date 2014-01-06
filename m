From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 6 Jan 2014 13:25:36 +0000
Subject: [RFC] drivers: irq-chip: Enable SGI's for Secure-to-NonSecure
 communication use-cases
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EDAD1B8@DBDE04.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A83EDAD1B8@DBDE04.ent.ti.com>
Message-ID: <20140106132536.GA27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 05:09:04AM +0000, Hiremath, Vaibhav wrote:
> The idea behind this RFC (or rather query) is, to get feedback or 
> comments on the use-case of using SGI for secure-to-nonsecure communication 
> on non-SMP architecture or SMP architecture with uniprocessor.
> I understand that, lot of things I need to take care from SMP architecture perspective. 
> Based on the feedback I can spend more time to make below changes more generic to handle 
> both uniprocessor and multi-processor architectures including more validation.

So it seems that your intention is to use the existing infrastructure
for this by directing SGIs through the normal IRQ processing.

To that idea, I say no way.

I also think you need to think more about the changes you're making in
your patch - several of them seem to have just been a case of s/32/0/
without any further thought whether that change is actually appropriate.
Really, I'd suggest reading the GIC documentation, especially the bits
about the first register being banked between each CPU.

So changing the setup in the distributor initialisation is only going to
hit the register on the CPU it's running on...

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
