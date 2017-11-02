From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 2 Nov 2017 15:18:11 +0000
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <SG2PR06MB11655BDEF09BB62D268A29DD8A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102112041.GW9463@n2100.armlinux.org.uk>
 <SG2PR06MB11653D39086B1F58497C9FE08A5C0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <nycvar.YSQ.7.76.1711021044380.21665@knanqh.ubzr>
Message-ID: <18e5317b-c3a4-1b6c-5bb1-154e5a0971d2@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/11/17 15:04, Nicolas Pitre wrote:
> On Thu, 2 Nov 2017, Chris Brandt wrote:
> 
>> Oops, I meant to show this:
>>
>> $ arm-linux-gnueabihf-as -version
>> GNU assembler (Linaro_Binutils-2017.01) 2.25.2 Linaro 2016_02
>> Copyright (C) 2014 Free Software Foundation, Inc.
>> This program is free software; you may redistribute it under the terms of
>> the GNU General Public License version 3 or later.
>> This program has absolutely no warranty.
>> This assembler was configured for a target of `arm-linux-gnueabihf'.
> 
> This is very strange. Here's a quick test with all the binutils versions 
> I have lying around on my system:
> 
> $ echo -e "mov r0, #'\\\r'\nmov r1, '\\\r'"
> mov r0, #'\r'
> mov r1, '\r'
> $ echo -e "mov r0, #'\\\r'\nmov r1, '\\\r'" > /tmp/t.s
> $ for as in $(find /opt -name arm-linux-\*-as); do \
>> $as --version | head -1; \
>> $as /tmp/t.s -o /tmp/t.o; done
> GNU assembler (Linaro_Binutils-2017.05) 2.27.0.20161019
> /tmp/t.s: Assembler messages:
> /tmp/t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'
> GNU assembler (crosstool-NG linaro-1.13.1-4.7-2013.02-01-20130221 - Linaro GCC 2013.02) 2.23.1
> /tmp/t.s: Assembler messages:
> /tmp/t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'
> GNU assembler (Linaro_Binutils-2017.05) 2.25.2 Linaro 2016_02
> /tmp/t.s: Assembler messages:
> /tmp/t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'
> GNU assembler (crosstool-NG linaro-1.13.1-4.9-2014.09 - Linaro GCC 4.9-2014.09) 2.24.0.20140829 Linaro 2014.09
> /tmp/t.s: Assembler messages:
> /tmp/t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'
> GNU assembler (GNU Binutils) Linaro 2014.11-3-git 2.24.0.20141017
> /tmp/t.s: Assembler messages:
> /tmp/t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'
> GNU assembler (Linaro_Binutils-2017.08) 2.28.2.20170706
> /tmp/t.s: Assembler messages:
> /tmp/t.s:2: Error: immediate expression requires a # prefix -- `mov r1,13'
> 
> They all fail, including the version that looks like the one you have.

Note that for UAL syntax, GAS follows the ARM ARM recommendation and
considers the '#' on immediate values optional everywhere. I'm going to
hazard a guess that Chris might be building a Thumb-2 kernel or somehow
otherwise has ARM_ASM_UNIFIED turned on.

Robin.

> Could you try that little test above on your side?
> 
>>> So, as far as ARM assembly in the Linux kernel goes, all constants must
>>> be preceded by # whether or not binutils requires it - no exceptions.
>>> Please always test assembly changes with a binutils version that is not
>>> gratuitously broken!
>>
>> Somewhat ironic since Nicolas works for Linaro.
> 
> I'm not involved with the toolchain people though, other than using 
> their output.
> 
> 
> Nicolas
> 
