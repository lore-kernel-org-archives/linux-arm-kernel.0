From: buildroot@browserseal.com (Sasha Sirotkin)
Date: Sat, 10 Apr 2010 00:36:13 +0300
Subject: Confusion regarding ARMv5 MMU access permissions 
Message-ID: <4BBF9DCD.3040007@browserseal.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm trying to figure out how ARMv5 MMU access permissions work in 
general and on Linux in particular.

Table B4-1 MMU access permissions (from the ARM Architecture Reference 
Manual) does not make sense to me and trying to correlate it with
 * Permission translation:
 *  YUWD   AP    SVC    User
 *  0xxx  0x00    no acc    no acc
 *  100x  0x00    r/o    no acc
 *  10x0  0x00    r/o    no acc
 *  1011  0x55    r/w    no acc
 *  110x  0xaa    r/w    r/o
 *  11x0  0xaa    r/w    r/o
 *  1111  0xff    r/w    r/w

from armv3_set_pte_ext makes even less sense.

Can please anybody shed some light on this black magic?

What YUWD stand for? How AP from the above table relate to AP[0:1] bits 
in the ARM page table ? How should I read ARM MMU access permissions table:
S R APXa AP[1:0] Privileged permissions User permissions Description
0 0  0       0b00     No access No access All accesses generate 
permission faults
x x  0       0b01     Read/write No access Privileged access only
x x  0       0b10     Read/write Read only Writes in User mode generate 
permission faults
x x  0       0b11     Read/write Read/write Full access
0 0 1        0b00     - - RESERVED
0 0 1        0b01     Read only No access Privileged read only
0 0 1        0b10     Read only Read only Privileged/User read only
0 0 1        0b11     - - RESERVED

The S and R bits are deprecated in VMSAv6. The following entries apply 
to legacy systems only.

0 1 0 0b00 Read only Read only Privileged/User read only
1 0 0 0b00 Read only No access Privileged read only
1 1 0 0b00 - - RESERVED
0 1 1 0bxx - - RESERVED
1 0 1 0bxx - - RESERVED
1 1 1 0bxx - - RESERVED

And what does that x (don't care !?) mean ?

Thanks a lot, hope this is the right place to ask these kinds of questions.
