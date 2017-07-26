From: bp@alien8.de (Borislav Petkov)
Date: Wed, 26 Jul 2017 16:55:22 +0200
Subject: [PATCH v8 1/3] perf: cavium: Support memory controller PMU
 counters
In-Reply-To: <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
References: <20170725150422.4775-1-jglauber@cavium.com>
 <20170725150422.4775-2-jglauber@cavium.com>
 <72145781-e9ec-036f-f752-b4756fef08ee@arm.com>
 <20170726111946.GA6273@hc>
 <faa339c4-b087-d970-1099-3d6cf8186545@arm.com>
 <20170726131058.GA8665@hc>
 <131179fe-42e7-f286-5bd4-801f4c93d5f9@arm.com>
Message-ID: <20170726145522.GC28875@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 26, 2017 at 03:35:25PM +0100, Suzuki K Poulose wrote:
> So the Cavium EDACs, which appear as PCI devices have a PMU attached to it.

Cavium EDACs?

So let me set something straight first: An EDAC driver simply talks to
some RAS IP block and reports errors. It shouldn't have anything to do
with a PMU.

> In order to build this PMU driver as a module, we need a way to load the module
> automatically based on the PCI id. However, since the EDAC driver already
> registers with that PCI id, we cannot use the same for the PMU. Ideally,

So this is strange. There's a single PCI ID but multiple functionalities
behind it?

> the PMU driver should be loaded when the EDAC driver is loaded. But looking
> at the links above, it looks like you don't like the idea of triggering a
> probe of the PMU component from the EDAC driver. We may be able to get rid
> of the PMU specific information from the EDAC driver by maintaining the PCI
> id of the device in the PMU driver. But we may still need to make sure that
> the PMU driver gets a chance to probe the PMU when the device is available.
> 
> What do you think is the best option here ?

Can either of the two - EDAC or PMU driver - use an alternate detection
method?

For example, we moved the main x86 EDAC drivers we moved to x86 CPU
family, model, stepping detection from PCI IDs because the PCI IDs were
clumsy to use.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
