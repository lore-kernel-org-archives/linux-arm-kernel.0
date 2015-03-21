From: cat.schulze@alice-dsl.net (Christopher Alexander Tobias Schulze)
Date: Sat, 21 Mar 2015 18:16:18 +0100
Subject: ARM1176JZF-S erratum causes unhandles bounces,
 corrupts userspace when FPSCR.IXE set
Message-ID: <201503211816.18492.cat.schulze@alice-dsl.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM1176JZF-S CPU has an erratum which affects floating point
exception traps when FPSCR.IXE is set. With this setup, the kernel will
produce a high number of "unhandled bounce" messages and userspace
corruption as a consequence of these bounces. This corruption may show
up as segmentation faults or silent corruption, depending on the
bouncing opcodes the VFP support code could not handle.

ARM documents the erratum as #328593, "VFP can take an inexact exception
on non-CDP VFP instructions" (see UAN0014B_ARM1176_errata_r0p7.pdf,
available from infocenter.arm.com).

Setting FPSCR.IXE on VFP11 is documented to cause all VFP *CDP*
instructions to "bounce" to the VFP support code, where these instructions
will be emulated. However, due to the silicon bug discussed in the erratum,
also *non-CDP* instructions may be "bounced" to support code under certain
circumstances: When trapping to the support code, the VFP11 sets
the status bit FPEXC.EX. Due to the erratum, this bit is also set when the
VFP instruction is not actually executed (to quote ARM: "it appears in the
shadow of a branch or exception"). However, a set FPEXC.EX causes any
VFP instruction to trap, so non-CDP instructions may also be passed to
the VFP support code.

The current VFP support code in Linux is unable to deal with this
class of instructions and ignores them (logging "unhandles bounces").

While this is already unpleasant for moves between ARM11 and VFP11
registers, it is outright evil for operations acting on memory which
use the address update feature of the ARM CPUs (e.g., VPUSH), as
failure to handle the bounce will corrupt the userspace stack pointer
and cause arbitrary behavior (in many cases leading to SIGSEGV).

There are two consequences: First, the kernel log may be spammed by
"unhandled bounce" messages at a significant rate. Second, user space
applications might be corrupted in arbitrary ways, which may lead to
significant data corruption problems.

ARM considers a fix of the VFP support code (which would either
emulate or retry bounced non-CDP instructions) optional, as setting
FPSCR.IXE is associated with significant runtime overhead and should
therefore be a very uncommon setting.

Considering the consequences, I think it might be better to check
for an ARM1176JZF-S CPU when encountering unhandled bounces with
FPSCR.IXE set, and in these cases terminate the userspace application
with some information logged to the kernel messages. Another option
might be to just retry the bounced instruction (with FPEXC.EX cleared).

Regards,
Alexander Schulze
