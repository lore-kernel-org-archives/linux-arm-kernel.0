From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Apr 2015 19:00:00 +0100
Subject: [PATCH 2/6] ARM: keystone2: move update of the phys-to-virt
 constants into generic code
In-Reply-To: <552541B1.2000501@linaro.org>
References: <20150408094438.GM12732@n2100.arm.linux.org.uk>
 <E1YfmXq-0006Wr-M7@rmk-PC.arm.linux.org.uk>
 <552541B1.2000501@linaro.org>
Message-ID: <20150408175959.GO12732@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 08, 2015 at 05:56:49PM +0300, Grygorii.Strashko at linaro.org wrote:
> Hi Russell,
> 
> On 04/08/2015 12:45 PM, Russell King wrote:
> > Make the init_meminfo function return the offset to be applied to the
> > phys-to-virt translation constants.  This allows us to move the update
> > into generic code, along with the requirements for this update.
> 
> 
> I have a question (or may be proposition) regarding this patch.
> 
> Could it be reasonable if .init_meminfo() will return new PHYS offset
> of RAM (new start address), instead of translation's offset?

I'm not that interested in such a change, for the simple reason that
what we mostly want to know is what the _difference_ between what's
already in the page tables, and what we want to update them to.

The page table update is a case of merely adding the delta to each
page table entry.

If we were to want to pass the actual new physical address, we would
have to have the fixup code mask out the old address, and insert the
new address, keeping track of the offset into the kernel's mapping.
We'd also have to do something weirder for the DT mapping too.

Using an offset makes the page table update rather trivial and easy.

I actually did start off with passing the new physical address
initially, and I changed to this way because it simplified the
assembly code.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
