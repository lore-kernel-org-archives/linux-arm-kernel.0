From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 30 Oct 2017 16:59:07 +0000
Subject: [PATCH] ARM: add a private asm/unaligned.h
In-Reply-To: <CAKv+Gu-wOaxV+O5hkDxfvOY7gy5KwnCvvsd6XGTwfnro=dVbcw@mail.gmail.com>
References: <87wp3g39es.fsf@free-electrons.com>
 <20171027152743.GJ20805@n2100.armlinux.org.uk>
 <87k1zc3fxp.fsf@free-electrons.com>
 <CAKv+Gu95RR3SBb1dydKVVeQQ5+Ui56TcWLfNh=rfmw8_Ty=F7g@mail.gmail.com>
 <87a8083cc2.fsf@free-electrons.com>
 <CAKv+Gu9=xLfyM7ZkK4vNmMkhL2fJnvZmOv-dNNzesk9myadCCA@mail.gmail.com>
 <8760aw3c5p.fsf@free-electrons.com>
 <CAKv+Gu-9pQjBb0YXADRT87qpFb6ttT3tLGBnGNgZj3B1VDRN6Q@mail.gmail.com>
 <871slk3b2k.fsf@free-electrons.com>
 <CAKv+Gu-wOaxV+O5hkDxfvOY7gy5KwnCvvsd6XGTwfnro=dVbcw@mail.gmail.com>
Message-ID: <20171030165907.GB27404@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 30, 2017 at 03:35:38PM +0000, Ard Biesheuvel wrote:
> Well, that is disappointing. This means the ASSERT() does not work
> reliably, and we're back to using a bunch of shell scripts to check
> whether _edata appears at the end of the image.

That didn't work too well here.  While it did correctly detect some
instances:

zImage size (8008200) disagrees with linked size (8008192)

it also misdetected others:

zImage size (13348808) disagrees with linked size (-928003328)

It seems to suggest that _magic_end - _magic_start = 0xc8afcb00.
zImage size is 0xcbafc8.  That points at the addresses output by
"nm" being dependent on the endian-ness of the image, which to
me seems utterly insane.

I wouldn't be surprised if that is toolchain version dependent
as well.

IMHO, our toolchain is a mess!

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
