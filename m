From: f.fainelli@gmail.com (Florian Fainelli)
Date: Sat, 27 Jun 2015 18:40:23 -0700
Subject: [PATCH 1/2] ARM: BCM: Do not select CONFIG_MTD_NAND_BRCMNAND
In-Reply-To: <CADtm3G6Y+w8BWkVh8WKmaVnheBK=g-9QMai5RDb8__jJMQSCpQ@mail.gmail.com>
References: <1435422344-31059-1-git-send-email-f.fainelli@gmail.com>
 <1435422344-31059-2-git-send-email-f.fainelli@gmail.com>
 <CACna6rz52zv5QBewf8rc6BbJHbAn0-D420dSQe=SBXGef4Birw@mail.gmail.com>
 <CADtm3G6Y+w8BWkVh8WKmaVnheBK=g-9QMai5RDb8__jJMQSCpQ@mail.gmail.com>
Message-ID: <558F5087.7010108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 06/27/15 16:01, Gregory Fong a ?crit :
> On Sat, Jun 27, 2015 at 2:39 PM, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
>> On 27 June 2015 at 18:25, Florian Fainelli <f.fainelli@gmail.com> wrote:
>>> This reverts 7dc95b40f599293aedf30432749ad25b51549041 ("ARM: BCM: Enable
>>> NAND support for iProc SoCs") since it creates an unmet dependency for
>>> MTD_NAND_BRCMNAND which depends on MTD and MTD_NAND, this results in the
>>> following build failure for brcmnand:
>>
>> This commit message doesn't make too much sense to me. If
>> MTD_NAND_BRCMNAND really depends on MTD and MTD_NAND then there
>> couldn't be this problem you described.
>>
>> Maybe MTD_NAND_BRCMNAND is *missing* that dependency?
> 
> Per Documentation/kbuild/kconfig-language.txt: "select will force a
> symbol to a value without visiting the dependencies. By abusing select
> you are able to select a symbol FOO even if FOO depends on BAR that is
> not set."
> 
> I believe this is what is happening here.

Right, what is happening is actually that CONFIG_MTD gates
CONFIG_MTD_NAND, using a if MTD statement, which only affects the
user-selectability aspect of it, it does therefore only *implicitly*
enforce a depdency CONFIG_MTD for CONFIG_MTD_NAND because all of this is
user-selectable, so you need CONFIG_MTD to have CONFIG_MTD_NAND
*apppear* as a selectable option first. The same is true for all NAND
drivers, which are gated with an if MTD_NAND statement.

I could put that in the commit message and resubmit if this is deemed
appropriate to understand what is being fixed here; I thought mentioning
the unmet dependency would be enough though.

Thanks!
-- 
Florian
