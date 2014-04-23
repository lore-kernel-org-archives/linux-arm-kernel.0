From: will.deacon@arm.com (Will Deacon)
Date: Wed, 23 Apr 2014 17:37:37 +0100
Subject: [PATCH] ARM64: disable DCACHE_WORD_ACCESS in big endian case
In-Reply-To: <CAA3XUr1LLphqsumkbY8UJNVx2R9_okjGox9SqukZ8cZib-AZgw@mail.gmail.com>
References: <1398119770-27817-1-git-send-email-victor.kamensky@linaro.org>
 <20140422094659.GB6979@arm.com>
 <CAA3XUr20eFyLshVM+7VBSMz4a4-cCA0PLrYGN5oyk-wOM2NLtg@mail.gmail.com>
 <20140423123845.GB5649@arm.com>
 <CAA3XUr1LLphqsumkbY8UJNVx2R9_okjGox9SqukZ8cZib-AZgw@mail.gmail.com>
Message-ID: <20140423163736.GG5649@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 05:22:22PM +0100, Victor Kamensky wrote:
> On 23 April 2014 05:38, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Apr 23, 2014 at 07:37:11AM +0100, Victor Kamensky wrote:
> >> Hi Will,
> >
> > Hi Victor,
> >
> > Thanks for investigating this!
> >
> >> On 22 April 2014 02:46, Will Deacon <will.deacon@arm.com> wrote:
> >> > On Mon, Apr 21, 2014 at 11:36:10PM +0100, Victor Kamensky wrote:
> >> The issue turned out to be in another commit: "word-at-a-time:
> >> provide generic big-endian zero_bytemask implementation". Because
> >> of the issue in zero_bytemask function full_name_hash and
> >> hash_name were giving different hash results for the same path
> >> name (without slash). The issue is that (~0ul << 64) gives
> >> ~0ul not 0. I could not come up with more elegant solution other
> >> than use inline function that check shift value against type maximum
> >> width. Please take a look below.
> >
> > Ah yes, we're in UNDEFINED territory here and AArch64 differs from AArch32
> > wrt LSL >= register width. Can you try the following instead of your patch
> > please? I think it should be more efficient.
> 
> Yes, it works. Checked initramfs and nfs boot with FVP.

Hurrah!

> I knew you could do it way more elegant :).
> 
> How do we get it in? Do you want to commit/submit it yourself?

I'll send a patch to LKML and see what Torvalds thinks. I've just come to
the realisation that fs/namei.c will *never* call zero_bytemask with a mask
== 0x0, so I'd like to remove the conditional altogether (which would be
beneficial on AArch32).

I'll keep you on CC.

Cheers,

Will
