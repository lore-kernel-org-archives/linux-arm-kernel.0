From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 15 Nov 2016 10:20:15 -0500
Subject: [PATCH/RESEND] recordmcount: arm: Implement make_nop
In-Reply-To: <CAKv+Gu-Cp775gbLxPcJQ4G2nEnwm9G_gxh5B1Sf2LGkkov_OZA@mail.gmail.com>
References: <20161018234200.5804-1-sboyd@codeaurora.org>
 <CAKv+Gu-Cp775gbLxPcJQ4G2nEnwm9G_gxh5B1Sf2LGkkov_OZA@mail.gmail.com>
Message-ID: <20161115102015.3392420e@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 15 Nov 2016 14:19:44 +0000
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> On 19 October 2016 at 00:42, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > In similar spirit to x86 and arm64 support, add a make_nop_arm()
> > to replace calls to mcount with a nop in sections that aren't
> > traced.
> >
> > Cc: Russell King <linux@arm.linux.org.uk>
> > Acked-by: Rabin Vincent <rabin@rab.in>
> > Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> > ---
> >  scripts/recordmcount.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >
> > diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
> > index 5423a58d1b06..aeb34223167c 100644
> > --- a/scripts/recordmcount.c
> > +++ b/scripts/recordmcount.c
> > @@ -213,6 +213,59 @@ static int make_nop_x86(void *map, size_t const offset)
> >         return 0;
> >  }
> >
> > +static unsigned char ideal_nop4_arm_le[4] = { 0x00, 0x00, 0xa0, 0xe1 }; /* mov r0, r0 */
> > +static unsigned char ideal_nop4_arm_be[4] = { 0xe1, 0xa0, 0x00, 0x00 }; /* mov r0, r0 */  
> 
> Shouldn't you be taking the difference between BE8 and BE32 into
> account here? IIRC, BE8 uses little endian encoding for instructions.
> 

I was just about to push this to linux-next (where I don't rebase). I'm
guessing I should hold off then.

Luckily, this was the last patch of my tree that I tested, and I can
just remove that one.

-- Steve
