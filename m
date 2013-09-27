From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Fri, 27 Sep 2013 23:39:19 +0200
Subject: About atags_proc buffer size
In-Reply-To: <20130927204743.GK12758@n2100.arm.linux.org.uk>
References: <5245E9C9.9030509@gmail.com>
 <20130927204743.GK12758@n2100.arm.linux.org.uk>
Message-ID: <CAMuHMdXyj8z6BoME1kS=BdcW46-nLq8agtECE7gWA+vt8VNRig@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 10:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 27, 2013 at 10:25:45PM +0200, Vojtech Bocek wrote:
>> I want to ask something about atags_proc.c implementation. Currently,
>> it uses a buffer to temporarily store atags. The buffer size is set to
>> 1.5kb for some reason, but as far as I know, atag list's size is not
>> limited in any way. I've got a device (HTC One) which uses about 12kb
>> of tags, that means it panics during boot if CONFIG_ATAGS_PROC is
>> enabled, because the buffer contains only part of the tag list without
>> an end tag.
>
> The tags are supposed to be a short-lived structure which gets used to
> pass barest minimum of details to the kernel, and the data stored in
> them almost certainly gets overwritten before the kernels memory
> allocators are up and running.
>
> So, we need to statically allocate some space to save these things -
> it can't be done dynamically.
>
> The problem is this: for the vast majority of platforms, they pass no
> more than 1.5kB (lower case b is *bits* not *bytes*) to the kernel in
> their tagged list.  Having a static allocation of 12k would be wasteful
> for the majority of users.

It's __initdata memory, right?
So it would waste this 12 KiB only temporarily.
Stll, it enlarges the kernel image by 12 KiB, as there's no such thing
as __initbss.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
