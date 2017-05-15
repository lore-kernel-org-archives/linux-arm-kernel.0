From: olof@lixom.net (Olof Johansson)
Date: Mon, 15 May 2017 10:04:08 -0700
Subject: [PATCH] devicetree: Move include prefixes from arch to separate
 directory
In-Reply-To: <20170515154845.GW22219@n2100.armlinux.org.uk>
References: <CAL_JsqKLxA8K8378z4nDBkDWnwM_zBbbf9D7EPtwQ1782dydTw@mail.gmail.com>
 <20170515142641.GU22219@n2100.armlinux.org.uk>
 <CAL_JsqJzoe_xNxMOZ88+k+bZ+bSK6-j30HXk0ZsFxHUqVDzwzw@mail.gmail.com>
 <CAOesGMgYDq5Sdk6OaK-mTyfdNGwcbgOVeKbeMSCOmwqd9k8TGQ@mail.gmail.com>
 <20170515154845.GW22219@n2100.armlinux.org.uk>
Message-ID: <CAOesGMjrjRTBTxN8_DGp6WUJk8hy5WnzCcxi+fUz446_Uk5JwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 15, 2017 at 8:48 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, May 15, 2017 at 08:27:54AM -0700, Olof Johansson wrote:
>> On Mon, May 15, 2017 at 7:47 AM, Rob Herring <robh+dt@kernel.org> wrote:
>> > On Mon, May 15, 2017 at 9:26 AM, Russell King - ARM Linux
>> > <linux@armlinux.org.uk> wrote:
>> >> Maybe what we should do is:
>> >>
>> >> mkdir include/dt
>> >> git mv include/dt-bindings include/dt
>> >> for arch in arch/*; do
>> >>   dts=$arch/boot/dts
>> >>   if [ -d $dts ]; then
>> >>      a=include/dt/$(basename $arch)
>> >>      ln -s $dts $a
>> >>      git add $a
>> >>   fi
>> >> done
>> >> ... fixup scripts/Makefile.lib ...
>> >> git commit
>> >
>> > That would just break every existing include in dts files.
>>
>> It doesn't break dts includes if done together with a change in -I,
>> but it might break includes from the driver side (or needs another -I
>> there).
>
> Good point.
>
> We could leave include/dt-bindings where it is, and just do the rest of
> it for the cross-arch includes.  Slightly less tidy but should have a
> lower impact.

I think you're proposing this?
include/dt-bindings
include/dt/$arch -> ../../arch/$arch/boot/dts/

And then having -I$(srctree)include/dt as argument to dtc?

That'd work but have the same drawback as I mentioned to Rob about
having several -I statements at different levels of the include
hierarchy, the same file could be reached through <dt/$arch/> and
<$arch/>. Not a showstopper but since Rob seems to be OK with the link
hierarchy living under scripts/dtc, I'd prefer to just stick to that.

This is all pretty isolated, and if we want to move it somewhere else
later for some reason, we should be able to do so without impacting
DTS and drivers.


-Olof
