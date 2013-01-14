From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 14 Jan 2013 18:43:19 +0000
Subject: [PATCH v5 13/14] KVM: ARM: Handle I/O aborts
In-Reply-To: <CANM98qKASA_YML6L0KDHNsPShA+rfE2E=XXznqG4+dNn+939kg@mail.gmail.com>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108184005.46302.38495.stgit@ubuntu>
 <20130114164326.GH23505@n2100.arm.linux.org.uk>
 <CANM98qKASA_YML6L0KDHNsPShA+rfE2E=XXznqG4+dNn+939kg@mail.gmail.com>
Message-ID: <20130114184319.GN23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 01:25:39PM -0500, Christoffer Dall wrote:
> However, unifying all instruction decoding within arch/arm is quite
> the heavy task, and requires agreeing on some canonical API that
> people can live with and it will likely take a long time.  I seem to
> recall there were also arguments against unifying kprobe code with
> other instruction decoding, as the kprobe code was also written to
> work highly optimized under certain assumptions, if I understood
> previous comments correctly.

Yes, I know Rusty had a go.

What I think may make sense is to unify this and the alignment code.
They're really after the same things, which are:

- Given an instruction, and register set, calculate the address of the
  access, size, number of accesses, and the source/destination registers.
- Update the register set as though the instruction had been executed
  by the CPU.

However, I've changed tack slightly from the above in the last 10 minutes
or so.  I'm thinking a little more that we might be able to take what we
already have in alignment.c and provide it with a set of accessors
according to size etc.
