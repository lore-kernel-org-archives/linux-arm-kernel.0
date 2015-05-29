From: matthijsvanduin@gmail.com (Matthijs van Duin)
Date: Fri, 29 May 2015 03:35:22 +0200
Subject: runtime check for omap-aes bus access permission (was: Re:
 3.13-rc3 (commit 7ce93f3) breaks Nokia N900 DT boot)
In-Reply-To: <CAALWOA9qJHUST0JQxA6MBohMfbTYAP9+NbSXGYHZY4Xa3nSFvw@mail.gmail.com>
References: <20131206213613.GA19648@earth.universe> <201502111339.54480@pali>
 <CAALWOA_ngoSKjB=ZQ264Va37bBK7v41Ei45SyoYLiMdanTKnxQ@mail.gmail.com>
 <201502112128.44852@pali>
 <CAGo_u6oZxi7O6re30L2-wVyxTeahhyMb4qVcrE3tSCV9sBvrnw@mail.gmail.com>
 <20150528073740.GD16509@pali> <20150528160113.GH30984@atomide.com>
 <CAALWOA8Pfc_zbN9MoHwR=njPBpFU56WObYMbGv9N7ktzy+RSeQ@mail.gmail.com>
 <20150528222412.GM30984@atomide.com>
 <CAALWOA9qJHUST0JQxA6MBohMfbTYAP9+NbSXGYHZY4Xa3nSFvw@mail.gmail.com>
Message-ID: <CAALWOA82=QmTpCeiceOFQOjqXKdSBjB3Z+jL-mi0vYF=QaL4sA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29 May 2015 at 02:58, Matthijs van Duin <matthijsvanduin@gmail.com> wrote:
> It is only guaranteed to happen immediately (before the next
> instruction is executed) if the error occurs before the posting-point
> of the write. However, in that case the error is reported in-band to
> the cpu, resulting in a (synchronous) bus error which takes precedence
> over the out-of-band error irq (if any is signalled).

OK, all this was actually assuming linux uses device-type mappings for
device mappings, which was also the impression I got from
build_mem_type_table() in arch/arm/mm/mmu.c (although it's a bit of a
maze). A quick test however seems to imply otherwise:

~# ./bogus-dev-write
Bus error

So... linux actually uses strongly-ordered mappings? I really didn't
expect that, given the performance implications (especially on a
strictly in-order cpu like the Cortex-A8 which will really just sit
there picking its nose until the write completes) and I think I recall
having seen an OCP barrier being used somewhere in driver code...

Well, in that case everything I said is technically still true, except
the posting point is the peripheral itself. That also means the
interconnect error reporting mechanism is not really useful for
probing since you'll get a bus error before any error irq is
delivered.

So I'd say you're back at having to trap that bus error using the
exception handling mechanism, which I still suspect shouldn't be hard
to do.

Or perhaps you could probe the device using a DMA access and combine
that with the interconnect error reporting irq... ;-)
