From: rabin@rab.in (Rabin Vincent)
Date: Wed, 11 May 2011 22:53:55 +0530
Subject: [patch 0/4] [RFC] mcount address adjustment
In-Reply-To: <20110510081039.241831019@de.ibm.com>
References: <20110510081039.241831019@de.ibm.com>
Message-ID: <BANLkTi=6FLtzXwg1yLAkLhP4GA4apSQ46g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 13:40, Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
> That leaves arm as the last remaining architecture with a non trivial
> ftrace_call_adjust function. There the least significant bit is removed
> from the address with an and operation. The comment says this is done
> for Thumb-2. This implies that for Thumb-1 the offset is 0 and for
> Thumb-2 the offset is -1, correct?

ARM supports building the kernel using either the ARM instruction set or
the Thumb-2 instruction set.  The kernel cannot be built with the
"Thumb-1" instruction set (btw usually referred to as just Thumb).

Thumb-2 via recordmcount.pl needs the clearing of the lsb because the
relocation (R_ARM_ABS32) that gets used for the assembly file
that recordmcount.pl generates and assembles dictates that the lsb be
set if the target symbol is Thumb/Thumb-2 function.  mcount_adjust would
not help here since the ORing is done later, when the relocation is
applied.

Thumb-2 via recordmcount.c does not need the clearing of the lsb in
ftrace_call_adjust.

Building with the ARM instruction set also does not need the clearing
of the lsb.

> Thumb-2 the offset is -1, correct? If there is a way to distinguish
> the two targets in recordmcount at compile time we could convert arm
> as well. Which would allow us to remove the ftrace_call_adjust function.

To remove ftrace_call_adjust, we could either deprecate the
recordmcount.pl usage for ARM (you already have to edit the Kconfig to
use it) or modify it to generate specific relocations explicitly instead
of using the assembler data directives.
