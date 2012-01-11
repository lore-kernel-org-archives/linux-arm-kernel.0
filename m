From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Jan 2012 17:29:28 +0100
Subject: [PATCH 0/7] at91 : pm.h cleanups
In-Reply-To: <201201111523.57368.arnd.bergmann@linaro.org>
References: <1326293740-15735-1-git-send-email-daniel.lezcano@linaro.org>
 <201201111523.57368.arnd.bergmann@linaro.org>
Message-ID: <4F0DB8E8.3060001@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/11/2012 04:23 PM, Arnd Bergmann wrote:
> On Wednesday 11 January 2012, Daniel Lezcano wrote:
>>
>> This patchset is the first series to cleanup some code around pm.h, pm.c and
>> cpuidle. The next series will bring more cleanups and finally the third series
>> will change the different functions into ops where we can export the structure
>> definition in order to encapsulate the code and move the at91's cpuidle driver
>> to the drivers/cpuidle directory.
> 
> Hi Daniel,
> 
> These all look like useful cleanups. You don't really have to split them
> up into so small units, but it doesn't hurt if you do. Patch 5 seems to
> actually fix a bug, but probably a harmless one.

Thanks Arnd for reviewing the patchset.

> It's not clear where you're headed though, I hope that becomes more obvious
> in the next patches. 

Yes, I think that will become more obvious in the next patches. The
objective is to cleanup the code first, unify the api and change that to
some ops we will register at boot time.

Also, I will address Russell's comment about the standby function to be
defined.

> The tricky bit that will have to be done is to turn
> all the #ifdef checks into runtime here. You have moved the #include for the
> memory controller into a new header, but that is not actually progress
> on this larger problem.

The next patches will include the header from the .c file. IMHO,
including a single file in a .c is more clear than a lot of #ifdef.

> It would be nice to move the
> sdram_selfrefresh_enable/disable functions into a .c file that uses
> cpu_is_at91...() to do runtime detection.

These patches are about separating the SoC specific code from the
cpuidle driver code in order to move this one to the drivers directory.

AFAIU, we agreed the drivers directory is the right place for the
cpuidle drivers. There is a lot of cleanup to be done on the different
SoC/arch and I would like to focus on that rather than fixing different
problems at the same time. By the way achieving this goal will benefit
to the single kernel image goal.

The next patchset will move these functions to the .c file and define an
ops structure which will be included from the cpuidle drivers.

I am not sure how to do runtime detection but as soon as this is defined
with ops, it will be trivial to register the right ops at boot time and
prevent unneeded cpu_is_at91 checks in the idle functions.

Thanks
  -- Daniel

- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPDbjoAAoJEAKBbMCpUGYATkQIAL6vVMgYQjeMcsXxD1VC+Xem
5e+xQEjGcItj0rbj5LAgAVrTxLAw9p+33xx5vjwOEa65mVm10bkkb3put9zKkKVz
QjilwywAzQ8LMsapJ5mIIQEOfXWOC41+cNbyKr150ydplSjuXIfgs255nCEsojtc
8kNGsgKjh7+vxE/3LCwa+kMz39rVHMxgle2JB+ThLZpv+c/wz/JXhZwOfjgH5ERL
K9neVmSS5N/LIzVh1IcXk0UxF4NDnSnoSadKWpxvxtnI1kb3oDiHXersq3BlIa8x
7wgohka5NlhzEmLeWzZ49DlOfZ5zyHIgzKeU8sY13ccZvxHDQuzqrv49AaM2PEM=
=4six
-----END PGP SIGNATURE-----
