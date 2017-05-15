From: robh+dt@kernel.org (Rob Herring)
Date: Mon, 15 May 2017 09:47:40 -0500
Subject: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
In-Reply-To: <20170515142641.GU22219@n2100.armlinux.org.uk>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk>
Message-ID: <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, May 15, 2017 at 08:01:07AM -0500, Rob Herring wrote:
>> I'd prefer not to mix things in scripts/dtc that aren't the import of
>> dtc (yes, we do have a few other things already, but they are at least
>> scripts). Couldn't this go in include/dt-bindings/ instead?
>
> I don't think that works.
>
> The include path used is "include", which means that we force people
> to use:
>
> #include <dt-bindings/foo.dtsi>

No, I was thinking you'd add include/dt-bindings/include-prefix/ to
the include path instead of scripts/dtc/include-prefix/. The only
downside I can see is people could mistakenly do:

#include <dt-bindings/include-prefix/$arch/foo.dtsi>

>
> in their DT files.  This means that we'd need to populate $topdir/include
> with per-architecture symlinks on top of the 26 or so directories already
> there, so that:
>
> #include <arch/foo.dtsi>
>
> would work.  That's quite horrible, since $topdir/include is the main
> include path for C headers.
>
> I guess we could have symlinks inside include/dt-bindings, but that
> makes the includes:
>
> #include <dt-bindings/arch/foo.dtsi>
>
> but that's rather absurd because these _aren't_ dt-binding definitions.

True, but the same can be said that "scripts/dtc" is not includes nor
kernel build infrastructure.

> Maybe what we should do is:
>
> mkdir include/dt
> git mv include/dt-bindings include/dt
> for arch in arch/*; do
>   dts=$arch/boot/dts
>   if [ -d $dts ]; then
>      a=include/dt/$(basename $arch)
>      ln -s $dts $a
>      git add $a
>   fi
> done
> ... fixup scripts/Makefile.lib ...
> git commit

That would just break every existing include in dts files.

Another idea. Could kbuild create all the symlinks at build time instead?

Rob
