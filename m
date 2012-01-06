From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 07 Jan 2012 00:19:53 +0100
Subject: [PATCH 1/2] at91 : move pm.h header to arch/arm/include/asm
In-Reply-To: <201201061730.33525.arnd.bergmann@linaro.org>
References: <1325864915-794-1-git-send-email-daniel.lezcano@linaro.org>
 <201201061730.33525.arnd.bergmann@linaro.org>
Message-ID: <4F078199.201@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/06/2012 06:30 PM, Arnd Bergmann wrote:
> On Friday 06 January 2012, Daniel Lezcano wrote:
>> Move the location of the pm.h header file to the include directory,
>> so it can be included from another place from the current one.
>>
>> That will allow the next patch which moves the cpuidle code to the
>> drivers/cpuidle directory.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} |    0
>>  arch/arm/mach-at91/cpuidle.c                       |    2 +-
>>  arch/arm/mach-at91/pm.c                            |    2 +-
>>  3 files changed, 2 insertions(+), 2 deletions(-)
>>  rename arch/arm/{mach-at91/pm.h => include/asm/at91_pm.h} (100%)
> 
> Moving the driver is great, as we have previously discussed, but
> the header file does not belong into include/asm really, because it
> is too hardware specific and we are trying to keep such stuff out
> of that place.
> 
> One option would be to move the pm.c along with the cpuidle.c file,
> in particular that might turn out to be a good idea if other
> platforms have the same requirement.
> 
> Aside from that, it would be good to hear from the AT91 maintainers
> how they want to deal with the removal of CONFIG_ARCH_AT91_*
> conditionals, which AFACIT will be necessary anyway in order to allow
> building a single kernel across multiple at91 targets. Once that
> problem is solved for pm.h, the question of where to place that header
> may be resolved, too.

Mmmh, the problem will be more complex with other architectures I think.

For instance, the omap cpuidle driver includes

#include "powerdomain.h"
#include "clockdomain.h"

#include "pm.h"
#include "control.h"
#include "common.h"

These include files are used by the other .c files in the same directory.



- -- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBAgAGBQJPB4GZAAoJEAKBbMCpUGYAI1YH/jJIoBtKku7YgXfBTj9Mqf92
nQQqDoGiQGNNXM2TDBKS4t8EyiRa9YuHYHAYS16JaoUPDTj1Zwzo3E3fTFLQcFi6
x0l3H82c6VvnqtY6qwO5ym9bB8m9kSdJjAFqIDPO987hOB4jeFBA6EE4SgcMuiHR
4rWzQVZjHtA1nf/9yrcVgwush75psWNHudnLn/0TyM14efuys0xUx+EMWqQzmpzj
aBc+TgWn/HUXX261VCYmTgUIo/L/xV7eU/IRSR7Nd8AWPp6hrm4x2C4SO5Kt8JFE
OA2peOGEIlNqre4tuKf4QXT1/QkiwTW6j194wag3kaLHBaARnXT/vX+xnYVqzjU=
=2H/1
-----END PGP SIGNATURE-----
