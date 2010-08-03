From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Aug 2010 21:02:34 +0100
Subject: READ_IMPLIES_EXEC set when no GNU_STACK header present
In-Reply-To: <20100803195816.GB31111@ubuntu-workstation>
References: <20100803195816.GB31111@ubuntu-workstation>
Message-ID: <20100803200234.GB28048@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 03, 2010 at 02:58:16PM -0500, Seth Forshee wrote:
> We recently noticed that all of our applications had the execute
> permission set for any mappings with read permission on an ARMv6
> platform. This is happening because the ELF images do not have a
> GNU_STACK program header, causing executable_stack=EXSTACK_DEFAULT to be
> passed to arm_elf_read_implies_exec(), and it immediately returns 1.

That's correct behaviour.  Historically, ARM ELF binaries don't have
the GNU_STACK program header, but expect read+exec behaviour from the
stack.

>     [ARM] enable NX support by default
>     
>     arm_elf_read_implies_exec() currently returns 1 unless non-
>     executable stacks are explicitly requested. This results in
>     READ_IMPLIES_EXEC being set for elf images without a GNU_STACK
>     program header, even though executable stacks aren't actually
>     being requested. This function should default to enabling NX when
>     the architecture supports it for better security.

NAK.  If you want NX, you must ensure that your applications are built
correctly.
