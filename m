From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2018 18:07:01 +0100
Subject: [PATCH 1/7] ARM: disallow combining XIP and LTO
In-Reply-To: <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
References: <20180220215954.4092811-1-arnd@arndb.de>
 <20180220215954.4092811-2-arnd@arndb.de>
 <nycvar.YSQ.7.76.1803112233070.28583@knanqh.ubzr>
 <CAK8P3a06_zke6Zy77TCX6aUS1C0aK2btvnLA7APxRykkxS6S_w@mail.gmail.com>
 <CAK8P3a128iw+HB5Fp6ZOBCyuK0LypqSXqnkNPQs8sWR1pc8x3g@mail.gmail.com>
 <nycvar.YSQ.7.76.1803121250360.28583@knanqh.ubzr>
Message-ID: <CAK8P3a05G_B+F=O1SWzmaXR27yPGRKGa=L6dctTiD2PmRHYhBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 12, 2018 at 6:00 PM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 12 Mar 2018, Arnd Bergmann wrote:
>
>> On Mon, Mar 12, 2018 at 2:52 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Mon, Mar 12, 2018 at 3:40 AM, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
>> >> On Tue, 20 Feb 2018, Arnd Bergmann wrote:
>> >
>> >>> Obviously we want to make the combination work, no idea why it doesn't.
>> >>
>> >> Well, it does work regardless of the noise. Here the nm output is piped
>> >> into sed, and the later exits early when it finds what it is looking
>> >> for, causing nm to complain about the broken pipe.
>> >>
>> >> Here's a patch silencing this bogus error message and fixing other minor
>> >> issues.
>> >>
>> >> ----- >8
>> >> Subject: [PATCH] ARM: deflate_xip_data.sh: minor fixes
>> >>
>> >> Send nm complaints about broken pipe (when sed exits early) to /dev/null.
>> >> All errors should be printed to stderr.
>> >> Don't trap on normal exit so the trap can return an error code.
>> >>
>> >> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>> >
>> > Ah, that explains it, thanks!
>> >
>> > Tested-by: Arnd Bergmann <arnd@arndb.de>
>>
>>
>> Nevermind, I confused it with a different problem that I'm running into
>> with randconfig builds:
>
> At least you no longer get the "broken pipe" warning as your initial
> report showed, right?

I don't know, my recent tests are all without the LTO patch series,
so I don't get that one anyway.

>> arm-linux-gnueabi-nm: 'arch/arm/boot/compressed/../../../../vmlinux':
>> No such file
>
> That is weird. The Makefile has:
>
> cmd_mkxip = $(cmd_objcopy) && $(cmd_deflate_xip_data)
>
> $(obj)/xipImage: vmlinux FORCE
>         $(call if_changed,mkxip)
>
> So the objcopy must succeed at producing vmlinux for deflate_xip_data
> (where nm is used) to be called.
>
> Do you have a .config for this issue?

I only get it while doing randconfig builds with my scripts, maybe
one out of three times, but don't ever get when rebuilding the
configs later. I have never figured out how to reproduce it reliably
other than with my randconfig script:

#!/bin/bash

RAND_DIR=build/rand
LOG_DIR=rand
PARALLEL="-j30" # number of CPUs on build system
MAKE="make O=${RAND_DIR} -sk ${PARALLEL}"
export CCACHE_DISABLE=1 # no point in ccache for random builds

buildone()
{
        mkdir -p ${RAND_DIR} ${LOG_DIR}

        eval `${MAKE} randconfig 2>&1 | grep KCONFIG_SEED=`
        export KCONFIG_SEED
        ${MAKE} allrandom.config > /dev/null

        rm -rf ${RAND_DIR}/arch/arm64/kernel/vdso
        ID=${KCONFIG_SEED}
        cp ${RAND_DIR}/.config ${LOG_DIR}/$ID-config

        if ${MAKE} > ${LOG_DIR}/$ID-output 2>&1 ; then
                mv ${LOG_DIR}/$ID-output ${LOG_DIR}/$ID-success
                echo $ID `date` success
        else
                mv ${LOG_DIR}/$ID-output ${LOG_DIR}/$ID-failure
                echo $ID `date` failed
                ${MAKE}
        fi

        ${MAKE} clean
}

buildone



      Arnd
