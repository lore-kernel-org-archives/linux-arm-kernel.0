From: olof@lixom.net (Olof Johansson)
Date: Wed, 8 Aug 2012 13:17:27 -0700
Subject: Kernels on Bad Firmware (was Re: kernel entry for thumb2-only
 cpus)
In-Reply-To: <5022A6F9.2000206@wwwdotorg.org>
References: <CAKGA1b=8gZdgpSJ28Hff+1199J0GarLxZU-NAv7JJDuk+La0ew@mail.gmail.com>
 <5022A6F9.2000206@wwwdotorg.org>
Message-ID: <CAOesGMiEt9hGE=WzDrNg4vkcfu+Z6Q9V42tzKE2ENq3ifcOEfg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 8, 2012 at 10:50 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 08/08/2012 11:36 AM, Matt Sealey wrote:
> ...
>> The fact we could update it with a script was the awesome thing about
>> using OpenFirmware -
>> but U-Boot can do this too, since libfdt is there and it's one option
>> to enable it to allow script
>> based modification of the blob. If the DT is hardcoded into the firmware somehow
>> (CONFIG_OF_CONTROL I think) then platforms can load "boot.scr" from
>> the root filesystem ...
>
> Just a comment on CONFIG_OF_CONTROL...
>
> In U-Boot, CONFIG_OF_CONTROL determines whether U-Boot uses a device
> tree to configure itself. This is completely orthogonal to whether a
> device tree is passed to the kernel, and where the kernel DT comes from,
> which is still controlled by the bootm/bootz command parameters.
>
> The DT used to configure U-Boot isn't the same one passed to the kernel
> typically. The one for U-Boot is typically appended to the U-Boot image,
> whereas the one passed to the kernel is likely loaded from a file in
> /boot alongside the uImage/zImage of the kernel. I suppose the U-Boot
> script /could/ be written to encode the location of the appended DTB
> used by U-Boot and so pass the same one to the kernel, I don't believe
> anyone has done that. Besides, U-Boot's copy of the .dts files has
> diverged a little from the kernel's...:-(

Right, OF_CONTROL was instigated around here, and I explicitly have
kept them from attempting to do that. Why? Because the U-boot device
tree is non-standard, and has a bunch of u-boot cruft in it. We quite
frankly don't want to see it in the kernel.

But the bigger argument is that the device tree bindings are still
rapidly evolving together with the kernel, and until we reach a more
stable state, it's a bad idea to provide a tree that is separate from
the kernel (on ARM), since there will be no way to undo early
mistakes.

The plan is to, at some point in time, take the device tree bindings,
as well as the DTS sources, out of the kernel tree and to a separate
repo. But not until the bindings have settled down quite a bit more.


-Olof
