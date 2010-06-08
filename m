From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 8 Jun 2010 22:51:38 +0800
Subject: Heads up: Linus plans to kill ARM defconfigs
In-Reply-To: <20100608131319.GF25370@n2100.arm.linux.org.uk>
References: <4C0853E1.1080005@bluewatersys.com>
	<AANLkTinEq99_8UyVNnmzNEreDoyHKEnxpuJmaAo_kpPN@mail.gmail.com>
	<20100604061034.GI6499@atomide.com>
	<AANLkTikrK-RkDntgrpptBaG6TvnesNFncOw3DW4Jt-TY@mail.gmail.com>
	<AANLkTil1IetX6koHVRrgnWs3DqhPtZVqR2euEdg9lZUa@mail.gmail.com>
	<alpine.LFD.2.00.1006041418390.22319@xanadu.home>
	<20100608115832.GB25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080839240.30664@xanadu.home>
	<20100608125053.GD25370@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1006080857390.30664@xanadu.home>
	<20100608131319.GF25370@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinWCRIKyMUseSpkRfEC0Cba4JRGBiUwb_jD_MkZ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 8, 2010 at 9:13 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jun 08, 2010 at 09:01:35AM -0400, Nicolas Pitre wrote:
>> I wouldn't give up on that option just yet though. ?I don't think he
>> fully understood your idea, and without an actual patch it might be hard
>> to understand as well, especially for people who are not used to deal
>> with the target varieties we have on ARM. ?Linus is also known to change
>> his mind when presented with evidences.
>
> The two ideas are very close to each other - and can be generated
> together.
>
> If we create something like Linus' preferred solution, we can then do
> in the main arch/arm/Kconfig:
>
> config STD_CONFIG
> ? ? ? ?bool "blah"
>
> if STD_CONFIG
>
> if MACH_WHATEVER
> include arch/arm/config/Kconfig.whatever
> endif
>
> if MACH_BLAH
> include arch/arm/config/Kconfig.blah
> endif
>
> endif
>
> which should work as per my idea.
>

Anyway, we might need a tool to analyze those common config options across all
boards, and those not. Attached is a script used when updating debian kernel
configs, which I found might be useful. The result is still a _big_
mess to sort out
though. Below is what I did:

1. Generating a complete list of configs (updated)
ycmiao at macbook-lucid:~/kernel/linux-2.6$ for i in arch/arm/configs/*;
do j=`echo $i | sed 's/.*configs\/\(.*\)_defconfig/\1/'`; echo $j;
mkdir ../build/tmp; make ARCH=arm O=../build/tmp `basename $i`; make
ARCH=arm O=../build/tmp oldconfig; cp ../build/tmp/.config
../configs/config.$j; rm -fr ../build/tmp; done

2. Use splitconfigs.pl shows the reduction of config options

ycmiao at macbook-lucid:~/kernel/configs$ cat * | wc -l
258408

ycmiao at macbook-lucid:~/kernel/configs$ splitconfig.pl .
Reading config's ...
Merging lists ...
Creating common config ... done.
Creating stub configs ...

ycmiao at macbook-lucid:~/kernel/configs$ cat * | wc -l
142062

3. A config.common includes those options common to all config.* and
the remaining
config.* now only includes those could be different across boards.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: splitconfig.pl
Type: application/octet-stream
Size: 2404 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100608/e0b6259d/attachment.obj>
