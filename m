From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 29 Mar 2017 18:03:25 +0100
Subject: [PATCH] ARM: dma-mapping: Fix dma_get_sgtable() for regions
 without struct page
In-Reply-To: <CAKocOOPjqdyLbtbeRLr9NZaNoqefjobYhev+0hr3OGwNLwNjmw@mail.gmail.com>
References: <CGME20170221131655eucas1p2f2ca6e3c819aeae227c5e5c5f2bc7d3f@eucas1p2.samsung.com>
 <1487682998-2564-1-git-send-email-m.szyprowski@samsung.com>
 <20170322111020.GD21222@n2100.armlinux.org.uk>
 <CAKocOONSt=UjPPVEN0ESLBMAsbk_HeWGQdkzyuUW+X7ddaLwzQ@mail.gmail.com>
 <20170322163237.GF21222@n2100.armlinux.org.uk>
 <CAKocOOMqWByyAotnjKM3Zqq9xUBNcBFMens5Rj08aiM99wxEzg@mail.gmail.com>
 <20170322224200.GH21222@n2100.armlinux.org.uk>
 <20170329163335.GA7909@n2100.armlinux.org.uk>
 <CAKocOOPjqdyLbtbeRLr9NZaNoqefjobYhev+0hr3OGwNLwNjmw@mail.gmail.com>
Message-ID: <20170329170325.GC7909@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 10:51:05AM -0600, Shuah Khan wrote:
> Hi Russell,
> 
> On Wed, Mar 29, 2017 at 10:33 AM, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > Okay, I'm about to merge the following patch for -rc, since refusing
> > to create a scattertable for non-page backed memory is the only valid
> > solution for that case.  I'm intending to queue this for -rc this
> > evening.
> 
> I was bit sidetracked and getting back to this today. I am just about
> to test this change on my system. I will test your patch and send you
> results.
> 
> This might not help my use-case - I suspect it will trip this check.
> That said I will send you results very soon.

I do hope that it _does_ trip this check - the result should be that you
get an error without the kernel oopsing.

> I have been thinking about this some. I would like to see if we can
> provide a way forward to address the cases where coherent memory is
> not guaranteed to be backed by struct pages. We know the memory isn't
> backed at alloc time in dma_alloc_coherent(). Can we key off of that
> maybe add a new attr flag to avoid page lookups. I am willing to work
> on the fixing it.

What we need is to revise the dma-buf API and DMA APIs to allow passing
coherent memory through it - there is no current provision in the DMA APIs
to have coherent memory mapped for two peripherals.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
