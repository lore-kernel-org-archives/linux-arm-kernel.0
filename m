From: oliver+list@schinagl.nl (Oliver Schinagl)
Date: Thu, 23 May 2013 10:10:17 +0200
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <CACRpkdaWADjy1YZXTcRaXU+ZsS6_pG0hojQdnz=qeTgyVY7_Ww@mail.gmail.com>
References: <1368797744-13737-1-git-send-email-oliver+list@schinagl.nl>
 <1368797744-13737-2-git-send-email-oliver+list@schinagl.nl>
 <CACRpkdaWADjy1YZXTcRaXU+ZsS6_pG0hojQdnz=qeTgyVY7_Ww@mail.gmail.com>
Message-ID: <519DCEE9.6070208@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/23/13 09:56, Linus Walleij wrote:
> On Fri, May 17, 2013 at 3:35 PM, Oliver Schinagl
> <oliver+list@schinagl.nl> wrote:
>
> (...)
>> While initially these fuses are used to somewhat determin the chipID, these
>> appear to be writeable by the user and thus can be used for other purpouses.
>> For example storing a 128 bit root key, a unique serial number, which could
>> then even be used as a MAC address.
> (...)
> Then follows some code to read out the keys from sysfs I guess..
>> +static int __init sid_probe(struct platform_device *pdev)
>
> It's really simple to actually make the kernel use this to seed the
> entropy pool.
>
> #include <linux/random.h>
> add_device_randomness(u8 *, num);
>
> If you know after probe that you can read out a number of bytes
> of device-unique data, I think you should add those bytes to the
> entropy pool like this.
While that is a great idea, we can't guarantee device uniqueness. We've 
already seen some chips that where 'forgotten' to program and default 
set to all 0. I guess that doesn't have to be a bad thing.

Then, i'm not sure if the driver is the best for this to be loaded? 
Maxime, what do you think? Personally I would feel more in having this 
in the mach-sunxi/core.c bit, but then again, this is currently a module 
and wouldn't be useful to have there. Maxime is far more knowledgeable 
to answer that.

It should probably be noted, that the sunxi series have a hardware 
crypto engine, with hardware random seed generator, one for a later project.
>
> Yours,
> Linus Walleij
>
