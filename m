From: jrnieder@gmail.com (Jonathan Nieder)
Date: Fri, 3 Sep 2010 13:43:51 -0500
Subject: [BUG?] rename patch accepted with --dry-run, rejected without (Re:
	[PATCH V3] arm & sh: factorised duplicated clkdev.c)
In-Reply-To: <20100903182323.GA17152@pengutronix.de>
References: <1283431716-21540-1-git-send-email-plagnioj@jcrosoft.com>
	<1283434786-26479-1-git-send-email-plagnioj@jcrosoft.com>
	<AANLkTimRKCYYQmgwY0DHu5+e-ggT8grJbdjWFvUqTzH=@mail.gmail.com>
	<20100903182323.GA17152@pengutronix.de>
Message-ID: <20100903184351.GC2341@burratino>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(+cc: bug-patch)

Hi,

Uwe Kleine-K?nig wrote:
> On Fri, Sep 03, 2010 at 07:18:43PM +0900, Magnus Damm wrote:

>> Using --dry-run is fine, but omitting dry-run gives me:
>> 
>> ...
>> patching file arch/arm/common/clkdev.c
>> patching file arch/sh/include/asm/clkdev.h
>> Hunk #1 FAILED at 1.
>> Hunk #2 FAILED at 11.
>> 2 out of 2 hunks FAILED -- saving rejects to file
>> arch/sh/include/asm/clkdev.h.rej
>> 
>> I guess this is caused by the last "renaming" hunk, see below.

Yep, I can reproduce this.  Patch applies with "git apply",
"patch --dry-run -p1" accepts it, "patch -p1" fails.

 $ patch --version | head -1
 GNU patch 2.6.1.85-423d
 $ cd ~/src/linux-2.6
 $ git checkout 2bfc96a12
 $ git clean -fd
 $ wget http://download.gmane.org/gmane.linux.ports.sh.devel/8747/8748
 $ patch -p1 --quiet --dry-run <8748 
 $ echo $?
 0
 $ patch -p1 --quiet <8748 
 2 out of 2 hunks FAILED -- saving rejects to file include/linux/clkdev.h.rej
 $ echo $?
 1

Andreas: ideas?
