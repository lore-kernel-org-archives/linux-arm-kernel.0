From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Jun 2013 12:29:14 -0600
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <20130606180824.GC3320@localhost.localdomain>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <51B0BC80.9040007@wwwdotorg.org>
 <20130606180824.GC3320@localhost.localdomain>
Message-ID: <51B0D4FA.5070500@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/06/2013 12:08 PM, Dave Martin wrote:
> On Thu, Jun 06, 2013 at 10:44:48AM -0600, Stephen Warren wrote:
>> On 06/06/2013 01:28 AM, Alexandre Courbot wrote:
>>> Boot loaders on some Tegra devices can be unlocked but do not let the
>>> system operate without SecureOS. SecureOS prevents access to some
>>> registers and requires the operating system to perform certain
>>> operations through Secure Monitor Calls instead of directly accessing
>>> the hardware.
>>>
>>> This patch introduces basic SecureOS support for Tegra. SecureOS support
>>> can be enabled by adding a "nvidia,secure-os" property to the "chosen"
>>> node of the device tree.
...
> So, something like
> 
> 	foo-firmware {
> 		compatible = "vendor1,foo-firmware-1.0", "vendor1,foo-firmware";
> 		method = "smc";
> 
> 		// ...
> 	};
> 
> 	bar-firmware {
> 		compatible = "vendor2,bar-firmware-1.6", "vendor2,bar-firmware";
> 		method = "smc";
> 
> 		// ...
> 	};
> 
> Could make sense.

I'm not sure if the method property is useful in most cases. For generic
ABIs such as PSCI that actually support multiple communication paths,
yes, it makes sense. However, it seems like for most custom ABIs, such
as is presumably implemented by whatever "SecureOS" is on Tegra, the
firmware type (or compatible value) directly implies that it operates
over SMC not HVC. After all, presumably if the kernel was virtualized,
it wouldn't have access to the raw secure monitor? I suppose you could
argue that the hypervisor might end up emulating the same ABI over HVC
instead? I'm not sure how likely that is. A compromise might be to
assume SMC if no property was present, which would allow it to be
optionally added later if it turned out to be useful.

> ...where we would require all new firmware interface bindings to
> include the "-firmware" in their node names and compatible strings
> (with a version suffix encouraged for the compatible strings, where
> relevant).

That's probably a good convention, but I'm not sure it should be
required (or at least validated by code). Requiring this by code review
might be OK. Node names aren't meant to be interpreted semantically.
