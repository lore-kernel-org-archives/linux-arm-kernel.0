From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Tue, 5 Nov 2013 19:48:42 -0800
Subject: [PATCH 20/23] ARM: signal: sigreturn_codes should be endian
 neutral to work in BE8
In-Reply-To: <20131105211807.GR14892@pengutronix.de>
References: <1381271679-27804-1-git-send-email-ben.dooks@codethink.co.uk>
 <1381271679-27804-21-git-send-email-ben.dooks@codethink.co.uk>
 <20131105211807.GR14892@pengutronix.de>
Message-ID: <CAA3XUr0RbbbB6md96DLW_XQXSB7K-qhggVcNeLxowS7xzZwdRA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe, and All,

On 5 November 2013 13:18, Uwe Kleine-K?nig
<u.kleine-koenig@pengutronix.de> wrote:

<snip>

>> +
>> +#if __LINUX_ARM_ARCH__ <= 4
>> +     /*
>> +      * Note we manually set minimally required arch that supports
>> +      * required thumb opcodes for early arch versions. It is OK
>> +      * for this file to be used in combination with other
>> +      * lower arch variants, since these code snippets are only
>> +      * used as input data.
>> +      */
>> +     .arch armv4t
>> +#endif
>> +
>> +     .section .rodata
>> +     .global sigreturn_codes
>> +     .type   sigreturn_codes, #object
>> +
>> +     .arm
> This breaks a ARMv7-M build, see
> http://arm-soc.lixom.net/buildlogs/misc/next-20131105-1-g2b29c44/buildall.arm.efm32_defconfig.log.failed

Could you please point to git tree and branch from which efm32_defconfig
was built - I could not find such in my tree.
I would like to be able to reproduce this failure.

This issue looks similar to

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/197636.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-September/197637.html

which is fixed as in left quoted patch above. but this time
is not thumb opcodes are problem, but rather arm opcodes.
However it seems to be more harder.

I have tried to enable arm opcodes with '.arch armv7a' directive. But
unlike above case of v4t and v7a. .o file with armv7a and armv7m are
not compatible and cannot be linked together even though
sigreturn_codes snipet used as data.

I see only way fix that is to come back to manually constructed
opcodes and use macros from <asm/opcodes.h> to deal with
endianity issues. Effectively it will back out my v3 version of patch
and apply v1 version as I posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2013-August/191543.html

Adding bunch of ifdef into sigreturns_codes.S could be another
option, but IMHO it seems to be move in wrong direction. I would
rather see constructed opcodes.

Any other ideas?

Thanks,
Victor

> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
