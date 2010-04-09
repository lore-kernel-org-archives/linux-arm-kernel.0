From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 9 Apr 2010 22:54:57 +0100
Subject: Confusion regarding ARMv5 MMU access permissions
In-Reply-To: <4BBF9DCD.3040007@browserseal.com>
References: <4BBF9DCD.3040007@browserseal.com>
Message-ID: <20100409215457.GA3219@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 10, 2010 at 12:36:13AM +0300, Sasha Sirotkin wrote:
> I'm trying to figure out how ARMv5 MMU access permissions work in  
> general and on Linux in particular.

If you're interested in ARMv5, only look at the ARMv5 documentation;
don't get confused by the later stuff because that's totally different.

> Table B4-1 MMU access permissions (from the ARM Architecture Reference  
> Manual) does not make sense to me

You really need to understand that table first.

> How AP from the above table relate to AP[0:1] bits in the ARM page table ?

This is covered in the ARMv5 ARM architecture reference manual.

Small pages (4K) have four sets of permission bits, one for each 1K of
the page.  So the two bits are replicated across all entries to ensure
that each 1K segment of a single 4K page has the same permissions.

Extended pages (again 4K) have a different layout, where there is one
single set of permission bits, and the freed bits are dedicated for
other purposes - which includes adding an APX bit.

> How should I read ARM MMU access permissions table:
>
> S R APXa AP[1:0] Privileged permissions User permissions Description
> 0 0  0       0b00     No access No access All accesses generate  
> permission faults
> x x  0       0b01     Read/write No access Privileged access only
> x x  0       0b10     Read/write Read only Writes in User mode generate  
> permission faults
> x x  0       0b11     Read/write Read/write Full access
> 0 0 1        0b00     - - RESERVED
> 0 0 1        0b01     Read only No access Privileged read only
> 0 0 1        0b10     Read only Read only Privileged/User read only
> 0 0 1        0b11     - - RESERVED

AP[1:0] give you the binary bit combinations for the permission bits.
For small pages, APX=0.

> and trying to correlate it with
> * Permission translation:
> *  YUWD   AP    SVC    User
> *  0xxx  0x00    no acc    no acc
> *  100x  0x00    r/o    no acc
> *  10x0  0x00    r/o    no acc
> *  1011  0x55    r/w    no acc
> *  110x  0xaa    r/w    r/o
> *  11x0  0xaa    r/w    r/o
> *  1111  0xff    r/w    r/w
>
> from armv3_set_pte_ext makes even less sense.

AP refers to the access permissions bits in the small page case; and
as you can see these are duplicated across the four 1K sub-pages.

> What YUWD stand for?

Young, User, Write, Dirty.  Young means that the page has not been aged
by the VM.  User means that the page is accessible from userspace.
Write means that userspace can write to the page, and Dirty means that
the page has been written to.

Since ARMs don't have support for 'young' and 'dirty' there's a translation
from these four bits to emulate the effect of them; if a page is not 'young'
we need to make any access fault.  If a page is not dirty, we need to make
any write cause a fault.

> The S and R bits are deprecated in VMSAv6. The following entries apply  
> to legacy systems only.
>
> 0 1 0 0b00 Read only Read only Privileged/User read only
> 1 0 0 0b00 Read only No access Privileged read only
> 1 1 0 0b00 - - RESERVED
> 0 1 1 0bxx - - RESERVED
> 1 0 1 0bxx - - RESERVED
> 1 1 1 0bxx - - RESERVED
>
> And what does that x (don't care !?) mean ?

x = don't care.
