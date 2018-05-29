From: frowand.list@gmail.com (Frank Rowand)
Date: Tue, 29 May 2018 15:45:12 -0700
Subject: [RFC 12/13] ARM: dts: ti: add dra71-evm FIT description file
In-Reply-To: <20180529173314.GN17671@n2100.armlinux.org.uk>
References: <1523956215-28154-1-git-send-email-t-kristo@ti.com>
 <1523956215-28154-13-git-send-email-t-kristo@ti.com>
 <20180417092924.GB20335@flint.armlinux.org.uk>
 <ad5ef67d-d566-0034-a7cd-09a549cbd6d7@ti.com>
 <20180417144913.GD5669@atomide.com>
 <43ff3894-a287-1558-687c-40f50712735c@ti.com>
 <20180522200100.GA23937@rob-hp-laptop>
 <16a6017f-96c8-42d8-38bc-5cdd36d6793f@gmail.com>
 <20180529173314.GN17671@n2100.armlinux.org.uk>
Message-ID: <a43ce521-ed7f-6126-4ebf-5e0e303d00a3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/29/18 10:33, Russell King - ARM Linux wrote:
> On Tue, May 29, 2018 at 10:05:37AM -0700, Frank Rowand wrote:
>> On 05/22/18 13:01, Rob Herring wrote:
>>> I'll tell you up front, I'm not a fan of FIT image (nor uImage, 
>>> Android boot image, $bootloader image). If you want a collection of 
>>> files and some configuration data, use a filesystem and a text file.
> 
> Me neither.
> 
>> My gut feel is that using a filesystem and a text file is the easier way
>> to create the boot info.  But that also makes applying the overlay(s)
>> during early Linux boot (at the point of FDT unflattening) impractical
>> (can't access the file system without a driver, the driver depends on
>> the devicetree, the devicetree depends upon the overlay).
> 
> Why do you want to apply overlays during the kernel boot?  The boot
> loader should be providing the kernel with the merged DT to describe
> the system that the kernel is running on - it's not the kernel's
> job to put that together.

I would much prefer that overlays get applied before the unflattened
devicetree is made available to the kernel instead of applying overlays
late in the boot (after many susbsystems and drivers are initialized)
or after boot.

If overlays are applied before the unflattened devicetree is made
available to the kernel then subsystems and drivers do not have to be
aware of the possibility of the data in the devicetree changing instead
of being invariant.  (I will call this "apply early overlays" later in
this email.)

There are use cases of overlays where the overlay is not available until
late in the boot, or after the boot completes.  I am not suggesting that
those use cases be ignored.  That is a completely different conversation.

If overlays are applied before the unflattened devicetree is made
available to the kernel, there are at least two obvious methods
(and I can think of at least one more) -- either the kernel does it
or the bootloader does it.  I do not see either of the two as being
the obvious and only correct choice.  If the kernel does it, then
there is no need for multiple bootloaders to implement the same code.
If the bootloaders do it, then there is no need for multiple kernels
(Linux, BSD, etc) to implement the same code.  I do not have a
strong opinion about whether the bootloaders or the kernels are a
better place to apply early overlays.


> The whole point of DT is to make the kernel _less_ tied to the hardware
> and more generic.  If we're going to introduce an entirely new set of
> drivers into the kernel to "probe" the hardware to determine which
> overlays are required, then that's really defeating the purpose of DT.

If you read my circular dependency sentence carefully, I said a kernel
driver is impractical for the task of getting the overlay.  So I agree.

If the kernel applies the overlay, an alternative to drivers is that the
kernel could receive the overlay(s) in a similar manner as the method it
currently receives the base devicetree.  (The overlay(s) could be
appended to the base devicetree, a wrapper could be placed around the
base devicetree and the overlay(s), or some other implementation.  There
are multiple ways to achieve the same result.)
