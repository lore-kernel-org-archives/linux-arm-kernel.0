From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 3 Nov 2017 18:29:01 +0000
Subject: [PATCH 00/15] Add support for clang LTO
In-Reply-To: <CAKwvOdkTSXuxiFVUPXmefnDM6uV3BLDEJ+suO0BgfZxC6+Srbw@mail.gmail.com>
References: <20171103171203.107569-1-samitolvanen@google.com>
 <20171103175156.f44o7kuxgzym3pbt@lakrids.cambridge.arm.com>
 <CAKwvOdkTSXuxiFVUPXmefnDM6uV3BLDEJ+suO0BgfZxC6+Srbw@mail.gmail.com>
Message-ID: <20171103182901.eajkzkef3to4p6rf@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 03, 2017 at 11:07:04AM -0700, Nick Desaulniers wrote:
> On Fri, Nov 3, 2017 at 10:51 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > I had to create an aarch64-linux-gnu-clang wrapper, too. I'm not sure if
> > there's build system help to avoid needing that?
> 
> Gah!  So a BIG difference with Clang vs GCC for cross compiling is
> that Clang by default ships with all backends enabled, and uses a
> `-target <triple>` CFLAG to determine the arch to cross compile for,
> while GCC is configured at compile time to support one back end, IIUC.

Yup.

I initally tried passing CC=clang\ --target=aarch64-linux-gnu

... but since that conflicts with CROSS_COMPILE, you then have to
override AS, LD, OBJCOPY, etc, separately too.

This is a little less than ideal. :/

> Clang _can_ be built with all other back ends disabled but one, but I
> have a problem with this approach:  distributions of Clang are rarely
> configured this way (all backends enabled by default), and it seems we
> just found this past week that Clang if configured with just one
> backend, it will silently ignore -target flags for other backends and
> generate code for the configured backend (this led to:
> https://lkml.org/lkml/2017/11/2/892).  I consider this a bug in Clang,
> so I just filed: https://bugs.llvm.org/show_bug.cgi?id=35196

Ouch. Thanks for attacking that.

> >   CC      arch/arm64/crypto/aes-ce-cipher.o
> > fatal error: error in backend: Do not know how to split the result of this operator!
> 
> Yep, we've seen this.  It was the FINAL bug in Clang for compiling the
> kernel for arm64.  It was recently fixed upstream in llvm by
> gbiv at google.com, but so recent that you'll need to either compiler
> Clang from source from ToT or work around it like we have in Android
> with:
> https://android.googlesource.com/kernel/msm/+/9093342a0186dad05095b70f1806938310ace6e7

Sure. I can live with patch 7 for now, assuming there's nothing else
lurking in the shadows.

Thanks,
Mark.
