From: rabin@rab.in (Rabin Vincent)
Date: Mon, 12 Nov 2012 18:26:02 +0100
Subject: [PATCH 8/9] ARM: support uprobe handling
In-Reply-To: <20121104101327.GZ21164@n2100.arm.linux.org.uk>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-8-git-send-email-rabin@rab.in>
 <20121104101327.GZ21164@n2100.arm.linux.org.uk>
Message-ID: <CAH+eYFDzqEFZhomL-szRDY-J=DFp_XLBXYVf0ox_F-z=YdXP0A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/11/4 Russell King - ARM Linux <linux@arm.linux.org.uk>
> On Sun, Oct 14, 2012 at 09:23:12PM +0200, Rabin Vincent wrote:
> > Extend the kprobes code to handle user-space probes.  Much of the code
> > can be reused so currently the ARM uprobes code reuses the kprobes
> > structures.  The decode tables are reused, with the modification that
> > for those instruction that require custom decoding for uprobes, a new
> > element is added in the table to specify a custom decoder function.
>
> How are accesses to userspace handled by the kprobes code?  Please point
> me to where these accesses are performed.

If you mean the accesses where we write the probe opcode, this is done
in write_opcode() in kernel/events/uprobes.c

If you instead mean the accesses which load/store instructions would
perform, this is done from userspace itself, by placing the modified
instruction in an executable area which is mapped to userspace, and
modifying the PC to point there.  See xol_get_insn_slot() in
kernel/events/uprobes.c
