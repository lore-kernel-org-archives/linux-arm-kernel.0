From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 5 Jun 2013 15:44:14 -0700
Subject: [PATCH] ARM/KVM: save and restore generic timer registers
In-Reply-To: <CAFEAcA8hp+fWWuvVVLSCxfPdN8itsMq9Jy6jgrcqAJ7bH4zmPA@mail.gmail.com>
References: <1370039952-20888-1-git-send-email-andre.przywara@linaro.org>
 <20130605192316.GB9640@ubuntu> <51AFA992.4060803@linaro.org>
 <CAFEAcA8hp+fWWuvVVLSCxfPdN8itsMq9Jy6jgrcqAJ7bH4zmPA@mail.gmail.com>
Message-ID: <20130605224414.GE9640@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 05, 2013 at 10:18:28PM +0100, Peter Maydell wrote:
> On 5 June 2013 22:11, Andre Przywara <andre.przywara@linaro.org> wrote:
> > On 06/05/2013 09:23 PM, Christoffer Dall wrote:
> >> To avoid the extra storage overhead here I suggest you just export the
> >> registers using a separate number space for the ONE_REG ioctl instead of
> >> piggybacking on the cp15 exports.
> 
> This is letting the kernel's internal implementation details
> affect the userspace API -- I think that's a bad idea.

OK, fair enough, they can be treated as regular cp15 registers.  But I
looked at the patch again, and I don't see why we have to touch
NR_CP15_REGS at all actually - even if we do keep the current ID for the
one_reg id field.

We don't need to fill in these registers in the coprocessor arrays just
because they're encoded that way in the one_reg id field - that would be
letting the user space API define the implementation in the kernel ;)
Or did I miss something?

(The truth is that the interface and implementation are probably not as
separate concepts in the real world as we would sometimes like, but
that's a different discussion.)

> As Andre says, we went through a round like this, and my
> opinion was that since these are cp15 registers the logical
> place to put them is in cp15 space.
> 

Well, that round wasn't public, so I didn't really have that background
info, but I agree with your sentiment, and it does avoid us having to
come up with encoding in an already existing number space (the cp15
access numbers), but we want it to make sense for both the kernel and
user space applications, and we don't want to be allocating random
unused bytes on kernel data structures just for the fun of it.

-Christoffer
