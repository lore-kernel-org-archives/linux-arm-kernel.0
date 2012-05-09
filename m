From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 09 May 2012 23:34:23 +0200
Subject: [PATCH v2] ARM: DT: Add binding for GIC virtualization extentions
 (VGIC)
In-Reply-To: <201205092047.06852.arnd@arndb.de>
References: <1336586277-28454-1-git-send-email-marc.zyngier@arm.com>
 <201205092027.50059.arnd@arndb.de>
 <37e096905f891fc6abdccf8977bd7447@localhost>
 <201205092047.06852.arnd@arndb.de>
Message-ID: <ed0ce2390716adbfc949f86c16dab996@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 9 May 2012 20:47:06 +0000, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 09 May 2012, Marc Zyngier wrote:
>> Ah, I see what you mean. But these registers and interrupt are actually
>> only visible on the hypervizor side. The guest shouldn't see any of
this.
> 
> Rihgt, that makes sense.
> 
>> I suppose we could have a "arm,has-virt-extensions" property in devices
>> that implement the virtualization extensions (GIC, timers...).
>> 
>> What do you think?
> 
> Sounds good. I don't have a strong preference whether that should be a
> property like you suggest or a separate "compatible" value, maybe Rob or
> Grant can comment on what they prefer.

At the moment, the compatible string should be pretty explicit, as it is
not possible to build an A7 or A15 based SoC without the virtualization
extensions.

> On the guest side, is it guaranteed that the virtual GIC looks like
> a real GIC without those extensions? If the actual behavior depends on
> the hypervisor, it might still make sense to add another flag in there
> to tell that it's virtual, even if we don't require it for now.

Nothing is really guaranteed, as the VGIC only exposes a GIC CPU interface
to the guest, and the distributor has to be modeled by the hypervisor. But
if the difference is observable by the guest, is it still a GIC? And how to
differentiate between behavior A and behavior B with a single flag?

My take would be that if the guest can tell the difference, than it
shouldn't be called a GIC, and have separate bindings. Or at least a
different compatible string that we could use to enable quirks in the
driver.

        M.
-- 
Fast, cheap, reliable. Pick two.
