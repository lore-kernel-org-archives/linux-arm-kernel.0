From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 5 Jun 2013 11:09:59 +0100
Subject: arm64: opportunity for (micro) optimisation in set_bit et al?
In-Reply-To: <20130605100152.GC8758@arm.com>
References: <1370424981.24512.163.camel@zakaz.uk.xensource.com>
 <20130605100152.GC8758@arm.com>
Message-ID: <1370426999.24512.181.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-06-05 at 11:01 +0100, Catalin Marinas wrote:
> Hi Ian,
> 
> On Wed, Jun 05, 2013 at 10:36:21AM +0100, Ian Campbell wrote:
> > I was "borrowing" the arm64 Linux bitops for use in Xen and Tim Deegan
> > wondered about the use of eor in:
> >        and     x3, x0, #63             // Get bit offset
> >        eor     x0, x0, x3              // Clear low bits
> >        mov     x2, #1
> >        add     x1, x1, x0, lsr #3      // Get word offset
> 
> BTW, the latest kernel uses W registers (32-bit here since the function
> prototype has an 'int' and the compiler does not guarantee that the top
> 32-bit are 0.

Thanks, that was in the version I actually picked up (from v3.10-rc4) I
just grabbed the wrong thing when cut-n-pasting here.

> > That eor has a dependency on the previous and instruction which could be
> > avoided using a bic or a lsr #5 followed by lsl #2 instead of the lsr #3
> > on the add (this is what arm32 does).
> 
> Any of these would do (I haven't tried, bic #imm is an alias for and).
> I'll check with the hardware guys whether it makes any difference but it
> is a harmless change anyway.

ACK, thanks.

Ian.
