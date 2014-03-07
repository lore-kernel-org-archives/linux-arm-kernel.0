From: grant.likely@linaro.org (Grant Likely)
Date: Fri, 07 Mar 2014 20:09:03 +0800
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140306085213.GU643@mal.justgohome.co.uk>
References: <20140226183454.GA14639@cbox> <20140301152756.67A02C40238@trevor
 .secretlab.ca> <20140306085213.GU643@mal.justgohome.co.uk>
Message-ID: <20140307120903.6F0C9C40612@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 6 Mar 2014 08:52:13 +0000, Robie Basak <robie.basak@canonical.com> wrote:
> On Sat, Mar 01, 2014 at 03:27:56PM +0000, Grant Likely wrote:
> > I would also reference section 3.3 (Boot Option Variables Default Boot
> > Behavior) and 3.4.1.1 (Removable Media Boot Behavior) here. It's fine to
> > restate the meaning of the requirement in this spec, but the UEFI spec
> > is the authoritative source. Distributed VM disk images fall under the
> > same scenario as the firmware not having any valid boot variables.
> 
> What happens when the VM is first booted without boot variables, but
> then the OS expects to be able to set boot variables and see them on
> next boot?
> 
> AIUI, we don't have an implementation of this right now, and even if we
> did, there are implications for persistent storage of this data further
> up the stack (a required implementation in libvirt, OpenStack nova
> providing a storage area for it, etc).
> 
> If possible, I would prefer to mandate that the host implementation is
> permitted to no-op (or otherwise disable) boot variable write operations
> altogether to avoid having to deal with this. In the common case, I
> don't see why an OS installation shipped via a VM disk image would need
> to write boot variables anyway.

If a VM is booting from a distributed disk image, the boot variables
absolutely should start out empty. That's the only sane option.

It is appropriate to implement boot variable storage, but only because
it is needed if multiple OSes get installed. Those variables should not
get distributed with a disk image.

> Would there be any adverse consequences to doing this?

It would be a bad idea to inhibit variable storage. That would break
all kinds of boot and install scenarios.

> My reason is that this would save us from blocking a general OpenStack
> implementation on ARM by requiring that these pieces are implemented
> further up the stack first, when it would bring actual gain to doing so.
> 
> This would not preclude host implementations from implementing writeable
> variables, or guests from using them. Just that for a _portable VM disk
> image_, the OS on it cannot assume that this functionality is present.

Yeah, just to restate what I mean. If you're talking about bringing up a
portable disk image, the VM should start with an empty list of boot
variables.

g.
