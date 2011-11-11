From: external.Peter.Waechtler@de.bosch.com (EXTERNAL Waechtler Peter (Fa. TCP, CM-AI/PJ-CF31))
Date: Fri, 11 Nov 2011 17:19:45 +0100
Subject: what causes an "imprecise external abort"
Message-ID: <274124B9C6907D4B8CE985903EAA19E91B2A67622C@SI-MBX06.de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

on an ARM11mpcore we get sporadic faults like the following - printed by a
selfmade exception handler:

[   14.453766] Unhandled fault: imprecise external abort (0xc06) at 0x002d3840
LINUX : ****** EXCEPTION in process PID=322 *******
LINUX : Bus error (object-specific hardware error), with fault addr = 0x002d3840
LINUX : command line : "./process.out"
LINUX : ************ thread_id 0x2b730490
LINUX : ====== registers :
LINUX : TRAP_NO = 0x00000000, ERROR_CODE = 0x00000c06, OLDMASK =0x00010001
LINUX : R0  = 0x00000000, R1  = 0x00000000, R2  = 0x00000000, R3  = 0x002d3898
LINUX : R4  = 0x002d37f8, R5  = 0x2ae97acc, R6  = 0x2b72f3c0, R7  = 0x00000078
LINUX : R8  = 0x2aeb3000, R9  = 0x2b730490, R10 = 0x00000000, FP  = 0x2b72f404
LINUX : IP  = 0x2b730930, SP  = 0x2b72f3c0, LR  = 0x2ae1d5c0, PC  = 0x2ae1d5c8
LINUX : CPSR = 0x20000010,
LINUX : ====== backtrace:
LINUX : /lib/libc.so.6(__libc_fork+0x188)[0x2ae1d5c8]
LINUX : libos_linux_so.so(ProcessSpawn+0x158)[0x2ac50674]
LINUX : ./process.out(xxx+0x218)[0x1fed98]
LINUX : libos_linux_so.so[0x2ac4fb38]
LINUX : /lib/libpthread.so.0[0x2aebe57c]
LINUX : /lib/libc.so.6(clone+0x88)[0x2ae4fb48]
LINUX : ====== memory map ======
[..]


So it's a SIGBUS - but "imprecise". Analyzing the output leads to conclusion
that the executed code is irrelevant - i.e. no error with fork().

The external means "something outside of the MMU" - for me DMA comes to mind.

How can we enhance the exception handler to print the state of the AXI DMA controllers
to get a clue if the fault has it's root cause there?
How to achieve that? Does it sound sane? Ring any bells? (christmas is approaching;)



The DFSR is 0xc06 with the folling meaning:
DFSR= 0xC06
[12]SD
[11]Not read/write
[10]Status
[7:4] Domain,
[3:0] Status
Status of 1..110 -> imprecise external abort
Domain is "0" and it was a "write" operation
SD = 0= External Abort marked as DECERRa
SLVERR and DECERR are the two possible types of abort reported in an AXI bus



Digging in the processor manual gives in chapter 2-29:
"Data Abort
Data Abort on the processor can be precise or imprecise. Precise Data Aborts are those
generated after performing an instruction side CP15 operation, and all those generated
by the MMU:
* alignment faults
* translation faults
* domain faults
* permission faults.
[..]
Errors that cause externally generated Data Aborts, signaled by AXI RRESP or
BRESP, might be precise or imprecise. Two separate Fault Status Registers encodings
indicate if the External Abort is precise or imprecise.
External Data Aborts are precise if:
* all aborts to loads or stores to Strongly Ordered memory are precise
* all aborts to loads to the Program Counter or the CPSR are precise
* all aborts on the load part of an SWP are precise.
All other External Aborts are imprecise.
External aborts are supported on cacheable locations. The abort is transmitted to the
processor only if a word requested by the processor had an External Abort."


Best regards

Peter W?chtler
