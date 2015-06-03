From: khilman@kernel.org (Kevin Hilman)
Date: Wed, 03 Jun 2015 10:41:29 -0700
Subject: [PATCH v2 05/12] ARM: imx: setup tctl register in device specific
 function
In-Reply-To: <20150603061648.GA20344@dragon> (Shawn Guo's message of "Wed, 3
 Jun 2015 14:16:48 +0800")
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
 <1432308599-28643-6-git-send-email-shawn.guo@linaro.org>
 <CAMAWPa-1MPgzT1GJQx4SjmfQpj9zdwsAw-qvLWZjVhoM66nHsQ@mail.gmail.com>
 <20150602011139.GP16165@dragon>
 <CAMAWPa-BYPnsqSxQ_VTa37a=Xg8xgrSQkzQgX+_65koZCNxBEg@mail.gmail.com>
 <20150603061648.GA20344@dragon>
Message-ID: <7heglsadva.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn Guo <shawnguo@kernel.org> writes:

> On Tue, Jun 02, 2015 at 08:56:02AM -0700, Kevin Hilman wrote:
>> I'm just using multi_v7_defconfig, and BROKEN is not set, but that
>> driver is still built because it's explicitly selected by ARCH_MXC:
>> 
>> $ git describe
>> next-20150601
>> $ rm build/.config
>> $ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build multi_v7_defconfig
>> make[1]: Entering directory `/work/kernel/next/build'
>>   GEN     ./Makefile
>> arch/arm/configs/multi_v7_defconfig:603:warning: override: reassigning
>> to symbol COMMON_CLK_QCOM
>> warning: (ARCH_MXC) selects CLKSRC_IMX_GPT which has unmet direct
>> dependencies (OF && BROKEN)
>> warning: (ARCH_MXC) selects CLKSRC_IMX_GPT which has unmet direct
>> dependencies (OF && BROKEN)
>> #
>> # configuration written to .config
>> #
>> make[1]: Leaving directory `/work/kernel/next/build'
>> $ grep CLKSRC_IMX_GPT build/.config
>> CONFIG_CLKSRC_IMX_GPT=y
>> $
>
> Yes, you're right.  It's broken on i.MX6DL/S indeed.  The cause is that
> i.MX6DL/S DTBs are using the same GPT compatible string as i.MX6Q.  It
> effectively makes kernel select an incorrect GPT device type on
> i.MX6DL/S.  We will need to update i.MX6DL/S device tree to use
> a correct compatible string.  But to keep the existing DTBs continue
> working, we need the following change.  As I'm asked by Arnd to rebase
> my branch, I would like fold the changes into the original patch to
> save the git bisect issue.

I tried your patch on top of next-20150529 (where I originally found the
issue) and it gets my wandboard dual and solo booting again.

Tested-by: Kevin Hilman <khilman@linaro.org>

Kevin
