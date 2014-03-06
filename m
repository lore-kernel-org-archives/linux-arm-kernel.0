From: robie.basak@canonical.com (Robie Basak)
Date: Thu, 6 Mar 2014 12:04:50 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <53185FB9.1040308@redhat.com>
References: <20140226183454.GA14639@cbox>
 <20140301152756.67A02C40238@trevor.secretlab.ca>
 <20140306085213.GU643@mal.justgohome.co.uk>
 <531843EE.8040102@redhat.com> <53185FB9.1040308@redhat.com>
Message-ID: <20140306120449.GA29916@mal.justgohome.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 06, 2014 at 12:44:57PM +0100, Laszlo Ersek wrote:
> If I understand correctly, the question is this:
> 
>   Given a hypervisor that doesn't support non-volatile UEFI variables
>   (including BootOrder and Boot####), is it possible to automatically
>   boot a carefully prepared VM image, made available as a fixed media
>   device?
> 
> The answer is "yes". See

Right, but I think there is a subsequent problem.

>   It is expected that this default boot will load an operating system or
>   a maintenance utility. If this is an operating system setup program it
>   is then responsible for setting the requisite environment variables
>   for subsequent boots. The platform firmware may also decide to recover
        ^^^^^^^^^^^^^^^^
>   or set to a known set of boot options.

It seems to me that the guest OS is permitted to assume that persistent
boot variables will work after first boot, for subsequent boots.

So, for example, the guest OS might, on bootloader or kernel upgrade,
completely replace the boot mechanism, dropping the removable path and
replacing it with a fixed disk arrangement, setting boot variables
appropriately, and assume that it can reboot and everything will
continue to work.

But if the host does not support non-volatile variables, then this will
break.

This is why I'm suggesting that the specification mandate that the guest
OS shipped in a "portable disk image" as defined by the spec must not
make this assumption.

It's either this, or mandate that all hosts must support persistent
variables. I have no objection to that in principle, but since we have
no implementation currently, it seems easier to avoid this particular
roadblock by tweaking the spec in a way that nobody seems to care about
anyway.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140306/72149884/attachment-0001.sig>
