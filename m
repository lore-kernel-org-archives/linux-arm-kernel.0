From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 28 Sep 2011 09:36:53 -0400
Subject: [PATCH] dma/imx-sdma+imx-dma: explicitly #include <linux/module.h>
In-Reply-To: <20110928064614.GN20550@pengutronix.de>
References: <1317018379-8897-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<4E824821.8040105@windriver.com>
	<20110928064614.GN20550@pengutronix.de>
Message-ID: <4E8322F5.6010206@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-28 02:46 AM, Uwe Kleine-K?nig wrote:
> [Cc: += linux-kbuild at v.k.o + Michal Marek]
> 
> Hello,
> 
> On Tue, Sep 27, 2011 at 06:03:13PM -0400, Paul Gortmaker wrote:
>> On 11-09-26 02:26 AM, Uwe Kleine-K?nig wrote:
>>> This is needed after commit
>>>
>>> 	include: replace linux/module.h with "struct module" wherever possible
>>>
>>> (currently 25215aa in next).
>>>
>>> Cc: Paul Gortmaker <paul.gortmaker@windriver.com>
>>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>>> ---
>>> Hello,
>>>
>>> maybe it's sensible for Paul to take that before his commit?
>>
>> Thanks, I'll blend it into the commit adding module.h to the other
>> drivers/dma files.  It seems the imx boards don't have a defconfig
>> in the arch/arm/configs that enables this (CONFIG_IMX_[S]DMA).
>>
>> What is really interesting (at least to me anyway) is that I
>> didn't get one iMX build in some 6000+ ARM randconfig builds....
>>
>> I would have thought it would have showed up at least a couple
>> times, given that number of builds.  Maybe randconfig doesn't
>> deal so well with "choice" Kconfig items?
>>
>> ~/git/module.h/linux-2.6.git$ ls -1 ../build-10*arm |wc -l
>> 6399
>> ~/git/module.h/linux-2.6.git$ grep CONFIG_ARCH_[A-Z0-9]*=y ../build-10*arm*/.config | sed 's/.*CON/CON/'|sort |uniq
>> CONFIG_ARCH_EBSA110=y
>> CONFIG_ARCH_H7201=y
>> CONFIG_ARCH_H7202=y
>> CONFIG_ARCH_H720X=y
>> CONFIG_ARCH_VERSATILE=y
> 
> I don't understand why you did that sed, but AFAICT it doesn't hurt,
> too. Maybe adding -c to uniq in your command line is interesting for the
> kbuild people?!

The sed was to strip the build paths from the grep output.  I could
have used "grep -h" instead.

> 
>> ~/git/module.h/linux-2.6.git$ 
>>
>> No ARCH_MXC, no ARCH_MXS, PXA, or any of the other 20+ variants.
>> Definitely not a random spread there, with all 6000 builds falling
>> in just 5 buckets.
> How did you test? Generate a .config, test without your change and if
> that succeeds test with it? If so, maybe the problem isn't that
> randconfig doesn't generate more random configs but that you got many
> failures in the first run?!

Testing was with the following chunk out of my $0.02 script:

 i=10000 ; while [ 1 ] ; do D=../build-$i-$MYARCH ; mkdir $D ; echo xxxxxxx $D xxxxxx  ; make ARCH=$MYARCH O=$D randconfig > $D/cfg.log 2>&1 ; if [ $? != 0 ] ; then echo  cfg failed in $D ; break ; fi ; time make ARCH=$MYARCH O=$D -j16 > $D/build.log 2>&1 ; if [ $? != 0 ]; then echo  bld fail in $D ; fi ; i=$[$i+1] ; done

Then I'd comb all the build logs looking for errors that were caused
by changes that I made.  As you can see, it just calls randconfig, but
the coverage never really "randomly" covered all arm platforms.

Paul.



> 
> Best regards
> Uwe
> 
