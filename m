From: will.deacon@arm.com (Will Deacon)
Date: Sat, 10 Nov 2018 17:03:21 +0000
Subject: [PATCH] arm64: sysreg: fix sparse warnings
In-Reply-To: <20181110111647.GA3511@speedy.hunter>
References: <20181109204747.10008-1-geomatsi@gmail.com>
 <20181110001615.GA5665@brain-police>
 <20181110111647.GA3511@speedy.hunter>
Message-ID: <20181110170311.GA7700@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 10, 2018 at 02:16:47PM +0300, Sergey Matyukevich wrote:
> On Sat, Nov 10, 2018 at 12:16:16AM +0000, Will Deacon wrote:
> > On Fri, Nov 09, 2018 at 11:47:47PM +0300, Sergey Matyukevich wrote:
> > > Specify correct type for the constants to avoid
> > > the following sparse complaints:
> > > 
> > > ./arch/arm64/include/asm/sysreg.h:471:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > > ./arch/arm64/include/asm/sysreg.h:512:42: warning: constant 0xffffffffffffffff is so big it is unsigned long
> > > 
> > > Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
> > > ---
> > >  arch/arm64/include/asm/sysreg.h | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > I thought this was fixed in newer versions of sparse so that it treats
> > AArch64 as 64-bit? [see sparse commit 49d56b6969d2f]
> 
> I am using up-to-date sparse. However this warning still appears,
> not sure why. Maybe sparse treats such constants as unsigned int ?
> 
> Meanwhile it looks like I chose wrong type: it is enough to use UL
> instead of ULL to make sparse happy. In fact warning is clear
> about it.

Ah yes, sorry. I misread the patch the first time around and thought you were
changing a UL suffix to a ULL suffix. So actually, I think this is just a
case of sparse getting confused about this constant because it's actually
going to get parsed by the pre-processor, which says:

  | It [the preprocessor parsing #if] carries out all calculations in the
  | widest integer type known to the compiler; on most machines supported by
  | GCC this is 64 bits

so I still think this is a false positive. Adding Luc in case he has any
ideas.

Will
