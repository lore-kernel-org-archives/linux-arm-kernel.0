From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Fri, 18 Dec 2015 12:18:04 -0800
Subject: [PATCH 0/3] Batched user access support
In-Reply-To: <20151218195617.GQ8644@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.20.1512171016510.27310@i7>
 <20151218195617.GQ8644@n2100.arm.linux.org.uk>
Message-ID: <CA+55aFwe8XvOQ_6jvHsmrqXyRsrrpMQorS0i0Ln8BhTt52_hwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 18, 2015 at 11:56 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> The area I'm specifically thinking that it'd be useful is in the ARM
> signal handling code, where we already have our special "__get_user_error"
> which tries to be as efficient as possible, though that may be a false
> optimisation.  Since the SW PAN stuff, I've been debating about converting
> that to use copy_to_user()/copy_from_user() instead, but haven't yet found
> the time to do any analysis.

Yes, on x86, we have something very similar. There's a separate
exception handling setup for exactly that code, which (with my
patches) also now batches up the accesses and does the STAC/CLAC only
once around the whole thing. It also checks the exception status only
once.

It turns out that with SMAP, the exception status optimization is
completely worthless. Checking the exception status is a couple of
extra instructions, but they are basically "free" instructions. So
that optimization was largely worthless, but avoiding the STAC/CLAC on
every access is much more noticeable.

             Linus
