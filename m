From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 10 Oct 2012 21:45:46 +0100
Subject: [PATCH 09/11] fsmc/nand:FIX: replace change_bit routine
In-Reply-To: <CACRpkdaot3DKCoJOBpUcJFVrJ89xRx2T58fDe4YKY_r4NFqEag@mail.gmail.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <ec169eb041e87e66c06108e85ea4a67e5797cecc.1349778821.git.vipin.kumar@st.com>
 <CACRpkdaot3DKCoJOBpUcJFVrJ89xRx2T58fDe4YKY_r4NFqEag@mail.gmail.com>
Message-ID: <20121010204546.GK4625@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2012 at 07:22:04PM +0200, Linus Walleij wrote:
> On Tue, Oct 9, 2012 at 12:44 PM, Vipin Kumar <vipin.kumar@st.com> wrote:
> 
> > change_bit routine accepts only ulong pointers as buffer, so an unaligned char
> > pointer passed to change_bit may lead to a crash.
> >
> > Fix this bug by accessing the buffer as char pointer.
> 
> Why not see if we can fix change_bit() instead?
> Since I suspect this is on ARM I bet Russell and Nico
> want to hear about this if there is a problem.

Not particularly.  There's a reason the argument to change_bit() is typed
'unsigned long' and that's not because it can take a void, char, or a
short.  It's because it _expects_ the buffer to be aligned to an
"unsigned long" quantity.

That's because on many architectures, misaligned loads and stores are
not atomic operations - and in this case, load/store exclusive will
fail when they're misalighed.

So...

-                       change_bit(err_idx[i], (unsigned long *)dat);

is highly invalid code.

> Can the ARM change_bit() not be fixed, so that
> long arguments are the only option?

Spot the intentional cast:

> > -                       change_bit(err_idx[i], (unsigned long *)dat);

which tries to work around this.  Remember my attitude towards casts:
if you're having to use a cast, you are _probably_ doing something
wrong.  In this case, it's hiding a warning which was saying that
the code is doing something wrong, and then the result blows up.
By adding that cast, the wrong wire was cut... you get to keep the
remains. ;)
