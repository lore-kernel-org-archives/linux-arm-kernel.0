From: dave.martin@linaro.org (Dave Martin)
Date: Wed, 8 Dec 2010 14:28:46 +0000
Subject: Linux kernel compilation failed with error: FPA is unsupported in
	the AAPCS
In-Reply-To: <AANLkTi=zWaZro08Q_8jSwpWfjdJsk7oRSV4bB7i_OYBD@mail.gmail.com>
References: <AANLkTikjG0DYxcG9Mo6jVKs2jKe7-uGL6eh2jGF10dpD@mail.gmail.com>
	<20101208133719.GC2716@pulham.picochip.com>
	<AANLkTi=zWaZro08Q_8jSwpWfjdJsk7oRSV4bB7i_OYBD@mail.gmail.com>
Message-ID: <AANLkTim9ZXMYQoXD5Uu-px_7446frquHBWLSJg3yGwSF@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 8, 2010 at 2:03 PM, Prasad Joshi <prasadjoshi124@gmail.com> wrote:

[...]

>
> Thanks a lot Jamie and Mikael. I can not follow what is EABI or OABI.
> But while configuring the linux kernel I enabled EABI. After disabling
> it, make is running smoothly.

EABI is the new ABI intended to be used with newer ARM processors, and
is applicable primarily for ARMv5 and later (though with some
limitations it also works with ARMv4T -- the Debian community
currently use this configuration for their "armel" architecture for
example).

OABI ("Old ABI") is the informal name for pre-existing ABI prior to
EABI, used with ARMv4 processors and earlier.  OABI isn't really an
official name for the old ABI, it's just a useful to have a name which
distinguishes it from the new ABI.

With regard to that, EABI compilers all have "eabi" in the GNU
architecture name, e.g.

$  arm-linux-gnueabi-gcc -dumpmachine
arm-linux-gnueabi

I believe the old ABI may get deprecated and eventually dropped from
new releases of GCC/binutils in the not-too-distant future.  Unless
you're using a really old platform (unlikely) you should stick with
EABI.

>
> I have one more (silly) question on same, my intention behind
> compiling the linux kernel is to boot RealView ARM under QEMU. Would
> disabling EABI would make kernel unbootable with QEMU?

If you are using full system emulation (I guess you are, if you're
running a kernel under QEMU) then either ABI should work, in general.

However, building an EABI kernel does imply a different system call
interface.  Therefore, EABI userspace (as used by pretty much all
modern distros for ARM) needs an EABI kernel.  For backwards
compatibility, you can use OABI userspace with an EABI kernel if you
turn on the CONFIG_OABI_COMPAT kernel option.

Cheers
---Dave
