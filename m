From: ryan@presslab.us (Ryan Press)
Date: Sat, 30 Mar 2013 12:40:33 -0700
Subject: [PATCH] arm: mvebu: Fix the memory size on the Mirabox
In-Reply-To: <20130330192030.GR13280@titan.lakedaemon.net>
References: <1364579477-19018-1-git-send-email-ryan@presslab.us>
 <20130329180447.GK13280@titan.lakedaemon.net>
 <CABx3TkVK86b8Ku4EvUVe8OBtprwKW6YtJ7OU6YVHa3Bd5s7DsQ@mail.gmail.com>
 <20130329193716.GA7127@localhost>
 <20130329194453.GN13280@titan.lakedaemon.net>
 <CABx3TkWDrN1wCvECjja=EGeGFB-QpFmCG5FGO=1n+343fcCXcQ@mail.gmail.com>
 <20130330192030.GR13280@titan.lakedaemon.net>
Message-ID: <CABx3TkU9O9i2onVw3ntk4fZGaSct3i6GMmyL=H9j5e34Eyj-gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason,

Thanks for your thoughts!

On Sat, Mar 30, 2013 at 12:20 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> On Fri, Mar 29, 2013 at 08:30:35PM -0700, Ryan Press wrote:
>> On Fri, Mar 29, 2013 at 12:44 PM, Jason Cooper <jason@lakedaemon.net> wrote:
> ...
>> > In this case, the bootloader should be amending the dtb to provide the
>> > correct value for the particular board.  If your bootloader is
>> > devicetree-capable, it'll happen auto-magically.  Otherwise, you'll need
>> > to enable ARM_ATAG_DTB_COMPAT.
>
> To clarify, I meant to enable this in the kernel.  It'll then take the
> ATAGs passed from the bootloader (including RAM size), and modify the
> dtb accordingly.  No bootloader modification necessary.
>

Yep, I saw that option and I understand how it works.

>> The U-Boot that comes with the Mirabox is not capable of devicetree;
>> it is circa 2009 so it has some support for other CPUs but not ARM.
>
> ?

It has devicetree support for PPC, etc. but not for ARM.  In the ARM
specific boot functions there is no devicetree stuff.  And there were
some endian-ness bugs in the common devicetree code.  Obviously it
supports ARM in general.  :)

>> I didn't see any Armada support in mainline U-Boot.  I am working on
>> making the old U-Boot devicetree capable and I am close.  I see that
>> there is an fdt_memory_fixup function that adds the memory entries, so
>> I will be sure to implement that.  I think getting a devicetree
>> capable bootloader is the best way forward.
>
> See my comment above.  It's a lot less work ;-)

There really isn't streamlined support for appending a dtb to the
kernel zImage.  So that means every time I install a different kernel
I need to make a custom uImage.  With devicetree support in the kernel
I can just make a deb package and install it with less worry about
soft bricking it.

I have recently built and am testing a U-Boot that is working with
devicetree, including the memory fixup.  If anyone wants to try it on
their Mirabox, let me know.  So more work in the short term, but it
eliminates the 'DOH! moments when I forget to install the special
uImage and need to fart around in the bootloader.

Ryan
