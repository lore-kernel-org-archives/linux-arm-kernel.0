From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Sep 2014 08:55:31 -0700
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <540D481F.8030500@collabora.co.uk>
References: <20140905115704.GO13515@arm.com> <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <CAD=FV=UYDDhL02CrhPUAHPncepwAF2-BgTmXOamy-Mdz80S-vw@mail.gmail.com>
 <540D481F.8030500@collabora.co.uk>
Message-ID: <CAD=FV=U_ZwgqBWN_bLfi97rjMLmDoQBk17gtQS1_ekxJKWJO6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Javier,

On Sun, Sep 7, 2014 at 11:09 PM, Javier Martinez Canillas
<javier.martinez@collabora.co.uk> wrote:
> Hello Doug,
>
> On 09/08/2014 06:36 AM, Doug Anderson wrote:
>>
>> One (ugly?) solution would be to add a feature to your bootloader to
>> modify the device tree to mark regulators as "always-on".  Since the
>> booloader gets to touch the device tree and the bootloader is involved
>> in communicating into about SimpleFB, it kinda makes sense.
>>
>
> I can't say I like to mark the regulators as always-on on the DT and that's
> why I copied the patch in the response instead of posting it as a proper patch
> but I think relying in the bootloaders to modify the DT is not better.
>
> IMHO U-boot should only modify the strictly necessary like the /chosen branch
> even though lately I've seen some attempts in the OMAP community to (ab)use
> U-Boot's fdt command to mangle the DT before passing to the kernel in order to
> support different Beagle Bone Black capes.

So "simple-framebuffer" is added to the device tree here:

https://chromium-review.googlesource.com/#/c/49358/2/board/samsung/smdk5250/smdk5250.c

That's one of the two patches to build your own U-Boot for enabling
simplefb.  You'll notice that's not a super official thing.  It's a
"DO NOT SUBMIT" patch sitting in a gerrit code review server, so I
wouldn't exactly call it a stable ABI that we can't break.  It's not
something shipping in real products and it's not even landed in a git
tree (I suppose maybe someone somewhere landed it, but...).

To me, that means that if someone is using that patch and it works for
them, then that's great!  If it stops working (possibly because it was
making assumptions about the state of the kernel) then it should be
fixed up.

In this case, that patch really should be adding references to
regulators (and possibly clocks) that are needed.  Given that this
patch is already reaching into the device tree to add the
"simple-framebuffer" node, it doesn't seem unreasonable to say that it
should be grabbing the proper references (or mark regulators as
always-on).


...as always, though, remember that my opinion doesn't count for much.
I also sympathize with the problems people are running into.  :(
