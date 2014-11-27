From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Nov 2014 11:36:36 +0000
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <9101942.u99uxeQ3XX@wuerfel>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <5E6565C8-E868-4559-978A-681045F3582F@redhat.com>
 <9101942.u99uxeQ3XX@wuerfel>
Message-ID: <20141127113636.GE11511@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 09:05:57AM +0000, Arnd Bergmann wrote:
> On Thursday 27 November 2014 02:39:59 Jon Masters wrote:
> > We're looking at this at the moment (in addition to having the ACPI specification
> > clarified to indicate that there is no safe default assumption, requiring that
> > DMA masters always indicate their coherency or otherwise via a _CCA whether true
> > or false). 
> 
> I think for arm64, this should be easy: since ACPI is only for servers, we can
> rely on the fact that the devices have cache-coherent DMA all the time. Let's
> not over-complicate the ACPI case with all the special hacks we need for embedded.

As usual, we need hw vendors to say what they expect/build here.

I think in the past (non-ARM) the assumption was that the DMA is
coherent on ACPI-capable systems unless otherwise stated but I've seen
discussions (as Jon mentioned above) that ACPI should always indicate
the coherency on ARM without any assumption.

Either way, I don't think it's a problem for the kernel. We just need to
change the default DMA ops to coherent when booting with ACPI (using
non-coherent ops for a coherent device is not safe as the CPU can
corrupt cache lines written by the device).

-- 
Catalin
