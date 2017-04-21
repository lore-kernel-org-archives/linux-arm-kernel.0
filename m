From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Apr 2017 18:17:54 +0200
Subject: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
In-Reply-To: <20170421145901.3wcft3ou7wwywuiu@sirena.org.uk>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com>
 <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
 <20170421145901.3wcft3ou7wwywuiu@sirena.org.uk>
Message-ID: <CAK8P3a0j_cnd9j2UuFD5eRVN8q-=dPh2-LBaibb8qdpDQbHpJA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 21, 2017 at 4:59 PM, Mark Brown <broonie@kernel.org> wrote:
> On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
>> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
>> > stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)
>
>> > 2 arch/mips/mm/fault.c:321:1: error: the frame size of 1104 bytes is larger
>> > than 1024 bytes [-Werror=frame-larger-than=]
>
>> This is a result of a newer compiler version, combined with the -Werror
>> flag that is applied to arch/mips/, and two of the mips defconfigs overriding
>> CONFIG_FRAME_WARN to 1024 on a 64-bit architecture (probably by
>> accident).
>
> I'm wondering how good an idea it is to leave -Werror on in stable
> kernels given that they're very likely to get used with newer compilers
> at some point.  But then I've never been a fan of -Werror in the first
> place.

I agree it's problematic as you never know what future compilers will warn
about. At the moment, alpha, mips, sh and sparc turn on -Werror
unconditionally for architecture specific code and there are only five
device drivers do this as well. The powerpc architecture and the i915
driver have a Kconfig option to control whether the warnings are enabled,
and they are turned off in allmodconfig.

I think this is just an artifact from the old days when we always had tons of
warnings in a given build, but we should try to replace it with something
better instead of just removing it (which would be easy enough to do).

I personally build with 'make CC="gcc -Werror" and fix all the warnings I
run into. I have some plans to improve it by hooking into the
scripts/Makefile.extrawarn infrastructure. Today, we can use "make W=1"
or "make W=12" to turn on extra levels of warnings, and I'd like to
add "make E=0" or "make E=012" as a way to turn on errors for
the default (0) or higher (1, 2, 3) levels, but this takes a little more
preparation.

    Arnd
