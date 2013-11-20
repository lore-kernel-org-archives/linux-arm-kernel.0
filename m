From: bgamari.foss@gmail.com (Ben Gamari)
Date: Wed, 20 Nov 2013 14:17:09 -0500
Subject: [BUG] PandaBoard hangs before starting init while booting v3.12
In-Reply-To: <20131120183548.GH10317@atomide.com>
References: <87hab9agjr.fsf@gmail.com>
 <CAKZq+rdQLrNE43aGaPtnDfaO6CHsq_ePLu+oRgWNs25OrdCtdw@mail.gmail.com>
 <87wqk3n54l.fsf@gmail.com> <20131120183548.GH10317@atomide.com>
Message-ID: <87r4aanaru.fsf@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Ben Gamari <bgamari.foss@gmail.com> [131119 19:07]:
>> Chao Xu <caesarxuchao@gmail.com> writes:
>> 
>> > Hi,
>> >
>> > I also try to boot v3.12 on my pandaboard rev A2, but it hangs at
>> > "starting kernel". My SD card is originally loaded with a linaro 12.04
>> > ubuntu-developer image. I have tried with v3.7 and v3.8 uImage and
>> > both of them work normally, but v3.12 hangs. Is there any trick I
>> > missed? Do I need to use the new u-boot as used by Ben?
>> >
>> I've written up some of my experiences bringing up 3.12 on the
>> PandaBoard here[1]. You may find it helpful. Regardless, I would
>> definitely try upgrading u-boot.
>
> Nice investigative blogging :)
>
Thanks!

> Care to also update it with the other issues remaining on pandaboard?
> 
Sure.

> Sounds like we're pretty close to having things working nicely with
> mainline kernel on it, so let's just fix those issues ASAP.
>
> I'm aware of at least two issues:
>
> 1.  The WLAN not working after a soft reset, or if the interface is
>     reset with ifconfig down. This could be a typo somewhere in the
>     .dts file for the WLAN regulator or something like that.
>
Yes, although frankly I've more or less given up on the wl12xx. This is
really a matter for linux-wireless@ but for some reason I find that it
is terribly unreliable. It stay associated without a problem but for
some reason I encounter extremely long (>2 seconds) dropouts where no
traffic can get in or out. Nothing is logged so I really have no idea
how to go about debugging this. Ultimately Ethernet is fine for my
purposes anyways.

> 2. Suspend and resume does not wake-up from serial console and spews
>    a bunch of warnings. The wake-up issue can be fixed with the new
>    the new interrupts-extended property to use the wake IRQs, I'll
>    try to update my patches for that today.
>  
Thankfully this is for a build-bot so this should be a problem for me.

I'll mention these in the write-up.

>> > And here is a separate problem with building u-boot. I cloned the
>> > upstream u-boot repository. The latest commit is
>> > c2e5e802ecb7ab668ce9911b210ed68c804b349f. Then I did:
>> > make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- omap4_panda_config
>> > make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- -j8
>> > cp MLO u-boot.img /media/boot/
>> > But when turn on my pandaboard, there is NO output from the serial
>> > console. I didn't change the other file in the boot partition. They
>> > are from linaro 12.04 ubuntu-developer image.
>> >
>> I would check that you have earlyprintk enabled (both in the kernel
>> configuration as well as on the kernel command line). Moreover, ensure
>> that the correct serial devices is selected for low-level debug output
>> (in the kernel configuration).
>
> I wonder if we also have some dependency to some earlier versions of
> u-boot as u-boot now only muxes the essential pins?
>
I haven't been very careful in characterizing the behavior of various
u-boot versions (although I've tried several) so I'm afraid I can't say.

Thanks again for your help.

Cheers,

- Ben
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 489 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131120/25d18364/attachment.sig>
