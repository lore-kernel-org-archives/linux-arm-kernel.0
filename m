From: luc.vanoostenryck@gmail.com (Luc Van Oostenryck)
Date: Mon, 19 Nov 2018 13:57:20 +0100
Subject: [PATCH v2] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181119123532.GB22589@arm.com>
References: <20181116182130.4327-1-geomatsi@gmail.com>
 <20181119122510.GD8361@arrakis.emea.arm.com>
 <20181119123532.GB22589@arm.com>
Message-ID: <20181119125719.bgdp6bwnhceyvjnp@ltop.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 12:35:32PM +0000, Will Deacon wrote:
> On Mon, Nov 19, 2018 at 12:25:11PM +0000, Catalin Marinas wrote:
> > On Fri, Nov 16, 2018 at 09:21:30PM +0300, Sergey Matyukevich wrote:
> > > Specify correct type for the constants to avoid
> > > the following sparse complaints:
> > > 
> > > ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > > ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > > 
> > > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > 
> > I queued the patch for 4.20-rc4 and also changed the constant to ~0UL as
> > per Luc's suggestion. Thanks.
> 
> My vague worry with using ~0UL is that the preprocessor says:
> 
>  It carries out all calculations in the widest integer type known to the
>  compiler; on most machines supported by GCC this is 64 bits.
> 
> which implies to me that if we ever got a 128-bit integer type, then this
> would break.

True, indeed.

Note: since C99, the standard says:
	(in the context of #if and #elif) "... all signed integer
	types and all unsigned integer types act as if they have
	the same representation as, respectively, the types intmax_t
	and uintmax_t defined in the header <stdint.h>."
   Which doesn't really change your concern.


Regards,
-- Luc
