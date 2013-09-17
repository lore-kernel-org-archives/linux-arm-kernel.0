From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 17 Sep 2013 17:45:42 -0400 (EDT)
Subject: [PATCH v2] ARM: fix Thumb-2 bug in AES assembler code
In-Reply-To: <CAKv+Gu8pgc6tu=8B9qFQe1ndm89_OyAeGHCu=L4F2Gm9xAsYyA@mail.gmail.com>
References: <1379438195-6911-1-git-send-email-ard.biesheuvel@linaro.org>
 <alpine.LFD.2.03.1309171429580.20709@syhkavp.arg>
 <CAKv+Gu8pgc6tu=8B9qFQe1ndm89_OyAeGHCu=L4F2Gm9xAsYyA@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1309171741310.20709@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Sep 2013, Ard Biesheuvel wrote:

> On 17 September 2013 20:34, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> > On Tue, 17 Sep 2013, Ard Biesheuvel wrote:
> >
> >> Patch 638591c enabled building the AES assembler code in Thumb2 mode.
> >> However, this code used arithmetic involving PC rather than adr{l}
> >> instructions to generate PC-relative references to the lookup tables,
> >> and this break in Thumb mode due to the different PC offset.
> >>
> >> Use adr instructions instead.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>
> >> v2:
> >> - use 'adr' instruction rather than explicit PC arithmetic
> >> - move the tables around so they are in range for 'adr' in each mode
> >>
> >>  arch/arm/crypto/aes-armv4.S | 388 ++++++++++++++++++++++----------------------
> >>  1 file changed, 193 insertions(+), 195 deletions(-)
> >
> > No no no.  NAK.
> >
> > This makes the patch completely unreviewable.  And unacceptable for
> > inclusion into the stable tree.
> >
> > Also, why do you have to move tables around?
> >
> 
> Well, my approach was to remove all the PC related arithmetic, but
> loading the address of the table itself using adr doesn't work in ARM
> as it's too far away, and adrl doesn't exist in Thumb.
> 
> > Isn't the following sufficient to fix the issue?
> >
> 
> Yes, this is obviously much less obtrusive, so much better.
> Should I respin my patch or should we just paste your diff into the
> patch system?
> (I will test it properly first, of course)

I don't think you need to repost this.

With regard to your comment about trying to stay as close as possible to 
the originating copy of the code... the best solution in this case would 
be to contribute back all those fixes to that other version.


Nicolas
