From: bp@alien8.de (Borislav Petkov)
Date: Wed, 4 Oct 2017 12:34:26 +0200
Subject: [PATCH v10 3/7] edac, soc: thunderx: Add wrapper for EDAC LMC PCI
 device
In-Reply-To: <20171002151756.GA11514@hc>
References: <20170925123502.17289-1-jglauber@cavium.com>
 <20170925123502.17289-4-jglauber@cavium.com>
 <20170927161901.4hto7mrc2s4yuugn@pd.tnic>
 <20171002151756.GA11514@hc>
Message-ID: <20171004103426.g6ivm6w7dfhcoluh@pd.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 02, 2017 at 05:17:56PM +0200, Jan Glauber wrote:
> I went for this as the simplest solution, the probing is completely
> synchronous and no state needs to be stored in the wrapper.

What state would you need to store? The wrapper simply gives out the
struct pci_dev * to the callers or NULL if not present.

> 1. What will trigger probing the edac (or perf) driver part?
>    Right now the trigger is the PCI device ID. If the wrapper
>    does not call into edac how should we load the ThunderX edac/perf drivers?
>    The only option I see is a initcall in edac/perf to look for their devices.

The wrapper loads on the PCI dev ID. EDAC loads later and calls the
wrapper function to get the struct pci_dev *. Simple.

> 2. The probe & register is _very_ specific to perf/edac and very different.
>    The only part that would fit in the wrapper is pci_enable_device().
>    So is that what you have in mind?

No, see above. Instead of getting the PCI device IDs from the PCI core,
you use the wrapper, which gets those from the PCI core. Thus it is
called a "wrapper". :)

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
