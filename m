From: khilman@kernel.org (Kevin Hilman)
Date: Tue, 2 Jun 2015 08:56:02 -0700
Subject: [PATCH v2 05/12] ARM: imx: setup tctl register in device specific
 function
In-Reply-To: <20150602011139.GP16165@dragon>
References: <1432308599-28643-1-git-send-email-shawn.guo@linaro.org>
 <1432308599-28643-6-git-send-email-shawn.guo@linaro.org>
 <CAMAWPa-1MPgzT1GJQx4SjmfQpj9zdwsAw-qvLWZjVhoM66nHsQ@mail.gmail.com>
 <20150602011139.GP16165@dragon>
Message-ID: <CAMAWPa-BYPnsqSxQ_VTa37a=Xg8xgrSQkzQgX+_65koZCNxBEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 1, 2015 at 6:11 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Hi Kevin,
>
> On Mon, Jun 01, 2015 at 04:53:28PM -0700, Kevin Hilman wrote:
>> Hi Shawn,
>>
>> On Fri, May 22, 2015 at 8:29 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> > It creates a gpt device speicific data structure and adds function hook
>> > gpt_setup_tctl in there to set up gpt TCTL register.
>> >
>> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>>
>> Starting with next-20150529, imx6dl-wandboard (both dual and solo)
>> started having boot failures[1].  Today I bisected it down to this
>> commit.  It didn't revert cleanly, so I didn't verify that this patch
>> alone is the root cause, but reproducing the boot failure should be
>> pretty easy on wandboard with recent linux-next.
>
> The imx clocksource driver was marked as BROKEN on linux-next, because
> it causes a build error on powerpc allyesconfig build [1].  I'm working
> on a fix for it.
>
> Can you please try to remove the BROKEN mark in your test to see if it
> fixes your problem?

I'm just using multi_v7_defconfig, and BROKEN is not set, but that
driver is still built because it's explicitly selected by ARCH_MXC:

$ git describe
next-20150601
$ rm build/.config
$ make ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- O=build multi_v7_defconfig
make[1]: Entering directory `/work/kernel/next/build'
  GEN     ./Makefile
arch/arm/configs/multi_v7_defconfig:603:warning: override: reassigning
to symbol COMMON_CLK_QCOM
warning: (ARCH_MXC) selects CLKSRC_IMX_GPT which has unmet direct
dependencies (OF && BROKEN)
warning: (ARCH_MXC) selects CLKSRC_IMX_GPT which has unmet direct
dependencies (OF && BROKEN)
#
# configuration written to .config
#
make[1]: Leaving directory `/work/kernel/next/build'
$ grep CLKSRC_IMX_GPT build/.config
CONFIG_CLKSRC_IMX_GPT=y
$

Kevin
