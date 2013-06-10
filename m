From: b.brezillon@overkiz.com (boris brezillon)
Date: Mon, 10 Jun 2013 11:28:35 +0200
Subject: [RFC PATCH 28/50] ASoC: atmel-ssc: prepare clk before calling
 enable
In-Reply-To: <20130610090649.GC31367@sirena.org.uk>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
 <1370622370-19614-1-git-send-email-b.brezillon@overkiz.com>
 <20130607165510.GA31367@sirena.org.uk> <51B23B04.20604@overkiz.com>
 <20130610090649.GC31367@sirena.org.uk>
Message-ID: <51B59C43.2020708@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2013 11:06, Mark Brown wrote:
> On Fri, Jun 07, 2013 at 09:56:52PM +0200, Boris BREZILLON wrote:
>> On 07/06/2013 18:55, Mark Brown wrote:
>>> On Fri, Jun 07, 2013 at 06:26:09PM +0200, Boris BREZILLON wrote:
>>>> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to
>>>> avoid common clk framework warnings.
>>> Applied since I happened to notice this on he list but you should
>>> *always* CC maintainers on patches otherwise they're likely to get
>>> missed.
>> I used get_mainainer script and it returns:
>> Arnd Bergmann <arnd@arndb.de> (supporter:CHAR and MISC DRI...)
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:CHAR and
>> MISC DRI...)
>> linux-kernel at vger.kernel.org (open list)
>> Please tell me if misuse this script or if I should use something else.
> I suspect you only ran this on some of the patches as that's missing
> pretty much all of the subsystem maintainers, but in general you always
> have to think about the output of get_maintainer.pl - it isn't terribly
> reliable.
I use a script to add "cc" and "to" fields to each patch:

to.sh:

#!/bin/bash

opts="--nogit --nogit-fallback --norolestats --pattern-depth=1"

if [[ $(basename $1) =~ ^0000- ]] ; then
     ./scripts/get_maintainer.pl --nom $opts $(dirname $1)/*
else
     maint=$(./scripts/get_maintainer.pl --nol $opts $1)

     if [ "$maint" == "" ] ; then
         echo "[hidden email]"
     else
         echo "$maint"
     fi
fi

cc.sh:

#!/bin/bash

opts="--nogit --nogit-fallback --norolestats"

if [[ $(basename $1) =~ ^0000- ]] ; then
     ./scripts/get_maintainer.pl --nom $opts $(dirname $1)/*
else
     ./scripts/get_maintainer.pl $opts $1
fi

But I guess it does not handle subsystem maintainers.

I'll check it before sending patch series next time.

BTW thanks for applying this patch.

Best Regards,
Boris
