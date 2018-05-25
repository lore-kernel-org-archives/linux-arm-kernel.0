From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 25 May 2018 12:47:46 +0100
Subject: [PATCH v2 1/8] driver core: make deferring probe after init
 optional
In-Reply-To: <20180524181834.GF4828@sirena.org.uk>
References: <20180524175024.19874-1-robh@kernel.org>
 <20180524175024.19874-2-robh@kernel.org>
 <20180524181834.GF4828@sirena.org.uk>
Message-ID: <5c0831eb-dcdc-af27-fc4f-5c5018297287@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/05/18 19:18, Mark Brown wrote:
> On Thu, May 24, 2018 at 12:50:17PM -0500, Rob Herring wrote:
> 
>> Subsystems or drivers may opt-in to this behavior by calling
>> driver_deferred_probe_check_init_done() instead of just returning
>> -EPROBE_DEFER. They may use additional information from DT or kernel's
>> config to decide whether to continue to defer probe or not.
> 
> Should userspace have some involvement in this decision?  It knows if
> it's got any intention of loading modules for example.  Kernel config
> checks might be good enough, though it's going to be a pain to work out
> if the relevant driver is built as a module for example.

Arguably userspace has some control over that already, as in many cases 
it can just unbind and reprobe the consumer driver after loading the 
provider driver (in my silly IOMMU-drivers-as-modules PoC a while ago I 
was delighted to find that it can really be that simple). It's a bit 
harder when the device is the primary console or root filesystem, but I 
think that's effectively just another variant of the "defer until a 
module is loaded" chicken-and-egg problem.

Robin.
