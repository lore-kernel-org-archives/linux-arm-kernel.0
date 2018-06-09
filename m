From: christoffer.dall@arm.com (Christoffer Dall)
Date: Sat, 9 Jun 2018 13:20:47 +0200
Subject: [PATCH] KVM: arm/arm64: drop resource size check for GICV window
In-Reply-To: <1559C9EA-DE8B-4F96-8406-CCBEB0DFD093@linaro.org>
References: <20180601150628.10111-1-ard.biesheuvel@linaro.org>
 <20180609100657.GI5097@C02W217FHV2R.local>
 <1559C9EA-DE8B-4F96-8406-CCBEB0DFD093@linaro.org>
Message-ID: <20180609112047.GK5097@C02W217FHV2R.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jun 09, 2018 at 12:30:14PM +0200, Ard Biesheuvel wrote:
> 
> 
> > On 9 Jun 2018, at 12:06, Christoffer Dall <christoffer.dall@arm.com> wrote:
> > 
> >> On Fri, Jun 01, 2018 at 05:06:28PM +0200, Ard Biesheuvel wrote:
> >> When booting a 64 KB pages kernel on a ACPI GICv3 system that
> >> implements support for v2 emulation, the following warning is
> >> produced
> >> 
> >>  GICV size 0x2000 not a multiple of page size 0x10000
> >> 
> >> and support for v2 emulation is disabled, preventing GICv2 VMs
> >> from being able to run on such hosts.
> >> 
> >> The reason is that vgic_v3_probe() performs a sanity check on the
> >> size of the window (it should be a multiple of the page size),
> >> while the ACPI MADT parsing code hardcodes the size of the window
> >> to 8 KB. This makes sense, considering that ACPI does not bother
> >> to describe the size in the first place, under the assumption that
> >> platforms implementing ACPI will follow the architecture and not
> >> put anything else in the same 64 KB window.
> > 
> > Does the architecture actually say that anywhere?
> > 
> >> 
> >> So let's just drop the sanity check altogether, and assume that
> >> the window is at least 64 KB in size.
> > 
> > This could obviously be dangerous if broken systems actually exist.
> > Marc may know more about that than me.  An alternative would be to
> > modify the ACPI code to assume max(8 KB, page size) instead, and/or a
> > command line parameter to override this check.
> > 
> > That said, I'm not directly opposed to this patch, but I'll let Marc
> > have a look as well.
> > 
> 
> This approach was actually Marc?s idea, and he already applied the patch to the queue branch afaik.
> 

Hmmm, ok.
-Christoffer
