From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 12 Aug 2011 21:55:20 +0100
Subject: [PATCH] ARM: zImage: Skip relinking if nothing changes
In-Reply-To: <CACqU3MUq5M-XPOxV=8GKyEzjEzpmdeaF+mGrXJrK+ZZxa4SdeQ@mail.gmail.com>
References: <4E457682.5020107@codeaurora.org>
	<1313175602-21834-1-git-send-email-sboyd@codeaurora.org>
	<CACqU3MUq5M-XPOxV=8GKyEzjEzpmdeaF+mGrXJrK+ZZxa4SdeQ@mail.gmail.com>
Message-ID: <20110812205520.GL4775@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 04:48:12PM -0400, Arnaud Lacombe wrote:
> You should be able to avoid the extra copy altogether by doing something ala:
> 
> $(obj)/lib1funcs.o: $(srctree)/arch/arm/lib/lib1funcs.S
>         $(call cmd,as_o_S)
> 
> note that I also remove the $(SRCARCH), as there is no other
> `arch/*/lib/lib1funcs.S' than `arch/arm/lib/lib1funcs.S'

We tried such things, but it results in kbuild arguing over building
lib1funcs.S in arch/arm/lib and arch/arm/boot/compressed.  You end up
with it rebuilding the arch/arm/lib one, followed by a rebuild of the
arch/arm/boot/compressed one.

We've ended up with what we have because its about the only way to get
kbuild to behave.
