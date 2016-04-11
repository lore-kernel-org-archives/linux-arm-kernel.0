From: will.deacon@arm.com (Will Deacon)
Date: Mon, 11 Apr 2016 11:40:13 +0100
Subject: [PATCH 1/2] arm64: mem-model: add flatmem model for arm64
In-Reply-To: <CAKv+Gu-cWWUi6fCiveqaZRVhGCpEasCLEs7wq6t+C-x65g4cgQ@mail.gmail.com>
References: <1459844572-53069-1-git-send-email-puck.chen@hisilicon.com>
 <20160407142148.GI5657@arm.com> <570B10B2.2000000@hisilicon.com>
 <CAKv+Gu8iQ0NzLFWHy9Ggyv+jL-BqJ3x-KaRD1SZ1mU6yU3c7UQ@mail.gmail.com>
 <570B5875.20804@hisilicon.com>
 <CAKv+Gu9aqR=E3TmbPDFEUC+Q13bAJTU5wVTTHkOr6aX6BZ1OVA@mail.gmail.com>
 <570B758E.7070005@hisilicon.com>
 <CAKv+Gu-cWWUi6fCiveqaZRVhGCpEasCLEs7wq6t+C-x65g4cgQ@mail.gmail.com>
Message-ID: <20160411104013.GG15729@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2016 at 12:31:53PM +0200, Ard Biesheuvel wrote:
> On 11 April 2016 at 11:59, Chen Feng <puck.chen@hisilicon.com> wrote:
> > Please see the pg-tables below.
> >
> >
> > With sparse and vmemmap enable.
> >
> > ---[ vmemmap start ]---
> > 0xffffffbdc0200000-0xffffffbdc4800000          70M     RW NX SHD AF    UXN MEM/NORMAL
> > ---[ vmemmap end ]---
> >
> 
> OK, I see what you mean now. Sorry for taking so long to catch up.
> 
> > The board is 4GB, and the memap is 70MB
> > 1G memory --- 14MB mem_map array.
> 
> No, this is incorrect. 1 GB corresponds with 16 MB worth of struct
> pages assuming sizeof(struct page) == 64
> 
> So you are losing 6 MB to rounding here, which I agree is significant.
> I wonder if it makes sense to use a lower value for SECTION_SIZE_BITS
> on 4k pages kernels, but perhaps we're better off asking the opinion
> of the other cc'ees.

You need to be really careful making SECTION_SIZE_BITS smaller because
it has a direct correlation on the use of page->flags and you can end up
running out of bits fairly easily.

Will
