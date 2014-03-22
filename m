From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 21 Mar 2014 19:29:50 -0700
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <20140307122418.2F2C4C408EC@trevor.secretlab.ca>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk>
 <531843EE.8040102@redhat.com> <53185FB9.1040308@redhat.com>
 <20140306120449.GA29916@mal.justgohome.co.uk>
 <20140307122418.2F2C4C408EC@trevor.secretlab.ca>
Message-ID: <20140322010206.GF25519@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 07, 2014 at 08:24:18PM +0800, Grant Likely wrote:
> On Thu, 6 Mar 2014 12:04:50 +0000, Robie Basak <robie.basak@canonical.com> wrote:
> > On Thu, Mar 06, 2014 at 12:44:57PM +0100, Laszlo Ersek wrote:
> > > If I understand correctly, the question is this:
> > > 
> > >   Given a hypervisor that doesn't support non-volatile UEFI variables
> > >   (including BootOrder and Boot####), is it possible to automatically
> > >   boot a carefully prepared VM image, made available as a fixed media
> > >   device?
> > > 
> > > The answer is "yes". See
> > 
> > Right, but I think there is a subsequent problem.
> > 
> > >   It is expected that this default boot will load an operating system or
> > >   a maintenance utility. If this is an operating system setup program it
> > >   is then responsible for setting the requisite environment variables
> > >   for subsequent boots. The platform firmware may also decide to recover
> >         ^^^^^^^^^^^^^^^^
> > >   or set to a known set of boot options.
> > 
> > It seems to me that the guest OS is permitted to assume that persistent
> > boot variables will work after first boot, for subsequent boots.
> > 
> > So, for example, the guest OS might, on bootloader or kernel upgrade,
> > completely replace the boot mechanism, dropping the removable path and
> > replacing it with a fixed disk arrangement, setting boot variables
> > appropriately, and assume that it can reboot and everything will
> > continue to work.
> > 
> > But if the host does not support non-volatile variables, then this will
> > break.
> 
> Correct
> 
> > This is why I'm suggesting that the specification mandate that the guest
> > OS shipped in a "portable disk image" as defined by the spec must not
> > make this assumption.
> 
> Also correct... the installer must be aware of this constraint which is
> why it is part of the draft spec.
> 
> > It's either this, or mandate that all hosts must support persistent
> > variables. I have no objection to that in principle, but since we have
> > no implementation currently, it seems easier to avoid this particular
> > roadblock by tweaking the spec in a way that nobody seems to care about
> > anyway.
> 
> Right. I guess my position is that if persistent storage is not
> implemented then there are a number of install/upgrade scenarios that
> won't work. Regardless, portable images must assume an empty boot list
> and we can build that into the spec.
> 

Sorry for the delay in responding - all sorts of unexpected things
happened when I returned from LCA14.

I agree on the technical discussion going on here.  My conclusion is
that we have two options:

1. Simply mandate that VM implementations support persistent variables
   for their UEFI implementation - with whatever constraints that may
   put on higher level tools.

2. Require that OSes shipped as part of compliant VM images make no
   assumption that changes to the UEFI environment will be stored.

I feel that option number two will break in all sorts of cases, just
like Grant stated above, and it is fundamentally not practical; if a
distribution ships Linux with a UEFI stub that expects to be able to do
something, distributions must modify Linux to conform to this spec.  I
think imagining that this spec controls how UEFI support in Linux/Grub
is done in general would be overreaching.  Additionally, Michael brought
up the fact that it would be non-UEFI compliant.

I know that door #1 may be a pain in terms of libvirt/openstack support
and other related tools, but it feels by far the cleanest and most
long-term solution and is in my oppinion what we shoud shoot for.  We
are early enough in the ARM server/VM game that we should be able to
make the right decisions at this point.

-Christoffer
