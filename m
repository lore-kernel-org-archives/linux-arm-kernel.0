From: ddaney@caviumnetworks.com (David Daney)
Date: Tue, 14 Jul 2015 09:12:57 -0700
Subject: [PATCH] arm64: Define HAVE_ARCH_PIO_SIZE and related symbols.
In-Reply-To: <20150714110039.GC16213@arm.com>
References: <1436823096-24059-1-git-send-email-ddaney.cavm@gmail.com>
 <20150714110039.GC16213@arm.com>
Message-ID: <55A53509.4060202@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2015 04:00 AM, Will Deacon wrote:
> On Mon, Jul 13, 2015 at 10:31:36PM +0100, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Needed to make pci_iomap() work.
>
> Care to elaborate?
>

I should have explained what I am doing here a little better.

Systems based on the Cavium ThunderX processor may have up to 8 
independent PCIe root complexes.  The I/O space on each bus occupies an 
independent physical address window.

So, in order to be able to map all of these (semi) contiguously, we need 
a lot more virtual address space than is supplied by the default values 
for all these constants.

The option I chose here was to unconditionally expand the I/O ranges for 
all arm64 systems.  If you think this breaks existing systems/drivers, I 
will have to look for other options.

David Daney


> AFAICT, mapping an IO bar on arm64 just gives you back a VA into our
> PCI_IOBASE region and the ioreadX accessors will just call the readX
> macros, so there should be no need for further port adjustment.
>
> Will
>
