From: erosca@de.adit-jv.com (Eugeniu Rosca)
Date: Fri, 14 Sep 2018 20:50:51 +0200
Subject: [PATCH v11 0/3] remain and optimize memblock_next_valid_pfn on
 arm and arm64
In-Reply-To: <20180907144447.GD12788@arm.com>
References: <1534907237-2982-1-git-send-email-jia.he@hxt-semitech.com>
 <CAKv+Gu9u8RcrzSHdgXiqHS9HK1aSrjbPxVUSCP0DT4erAhx0pw@mail.gmail.com>
 <20180907144447.GD12788@arm.com>
Message-ID: <20180914185051.GA22530@vmlxhi-102.adit-jv.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Renesas people

Hello Will, hello Ard, 

On Fri, Sep 07, 2018 at 03:44:47PM +0100, Will Deacon wrote:
> On Thu, Sep 06, 2018 at 01:24:22PM +0200, Ard Biesheuvel wrote:
> > OK so we can summarize the benefits of this series as follows:
> > - boot time on a virtual model of a Samurai CPU drops from 109 to 62 seconds
> > - boot time on a QDF2400 arm64 server with 96 GB of RAM drops by ~15
> > *milliseconds*
> > 
> > Google was not very helpful in figuring out what a Samurai CPU is and
> > why we should care about the boot time of Linux running on a virtual
> > model of it, and the 15 ms speedup is not that compelling either.
> > 
> > Apologies to Jia that it took 11 revisions to reach this conclusion,
> > but in /my/ opinion, tweaking the fragile memblock/pfn handling code
> > for this reason is totally unjustified, and we're better off
> > disregarding these patches.
> 
> Oh, we're talking about a *simulator* for the significant boot time
> improvement here? I didn't realise that, so I agree that the premise of
> this patch set looks pretty questionable given how much "fun" we've had
> with the memmap on arm and arm64.
> 
> Will

Similar to https://lkml.org/lkml/2018/1/24/420, my measurements show that
the boot time of R-Car H3-ES2.0 Salvator-X (having 4GiB RAM) is decreased
by ~135-140ms with this patch-set applied on top of v4.19-rc3.

I agree that in the Desktop realm you would barely perceive the 140ms
difference, but saving 140ms on the automotive SoC (designed for products
which must comply with 2s-to-rear-view-camera NHTSA US regulations) *is*
significant.

FWIW, cppcheck and `checkpatch --strict` report style issues for
patches #2 and #3. I hope these can be fixed and the review process
can go on? From functional standpoint, I did some dynamic testing on
H3-Salvator-X with UBSAN/KASAN=y and didn't observe any regressions, so:

Tested-by: Eugeniu Rosca <erosca@de.adit-jv.com>

Best regards,
Eugeniu.
