From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Wed, 15 Nov 2017 11:13:51 -0800
Subject: [GIT PULL] arm64: updates for 4.15
In-Reply-To: <20171114201132.GB18699@arm.com>
References: <20171114201132.GB18699@arm.com>
Message-ID: <CA+55aFxnePDimkVKVtv3gNmRGcwc8KQ5mHYvUxY8sAQg6yvVYg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 12:11 PM, Will Deacon <will.deacon@arm.com> wrote:
>
> Please pull the following arm64 updates

Pulled. However, looking at the non-arm changes, I noticed this:

  static inline int irq_is_percpu_devid(unsigned int irq)
  ...
         return desc->status_use_accessors & IRQ_PER_CPU_DEVID;

and it matches the existing pattern in that file, so it is fine and
I'm not complaining about this pull.

But that existing pattern happens to be very dangerous and bad.

In particular, what can (and _has_ happened) is that people end up
using these functions that return true or false, and they assign the
result to something like a bitfield (or a char) or whatever.

And the code looks *obviously* correct, when you have things like

     dev->percpu = irq_is_percpu_devid(dev->irq);

and that "percpu" thing is just one status bit among many. It may even
*work*, because maybe that "percpu" flag ends up not being all that
important, or it just happens to never be set on the particular
hardware that people end up testing.

But while it looks obviously correct, and might even work, it's really
fundamentally broken. Because that "true or false" function didn't
actually return 0/1, it returned 0 or 0x20000.

And 0x20000 may not fit in a bitmask or a "char" or whatever.

So I'm not a huge fan of "bool" in structures etc (a "unsigned int
percpu:1" really is fundamentally much better), but when it comes to
inline helper functions like this, "bool" really is the right return
type, because it avoids these issues, and turns the return value to
0/1 if you actually use it in an integer context.

Alternatively, just add the "!= 0" to do that 0/1 conversion by hand.
Some people like doing "!!", I find that to be a very annoying
pattern.

                     Linus
