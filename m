From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 14 Jul 2013 15:32:07 +0100
Subject: Call for testing/opinions: Optimized memset/memcpy
In-Reply-To: <CAKv+Gu8JcQUH6d1mWh+sGcMXU6rPW7yk8P16PgqnF1Zdfn3OkA@mail.gmail.com>
References: <loom.20130713T172357-560@post.gmane.org>
 <20130713164840.GC28473@gallifrey> <loom.20130714T130546-799@post.gmane.org>
 <CAKv+Gu-fUNSZaNMgZekoCX2kOGEFDLKY1yFtKq1=yp9xQN3rOA@mail.gmail.com>
 <loom.20130714T152342-120@post.gmane.org>
 <CAKv+Gu8JcQUH6d1mWh+sGcMXU6rPW7yk8P16PgqnF1Zdfn3OkA@mail.gmail.com>
Message-ID: <20130714143207.GT24642@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 14, 2013 at 04:09:20PM +0200, Ard Biesheuvel wrote:
> Well, the whole lazy preserve/restore mechanism is based on the
> premise that preserve/restore is only required when multiple users are
> contending for the NEON (or in the SMP case, when a task gets migrated
> to another CPU). As we will not be allowing NEON in interrupt context
> nor in a preemptible section, the burden of the more costly context
> switches should not grow disproportionately, even if tasks may be
> contending for the NEON with themselves in a way (userland vs kernel).
> However, it also means that a NEON based memcpy() is going to be
> problematic, not only for the reasons pointed out by Russell, also
> because you will need a fallback to use from interrupt context.

There's another reason too: it would make memcpy() et.al., non-preemptible
also - that's probably fine for very small copies, but not for larger ones.
The acceptability threshold depends on how RT orientated you are and what
your application demands in terms of accuracy from the RT implementation.
